package model;

import java.util.List;

public class Pharmacie {
    private int id;
    private String nom;
    private String adresse;
    private String coordonneesGPS;
    private List<Medicament> stock;

    public Pharmacie() {}

    public Pharmacie(int id, String nom, String adresse, String coordonneesGPS, List<Medicament> stock) {
        this.id = id;
        this.nom = nom;
        this.adresse = adresse;
        this.coordonneesGPS = coordonneesGPS;
        this.stock = stock;
    }
    
    public Pharmacie(int id, String nom) {
        this.id = id;
        this.nom = nom;

    }
    public Pharmacie(int id, String nom, String adresse) {
        this.id = id;
        this.nom = nom;
        this.adresse = adresse;


    }
    // Getters et Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    public String getCoordonneesGPS() { return coordonneesGPS; }
    public void setCoordonneesGPS(String coordonneesGPS) { this.coordonneesGPS = coordonneesGPS; }
    public List<Medicament> getStock() { return stock; }
    public void setStock(List<Medicament> stock) { this.stock = stock; }
}