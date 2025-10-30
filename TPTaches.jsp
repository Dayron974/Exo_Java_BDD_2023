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
     private String dueDate;
     private boolean completed;

     public Task(String title, String description) {
          this.title = title;
          this.description = description;
          this.dueDate = dueDate;
          this.completed = false;
          }

          public String getTitle() {
               return title;
          }

          public String getDescription() {
               return description;
          }
          public String getDueDate() { return dueDate; }
          public boolean isCompleted() { return completed; }
}
%>

<%-- ================================
     Gestion de la liste de tâches
     ================================ --%>
<%-- code exécuté à chaque requête HTTP --%>
<%
     // Récupérer la liste de tâches dans la session
     // La session sert à stocker des données temporaires entre plusieurs requêtes HTTP d’un même utilisateur, dure 30 minutes d’inactivité (valeur par défaut dans Tomcat).
     ArrayList<Task> tasks = (ArrayList<Task>) session.getAttribute("tasks");

     // Si elle n'existe pas encore, on la crée
     if (tasks == null) {
          tasks = new ArrayList<Task>();
          session.setAttribute("tasks", tasks);
     }

     String action = request.getParameter("action");

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
<%-- ================================
     Style CSS
     ================================ --%>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f5f5f5;
        }
        a {
            text-decoration: none;
            color: #0078d7;
        }
        h1 { color: #333; }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            width: 450px;
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
            position: relative;
        }
        .task.completed {
            opacity: 0.6;
            text-decoration: line-through;
        }
        .actions {
            position: absolute;
            right: 15px;
            top: 15px;
        }
        .actions a {
            margin-left: 10px;
            color: #0078d7;
        }
        .actions a:hover {
            text-decoration: underline;
        }
        .back-home {
            display: inline-block;
            margin-bottom: 20px;
            background: #ccc;
            padding: 8px 12px;
            border-radius: 5px;
            color: black;
        }
    </style>
</head>
<body>

<a class="back-home" href="index.html">⬅ Retour à l'accueil</a>

<h1>📝 Liste de tâches</h1>

<!-- Formulaire d'ajout -->
<form method="post" action="TPTaches.jsp">
    <label for="title">Titre :</label>
    <input type="text" id="title" name="title" required>

    <label for="description">Description :</label>
    <textarea id="description" name="description" rows="3"></textarea>

    <label for="dueDate">Date d’échéance :</label>
    <input type="date" id="dueDate" name="dueDate">

    <button type="submit">Ajouter la tâche</button>
</form>

<!-- Affichage de la liste des tâches -->
<div class="task-list">
    <h2>Vos tâches :</h2>
    <%
     if (tasks.isEmpty()) 
     {
    %>
        <p>Aucune tâche pour le moment.</p>
    <%
     } 
     else 
     {
          for (int i = 0; i < tasks.size(); i++) 
          {
               Task t = tasks.get(i);

               // Déterminer la classe CSS selon l'état
               String taskClass = "";
               if (t.isCompleted()) {
                    taskClass = "completed";
               }

               // Déterminer le texte pour la date d'échéance
               String dueDateText = "Aucune";
               if (t.getDueDate() != null && !t.getDueDate().isEmpty()) {
                    dueDateText = t.getDueDate();
               }

               // Déterminer le texte pour le lien d'action
               String toggleText = "Terminer";
               if (t.isCompleted()) {
                    toggleText = "Rétablir";
               }

    %>
        <div class="task <%= taskClass %>">
            <h3><%= t.getTitle() %></h3>
            <p><%= t.getDescription() %></p>
            <div class="actions">
                 <a href="tasks.jsp?action=toggle&index=<%=i%>"><%= toggleText %></a>
                 //<a href="tasks.jsp?action=delete&index=<%=i%>" onclick="return confirm('Supprimer cette tâche ?');">Supprimer</a>
            </div>
        </div>
    <%
            }
        }
    %>
</div>

</body>
</html>
