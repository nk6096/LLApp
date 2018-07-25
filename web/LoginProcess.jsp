<%@page import="db.DbConnect"%>
<%@page errorPage="ExceptionPage.jsp"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.*"%>
<% 
    String e=request.getParameter("email");
    String p=request.getParameter("pass");
    DbConnect db=(DbConnect)application.getAttribute("db");
    if(db==null){
    db=new DbConnect();
    application.setAttribute("db",db);
    }
    PreparedStatement checkUser=db.getCheckUser();
    checkUser.setString(1, e);
    checkUser.setString(2, p);
    ResultSet rs=checkUser.executeQuery();
    if(rs.next()){
        HashMap ud=new HashMap();
        ud.put("email",rs.getString(1));
        ud.put("name",rs.getString(3));
        ud.put("phone",rs.getString(4));
        ud.put("dob",rs.getString(5));
        session.setAttribute("userdata", ud);
        rs.close();
        response.sendRedirect("Profile.jsp");
    }else{
        session.setAttribute("msg","Invalid UserID or Password!!");
        response.sendRedirect("index.jsp");
    }
%>