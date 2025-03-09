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
       


    public RegisterController() {
        super();

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.getRequestDispatcher("auth/registre.jsp").forward(request, response);

	}



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		  String nom = request.getParameter("nom");
	        String email = request.getParameter("email");
	        String telephone = request.getParameter("telephone");
	        String adresse = request.getParameter("adresse");
	        String password = request.getParameter("password");
            String role = request.getParameter("role");
            System.out.println("Vous avez sélectionné l'option : " + role);

			Pharmacien pharmacien=null;

            Utilisateur utilisateur = null;

            if (role != null) {
                if (role.equals("1")) {
                    System.out.println("from cond 1 : ");
                    utilisateur = new Utilisateur(0, nom, email, telephone, adresse, password);
                } else if (role.equals("2")) {
                    System.out.println("from cond 2 : ");
        	        pharmacien = new Pharmacien(0, nom, email, telephone, adresse, password, new Pharmacie(1, ""));

                } else {
                    System.out.println("from cond else : ");
                    utilisateur = new Utilisateur(0, nom, email, telephone, adresse, password);
                }
            } else {
                // Si `role` est null, on attribue une valeur par défaut
                System.out.println("Le rôle est null, affectation par défaut.");
                utilisateur = new Utilisateur(0, nom, email, telephone, adresse, password);
            }
            

	        System.out.print(utilisateur);
	        if(utilisateur==null) {
		     try (Connection conn = DBConnection.getConnection()) {
		         

		            PharmacienDAO pharmacienDAO = new PharmacienDAO(conn);
					pharmacienDAO.create(pharmacien);
		    	    request.getRequestDispatcher("auth/connect.jsp").forward(request, response);
		        } catch (SQLException e) {
		            throw new ServletException("Erreur lors de l'ajout du pharmacien", e);
		        }
	        }else {
			        try (Connection conn = DBConnection.getConnection()) {
			    			
			            UtilisateurDAO dao = new UtilisateurDAO(conn);
			                
			            dao.create(utilisateur);
			            request.setAttribute("message", "Compte créé avec succès !");
			    	    request.getRequestDispatcher("auth/connect.jsp").forward(request, response);
			        } catch (SQLException e) {
			            e.printStackTrace();
			            request.setAttribute("error", e);
			    	    request.getRequestDispatcher("WEB-INF/views/utilisateur/error.jsp").forward(request, response);
		
			        }
	        }
	}

}
