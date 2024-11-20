
import 'package:flutter/material.dart';
import 'package:tp_no_4/editTask.dart';
import 'package:tp_no_4/models/databaseService.dart';

import 'ajoutTache.dart';
import 'models/model.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({super.key});

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {

  List<Todo> tasks = [];
  TodoDatabaseService service = TodoDatabaseService();

  void _showDeleteDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Supprimer la tâche"),
          content: Text("Voulez-vous vraiment supprimer cette tâche ?"),
          actions: <Widget>[
            TextButton(
              child: Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Supprimer"),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              onPressed: () {
                service.deleteTodo(id);
                _loadTask();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _loadTask () async {
    tasks = await service.getData();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tasks.isNotEmpty?
      ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    tasks[index].name,
                    style: TextStyle(
                      color: Colors.green, // Couleur verte pour le titre
                      fontWeight: FontWeight.bold, // Texte en gras
                    ),
                  ),
                  subtitle: Text(
                    tasks[index].description,
                  ),
                  onTap: () => _showDeleteDialog(
                      context, tasks[index].id), // Afficher la boîte de dialogue
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    tasks[index].statut == "En cours" ?
                    TextButton(
                      onPressed: () async {
                        service.updateTodoStatus(tasks[index].id, "Terminé");
                        _loadTask();
                      },
                      child: Text("Terminer la tâche"),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green, // Texte vert
                      ),
                    ):
                    const SizedBox(width: 8),
                    tasks[index].statut == "" ?
                    TextButton(
                      onPressed: () async {
                        service.updateTodoStatus(tasks[index].id, "En cours");
                        _loadTask();
                      },
                      child: Text("Démarrer la tâche"),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green, // Texte vert
                      ),
                    ):
                    const SizedBox(width: 8),
                    // TextButton(
                    //   onPressed: () {
                    //
                    //   },
                    //   child: Text("Détails"),
                    //   style: TextButton.styleFrom(
                    //     foregroundColor: Colors.green, // Texte vert
                    //   ),
                    // ),
                    // const SizedBox(width: 8),
                    tasks[index].statut != "En cours" ?
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context)=> EditTask(todo: tasks[index])
                            ));
                      },
                      child: Text("Modifier"),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green, // Texte vert
                      ),
                    ): SizedBox(),
                  ],
                ),
              ],
            ),
          );
        },
      ) :
      Center(
        child: Text("Aucune tâche"),
      )
      ,
    );
  }
}

