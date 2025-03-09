package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Commande;
import model.Medicament;
import model.Pharmacie;
import model.Utilisateur;
import util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.CommandeDAO;

@WebServlet("/commande")
public class CommandeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CommandeController() {
        super();
    }

    // Récupérer toutes les commandes (GET)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            CommandeDAO commandeDAO = new CommandeDAO(conn);
            List<Commande> commandes = commandeDAO.getAllCommandes();
            request.setAttribute("commandes", commandes);
            request.getRequestDispatcher("commandes.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Erreur: " + e.getMessage());
        }
    }

    // Ajouter une commande (POST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            CommandeDAO commandeDAO = new CommandeDAO(conn);

            int utilisateurId = Integer.parseInt(request.getParameter("utilisateur_id"));
            int pharmacieId = Integer.parseInt(request.getParameter("pharmacie_id"));
            String statut = request.getParameter("statut");
            String[] medicamentIds = request.getParameterValues("medicament_id");

            Utilisateur utilisateur = new Utilisateur();
            utilisateur.setId(utilisateurId);

            Pharmacie pharmacie = new Pharmacie();
            pharmacie.setId(pharmacieId);

            List<Medicament> medicaments = new ArrayList<>();
            for (String id : medicamentIds) {
                Medicament medicament = new Medicament();
                medicament.setId(Integer.parseInt(id));
                medicaments.add(medicament);
            }

            Commande commande = new Commande(0, utilisateur, pharmacie, medicaments, statut);

            commandeDAO.ajouterCommande(commande);
            response.sendRedirect("commandes.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Erreur: " + e.getMessage());
        }
    }

    // Mettre à jour une commande (PUT)
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            CommandeDAO commandeDAO = new CommandeDAO(conn);

            int commandeId = Integer.parseInt(request.getParameter("commande_id"));
            String statut = request.getParameter("statut");

            Commande commande = new Commande();
            commande.setId(commandeId);
            commande.setStatut(statut);

            commandeDAO.mettreAJourCommande(commande);
            response.sendRedirect("commandes.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Erreur: " + e.getMessage());
        }
    }

    // Supprimer une commande (DELETE)
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            CommandeDAO commandeDAO = new CommandeDAO(conn);

            int commandeId = Integer.parseInt(request.getParameter("commande_id"));
            commandeDAO.supprimerCommande(commandeId);
            response.sendRedirect("commandes.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Erreur: " + e.getMessage());
        }
    }
}
