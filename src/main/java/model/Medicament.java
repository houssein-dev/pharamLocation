package model;


public class Medicament {
    private int id;
    private String nom;
    private String dosage;
    private String laboratoire;
    private boolean disponibilite;
    private float prix;
    private String imageUrl; // Nouveau champ

    public Medicament() {}

    // Constructeur existant avec nouveau paramètre imageUrl
    public Medicament(int id, String nom, String dosage, String laboratoire, 
                     boolean disponibilite, float prix, String imageUrl) {
        this.id = id;
        this.nom = nom;
        this.dosage = dosage;
        this.laboratoire = laboratoire;
        this.disponibilite = disponibilite;
        this.prix = prix;
        this.imageUrl = imageUrl;
    }

    // Nouveau constructeur pour compatibilité descendante
    public Medicament(int id, String nom, String dosage, String laboratoire, 
                     boolean disponibilite, float prix) {
        this(id, nom, dosage, laboratoire, disponibilite, prix, "");
    }

    // Getters et Setters
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    


    // Getters et Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getDosage() { return dosage; }
    public void setDosage(String dosage) { this.dosage = dosage; }
    public String getLaboratoire() { return laboratoire; }
    public void setLaboratoire(String laboratoire) { this.laboratoire = laboratoire; }
    public boolean isDisponibilite() { return disponibilite; }
    public void setDisponibilite(boolean disponibilite) { this.disponibilite = disponibilite; }
    public float getPrix() { return prix; }
    public void setPrix(float prix) { this.prix = prix; }
}
