package controller;
import dao.PharmacieDAO;
import dao.PharmacienDAO;
import model.Pharmacien;
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

@WebServlet("/pharmacien")
public class PharmacienController extends HttpServlet {
    private PharmacienDAO pharmacienDAO;
    private PharmacieDAO pharmacieDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnection.getConnection();
            pharmacienDAO = new PharmacienDAO(connection);
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
                Pharmacien pharmacien = pharmacienDAO.read(id);
                request.setAttribute("pharmacien", pharmacien);
                request.getRequestDispatcher("/views/pages/dashboard/pharmacienDetail.jsp").forward(request, response);
            } else {
                // Récupérer la liste des pharmacies pour le formulaire
                List<Pharmacie> pharmacies = pharmacieDAO.getAll();
                request.setAttribute("pharmacies", pharmacies);
                
                // Récupérer la liste des pharmaciens pour le tableau
                List<Pharmacien> pharmaciens = pharmacienDAO.getAll();
                request.setAttribute("pharmaciens", pharmaciens);
                
                request.getRequestDispatcher("/views/pages/dashboard/pharmacien.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la récupération des données", e);
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
            try {
                createPharmacien(request, response);
            } catch (SQLException e) {
                throw new ServletException("Erreur lors de la création", e);
            }
        }
    }

    private void createPharmacien(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        Pharmacien pharmacien = new Pharmacien(
            0,
            request.getParameter("nom"),
            request.getParameter("email"),
            request.getParameter("telephone"),
            request.getParameter("adresse"),
            request.getParameter("password"),
            "pharmacien",
            new Pharmacie(Integer.parseInt(request.getParameter("pharmacie_id")), "")
        );
        
        pharmacienDAO.create(pharmacien);
        response.sendRedirect(request.getContextPath() + "/pharmacien");
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Pharmacien pharmacien = new Pharmacien(
                Integer.parseInt(request.getParameter("id")),
                request.getParameter("nom"),
                request.getParameter("email"),
                request.getParameter("telephone"),
                request.getParameter("adresse"),
                request.getParameter("password"),
                "pharmacien",
                new Pharmacie(Integer.parseInt(request.getParameter("pharmacie_id")), "")
            );
            
            pharmacienDAO.update(pharmacien);
            response.sendRedirect(request.getContextPath() + "/pharmacien");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la mise à jour", e);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            pharmacienDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/pharmacien");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la suppression", e);
        }
    }
}