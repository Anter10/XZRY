<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "org.json.*"  %>
<%@ page import = "database.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.sql.*"%>
<%@ page import = "Parameter.*" %>
<%@ page import = "file.*" %>
<%@ page import = "java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>所有数据导出</title>
</head>
<body>
 
    <%
	    String select = "select table_name from information_schema.tables where table_schema='xuzhirongyao'";
	    JSONArray ja = DealDatabase.getDescrible1(select,"table_name");
	    
	    List <String> dbtable = new ArrayList<String>();
	    for(int index = 0; index < ja.length(); index ++){
	 	   dbtable.add(ja.getString(index));
	    }
	    System.out.print("数据库表  = "+dbtable.toString());
       ProduceTableClassModel.exportLua("lua",dbtable);
   
       response.sendRedirect("ShowData.jsp?tablename=HeroStatues");
    %>
</body>
</html>