package model;

import java.util.List;

public class Commande {
    private int id;
    private Utilisateur utilisateur;
    private Pharmacie pharmacie;
    private List<Medicament> medicaments;
    private String statut;

    public Commande() {}

    public Commande(int id, Utilisateur utilisateur, Pharmacie pharmacie, List<Medicament> medicaments, String statut) {
        this.id = id;
        this.utilisateur = utilisateur;
        this.pharmacie = pharmacie;
        this.medicaments = medicaments;
        this.statut = statut;
    }

    // Getters et Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Utilisateur getUtilisateur() { return utilisateur; }
    public void setUtilisateur(Utilisateur utilisateur) { this.utilisateur = utilisateur; }
    public Pharmacie getPharmacie() { return pharmacie; }
    public void setPharmacie(Pharmacie pharmacie) { this.pharmacie = pharmacie; }
    public List<Medicament> getMedicaments() { return medicaments; }
    public void setMedicaments(List<Medicament> medicaments) { this.medicaments = medicaments; }
    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }
}
