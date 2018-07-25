<%@page import="java.sql.PreparedStatement"%>
<%@page import="db.DbConnect"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.ResultSet"%>
<%
    String e=request.getParameter("email");
    DbConnect db=(DbConnect)application.getAttribute("db");
    if(db==null){
    db=new DbConnect();
    application.setAttribute("db",db);
    }
    PreparedStatement userDetails=db.getUserDetails();
    userDetails.setString(1, e);
    ResultSet rs=userDetails.executeQuery();
    if(rs.next()){
        String pass=rs.getString(2);
        //MAil send COde
try{
    final String AEMAIL="nkwork6096@gmail.com";
    final String APASS="nkwork@1831996";
    String SEMAIL=e;
    String SUB="pass";
    String BODY="Your Id: "+e+" <br/> Password= "+pass;
    
    Properties props=new Properties();
    props.put("mail.smtp.host","smtp.gmail.com");
    props.put("mail.smtp.socketFactory.port","465");
    props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
    props.put("mail.smtp.auth","true");
    props.put("mail.smtp.port","465");
    Session ses=Session.getInstance(props,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication(){
                    return new PasswordAuthentication(AEMAIL,APASS);
                }
            }
            );
    
    Message message=new MimeMessage(ses);
    message.setFrom(new InternetAddress(AEMAIL));
    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(SEMAIL));
    message.setSubject(SUB);
    message.setContent(BODY,"text/html" );
    Transport.send(message);
    session.setAttribute("msg","Mail Send for Your Password success.");
}
catch(Exception ex){
    ex.printStackTrace();
    session.setAttribute("msg","Mail Send Failed ."+ex.getMessage());
}
response.sendRedirect("index.jsp");
                //end--MAil send COde
    }
    else{
        session.setAttribute("msg", "Email ID is not Registered");
response.sendRedirect("index.jsp");
    }
%>