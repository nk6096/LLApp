import db.DbConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DwnFile extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
HttpSession session=request.getSession();
try{
HashMap ud=(HashMap)session.getAttribute("userdata");
if(ud!=null){
    int upid=Integer.parseInt(request.getParameter("upid"));
    ServletContext application=getServletContext();
    DbConnect db=(DbConnect)application.getAttribute("db");
    if(db==null){
    db=new DbConnect();
    application.setAttribute("db",db);
    }
    PreparedStatement fetchFile=db.getFetchFile();
    fetchFile.setInt(1, upid);
    ResultSet rs=fetchFile.executeQuery();
    if(rs.next())
    {
        String fname=rs.getString(3);
        response.setContentType("APPLICATION/OCTET-STREAM");   
        response.setHeader("Content-Disposition","attachment; filename="+fname); 
        response.getOutputStream().write(rs.getBytes(4)); 

    }
    
}else{
    session.setAttribute("msg","Plz Login First!");
        response.sendRedirect("index.jsp");
}  
    
} catch (Exception ex) {
    session.setAttribute("msg", 
            "File Download Failed "+ex.getMessage());
    ex.printStackTrace();
    response.sendRedirect("Profile.jsp");
}
    }
}
