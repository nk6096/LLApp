<%@page import="java.sql.PreparedStatement"%>
<%@page import="db.DbConnect"%>
<%@page import="java.util.HashMap"%>
<%
HashMap ud=(HashMap)session.getAttribute("userdata");
if(ud!=null){
    int upid=Integer.parseInt(request.getParameter("upid"));
    DbConnect db=(DbConnect)application.getAttribute("db");
    if(db==null){
    db=new DbConnect();
    application.setAttribute("db",db);
    }
    PreparedStatement deleteFile=db.getDeleteFile();
    deleteFile.setInt(1, upid);
    deleteFile.executeUpdate();
    session.setAttribute("msg", "File Deleted.");
    response.sendRedirect("Profile.jsp");
}else{
    session.setAttribute("msg","Plz Login First!");
        response.sendRedirect("index.jsp");
}
%>