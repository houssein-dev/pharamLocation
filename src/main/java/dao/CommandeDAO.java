package dao;

import model.Commande;
import model.Medicament;
import model.Pharmacie;
import model.Utilisateur;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommandeDAO {
    private Connection connection;

    public CommandeDAO(Connection connection) {
        this.connection = connection;
    }

    // Ajouter une commande
    public void ajouterCommande(Commande commande) throws SQLException {
        String sql = "INSERT INTO commande (utilisateur_id, pharmacie_id, statut) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, commande.getUtilisateur().getId());
            stmt.setInt(2, commande.getPharmacie().getId());
            stmt.setString(3, commande.getStatut());
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                int commandeId = rs.getInt(1);
                for (Medicament medicament : commande.getMedicaments()) {
                    ajouterMedicamentCommande(commandeId, medicament.getId());
                }
            }
        }
    }

    // Associer un médicament à une commande
    private void ajouterMedicamentCommande(int commandeId, int medicamentId) throws SQLException {
        String sql = "INSERT INTO commande_medicament (commande_id, medicament_id) VALUES (?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, commandeId);
            stmt.setInt(2, medicamentId);
            stmt.executeUpdate();
        }
    }

    // Récupérer toutes les commandes
    public List<Commande> getAllCommandes() throws SQLException {
        List<Commande> commandes = new ArrayList<>();
        String sql = "SELECT * FROM commande";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Commande commande = new Commande();
                commande.setId(rs.getInt("id"));
                // Ici, il faut récupérer l'utilisateur et la pharmacie en utilisant leur ID
                commandes.add(commande);
            }
        }
        return commandes;
    }

    // Mettre à jour une commande
    public void mettreAJourCommande(Commande commande) throws SQLException {
        String sql = "UPDATE commande SET statut = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, commande.getStatut());
            stmt.setInt(2, commande.getId());
            stmt.executeUpdate();
        }
    }

    // Supprimer une commande
    public void supprimerCommande(int commandeId) throws SQLException {
        String sql = "DELETE FROM commande WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, commandeId);
            stmt.executeUpdate();
        }
    }
}
