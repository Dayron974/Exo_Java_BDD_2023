<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%-- ================================
     Définition de la classe Task
     ================================ --%>
<%-- contient du code Java déclaré au niveau de la page --%>
<%! 
    public class Task {
        private String title;
        private String description;

        public Task(String title, String description) {
            this.title = title;
            this.description = description;
        }

        public String getTitle() {
            return title;
        }

        public String getDescription() {
            return description;
        }
    }
%>

<%-- ================================
     Gestion de la liste de tâches
     ================================ --%>
<%-- code exécuté à chaque requête HTTP --%>
<%
    // Récupérer la liste de tâches dans la session
    ArrayList<Task> tasks = (ArrayList<Task>) session.getAttribute("tasks");

    // Si elle n'existe pas encore, on la crée
    if (tasks == null) {
        tasks = new ArrayList<Task>();
        session.setAttribute("tasks", tasks);
    }

    // Vérifier si le formulaire a été soumis
    String title = request.getParameter("title");
    String description = request.getParameter("description");

    if (title != null && description != null && !title.trim().isEmpty()) {
        // Créer et ajouter une nouvelle tâche
        Task newTask = new Task(title.trim(), description.trim());
        tasks.add(newTask);
        session.setAttribute("tasks", tasks);
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des tâches</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f5f5f5;
        }
        h1 { color: #333; }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            width: 400px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        input, textarea, button {
            width: 100%;
            margin-top: 10px;
            padding: 10px;
            font-size: 14px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        button {
            background-color: #0078d7;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #005fa3;
        }
        .task-list {
            margin-top: 30px;
        }
        .task {
            background: white;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 10px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .task h3 {
            margin: 0 0 5px 0;
        }
    </style>
</head>
<body>

<h1>📝 Liste de tâches</h1>

<!-- Formulaire d'ajout -->
<form method="post" action="TPTaches.jsp">
    <label for="title">Titre :</label>
    <input type="text" id="title" name="title" required>

    <label for="description">Description :</label>
    <textarea id="description" name="description" rows="3"></textarea>

    <button type="submit">Ajouter la tâche</button>
</form>

<!-- Affichage de la liste des tâches -->
<div class="task-list">
    <h2>Vos tâches :</h2>
    <%
        if (tasks.isEmpty()) {
    %>
        <p>Aucune tâche pour le moment.</p>
    <%
        } else {
            for (Task t : tasks) {
    %>
        <div class="task">
            <h3><%= t.getTitle() %></h3>
            <p><%= t.getDescription() %></p>
        </div>
    <%
            }
        }
    %>
</div>

</body>
</html>
