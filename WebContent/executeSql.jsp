<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "org.json.*"  %>
<%@ page import = "database.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.sql.*"%>
<%@ page import = "Parameter.*" %>
<%@ page import = "file.*" %>
<%@ page import = "jxl.*" %>
<%@ page import = "jxl.write.*" %>
<%
  String sql = request.getParameter("sql");
  String TN = request.getParameter("tb");
  if(sql.isEmpty() == false){
	 boolean yes =  DealDatabase.executeSQL(sql);
	 response.sendRedirect("ShowData.jsp?tablename="+TN); 
  }
%>

