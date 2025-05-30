package controller;

import dao.MedicamentDAO;
import dao.PharmacieDAO;

import model.Medicament;
import model.Pharmacie;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class AdminDashboardController
 */
@WebServlet("/dashboard")
public class AdminDashboardController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
//        Object medicamentDAO;
//		// Récupérer les données pour le dashboard
//        int medicamentCount = medicamentDAO.getCount();
//        Object pharmacieDAO;
//		int pharmacieCount = pharmacieDAO.getCount();
//        Object commandeDAO;
//		int commandeCount = commandeDAO.getCount();
//        Object utilisateurDAO;
//		int utilisateurCount = utilisateurDAO.getCount();
//        
//        List<Commande> recentCommandes = commandeDAO.getRecent(5);
//        List<Stock> lowStocks = stockDAO.getLowStock(10);
//        
//        // Ajouter les attributs à la requête
//        request.setAttribute("medicamentCount", medicamentCount);
//        request.setAttribute("pharmacieCount", pharmacieCount);
//        request.setAttribute("commandeCount", commandeCount);
//        request.setAttribute("utilisateurCount", utilisateurCount);
//        request.setAttribute("recentCommandes", recentCommandes);
//        request.setAttribute("lowStocks", lowStocks);
        
        // Transférer à la JSP
        request.getRequestDispatcher("views/pages/dashboard/dashboard.jsp").forward(request, response);
    }
}