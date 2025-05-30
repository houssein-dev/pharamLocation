package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Pharmacien;
import model.Utilisateur;
import util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import dao.PharmacienDAO;
import dao.UtilisateurDAO;



@WebServlet("/auth")

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public LoginController() {
        super();

    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    request.getRequestDispatcher("views/pages/auth/login.jsp").forward(request, response);
	}


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try (Connection conn = DBConnection.getConnection()) {
            UtilisateurDAO dao = new UtilisateurDAO(conn);
            Utilisateur utilisateur = dao.findByEmailAndPassword(email, password);
            
            PharmacienDAO daoPh = new PharmacienDAO(conn);            
            Pharmacien pharmacien = daoPh.findByEmailAndPassword(email, password);
            
            if (utilisateur != null) {
                HttpSession session = request.getSession();
                session.setAttribute("utilisateur", utilisateur);
                session.setAttribute("role", "utilisateur");
                response.sendRedirect(request.getContextPath() + "/main"); 
                
            } else if (pharmacien != null) {
                HttpSession session = request.getSession();
                session.setAttribute("pharmacien", pharmacien);
                session.setAttribute("role", "pharmacien");
                session.setAttribute("pharmacieId", pharmacien.getPharmacie().getId());
                response.sendRedirect(request.getContextPath() + "/main"); 
                
            } else {
                request.setAttribute("error", "Email ou mot de passe incorrect !");
                request.setAttribute("email", email); 
        	    request.getRequestDispatcher("views/pages/auth/login.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Erreur technique. Veuillez réessayer plus tard.");
    	    request.getRequestDispatcher("views/pages/auth/login.jsp").forward(request, response);
        }	
    }
	
}
