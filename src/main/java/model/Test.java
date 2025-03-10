package model;

import model.*;

import java.util.ArrayList;
import java.util.List;

public class Test {
    public static void main(String[] args) {
        // Création de médicaments
        Medicament paracetamol = new Medicament(1, "Paracétamol", "500mg", "Sanofi", true, 2.5f);
        Medicament ibuprofene = new Medicament(2, "Ibuprofène", "400mg", "Bayer", true, 3.0f);

        // Création d'une pharmacie
        Pharmacie pharmacie1 = new Pharmacie(1, "Pharmacie Centrale", "123 Rue Principale", "35.6895, 139.6917",null);

        // Création d'un stock (utilisation correcte de List<Stock>)
        List<Stock> stockList = new ArrayList<>();  // ✅ Correction : On utilise List<Stock>

        // Ajout des médicaments avec leur quantité
        stockList.add(new Stock(pharmacie1, paracetamol, 50)); // ✅ Correct
        stockList.add(new Stock(pharmacie1, ibuprofene, 30));  // ✅ Correct

        // Ajout du stock à la pharmacie
        pharmacie1.setStock(stockList);

        // Affichage des médicaments en stock
        System.out.println("Stock de la " + pharmacie1.getNom() + " :");
        for (Stock stock : pharmacie1.getStock()) {  // ✅ Correction : Boucle sur List<Stock>
            System.out.println("- " + stock.getMedicament().getNom() + " : " + stock.getQuantite() + " unités");
        }
    }
}
