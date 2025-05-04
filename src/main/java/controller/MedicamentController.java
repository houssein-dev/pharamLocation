package controller;

import dao.MedicamentDAO;
import model.Medicament;
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

@WebServlet("/medicament")
public class MedicamentController extends HttpServlet {
    private MedicamentDAO medicamentDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnection.getConnection();
            medicamentDAO = new MedicamentDAO(connection);
        } catch (SQLException e) {
            throw new ServletException("Erreur de connexion à la base de données", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String search = request.getParameter("search");

        try {
            if (idParam != null) {
                int id = Integer.parseInt(idParam);
                Medicament medicament = medicamentDAO.read(id);
                request.setAttribute("medicament", medicament);
                request.getRequestDispatcher("medicament/medicamentDetail.jsp").forward(request, response);
            }else if(search != null){
            	System.out.printf("========== from search validation ===========",search);
            	List<Medicament> medicaments = medicamentDAO.search(search);
                request.setAttribute("medicaments", medicaments);

                request.getRequestDispatcher("medicament/search.jsp").forward(request, response);

            }
            else {
                List<Medicament> medicaments = medicamentDAO.getAll();
                request.setAttribute("medicaments", medicaments);
                request.getRequestDispatcher("medicament/medicamentList.jsp").forward(request, response);

            }
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la récupération des médicaments", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	
        String method = request.getParameter("_method");
        System.out.println(method);
        if ("PUT".equalsIgnoreCase(method)) {
            doPut(request, response);
        } else if ("DELETE".equalsIgnoreCase(method)) {
            doDelete(request, response);
        }else {
    	
    	
	    	String nom = request.getParameter("nom");
	        String dosage = request.getParameter("dosage");
	        String laboratoire = request.getParameter("laboratoire");
	        boolean disponibilite = Boolean.parseBoolean(request.getParameter("disponibilite"));
	        float prix = Float.parseFloat(request.getParameter("prix"));
	
	        Medicament medicament = new Medicament(0, nom, dosage, laboratoire, disponibilite, prix);
	        try {
	            medicamentDAO.create(medicament);
	            response.sendRedirect("/PharmLocation/auth");
	        } catch (SQLException e) {
	            throw new ServletException("Erreur lors de l'ajout du médicament", e);
	        }
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String dosage = request.getParameter("dosage");
        String laboratoire = request.getParameter("laboratoire");
        boolean disponibilite = Boolean.parseBoolean(request.getParameter("disponibilite"));
        float prix = Float.parseFloat(request.getParameter("prix"));

        Medicament medicament = new Medicament(id, nom, dosage, laboratoire, disponibilite, prix);
        try {
            medicamentDAO.update(medicament);
            response.sendRedirect("/PharmLocation/medicament");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la mise à jour du médicament", e);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            medicamentDAO.delete(id);
            response.sendRedirect("/PharmLocation/medicament");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la suppression du médicament", e);
        }
    }
}
