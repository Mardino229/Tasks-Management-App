# Application Flutter - Gestion de Tâches

## Description

Cette application Flutter utilisant sqlite comme base de donnée est un projet minmaliste de gestion de tâche. Grâce à son interface simple et conviviale, vous pouvez suivre l'état de vos activités et interagir avec elles de manière intuitive.

---

## Fonctionnalités

### 1. **Page de Connexion**
   - Permet de se connecter à l'application à l'aide de vos identifiants.

### 2. **Page de Création de Compte**
   - Permet de créer un compte utilisateur avec lequel vous pourrez vous connecter et accéder à toutes les fonctionnalités.

### 3. **Page d'Enregistrement de Tâches**
   - Ajoutez de nouvelles tâches avec un titre et une description.

### 4. **Page d'Accueil**
   - Offre une vue d'ensemble avec des statistiques générales :
     - Nombre total de tâches.
     - Tâches non commencées.
     - Tâches en cours.
     - Tâches terminées.

### 5. **Page de Liste des Tâches**
   - Affiche toutes les tâches enregistrées sous forme de liste.
   - Chaque tâche présente son **titre** et sa **description**.
   - Actions disponibles pour chaque tâche :
     - **Modification** : Modifier le titre et la description uniquement si la tâche est non commencée ou en cours (redirige vers une page de modification).
     - **Commencer une tâche** : Si elle n’a pas encore commencé.
     - **Finir une tâche** : Si elle est en cours.
     - **Supprimer une tâche** : Retire la tâche définitivement.

---

## Technologies Utilisées
- **Framework** : Flutter
- **Langage** : Dart
- **Architecture** : MVVM (Model-View-ViewModel)

---

## Installation
   ```bash
   git clone https://github.com/username/task-manager-flutter.git
   cd Tasks-Management-App
   flutter pub get
   flutter run
