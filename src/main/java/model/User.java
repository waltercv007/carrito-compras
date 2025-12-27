package model;

import connection.ConexionMySQL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class User {
    private int id;
    private String username;
    private String password; // Storing plain text password as per user's request for simplicity

    public User() {
    }

    public User(int id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Authenticates a user by checking their username and password against the database.
     * Returns a User object if credentials are valid, otherwise returns null.
     * @param username The username provided by the user.
     * @param password The password provided by the user (plain text, as stored).
     * @return A User object if authentication is successful, null otherwise.
     */
    public static User authenticate(String username, String password) {
        User user = null;
        String sql = "SELECT id, username, password FROM users WHERE username = ? AND password = ?";

        try (Connection con = ConexionMySQL.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
