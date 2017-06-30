 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
    
<%@ page import = "org.json.*"  %>
<%@ page import = "database.DealDatabase" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.sql.*"%>
<%@ page import = "Parameter.*" %>
<%@ page import = "file.*" %>


<%
    String tb = request.getParameter("tn");
    if(tb.equals("work") == true){
    	String id = request.getParameter("id");
        
        String usql = "update "+tb+" set finish = '完成',finish_statue = '1' where id = '"+id+"'";
        System.out.print("更新失去了= "+usql);
        DealDatabase.executeSQL(usql);
    }
    response.sendRedirect("changedatas.jsp?tb="+tb); 		
%>