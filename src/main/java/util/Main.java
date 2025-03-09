package util;

import java.sql.Connection;

import dao.UtilisateurDAO;
import model.Utilisateur;

public class Main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
        try (Connection conn = DBConnection.getConnection()) {
            UtilisateurDAO dao = new UtilisateurDAO(conn);
            
            // Création d'un utilisateur
            Utilisateur user = new Utilisateur( 4, "John Doe", "john@example.com", "123456789", "Rue A", "securePass");
            dao.create(user);
            System.out.println("Utilisateur ajouté avec succès !");

            // Récupération de l'utilisateur
            Utilisateur retrievedUser = dao.read(1);
            if (retrievedUser != null) {
                System.out.println("Utilisateur récupéré : " + retrievedUser.getNom());
            }
            
            // Mise à jour
            retrievedUser.setNom("John Updated");
            dao.update(retrievedUser);
            System.out.println("Utilisateur mis à jour !");

            // Suppression
            dao.delete(1);
            System.out.println("Utilisateur supprimé !");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

}
