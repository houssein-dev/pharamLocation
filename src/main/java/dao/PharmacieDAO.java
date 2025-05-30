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
        String sql = "INSERT INTO Pharmacie (nom, adresse, coordonneesGPS, logoUrl) " +
                     "VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, pharmacie.getNom());
            stmt.setString(2, pharmacie.getAdresse());
            stmt.setString(3, pharmacie.getCoordonneesGPS());
            stmt.setString(4, pharmacie.getLogoUrl()); 
            stmt.executeUpdate();
            
        }
    }

    // READ - Récupérer une pharmacie par ID
    public Pharmacie read(int id) throws SQLException {
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
                    new ArrayList<>(), // Stock non chargé ici
                    rs.getString("logoUrl") // Nouveau champ
                );
            }
        }
        return null;
    }

    // UPDATE - Modifier une pharmacie
    public void update(Pharmacie pharmacie) throws SQLException {
        String sql = "UPDATE Pharmacie SET nom = ?, adresse = ?, coordonneesGPS = ?, " +
                     "logoUrl = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, pharmacie.getNom());
            stmt.setString(2, pharmacie.getAdresse());
            stmt.setString(3, pharmacie.getCoordonneesGPS());
            stmt.setString(4, pharmacie.getLogoUrl()); // Nouveau champ
            stmt.setInt(5, pharmacie.getId());
            stmt.executeUpdate();
        }
    }

    // GET ALL - Récupérer toutes les pharmacies
    public List<Pharmacie> getAll() throws SQLException {
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
                    new ArrayList<>(),
                    rs.getString("logoUrl") // Nouveau champ
                ));
            }
        }
        return pharmacies;
    }

// DELETE - Supprimer un pharmacien
public void delete(int id) throws SQLException {
	
	if (connection == null || connection.isClosed()) {
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
	}
	
	
    String sql = "DELETE FROM pharmacie WHERE id = ?";
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }
}}