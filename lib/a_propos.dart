import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container( // Arrière-plan vert
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "À propos de l'application",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Cette application est de type Todo app, "
                    "développée pour faciliter la gestion des tâches au sein de notre groupe.",
              ),
              SizedBox(height: 16),
              Text(
                "Membres du groupe",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // Exemple pour un membre du groupe
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text("AGUESSY Marie-Adelphe"),
                subtitle: Text("IM"),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text("AKPO Hector"),
                subtitle: Text("GL"),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text("CODJIA TOGNIDE Elcy"),
                subtitle: Text("GL"),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text("DASSI Mardino"),
                subtitle: Text("GL"),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text("DEGBE Brandon"),
                subtitle: Text("IM"),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text("EGBOGBE Wisdom"),
                subtitle: Text("GL"),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text("SOSSA Chavinelle"),
                subtitle: Text("IM"),
              )
            ],
          ),
        ),
      )
    );
  }
}



