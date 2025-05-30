package controller;

import dao.MedicamentDAO;
import dao.PharmacieDAO;

import model.Medicament;
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

@WebServlet("/main")
public class MainController extends HttpServlet {
    private MedicamentDAO medicamentDAO;
    private PharmacieDAO pharmacieDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnection.getConnection();
            medicamentDAO = new MedicamentDAO(connection);
            pharmacieDAO = new PharmacieDAO(connection);

        } catch (SQLException e) {
            throw new ServletException("Erreur de connexion à la base de données", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupération des médicaments
        List<Medicament> medicaments = null;
		try {
			medicaments = medicamentDAO.getAll();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        request.setAttribute("medicaments", medicaments);

        // Récupération des pharmacies
        List<Pharmacie> pharmacies = null;
		try {
			pharmacies = pharmacieDAO.getAll();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        request.setAttribute("pharmacies", pharmacies);

        // Redirection vers la page d'accueil
        request.getRequestDispatcher("./index.jsp").forward(request, response);
    }    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
