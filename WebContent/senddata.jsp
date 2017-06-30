<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "org.json.*"  %>
<%@ page import = "database.DealDatabase" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.sql.*"%>
<%@ page import = "Parameter.*" %>
<%@ page import = "file.*" %>
<%
    
 
   /*  	String sql = "create table If Not Exists " +"Systemdataring"+"" + " select * from EquipColor1";
    	 
    	DealDatabase.executeSQL(sql); */
    	
    	
    	String ssj = DealDatabase.getQuerryJsonStringData("select * from versiondata");
    	JSONObject obj = new JSONObject(ssj);
    	String verdata = obj.getString("ps");
    	Param.sendData(verdata, response.getWriter());
         
 %>
 