package dao;

import model.Medicament;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicamentDAO {
    private Connection connection;

    public MedicamentDAO(Connection connection) {
        this.connection = connection;
    }

 // CREATE - Ajouter un médicament
    public void create(Medicament medicament) throws SQLException {
        String sql = "INSERT INTO Medicament (nom, dosage, laboratoire, prix, disponibilite, imageUrl) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, medicament.getNom());
            stmt.setString(2, medicament.getDosage());
            stmt.setString(3, medicament.getLaboratoire());
            stmt.setFloat(4, medicament.getPrix());
            stmt.setBoolean(5, medicament.isDisponibilite());
            stmt.setString(6, medicament.getImageUrl());
            stmt.executeUpdate();
            
            // ... reste du code ...
        }
    }

    // READ - Récupérer un médicament par ID
    public Medicament read(int id) throws SQLException {
        String sql = "SELECT * FROM Medicament WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Medicament(
                    rs.getInt("id"),
                    rs.getString("nom"),
                    rs.getString("dosage"),
                    rs.getString("laboratoire"),
                    rs.getBoolean("disponibilite"),
                    rs.getFloat("prix"),
                    rs.getString("imageUrl") 
                );
            }
        }
        return null;
    }

    // UPDATE - Modifier un médicament
    public void update(Medicament medicament) throws SQLException {
        String sql = "UPDATE Medicament SET nom = ?, dosage = ?, laboratoire = ?, " +
                     "prix = ?, disponibilite = ?, imageUrl = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, medicament.getNom());
            stmt.setString(2, medicament.getDosage());
            stmt.setString(3, medicament.getLaboratoire());
            stmt.setFloat(4, medicament.getPrix());
            stmt.setBoolean(5, medicament.isDisponibilite());
            stmt.setString(6, medicament.getImageUrl()); 
            stmt.setInt(7, medicament.getId());
            stmt.executeUpdate();
        }
    }

    // GET ALL - Récupérer tous les médicaments
    public List<Medicament> getAll() throws SQLException {
        List<Medicament> medicaments = new ArrayList<>();
        String sql = "SELECT * FROM Medicament";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                medicaments.add(new Medicament(
                    rs.getInt("id"),
                    rs.getString("nom"),
                    rs.getString("dosage"),
                    rs.getString("laboratoire"),
                    rs.getBoolean("disponibilite"),
                    rs.getFloat("prix"),
                    rs.getString("imageUrl") 
                ));
            }
        }
        return medicaments;
    }
}
