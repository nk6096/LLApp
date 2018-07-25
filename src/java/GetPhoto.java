import db.DbConnect;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetPhoto extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
String e=request.getParameter("email");
ServletContext application=getServletContext();
DbConnect db=(DbConnect)application.getAttribute("db");
    if(db==null){
    db=new DbConnect();
    application.setAttribute("db",db);
    }
    PreparedStatement userDetails=db.getUserDetails();
userDetails.setString(1, e);
    ResultSet rs=userDetails.executeQuery();
    if(rs.next()){
    response.getOutputStream().write(rs.getBytes(6)); 
} 
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
