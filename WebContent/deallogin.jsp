<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "org.json.*"  %>
<%@ page import = "database.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.sql.*"%>
<%@ page import = "Parameter.*" %>
<%@ page import = "file.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<% 
     String id = ""; 
%>
<script>
function abc(){
    var id = <%=2121%>;
    localStorage.setItem("name",id); 
	alert("HELLO A"+localStorage.getItem("name"));
	
}

</script>
<body>
 
    <%
         id = request.getParameter("id");
         String pwd = request.getParameter("pwd");
         String loginSql = "select * from AMUsers where id = '"+id+"' and pwd = '"+pwd+"'";
         System.out.print("session ＝ "+loginSql);  
         String suces = DealDatabase.getQuerryJsonStringData(loginSql);
         
         if(suces != null){
        	 System.out.print("suces"+suces);
        	 session.setAttribute("ambuguser",id);
        	 response.sendRedirect("index.jsp");
        	 
        %>
         
   
        <%
         }else{
        	 response.sendRedirect("Login.jsp");
         }
        %>

</body>
</html>