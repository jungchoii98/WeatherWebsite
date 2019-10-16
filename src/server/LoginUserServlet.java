package server;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginUserServlet
 */
@WebServlet("/LoginUserServlet")
public class LoginUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//user input
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		//keeps track of which user its currently at
		HttpSession session = request.getSession();
		int currentUser;
		
		//variables for accessing database
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		PreparedStatement ps3 = null;
		
		//check if username exists in the database
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HW3Database?user=root&password=youtube1");
			
			//if the username does not exist
			String query = "SELECT * FROM UserInfo WHERE username=?";
			ps = conn.prepareStatement(query);
			ps.setString(1,  username);
			rs = ps.executeQuery();
			if( !(rs.next()) ) {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.print("This user does not exist.");
				return;
			}
			
			
			//if the password does not exist
			query = "SELECT * FROM UserInfo WHERE username=? AND password=?";
			ps2 = conn.prepareStatement(query);
			ps2.setString(1, username);
			ps2.setString(2,  password);
			rs = ps2.executeQuery();
			if( !(rs.next()) ) {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.print("Incorrect Password.");
				return;
			}
			
			//if everything is successful is then get the userID
			query = "SELECT * FROM UserInfo WHERE username=?";
			ps3 = conn.prepareStatement(query);
			ps3.setString(1,  username);
			rs = ps3.executeQuery();
			rs.next();
			currentUser = rs.getInt("userID");
			session.setAttribute("currentUser", currentUser);
		}catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
				if(ps2 != null) {
					ps2.close();
				}
				if(ps3 != null) {
					ps3.close();
				}
			}catch(SQLException sqle) {
			System.out.println("sqle closing stuff: " + sqle.getMessage());
		 }
		}
	}


}
