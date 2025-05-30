package model;

import java.util.List;

public class Pharmacie {
    private int id;
    private String nom;
    private String adresse;
    private String coordonneesGPS;
    private List<Stock> stock;
    private String logoUrl; // Nouveau champ

    public Pharmacie() {}

    // Constructeur existant avec nouveau paramètre logoUrl
    public Pharmacie(int id, String nom, String adresse, String coordonneesGPS, 
                    List<Stock> stock, String logoUrl) {
        this.id = id;
        this.nom = nom;
        this.adresse = adresse;
        this.coordonneesGPS = coordonneesGPS;
        this.stock = stock;
        this.logoUrl = logoUrl;
    }

    // Nouveaux constructeurs pour compatibilité
    public Pharmacie(int id, String nom) {
        this(id, nom, "", "", null, "");
    }
    
    public Pharmacie(int id, String nom, String adresse) {
        this(id, nom, adresse, "", null, "");
    }

    // Getters et Setters
    public String getLogoUrl() { return logoUrl; }
    public void setLogoUrl(String logoUrl) { this.logoUrl = logoUrl; }
    

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    public String getCoordonneesGPS() { return coordonneesGPS; }
    public void setCoordonneesGPS(String coordonneesGPS) { this.coordonneesGPS = coordonneesGPS; }


    public List<Stock> getStock() { return stock; }
    public void setStock(List<Stock> stock) { this.stock = stock; }
}