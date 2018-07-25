<%-- 
    Document   : Profile
    Created on : Oct 29, 2017, 8:38:25 PM
    Author     : incapp
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="db.DbConnect"%>
<%@page import="java.util.HashMap"%>
<%
    HashMap ud=(HashMap)session.getAttribute("userdata");
    if(ud!=null){
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LLA</title>
    </head>
    <body>
        <h1>Login Logout App</h1>
        <hr>
        Welcome <b><%=ud.get("name")%></b> <a href='Logout.jsp'>logout</a> <br><hr><br>
        <img src="GetPhoto?email=<%=ud.get("email")%>" width="200" height="230"><br>
        Email: <b><%=ud.get("email")%></b><br>
        Phone: <b><%=ud.get("phone")%></b><br>
        DOB: <b><%=ud.get("dob")%></b><br>
        <hr>
        <%
            String m=(String)session.getAttribute("msg");
            if(m!=null){
        %>
        <b> <%=m%> </b><hr>
        <%   
            session.setAttribute("msg",null);
            }
        %>
        <h3>Upload your Files:</h3>
<form action='Upload' enctype="multipart/form-data" method='post'>
	<b>File:</b> <input type='file' name='ufile' required /> 
	<br><br>
		<input type='submit' value='Submit'/>
</form> 
<hr>
<h3><b><%=ud.get("name")%></b> Uploads:</h3>
<%
    DbConnect db=(DbConnect)application.getAttribute("db");
    if(db==null){
    db=new DbConnect();
    application.setAttribute("db",db);
    }
    PreparedStatement userFiles=db.getUserFiles();
    userFiles.setString(1,(String)ud.get("email"));
    ResultSet rs=userFiles.executeQuery();
    int x=1;
    while(rs.next()){
        String fn=rs.getString(3);
        int upid=rs.getInt(1);
%>
<%=x++%>. <a href="DwnFile?upid=<%=upid%>"><%=fn%></a> 
File Upload Date: <%=rs.getDate(5)%> 
<form action='DeleteFile.jsp' method='post'>
	<input type='hidden' name='upid' value="<%=upid%>"/> 
	<input type='submit' value='Delete'/>
</form> <hr><br>
<%        
    }
%>
    </body>
</html>
<%
    }else{
        session.setAttribute("msg","Plz Login First!");
            response.sendRedirect("index.jsp");
    }
%>