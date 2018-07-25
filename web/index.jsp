<%-- 
    Document   : index
    Created on : Oct 29, 2017, 7:23:06 PM
    Author     : incapp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> LLA </title>
    </head>
    <body>
        <%
            String m=(String)session.getAttribute("msg");
            if(m!=null){
        %>
        <b> <%=m%> </b><hr>
        <%   
            session.setAttribute("msg",null);
            }
        %>
        <h2>Login Form:</h2>
<form action='LoginProcess.jsp' method='post'>
	<b>User ID:</b> <input type='text' name='email' required /> 
	<br><br>
	<b>Password:</b> <input type='password' name='pass' required /> 
	<br><br>
		<input type='submit' value='Login'/>
		<input type='reset' value='Clear'/>
</form> 
<hr>
<h3>Forget Password:</h3>
<form action='ForgetPass.jsp' method='post'>
	<b>Registered Email ID:</b> <input type='text' name='email' required /> 
	<br><br>
		<input type='submit' value='Submit'/>
		<input type='reset' value='Clear'/>
</form>
<hr>
<h2>New User Registration:</h2>
<form action='register' method='post' enctype="multipart/form-data">
	<b>Email:</b> <input type='text' name='email' required /> 
	<br><br>
	<b>Name:</b> <input type='text' name='name' required /> 
	<br><br>
	<b>Phone:</b> <input type='text' name='phone' required /> 
	<br><br>
        <b>DOB:</b> <input type='date' name='dob' required /> 
	<br><br>
        <b>Photo:</b> <input type='file' name='photo' required /> 
	<br><br>
	<b>Password:</b> <input type='password' name='pass' required /> 
	<br><br>
		<input type='submit' value='Register'/>
		<input type='reset' value='Clear'/>
</form> 
    </body>
</html>
