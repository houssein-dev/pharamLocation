package dao;

import model.Stock;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StockDAO {
    private Connection connection;

    public StockDAO(Connection connection) {
        this.connection = connection;
    }

    // CREATE - Ajouter un stock
    public void create(Stock stock) throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
        }
        String sql = "INSERT INTO Stock (pharmacie_id, medicament_id, quantite) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, stock.getPharmacie().getId());
            stmt.setInt(2, stock.getMedicament().getId());
            stmt.setInt(3, stock.getQuantite());
            stmt.executeUpdate();
        }
    }

    // READ - Récupérer le stock d'un médicament dans une pharmacie
    public Stock read(int pharmacieId, int medicamentId) throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
        }
        PharmacieDAO ph =new PharmacieDAO(connection);
        MedicamentDAO md =new MedicamentDAO(connection);

        String sql = "SELECT * FROM Stock WHERE pharmacie_id = ? AND medicament_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, pharmacieId);
            stmt.setInt(2, medicamentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Stock(
                		ph.read(rs.getInt("pharmacie_id")),
                		md.read(rs.getInt("medicament_id")),
                        rs.getInt("quantite")
                );
            }
        }
        return null;
    }
    public List<Stock> getByMedicamentId(int medicamentId) throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
        }
        PharmacieDAO ph =new PharmacieDAO(connection);
        MedicamentDAO md =new MedicamentDAO(connection);
        
        List<Stock> stocks = new ArrayList<>();
        String sql = "SELECT * FROM Stock WHERE medicament_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, medicamentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                stocks.add(new Stock(
                    ph.read(rs.getInt("pharmacie_id")),
                    md.read(medicamentId), 
                    rs.getInt("quantite")
                ));
            }
        }
        return stocks;
    }

    // UPDATE - Modifier la quantité d'un médicament en stock
    public void update(Stock stock) throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
        }
        String sql = "UPDATE Stock SET quantite = ? WHERE pharmacie_id = ? AND medicament_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, stock.getQuantite());
            stmt.setInt(2, stock.getPharmacie().getId());
            stmt.setInt(3, stock.getMedicament().getId());
            stmt.executeUpdate();
        }
    }

    // DELETE - Supprimer un stock
    public void delete(int pharmacieId, int medicamentId) throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
        }
        String sql = "DELETE FROM Stock WHERE pharmacie_id = ? AND medicament_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, pharmacieId);
            stmt.setInt(2, medicamentId);
            stmt.executeUpdate();
        }
    }

    // GET ALL - Récupérer tous les stocks d'une pharmacie
    public List<Stock> getAll(int pharmacieId) throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmalocator", "root", "");
        }
        PharmacieDAO ph =new PharmacieDAO(connection);
        MedicamentDAO md =new MedicamentDAO(connection);

        List<Stock> stocks = new ArrayList<>();
        String sql = "SELECT * FROM Stock WHERE pharmacie_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, pharmacieId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                stocks.add(new Stock(
	                		ph.read(rs.getInt("pharmacie_id")),
	                		md.read(rs.getInt("medicament_id")),
	                        rs.getInt("quantite")
	                        )
                		);
            }
        }
        return stocks;
    }
}
