package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.ConexionMySQL;

public class Producto {
	// Atributos
	private String codigo,modelo;
	private int id,stock;
	private double precio;
	
	// Set y Get
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getModelo() {
		return modelo;
	}
	public void setModelo(String modelo) {
		this.modelo = modelo;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public double getPrecio() {
		return precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	// Metodos para el CRUD
	public boolean crearProducto() {
		String sql = "INSERT INTO producto (codigo,modelo,stock,precio) VALUES (?,?,?,?)";
		try(Connection con = ConexionMySQL.obtenerConexion();
			PreparedStatement ps = con.prepareStatement(sql)) {
		
		ps.setString(1, getCodigo());
		ps.setString(2, getModelo());
		ps.setInt(3, getStock());
		ps.setDouble(4, getPrecio());
		
		// Ejecutar
		int filasAfectadas = ps.executeUpdate();
		return filasAfectadas > 0;
		
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public List<Producto> obtenerTodosLosProductos() {
		List<Producto> lista = new ArrayList<>();
		String sql = "SELECT id, codigo, modelo, stock, precio FROM producto";
		
		try(Connection con = ConexionMySQL.obtenerConexion();
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery()) {
			
			while (rs.next()) {
				Producto p = new Producto();
				p.setId(rs.getInt("id"));
				p.setStock(rs.getInt("stock"));
				p.setPrecio(rs.getDouble("precio"));
				p.setCodigo(rs.getString("codigo"));
				p.setModelo(rs.getString("modelo"));
				lista.add(p);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public boolean eliminarProducto(int id) {
		String sql = "DELETE FROM producto WHERE id = ?";
		try (Connection con = ConexionMySQL.obtenerConexion();
			PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setInt(1, id);
			
			int filasAfectadas = ps.executeUpdate();
			return filasAfectadas > 0;
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public Producto obtenerProductoPorId(int id) throws ClassNotFoundException, SQLException {
		
		Connection con = ConexionMySQL.obtenerConexion();
		Producto objPro = null;
		
		String sql = "SELECT id, stock, precio, codigo, modelo FROM producto WHERE id = ?";
		
		PreparedStatement pstsmt = con.prepareStatement(sql);
		pstsmt.setInt(1, id);
		
		ResultSet rs = pstsmt.executeQuery();
		
		if(rs.next()) {
			objPro = new Producto();
			
			objPro.setId(rs.getInt("id"));
			objPro.setStock(rs.getInt("stock"));
			objPro.setPrecio(rs.getDouble("precio"));
			objPro.setCodigo(rs.getString("codigo"));
			objPro.setModelo(rs.getString("modelo"));
		}
		
		return objPro;
	}
	
	public boolean actualizarProducto() throws SQLException, ClassNotFoundException {
		
		Connection con = ConexionMySQL.obtenerConexion();
		String sql = "UPDATE producto SET codigo = ?, modelo = ?, stock = ?, precio = ? WHERE id = ?";
		PreparedStatement pstsmt = con.prepareStatement(sql);
		pstsmt.setString(1, getCodigo());
		pstsmt.setString(2, getModelo());
		pstsmt.setInt(3, stock);
		pstsmt.setDouble(4, getPrecio());
		pstsmt.setInt(5, getId());
		
		int filasAfectaron = pstsmt.executeUpdate();
		
		if(filasAfectaron > 0) {
			return true;
		}
		
		return false;
	}
}
