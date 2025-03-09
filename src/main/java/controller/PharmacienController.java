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
import jakarta.servlet.http.HttpSession;
import model.Utilisateur;

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
        Connection connection = null;
		try {
			connection = DBConnection.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        pharmacienDAO = new PharmacienDAO(connection);
        pharmacieDAO = new PharmacieDAO(connection);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
    	System.out.printf("pharmacien id ",idParam);

        try {
            if (idParam != null) {
                int id = Integer.parseInt(idParam);
                Pharmacien pharmacien = pharmacienDAO.read(id);
                request.setAttribute("pharmacien", pharmacien);
                request.setAttribute("id", id);


                String method = request.getParameter("_method");
                if ("PUT".equalsIgnoreCase(method)) {
                    //request.getRequestDispatcher("/PharmLocation/pharmacien/modifierPharmacien.jsp").forward(request, response);
                	System.out.printf("pharmacien",pharmacien);
    	            response.sendRedirect("/PharmLocation/pharmacien/modifierPharmacien.jsp");
                } else {
                    request.getRequestDispatcher("pharmacien/pharmacienDetail.jsp").forward(request, response);
                } 
            } else {

                List<Pharmacie> pharmacies = pharmacieDAO.getAll();
                request.setAttribute("pharmacies", pharmacies);
                List<Pharmacien> pharmaciens = pharmacienDAO.getAll();
                request.setAttribute("pharmaciens", pharmaciens);
                request.getRequestDispatcher("pharmacien/pharmacienList.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la récupération des pharmaciens", e);
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
    	
    	
	    	String nom = request.getParameter("nom");
	        String email = request.getParameter("email");
	        String telephone = request.getParameter("telephone");
	        String adresse = request.getParameter("adresse");
	        String password = request.getParameter("password");
	        int pharmacieId = Integer.parseInt(request.getParameter("pharmacie_id"));
	
	        Pharmacien pharmacien = new Pharmacien(0, nom, email, telephone, adresse, password, new Pharmacie(pharmacieId, ""));
	        try {
	            pharmacienDAO.create(pharmacien);
	            response.sendRedirect("/PharmLocation/pharmacien");
	        } catch (SQLException e) {
	            throw new ServletException("Erreur lors de l'ajout du pharmacien", e);
	        }
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");
        String adresse = request.getParameter("adresse");
        String password = request.getParameter("password");
        int pharmacieId = Integer.parseInt(request.getParameter("pharmacie_id"));

        Pharmacien pharmacien = new Pharmacien(id, nom, email, telephone, adresse, password, new Pharmacie(pharmacieId, ""));
        try {
            pharmacienDAO.update(pharmacien);
            response.sendRedirect("pharmacien");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la mise à jour du pharmacien", e);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            pharmacienDAO.delete(id);
            response.sendRedirect("pharmacien");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la suppression du pharmacien", e);
        }
    }
}
