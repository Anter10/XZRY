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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据单个备份</title>
</head>
<body>
  <%      
           String tableName = "work";
           String myid = session.getAttribute("username").toString();
    	   WorkbookSettings workbookSettings = new WorkbookSettings();
    	   workbookSettings.setEncoding("UTF-8");
    	   WritableWorkbook sheetbook =  Workbook.createWorkbook(new File(  
                   "/Users/guoyouchao/Desktop/work/client/res/Data_excel/bug日志.csv")); 
    	   String exportsql = "select * from "+tableName +" where finish_statue = 1"; 
         
   	      WritableSheet firstSheet = sheetbook.createSheet("已经修改的bug", 1);
          
          String exportdata = DealDatabase.getQuerryJsonStringData(exportsql);
          if (exportdata != null){
        	  JSONObject obj =  new JSONObject(exportdata);
        	  JSONArray array = obj.getJSONArray("ps");
              JSONArray array1 = obj.getJSONArray("lb");
              for(int tableIndex = 0;tableIndex < array1.length(); tableIndex ++){
            	   Label label1 = new Label(tableIndex, 0, array1.getString(tableIndex)); 
                   firstSheet.addCell(label1);  
              }
              for(int tableIndex = 0;tableIndex < array.length(); tableIndex ++){
            	 for(int tableIndex1 = 0;tableIndex1 < array1.length(); tableIndex1 ++){
            	    JSONObject obj1 = array.getJSONObject(tableIndex);
               	    Label label1 = new Label(tableIndex1, tableIndex + 1, obj1.getString(array1.get(tableIndex1).toString()) ); 
                    firstSheet.addCell(label1);  
                 }
            	  
              }
          }
          
       
          sheetbook.write();  
          // 5、关闭流  
          sheetbook.close(); 
    	  /*  String exportdata = DealDatabase.getQuerryJsonStringData(exportsql);
    	   fil emanager.getFM().writeJSONDataToFile(exportdata, "/Users/guoyouchao/Desktop/Weimo/JSONData/"+tableName+".json"); */
          response.sendRedirect("weekq.jsp"); 
    %>
</body>
</html>