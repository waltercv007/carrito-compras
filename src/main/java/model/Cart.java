package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.ConexionMySQL;

public class Cart {

    /**
     * Retrieves a list of all products currently in the cart.
     * It joins the 'cart' and 'producto' tables to get full product details.
     * @return A list of Producto objects.
     */
    public List<Producto> getCartProducts() {
        List<Producto> cartProducts = new ArrayList<>();
        // The SQL query joins cart and producto tables and retrieves all columns from producto
        String sql = "SELECT p.* FROM producto p JOIN cart c ON p.id = c.producto_id";

        try (Connection con = ConexionMySQL.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setId(rs.getInt("id"));
                p.setStock(rs.getInt("stock"));
                p.setPrecio(rs.getDouble("precio"));
                p.setCodigo(rs.getString("codigo"));
                p.setModelo(rs.getString("modelo"));
                p.setImagen(rs.getString("imagen"));
                cartProducts.add(p);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return cartProducts;
    }

    /**
     * Adds a product to the cart by its ID, but only if it's not already there.
     * @param producto_id The ID of the product to add.
     * @return true if the product was added, false otherwise.
     */
    public boolean addProduct(int producto_id) {
    	// 1. Verificar si el producto ya está en el Cart
        String checkSql = "SELECT COUNT(*) FROM cart WHERE producto_id = ?";
        try (Connection con = ConexionMySQL.obtenerConexion();
             PreparedStatement checkPs = con.prepareStatement(checkSql)) {
            
            checkPs.setInt(1, producto_id);
            try (ResultSet rs = checkPs.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    // Product is already in the cart
                    return false; 
                }
            }

            // If not in the cart, insert it
            String insertSql = "INSERT INTO cart (producto_id) VALUES (?)";
            try (PreparedStatement insertPs = con.prepareStatement(insertSql)) {
                insertPs.setInt(1, producto_id);
                int filasAfectadas = insertPs.executeUpdate();
                return filasAfectadas > 0;
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Removes a product from the cart using its product ID.
     * @param producto_id The ID of the product to remove.
     * @return true if the product was removed, false otherwise.
     */
    public boolean removeProduct(int producto_id) {
        String sql = "DELETE FROM cart WHERE producto_id = ?";
        try (Connection con = ConexionMySQL.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, producto_id);
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
