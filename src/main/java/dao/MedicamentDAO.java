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
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
    	
        String sql = "INSERT INTO Medicament (nom, dosage, laboratoire, prix, disponibilite) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, medicament.getNom());
            stmt.setString(2, medicament.getDosage());
            stmt.setString(3, medicament.getLaboratoire());
            stmt.setFloat(4, medicament.getPrix());
            stmt.setBoolean(5, medicament.isDisponibilite());
            stmt.executeUpdate();
            
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                medicament.setId(generatedKeys.getInt(1));
            }
        }
    }

    // READ - Récupérer un médicament par ID
    public Medicament read(int id) throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
    	
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
                        rs.getFloat("prix")
                );
            }
        }
        return null;
    }
    public List<Medicament> search(String nom) throws SQLException {
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
    	
        String sql = "SELECT * FROM medicament WHERE nom LIKE ? ";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + nom + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
                List<Medicament> medicaments = new ArrayList<>();
                while (resultSet.next()) {
                    Medicament medicament = new Medicament(
                            resultSet.getInt("id"),
                            resultSet.getString("nom"),
                            resultSet.getString("dosage"),
                            resultSet.getString("laboratoire"),
                            resultSet.getBoolean("disponibilite"),
                            resultSet.getFloat("prix")
                    );
                    medicaments.add(medicament);
                }
                return medicaments;
            }
        }
    }

    // UPDATE - Modifier un médicament
    public void update(Medicament medicament) throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
    	
        String sql = "UPDATE Medicament SET nom = ?, dosage = ?, laboratoire = ?, prix = ?, disponibilite = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, medicament.getNom());
            stmt.setString(2, medicament.getDosage());
            stmt.setString(3, medicament.getLaboratoire());
            stmt.setFloat(4, medicament.getPrix());
            stmt.setBoolean(5, medicament.isDisponibilite());
            stmt.setInt(6, medicament.getId());
            stmt.executeUpdate();
        }
    }

    // DELETE - Supprimer un médicament
    public void delete(int id) throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
    	
        String sql = "DELETE FROM Medicament WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // GET ALL - Récupérer tous les médicaments
    public List<Medicament> getAll() throws SQLException {
    	
    	if (connection == null || connection.isClosed()) {
    		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
    	}
    	
    	
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
                        rs.getFloat("prix")
                ));
            }
        }
        return medicaments;
    }
}
