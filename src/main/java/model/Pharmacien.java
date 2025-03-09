package model;

public class Pharmacien extends Utilisateur {
    private Pharmacie pharmacie;

    public Pharmacien() {}

    public Pharmacien(int id, String nom, String email, String telephone, String adresse, String password, Pharmacie pharmacie) {
        super(id, nom, email, telephone, adresse, password);
        this.pharmacie = pharmacie;
    }

    
    public Pharmacien(int id, String nom, String email, String telephone, String adresse, String password,String role, Pharmacie pharmacie) {
        super(id, nom, email, telephone, adresse, password,role);
        this.pharmacie = pharmacie;
    }
    public Pharmacie getPharmacie() { return pharmacie; }
    public void setPharmacie(Pharmacie pharmacie) { this.pharmacie = pharmacie; }
}
