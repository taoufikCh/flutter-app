import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/firebase_options.dart';
import 'package:voyage/pages/authentification.page.dart';
import 'package:voyage/pages/contact.page.dart';
import 'package:voyage/pages/gallerie.page.dart';
import 'package:voyage/pages/home.page.dart';
import 'package:voyage/pages/inscription.page.dart';
import 'package:voyage/pages/meteo.page.dart';
import 'package:voyage/pages/parametres.page.dart';
import 'package:voyage/pages/pays.page.dart';
import 'config/global.params.dart';

ThemeData theme = ThemeData.light();
//void main() => runApp(MyApp());
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GlobalParams.themeActuel.setMode(await _onGetMode());
  //theme = (await _onGetMode()== "Jour") ? ThemeData.light(): ThemeData.dark();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = {
    '/home' : (Context) => HomePage(),
    '/inscription' : (Context) => InscriptionPage(),
    '/authentification' : (Context) => AuthentificationPage(),
    '/meteo' : (Context) => MeteoPage(),
    '/gallerie' : (Context) => GalleriePage(),
    '/pays' : (Context) => PaysPage(),
    '/contact' : (Context) => ContactPage(),
    '/parametres' : (Context) => ParametresPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      routes: routes,
      //theme: theme,
      theme: GlobalParams.themeActuel.getTheme(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapshot){
              if(snapshot.hasData)
                return HomePage();
              else
                return AuthentificationPage();
            }
           /* future: SharedPreferences.getInstance(),
            builder: (BuildContext context, AsyncSnapshot<SharedPreferences> prefs){
              var x = prefs.data;
              if(prefs.hasData){
                bool c = x?.getBool("connecte") ?? false;
                if(c) return HomePage();
              }
              return AuthentificationPage();
        }*/
      ),
      //InscriptionPage(),

    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GlobalParams.themeActuel.addListener(() {
      setState(() { });
    });
  }
}
Future<String> _onGetMode() async{
  final snapshot = await ref.child('mode').get();
  if(snapshot.exists)
    mode= snapshot.value.toString();
  else
    mode = "Jour";
  print(mode);
  return(mode);
}
