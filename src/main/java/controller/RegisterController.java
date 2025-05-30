package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Pharmacie;
import model.Pharmacien;
import model.Utilisateur;
import util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import dao.PharmacieDAO;
import dao.PharmacienDAO;
import dao.UtilisateurDAO;

@WebServlet("/inscription")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            // Charger la liste des pharmacies pour le formulaire pharmacien
            PharmacieDAO pharmacieDAO = new PharmacieDAO(conn);
            request.setAttribute("pharmacies", pharmacieDAO.getAll());
            request.getRequestDispatcher("views/pages/auth/registre.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Erreur de connexion à la base de données", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");
        String adresse = request.getParameter("adresse");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String pharmacieIdParam = request.getParameter("pharmacie_id");

        try (Connection conn = DBConnection.getConnection()) {
            if ("pharmacien".equals(role)) {
                // Enregistrement pharmacien
                int pharmacieId = Integer.parseInt(pharmacieIdParam);
                Pharmacie pharmacie = new PharmacieDAO(conn).read(pharmacieId);
                
                Pharmacien pharmacien = new Pharmacien(
                    0, nom, email, telephone, adresse, password, pharmacie
                );
                
                PharmacienDAO pharmacienDAO = new PharmacienDAO(conn);
                pharmacienDAO.create(pharmacien);
                
                request.setAttribute("message", "Compte pharmacien créé avec succès !");
            } else {
                // Enregistrement utilisateur normal
                Utilisateur utilisateur = new Utilisateur(
                    0, nom, email, telephone, adresse, password
                );
                utilisateur.setRole("utilisateur");
                
                UtilisateurDAO dao = new UtilisateurDAO(conn);
                dao.create(utilisateur);
                
                request.setAttribute("message", "Compte utilisateur créé avec succès !");
            }
            
    	    request.getRequestDispatcher("views/pages/auth/login.jsp").forward(request, response);
            
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de la création du compte: " + e.getMessage());
            request.getRequestDispatcher("views/pages/auth/registre.jsp").forward(request, response);
        }
    }
}