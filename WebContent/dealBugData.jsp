 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
    
<%@ page import = "org.json.*"  %>
<%@ page import = "database.DealDatabase" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.sql.*"%>
<%@ page import = "Parameter.*" %>
<%@ page import = "file.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>完成了的BUG</title>
</head>
<body>
 <%
 response.setCharacterEncoding("UTF-8");
 request.setCharacterEncoding("UTF-8");
 String bugid   =  request.getParameter("id");
 String bugtype = request.getParameter("bugtype");
 String sql = "";
 if(bugtype.equals("0") == true){
	 sql = "update GameBugData set bugtype = 6 where id = '"+bugid+"'";
 }else if(bugtype.equals("5") == true){
	 
 }else if(bugtype.equals("4") == true){
	 
 }else if(bugtype.equals("3") == true){
	 
 }else if(bugtype.equals("2") == true){
	 
 }else if(bugtype.equals("1") == true){
	 
 }
 if(sql.equals("") == false){
	boolean hasup = DealDatabase.updateDatabase(sql);
	if(hasup == true && bugtype.equals("0") == true){
	  response.sendRedirect("Bugs.jsp?type=6");
	}else{
		response.sendRedirect("error.jsp");
	}
 }

 %>
</body>
</html>