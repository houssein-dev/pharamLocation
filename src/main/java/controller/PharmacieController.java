package controller;

import dao.PharmacieDAO;
import model.Pharmacie;
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

@WebServlet("/pharmacie")
public class PharmacieController extends HttpServlet {
    private PharmacieDAO pharmacieDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnection.getConnection();
            pharmacieDAO = new PharmacieDAO(connection);
        } catch (SQLException e) {
            throw new ServletException("Erreur d'initialisation de la base de données", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        try {
            if (idParam != null) {
                int id = Integer.parseInt(idParam);
                Pharmacie pharmacie = pharmacieDAO.read(id);
                request.setAttribute("pharmacie", pharmacie);
                request.getRequestDispatcher("/views/pages/dashboard/pharmacieDetail.jsp").forward(request, response);
            } else {
                List<Pharmacie> pharmacies = pharmacieDAO.getAll();
                request.setAttribute("pharmacies", pharmacies);
                request.getRequestDispatcher("/views/pages/dashboard/pharmacie.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la récupération des pharmacies", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("_method");
        
        if ("PUT".equalsIgnoreCase(method)) {
            doPut(request, response);
        } else if ("DELETE".equalsIgnoreCase(method)) {
            doDelete(request, response);
        } else {
            createPharmacie(request, response);
        }
    }

    private void createPharmacie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String adresse = request.getParameter("adresse");
        String coordonneesGPS = request.getParameter("coordonneesGPS");
        String logoUrl = request.getParameter("logoUrl");

        Pharmacie pharmacie = new Pharmacie(0, nom, adresse, coordonneesGPS, null, logoUrl);
        
        try {
            pharmacieDAO.create(pharmacie);
            response.sendRedirect(request.getContextPath() + "/pharmacie");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de l'ajout de la pharmacie", e);
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String adresse = request.getParameter("adresse");
        String coordonneesGPS = request.getParameter("coordonneesGPS");
        String logoUrl = request.getParameter("logoUrl");

        Pharmacie pharmacie = new Pharmacie(id, nom, adresse, coordonneesGPS, null, logoUrl);
        
        try {
            pharmacieDAO.update(pharmacie);
            response.sendRedirect(request.getContextPath() + "/pharmacie");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la mise à jour de la pharmacie", e);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        try {
            pharmacieDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/pharmacie");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la suppression de la pharmacie", e);
        }
    }
}