package model;

public class Utilisateur {
    private int id;
    private String nom;
    private String email;
    private String telephone;
    private String adresse;
    private String password;
    private String role="utilisateur" ;
    
    
    public Utilisateur() {}

    public Utilisateur(int id, String nom, String email, String telephone, String adresse,String password) {
        this.id = id;
        this.nom = nom;
        this.email = email;
        this.telephone = telephone;
        this.adresse = adresse;
        this.password=password;
    }
    
    public Utilisateur(int id, String nom, String email, String telephone, String adresse,String password ,String role) {
        this.id = id;
        this.nom = nom;
        this.email = email;
        this.telephone = telephone;
        this.adresse = adresse;
        this.password=password;
        this.role=role;
    }
    
    
    public Utilisateur(int id, String nom, String email) {
        this.id = id;
        this.nom = nom;
        this.email = email;
    }

    // Getters et Setters
    public int getId() { return id; }
    public String getRole() { return this.role; }

    public String getNom() { return nom; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getTelephone() { return telephone ;}
    public String getAdresse() { return adresse ;}


    public void setId(int id) { this.id = id; }
    public void setNom(String nom) { this.nom = nom; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
    public void setTelephone(String telephone) {this.telephone =telephone ;}
    public void setAdresse(String adresse) { this.adresse = adresse ; }
    public void setRole(String role) { this.role = role; }

}
