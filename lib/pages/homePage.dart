// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:tp_no_4/listStatutPage.dart';
import 'package:tp_no_4/listTaskPage.dart';
import 'package:tp_no_4/a_propos.dart';
import 'package:tp_no_4/ajoutTache.dart';
import 'package:tp_no_4/models/databaseService.dart';
import 'package:tp_no_4/models/model.dart';

class GridItem {
  final String title;
  final int value;

  GridItem({required this.title, required this.value});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Pour suivre la page sélectionnée

  // Liste des pages pour le BottomNavigationBar
  final List<Widget> _pages = [
    HomeContent(),
    About(),
    ListTasks(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Application de tâches",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex], // Affiche la page sélectionnée
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            activeIcon: Icon(Icons.home, size: 30, color: Colors.green,),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info, size: 30),
            activeIcon: Icon(Icons.info, size: 30, color: Colors.green,),
            label: "A propos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, size: 30),
            activeIcon: Icon(Icons.list, size: 30, color: Colors.green,),
            label: "Liste",
          ),
        ],
      ),
    );
  }
}

// Contenu de la page d'accueil avec FloatingActionButton
class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int total = 0;
  int totalarealise = 0;
  int totalencours = 0;
  int totaltermine = 0;

  TodoDatabaseService service = TodoDatabaseService();

  final List<GridItem> items = [
    GridItem(title: "Total des tâches", value: 0),
    GridItem(title: "Tâche à réaliser", value: 0),
    GridItem(title: "Tâches en cours", value: 0),
    GridItem(title: "Tâches terminées", value: 0),
  ];

  // Chargement des données depuis la base de données
  _loadData() async {
    List<Todo> liste = await service.getData();
    List<Todo> listearealise = await service.getByStatut("");
    List<Todo> listeEncours = await service.getByStatut("En cours");
    List<Todo> listeTermine = await service.getByStatut("Terminé");

    setState(() {
      total = liste.length;
      totalarealise = listearealise.length;
      totalencours = listeEncours.length;
      totaltermine = listeTermine.length;

      // Mise à jour des items affichés
      items[0] = GridItem(title: "Total des tâches", value: total);
      items[1] = GridItem(title: "Tâche à réaliser", value: totalarealise);
      items[2] = GridItem(title: "Tâches en cours", value: totalencours);
      items[3] = GridItem(title: "Tâches terminées", value: totaltermine);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item.value.toString(),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    item.title != "Total des tâches" ?
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                        ),
                          onPressed: () {

                            item.title == "Tâches en cours" ?
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>ListStatutPage(statut: "En cours"))
                                ): item.title == "Tâches terminées"?
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>ListStatutPage(statut: "Terminé"))
                            ):
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>ListStatutPage(statut: "")));
                          },
                          child: Icon(Icons.remove_red_eye_rounded, color: Colors.green,)
                      ): SizedBox()
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers la page d'ajout de tâche
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
