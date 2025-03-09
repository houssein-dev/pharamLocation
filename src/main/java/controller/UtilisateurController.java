package controller;

import dao.UtilisateurDAO;
import model.Utilisateur;
import util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/utilisateur")
public class UtilisateurController extends HttpServlet {
    private UtilisateurDAO utilisateurDAO;

    @Override
    public void init() throws ServletException {
        Connection connection = null;
        try {
            connection = DBConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        utilisateurDAO = new UtilisateurDAO(connection);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String method = request.getParameter("_method");

        if ("PUT".equalsIgnoreCase(method)) {
            doPut(request, response);
        }
        try {
            if (idParam != null) {
                int id = Integer.parseInt(idParam);
                Utilisateur utilisateur = utilisateurDAO.read(id);
                request.setAttribute("utilisateur", utilisateur);
                request.setAttribute("id", id);


            } else {
                List<Utilisateur> utilisateurs = utilisateurDAO.getAll();
                request.setAttribute("utilisateurs", utilisateurs);
                request.getRequestDispatcher("/utilisateur/listutilisateur.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la récupération des utilisateurs", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Gestion de la méthode HTTP personnalisée
        String method = request.getParameter("_method");
        if ("PUT".equalsIgnoreCase(method)) {
            doPut(request, response);
        } else if ("DELETE".equalsIgnoreCase(method)) {
            doDelete(request, response);
        } else {
            String nom = request.getParameter("nom");
            String email = request.getParameter("email");
            String telephone = request.getParameter("telephone");
            String adresse = request.getParameter("adresse");
            String password = request.getParameter("password");

            Utilisateur utilisateur = new Utilisateur(0, nom, email, telephone, adresse, password);
            try {
                utilisateurDAO.create(utilisateur);
                response.sendRedirect("utilisateur");
            } catch (SQLException e) {
                throw new ServletException("Erreur lors de l'ajout de l'utilisateur", e);
            }
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "L'ID est manquant ou invalide.");
            return;
        }

        int id = Integer.parseInt(idParam);
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");
        String adresse = request.getParameter("adresse");
        String password = request.getParameter("password");

        Utilisateur utilisateur = new Utilisateur(id, nom, email, telephone, adresse, password);
        try {
            utilisateurDAO.update(utilisateur);
            response.sendRedirect("utilisateur");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la mise à jour de l'utilisateur", e);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            utilisateurDAO.delete(id);
            response.sendRedirect("utilisateur");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la suppression de l'utilisateur", e);
        }
    }
}
