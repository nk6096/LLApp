
import db.DbConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@MultipartConfig
public class Upload extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
HttpSession session=request.getSession();
HashMap ud=(HashMap)session.getAttribute("userdata");
if(ud!=null){
try{
    String e=(String)ud.get("email");
    
    java.util.Date dt=new java.util.Date();
    java.sql.Date date=new java.sql.Date(dt.getTime());
//code end
    
//code to get file from form request 
javax.servlet.http.Part file=request.getPart("ufile");
String fname=file.getSubmittedFileName();
java.io.InputStream fis=file.getInputStream();
//code end
ServletContext application=getServletContext();
DbConnect db=(DbConnect)application.getAttribute("db");
if(db==null){
db=new DbConnect();
application.setAttribute("db",db);
}
PreparedStatement insertFile=db.getInsertFile();

insertFile.setString(1, e);
insertFile.setString(2, fname);
insertFile.setBinaryStream(3, fis);
insertFile.setDate(4,date);
insertFile.executeUpdate();
session.setAttribute("msg", "Upload Done.");
response.sendRedirect("Profile.jsp");
    
} catch (Exception ex) {
    session.setAttribute("msg", 
            "File Upload Failed "+ex.getMessage());
    ex.printStackTrace();
    response.sendRedirect("Profile.jsp");
} 
}else{
    session.setAttribute("msg","Plz Login First!");
        response.sendRedirect("index.jsp");
}
    }

}
