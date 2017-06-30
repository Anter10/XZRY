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
<body>
   <% 
         
        String tableName = request.getParameter("tb");
        if (tableName != null){
        	String exportsql = "select * from "+tableName; 
            String exportdata = DealDatabase.ExportGameData(exportsql);
            exportdata = exportdata.replaceAll("\r", "");
            System.out.print("当前导出数据 = "+exportdata+"\n");
            String file1  = "/Users/guoyouchao/Documents/eclipsejee/XZRY/WebContent/JsonData/"+tableName+".json";
            String file2  = "/Users/guoyouchao/Desktop/work/client/res/Data_json/"+tableName+".json";
            filemanager.getFM().deleteDictionaryOrFile(file1);
         	filemanager.getFM().writeJSONDataToFile(exportdata, file2);
         	filemanager.getFM().copyDirToDir(file2, file1);
         	filemanager.getFM().writeJSONDataToFile(exportdata, file1);
        }
        response.sendRedirect("ShowData.jsp?tablename="+tableName);
    %>
</body>
</html>