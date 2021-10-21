import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ahmed khaled hasan",
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage("assets/images/personalimage.jpg"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Ahmed khaled",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Flutter Developer",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Festive",
                  ),
                ),
              ),
              ContactCard(
                url: "tel:+201141537743",
                contactText: "+201141537743",
                iconData: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
              ),
              ContactCard(
                url: "mailto:ahmedklose3112@gmail.com",
                contactText: "ahmedklose3112@gmail.com",
                iconData: Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
              ),
              ContactCard(
                url: "https://www.facebook.com/ahmedkhaled.ellaban.1/",
                contactText: "Ahmed Khaled El laban",
                iconData: Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.black,
                ),
                // iconData: Icon(
                //   Icons.facebook_rounded,
                //   color: Colors.black,
                // ),
              ),
              ContactCard(
                url: "https://github.com/ahmedkhaled3112",
                contactText: "ahmedkhaled3112",
                // iconData: Image.asset(
                //   "assets/images/github.png",
                //   width: 22.0,
                // ),
                iconData: Icon(
                  FontAwesomeIcons.github,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final String url, contactText;
  final Widget iconData;

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  const ContactCard({
    Key? key,
    required this.url,
    required this.contactText,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        color: Colors.blueGrey,
        child: ListTile(
          onTap: () {
            _launchURL(url);
          },
          leading: iconData,
          title: Text(
            contactText,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
