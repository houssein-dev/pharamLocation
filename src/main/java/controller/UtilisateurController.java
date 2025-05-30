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
        try {
            Connection connection = DBConnection.getConnection();
            utilisateurDAO = new UtilisateurDAO(connection);
        } catch (SQLException e) {
            throw new ServletException("Erreur de connexion à la base de données", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String method = request.getParameter("_method");

        if ("PUT".equalsIgnoreCase(method)) {
            doPut(request, response);
            return;
        }

        try {
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                Utilisateur utilisateur = utilisateurDAO.read(id);
                if (utilisateur != null) {
                    request.setAttribute("utilisateur", utilisateur);
                    request.getRequestDispatcher("views/pages/dashboard/editutilisateur.jsp").forward(request, response);

                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Utilisateur non trouvé");
                }
            } else {
                List<Utilisateur> utilisateurs = utilisateurDAO.getAll();
                request.setAttribute("utilisateurs", utilisateurs);
                request.getRequestDispatcher("views/pages/dashboard/utilisateurs.jsp").forward(request, response);

            }
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException("Erreur lors de la récupération des utilisateurs", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("_method");
        if ("PUT".equalsIgnoreCase(method)) {
            doPut(request, response);
            return;
        } else if ("DELETE".equalsIgnoreCase(method)) {
            doDelete(request, response);
            return;
        }

        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");
        String adresse = request.getParameter("adresse");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        Utilisateur utilisateur = new Utilisateur(0, nom, email, telephone, adresse, password, role);
        try {
            utilisateurDAO.create(utilisateur);
            response.sendRedirect("utilisateur");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de l'ajout de l'utilisateur", e);
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID manquant");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            String nom = request.getParameter("nom");
            String email = request.getParameter("email");
            String telephone = request.getParameter("telephone");
            String adresse = request.getParameter("adresse");
            String password = request.getParameter("password");
            String role = request.getParameter("role");


            Utilisateur utilisateur = new Utilisateur(id, nom, email, telephone,password, adresse, role);
            System.out.println("utilisateur");
            System.out.println(utilisateur);
            utilisateurDAO.update(utilisateur);
            response.sendRedirect("utilisateur");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID invalide");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la mise à jour de l'utilisateur", e);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID manquant");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            utilisateurDAO.delete(id);
            response.sendRedirect("utilisateur");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID invalide");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la suppression de l'utilisateur", e);
        }
    }
}