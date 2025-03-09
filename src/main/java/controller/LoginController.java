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

	    request.getRequestDispatcher("auth/connect.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
    	System.out.printf("=========password from page jsp =======", email);

		try (Connection conn = DBConnection.getConnection()) {
			
            UtilisateurDAO dao = new UtilisateurDAO(conn);
            Utilisateur utilisateur = dao.findByEmailAndPassword(email, password);
            
            PharmacienDAO daoPh = new PharmacienDAO(conn);            
            Pharmacien pharmacien = daoPh.findByEmailAndPassword(email, password);
            if (utilisateur != null) {
            	
                HttpSession session = request.getSession();
                session.setAttribute("utilisateur", utilisateur);
        	    request.getRequestDispatcher("/main").forward(request, response);
        	    
        	    
            }else if (pharmacien != null) {
            	

                HttpSession session = request.getSession();
                session.setAttribute("pharmacien", pharmacien);
                session.setAttribute("role", pharmacien.getRole());

                //session.setAttribute("roel", "pharmacien");
        	    request.getRequestDispatcher("/main").forward(request, response);
        	    System.out.println("pharmacien exist");
        	    
            }  else {
            	
                request.setAttribute("error", "Email ou mot de passe incorrect !");
        	    request.getRequestDispatcher("auth/connect.jsp").forward(request, response);
        	    
            }
            
        }catch (SQLException e) {
        	
        	e.printStackTrace();
            request.setAttribute("error", e);
    	    request.getRequestDispatcher("WEB-INF/views/utilisateur/error.jsp").forward(request, response);
    	    
        }	
	}

	
}
