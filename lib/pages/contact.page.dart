import 'package:flutter/material.dart';
import 'package:voyage/menu/drawer.widget.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'ajout_modif_contact.page.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import '../model/contact.model.dart';
import '../services/contact.service.dart';


class ContactPage extends StatefulWidget {

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactService contactService = ContactService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Contact"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FormHelper.submitButton("Ajout", () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AjoutModifContactPage(),
                ),
                ).then((value) {
                  setState(() {});
                });
              },
                borderRadius: 10,
                btnColor: Colors.blue,
                borderColor: Colors.blue,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _fetchData(),
          ],
        ),
      ),
    );
  }

  _fetchData() {
    return FutureBuilder<List<Contact>>(
      future: contactService.listEContacts(),
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> contacts) {
        if (contacts.hasData) return _buildDataTable(contacts.data!);
        return Center(child: CircularProgressIndicator());
      },
    );
  }
  _buildDataTable(List<Contact> listContacts){
    return Padding(padding: const EdgeInsets.all(8.0),
      child: ListUtils.buildDataTable(context,
          ["Nom", "Telephone", "Action"],
          ["nom", "tel", ""],
          false, 0, listContacts,
          (Contact c){
        //modifier contact
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => AjoutModifContactPage(
                contact: c,
                modifMode: true,
              ),
            ),
            ).then((value) {
              setState(() {});
            });
          },
          (Contact c){
        //supprimer contact
            return showDialog(context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: const Text("Supprimer contact"),
                    content: const Text("Etes vous sûr de vouloir supprimer ce contact ?"),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FormHelper.submitButton("Oui",
                              (){
                            contactService.supprimerContact(c).then((value) => setState((){
                              Navigator.of(context).pop();
                            }));
                              },
                          width: 100,
                          borderRadius: 5,
                          btnColor: Colors.green,
                          borderColor: Colors.green,
                          ),
                          const SizedBox(width: 20),
                          FormHelper.submitButton("Non",
                                (){

                                Navigator.of(context).pop();
                              },
                            width: 100,
                            borderRadius: 5,
                          )
                        ],
                      )
                    ],
                  );
                }
            );
          },
        headingRowColor: Colors.orangeAccent,
        isScrollable: true,
        columnTextFontSize: 20,
        columnTextBold: false,
        columnSpacing: 50,
        onSort: (columnIndex, colimnName, asc){},
      )
    );
  }
}

