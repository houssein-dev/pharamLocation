package dao;

import model.Utilisateur;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UtilisateurDAO {
    private Connection connection;

    public UtilisateurDAO(Connection connection) {
        this.connection = connection;
    }

    // CREATE - Ajouter un utilisateur
    public void create(Utilisateur utilisateur) throws SQLException {
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
        String sql = "INSERT INTO utilisateur (nom, email, telephone, adresse, password,role) VALUES (?, ?, ?, ?, ?,?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getEmail());
            stmt.setString(3, utilisateur.getTelephone());
            stmt.setString(4, utilisateur.getAdresse());
            stmt.setString(5, utilisateur.getPassword());
            stmt.setString(6, utilisateur.getRole());

            stmt.executeUpdate();
        }
    }

    // READ - Récupérer un utilisateur par ID
    public Utilisateur read(int id) throws SQLException {
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
        String sql = "SELECT * FROM utilisateur WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Utilisateur(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("email"),
                        rs.getString("telephone"),
                        rs.getString("adresse"),
                        rs.getString("password")
                );
            }
        }
        return null;
    }

    // UPDATE - Modifier un utilisateur
    public void update(Utilisateur utilisateur) throws SQLException {
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
        String sql = "UPDATE utilisateur SET nom = ?, email = ?, telephone = ?, adresse = ?, password = ?, role = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getEmail());
            stmt.setString(3, utilisateur.getTelephone());
            stmt.setString(4, utilisateur.getAdresse());
            stmt.setString(5, utilisateur.getPassword());
            stmt.setString(6, utilisateur.getRole());
            stmt.setInt(6, utilisateur.getId());
            stmt.executeUpdate();
        }
    }

    
    // DELETE - Supprimer un utilisateur
    public void delete(int id) throws SQLException {
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
        String sql = "DELETE FROM utilisateur WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // GET ALL - Récupérer tous les utilisateurs
    public List<Utilisateur> getAll() throws SQLException {
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
        List<Utilisateur> utilisateurs = new ArrayList<>();
        String sql = "SELECT * FROM utilisateur";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                utilisateurs.add(new Utilisateur(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("email"),
                        rs.getString("telephone"),
                        rs.getString("adresse"),
                        rs.getString("password")
                ));
            }
        }
        return utilisateurs;
    }
    public Utilisateur findByEmailAndPassword(String email, String password) throws SQLException {
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}

    	String sql = "SELECT * FROM utilisateur WHERE email = ? AND password = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Utilisateur(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("email")
//                        2323,'kiffa', '    ',
//                        rs.getString("telephone"),
//                        rs.getString("adresse"),
//                        rs.getString("password")
                );
            }
        }
        return null; // Aucun utilisateur trouvé
}}
