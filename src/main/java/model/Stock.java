package model;

public class Stock {
    private Pharmacie pharmacie;
    private Medicament medicament;
    private int quantite;

    public Stock() {}

    public Stock(Pharmacie pharmacie, Medicament medicament, int quantite) {
        this.pharmacie = pharmacie;
        this.medicament = medicament;
        this.quantite = quantite;
    }
    
    

    // Getters et Setters
    public Pharmacie getPharmacie() { return pharmacie; }
    public void setPharmacie(Pharmacie pharmacie) { this.pharmacie = pharmacie; }
    
    public Medicament getMedicament() { return medicament; }
    public void setMedicament(Medicament medicament) { this.medicament = medicament; }
    
    public int getQuantite() { return quantite; }
    public void setQuantite(int quantite) { this.quantite = quantite; }
}
