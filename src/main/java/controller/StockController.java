package controller;

import dao.StockDAO;
import dao.PharmacieDAO;
import dao.MedicamentDAO;
import model.Stock;
import model.Pharmacie;
import model.Medicament;
import util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/stock")
public class StockController extends HttpServlet {
    private StockDAO stockDAO;
    private PharmacieDAO pharmacieDAO;
    private MedicamentDAO medicamentDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnection.getConnection();
            stockDAO = new StockDAO(connection);
            pharmacieDAO = new PharmacieDAO(connection);
            medicamentDAO = new MedicamentDAO(connection);
        } catch (SQLException e) {
            throw new ServletException("Erreur de connexion à la base de données", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        String pharmacieIdParam = request.getParameter("pharmacieId");
        String medicamentIdParam = request.getParameter("medicamentId");
        String action = request.getParameter("action");

        try {
            if (action != null) {
                handleActions(request, response, action);
                return;
            }

            if (bothParamsPresent(pharmacieIdParam, medicamentIdParam)) {
                handleStockDetails(request, response);
                return;
            }

            if (pharmacieIdParam != null) {
                handlePharmacyStocks(request, response);
                return;
            }

            if (medicamentIdParam != null) {
                handleMedicamentAvailability(request, response);
                return;
            }

            sendBadRequest(response, "Paramètres manquants");

        } catch (SQLException e) {
            handleServletError("Erreur lors de la récupération des données", e);
        } catch (NumberFormatException e) {
            sendBadRequest(response, "Format ID invalide");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException, NumberFormatException {
        
        String method = request.getParameter("_method");
        if (method != null) {
            handleHttpMethodOverride(request, response, method);
            return;
        }

        try {
            Stock newStock = createStockFromRequest(request);
            validateStockEntities(newStock);
            stockDAO.create(newStock);
           redirectAfterCreate(request, response, newStock);
            
        } catch (SQLException e) {
            handleServletError("Erreur lors de la création du stock", e);
        } catch (IllegalArgumentException e) {
            sendBadRequest(response, "Données invalides");
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException, NumberFormatException {
        
        try {
            Stock existingStock = getExistingStockFromRequest(request);
            existingStock.setQuantite(Integer.parseInt(request.getParameter("quantite")));
            stockDAO.update(existingStock);
            redirectAfterUpdate(request ,response, existingStock);
            
        } catch (SQLException e) {
            handleServletError("Erreur lors de la mise à jour du stock", e);
        } catch (IllegalArgumentException e) {
            sendBadRequest(response, "Données invalides");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        try {
            int pharmacieId = Integer.parseInt(request.getParameter("pharmacieId"));
            int medicamentId = Integer.parseInt(request.getParameter("medicamentId"));
            
            stockDAO.delete(pharmacieId, medicamentId);
            redirectAfterDelete(request ,response, pharmacieId);
            
        } catch (SQLException e) {
            handleServletError("Erreur lors de la suppression du stock", e);
        } catch (NumberFormatException e) {
            sendBadRequest(response, "ID invalide");
        }
    }

    // Méthodes helper
    private boolean bothParamsPresent(String pharmaId, String medocId) {
        return pharmaId != null && medocId != null;
    }

    private void handleActions(HttpServletRequest request, HttpServletResponse response, String action) 
        throws SQLException, ServletException, IOException {
        
        if ("new".equals(action)) {
            showForm(request, response, false);
        } else if ("edit".equals(action)) {
            showForm(request, response, true);
        }
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response, boolean isEdit) 
        throws SQLException, ServletException, IOException {
        
        if (isEdit) {
            int pharmacieId = Integer.parseInt(request.getParameter("pharmacieId"));
            int medicamentId = Integer.parseInt(request.getParameter("medicamentId"));
            request.setAttribute("stock", stockDAO.read(pharmacieId, medicamentId));
        }
        
        request.setAttribute("pharmacies", pharmacieDAO.getAll());
        request.setAttribute("medicaments", medicamentDAO.getAll());
        request.getRequestDispatcher("WEB-INF/stock/stockForm.jsp").forward(request, response);
    }

    private void handleStockDetails(HttpServletRequest request, HttpServletResponse response) 
        throws SQLException, ServletException, IOException {
        
        int pharmacieId = Integer.parseInt(request.getParameter("pharmacieId"));
        int medicamentId = Integer.parseInt(request.getParameter("medicamentId"));
        
        Stock stock = stockDAO.read(pharmacieId, medicamentId);
        request.setAttribute("stock", stock);
        request.getRequestDispatcher("WEB-INF/stock/stockDetail.jsp").forward(request, response);
    }

    private void handlePharmacyStocks(HttpServletRequest request, HttpServletResponse response) 
        throws SQLException, ServletException, IOException {
        
        int pharmacieId = Integer.parseInt(request.getParameter("pharmacieId"));
        request.setAttribute("stocks", stockDAO.getAll(pharmacieId));
        request.getRequestDispatcher("WEB-INF/stock/stockList.jsp").forward(request, response);
    }

    private void handleMedicamentAvailability(HttpServletRequest request, HttpServletResponse response) 
        throws SQLException, ServletException, IOException {
        
        int medicamentId = Integer.parseInt(request.getParameter("medicamentId"));
        Medicament medicament = medicamentDAO.read(medicamentId);
        
        request.setAttribute("medicament", medicament);
        request.setAttribute("stocks", stockDAO.getByMedicamentId(medicamentId));
        request.getRequestDispatcher("WEB-INF/stock/medicamentAvailability.jsp").forward(request, response);
    }

    private Stock createStockFromRequest(HttpServletRequest request) throws SQLException {
        int pharmacieId = Integer.parseInt(request.getParameter("pharmacieId"));
        int medicamentId = Integer.parseInt(request.getParameter("medicamentId"));
        int quantite = Integer.parseInt(request.getParameter("quantite"));
        
        return new Stock(
            pharmacieDAO.read(pharmacieId),
            medicamentDAO.read(medicamentId),
            quantite
        );
    }

    private void validateStockEntities(Stock stock) throws IllegalArgumentException {
        if (stock.getPharmacie() == null || stock.getMedicament() == null) {
            throw new IllegalArgumentException("Pharmacie ou médicament introuvable");
        }
    }

    private Stock getExistingStockFromRequest(HttpServletRequest request) throws SQLException {
        int pharmacieId = Integer.parseInt(request.getParameter("pharmacieId"));
        int medicamentId = Integer.parseInt(request.getParameter("medicamentId"));
        Stock stock = stockDAO.read(pharmacieId, medicamentId);
        
        if (stock == null) {
            throw new IllegalArgumentException("Stock introuvable");
        }
        return stock;
    }

    // Gestion des redirections
    private void redirectAfterCreate(HttpServletRequest request,HttpServletResponse response, Stock stock) throws IOException {
        response.sendRedirect(request.getContextPath() + 
            "/stock?pharmacieId=" + stock.getPharmacie().getId());
    }

    private void redirectAfterUpdate(HttpServletRequest request,HttpServletResponse response, Stock stock) throws IOException {
        response.sendRedirect(request.getContextPath() + 
            "/stock?pharmacieId=" + stock.getPharmacie().getId());
    }

    private void redirectAfterDelete(HttpServletRequest request,HttpServletResponse response, int pharmacieId) throws IOException {
        response.sendRedirect(request.getContextPath() + 
            "/stock?pharmacieId=" + pharmacieId);
    }

    // Gestion des erreurs
    private void sendBadRequest(HttpServletResponse response, String message) throws IOException {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, message);
    }

    private void handleServletError(String message, Exception e) throws ServletException {
        throw new ServletException(message, e);
    }

    private void handleHttpMethodOverride(HttpServletRequest request, HttpServletResponse response, String method) 
        throws ServletException, IOException {
        
        if ("PUT".equalsIgnoreCase(method)) {
            doPut(request, response);
        } else if ("DELETE".equalsIgnoreCase(method)) {
            doDelete(request, response);
        }
    }
}