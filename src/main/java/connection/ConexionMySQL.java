package connection;

import java.sql.DriverManager; // Para iniciar la cadena de conexion
import java.sql.SQLException;
import java.sql.Connection; // Para traer la conexion a la BD

public class ConexionMySQL {

	// Atributos
	private static final String HOST = "localhost";
	private static final String PUERTO = "3306";
	private static final String BASE_DE_DATOS = "db_carrito_compras"; 
	private static final String USUARIO = "root";
	private static final String PASSWORD = "";
	private static final String URL = "jdbc:mysql://"+HOST+":"+PUERTO+"/"+BASE_DE_DATOS+"?serverTimezone=America/Lima";
	// Metodos
	
	public static Connection obtenerConexion() throws SQLException, ClassNotFoundException {
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		return DriverManager.getConnection(URL,USUARIO,PASSWORD);
		
	}
}
