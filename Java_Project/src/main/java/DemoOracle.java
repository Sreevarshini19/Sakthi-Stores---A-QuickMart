import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.*;
@WebServlet("/DemoOracle")
public class DemoOracle extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out= response.getWriter();
		ResultSet rs=null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","sreevarshini");
			System.out.println("Connection Established Successfully"+con);
			out.println("Connection  Established Successfully"+con);
			Statement st= con.createStatement();
			String query="Select * from student";
			rs=st.executeQuery(query);
			while(rs.next()) {
				int sno=rs.getInt(1);
				String name=rs.getString(2);
				int mark=rs.getInt(3);
				System.out.println("Sno "+sno +" Name "+name+" mark "+mark);
				
			}
		}
		catch(ClassNotFoundException e) {
			e.printStackTrace();	
		}
		catch(SQLException e) {
			e.printStackTrace();
			
		}
		catch(Exception e) {
			e.printStackTrace();	
		}
	}
}
