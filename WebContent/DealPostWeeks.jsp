<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "com.jspsmart.upload.*" %>
 
<%@ page import = "java.io.DataOutputStream" %>
  
<%@ page import = "org.json.*"  %>
<%@ page import = "database.*" %>
 
<%@ page import = "javax.sql.*"%>
<%@ page import = "Parameter.*" %>
 
<%@ page import = "jxl.*" %>
<%@ page import = "jxl.write.*" %>
<%@ page import = "file.filemanager" %>


<%
   response.setCharacterEncoding("UTF-8");
   request.setCharacterEncoding("UTF-8");
   String w1   = request.getParameter("w1");
   String w2   = request.getParameter("w2");
   String w3   = request.getParameter("w3");
   String w4   = request.getParameter("w4");
   String w5   = request.getParameter("w5");
   String myname    = session.getAttribute("username").toString();
   String myid = session.getAttribute("ambuguser").toString();
   System.out.print(w1+w2+w3+w4+w5+myid);
   String upSql = "insert into Weeks(w1, w2, w3, w4, w5,username,userid) values ('"+w1+"','"+w2+"','"+w3+"','"+w4+"','"+w5+"','"+myname+"','"+myid+"')";
   boolean success = DealDatabase.updateDatabase(upSql);
   if(success == true){
   	 response.sendRedirect("MyWeeks.jsp");
   }  
   
    
   
   
   

%>