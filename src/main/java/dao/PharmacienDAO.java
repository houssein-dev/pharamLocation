package dao;

import model.Pharmacien;
import model.Utilisateur;
import model.Pharmacie;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PharmacienDAO {
    private Connection connection;

    public PharmacienDAO(Connection connection) {
        this.connection = connection;
    }

    // CREATE - Ajouter un pharmacien
    public void create(Pharmacien pharmacien) throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
        String sql = "INSERT INTO pharmacien (nom, email, telephone, adresse, password, pharmacie_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, pharmacien.getNom());
            stmt.setString(2, pharmacien.getEmail());
            stmt.setString(3, pharmacien.getTelephone());
            stmt.setString(4, pharmacien.getAdresse());
            stmt.setString(5, pharmacien.getPassword());
            stmt.setInt(6, pharmacien.getPharmacie().getId());
            stmt.executeUpdate();

            // Récupérer l'ID généré
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    pharmacien.setId(generatedKeys.getInt(1));
                }
            }
        }
    }

    // READ - Récupérer un pharmacien par ID
    public Pharmacien read(int id) throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
        String sql = "SELECT p.*, ph.nom AS pharmacie_nom FROM pharmacien p JOIN pharmacie ph ON p.pharmacie_id = ph.id WHERE p.id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Pharmacie pharmacie = new Pharmacie(rs.getInt("pharmacie_id"), rs.getString("pharmacie_nom"));
                return new Pharmacien(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("email"),
                        rs.getString("telephone"),
                        rs.getString("adresse"),
                        rs.getString("password"),
                        pharmacie
                );
            }
        }
        return null;
    }

    
    public Pharmacien findByEmailAndPassword(String email, String password) throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
        }

        String sql = "SELECT * FROM pharmacien WHERE email = ? AND password = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int pharmacieId = rs.getInt("pharmacie_id");
                    Pharmacie pharmacie = new Pharmacie(pharmacieId, ""); 
                    
                    return new Pharmacien(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("email"),
                        rs.getString("telephone"),
                        rs.getString("adresse"),
                        rs.getString("password"),
                        pharmacie
                    );
                }
            }
        }
        return null;
    }


    // UPDATE - Modifier un pharmacien
    public void update(Pharmacien pharmacien) throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
        String sql = "UPDATE pharmacien SET nom = ?, email = ?, telephone = ?, adresse = ?, password = ?, pharmacie_id = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, pharmacien.getNom());
            stmt.setString(2, pharmacien.getEmail());
            stmt.setString(3, pharmacien.getTelephone());
            stmt.setString(4, pharmacien.getAdresse());
            stmt.setString(5, pharmacien.getPassword());
            stmt.setInt(6, pharmacien.getPharmacie().getId());
            stmt.setInt(7, pharmacien.getId());
            stmt.executeUpdate();
        }
    }

    // DELETE - Supprimer un pharmacien
    public void delete(int id) throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
    	
        String sql = "DELETE FROM pharmacien WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // GET ALL - Récupérer tous les pharmaciens
    public List<Pharmacien> getAll() throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
        List<Pharmacien> pharmaciens = new ArrayList<>();
        String sql = "SELECT p.*, ph.nom AS pharmacie_nom FROM pharmacien p JOIN pharmacie ph ON p.pharmacie_id = ph.id";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Pharmacie pharmacie = new Pharmacie(rs.getInt("pharmacie_id"), rs.getString("pharmacie_nom"));
                Pharmacien pharmacien = new Pharmacien(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("email"),
                        rs.getString("telephone"),
                        rs.getString("adresse"),
                        rs.getString("password"),
                        pharmacie
                );
                pharmaciens.add(pharmacien);
            }
        }
        return pharmaciens;
    }
}
