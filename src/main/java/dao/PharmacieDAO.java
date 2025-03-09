package dao;

import model.Pharmacie;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PharmacieDAO {
    private Connection connection;

    public PharmacieDAO(Connection connection) {
        this.connection = connection;
    }

    // CREATE - Ajouter une pharmacie
    public void create(Pharmacie pharmacie) throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
    	
        String sql = "INSERT INTO Pharmacie (nom, adresse, coordonneesGPS) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, pharmacie.getNom());
            stmt.setString(2, pharmacie.getAdresse());
            stmt.setString(3, pharmacie.getCoordonneesGPS());
            stmt.executeUpdate();
            
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                pharmacie.setId(generatedKeys.getInt(1));
            }
        }
    }

    // READ - Récupérer une pharmacie par ID
    public Pharmacie read(int id) throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
    	
        String sql = "SELECT * FROM Pharmacie WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Pharmacie(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("adresse"),
                        rs.getString("coordonneesGPS"),
                        new ArrayList<>() // Stock non chargé ici
                );
            }
        }
        return null;
    }

    // UPDATE - Modifier une pharmacie
    public void update(Pharmacie pharmacie) throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
    	
        String sql = "UPDATE Pharmacie SET nom = ?, adresse = ?, coordonneesGPS = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, pharmacie.getNom());
            stmt.setString(2, pharmacie.getAdresse());
            stmt.setString(3, pharmacie.getCoordonneesGPS());
            stmt.setInt(4, pharmacie.getId());
            stmt.executeUpdate();
        }
    }

    // DELETE - Supprimer une pharmacie
    public void delete(int id) throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
    	
        String sql = "DELETE FROM Pharmacie WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // GET ALL - Récupérer toutes les pharmacies
    public List<Pharmacie> getAll() throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
    	
        List<Pharmacie> pharmacies = new ArrayList<>();
        String sql = "SELECT * FROM Pharmacie";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                pharmacies.add(new Pharmacie(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("adresse"),
                        rs.getString("coordonneesGPS"),
                        new ArrayList<>()
                ));
            }
        }
        return pharmacies;
    }
}
