<%@ page import="model.Utilisateur" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Expires", "0"); 
%>
<%
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || sessionUser.getAttribute("utilisateur") == null) {
    	
    	
        response.sendRedirect("login.jsp");
        return;
    }
    Utilisateur utilisateur = (Utilisateur) sessionUser.getAttribute("utilisateur");
%>
<h1>Bienvenue, <%= utilisateur.getNom() %> !</h1>
<p>Email : <%= utilisateur.getEmail() %>< /p>
<p><a href="logout">Déconnexion</a></p>

</body>
</html>