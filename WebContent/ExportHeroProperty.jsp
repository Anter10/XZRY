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
<title>所有数据导出</title>
</head>
<body>
 
    <%
   
      for(int index = 0; index < Param.allheroproperty.length; index ++){
    	   String tableName = Param.allheroproperty[index];
    	   String exportsql = "select * from "+"Systemdata"+tableName; 
    	   String exportdata = DealDatabase.ExportGameData(exportsql);
    	   
    	   String sp = "/Users/guoyouchao/Desktop/work/client/res/Data_json/HeroLevelsData/";
    	   String name = "Systemdata" + tableName + ".json";
    	   filemanager.getFM().createDir(sp);
    	   filemanager.getFM().writeJSONDataToFile(exportdata,sp +name);
    	   filemanager.getFM().writeJSONDataToFile(exportdata, "/Users/guoyouchao/Documents/eclipsejee/XZRY/WebContent/JsonData/HeroProperity/"+name);
      } 
       response.sendRedirect("ShowData.jsp?tablename=HeroStatues");
    %>
</body>
</html>