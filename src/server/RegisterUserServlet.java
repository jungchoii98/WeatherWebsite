package server;

import java.io.IOException;


import java.io.PrintWriter;

import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RegisterUserServlet
 */
@WebServlet("/RegisterUserServlet")
public class RegisterUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RegisterUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//user input
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		
		//keeps track of which user its currently at
		HttpSession session = request.getSession();
		int currentUser;
		
		//variables for accessing database
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		PreparedStatement ps3 = null;
		
		//if the password and confirm password sections are not equal, give this output
		if( !(password.equals(confirmPassword)) ) {
			PrintWriter out = response.getWriter();
			out.print("The passwords do not match.");
			return;
		}
		
		
		//insert the info into the database
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HW3Database?user=root&password=youtube1");
			
			//if the username already exists in the database, give this output
			String query = "SELECT * FROM UserInfo WHERE username=?";
			ps = conn.prepareStatement(query);
			ps.setString(1,  username);
			rs = ps.executeQuery();
			if( rs.next() ) {
					response.setContentType("text/html");
					PrintWriter out = response.getWriter();
					out.print("This username is already taken.");
					return;
				
			}
			
			//insert the username and password
			query = " insert into UserInfo (username, password)" + " values (?, ?)";
			ps2 = conn.prepareStatement(query);
			ps2.setString(1, username);
			ps2.setString(2,  password);
			ps2.execute();
			
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
		}finally {
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
			}catch (SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
			}
		}
	}

}
