<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "org.json.*"  %>
<%@ page import = "database.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.sql.*"%>
<%@ page import = "Parameter.*" %>
<%@ page import = "file.*" %>



<%
System.out.print("Hello21");
for(int index = 0; index < Param.SingleTable.length; index ++){
	   String tableName = Param.SingleTable[index];
	   String exportsql = "select * from "+tableName; 
	   String exportdata = DealDatabase.ExportGameData(exportsql);
	   JSONArray json = new JSONArray(exportdata);
	  
	   for(int tindex = 0; tindex < json.length(); tindex++){
		   String tdata = json.getString(tindex);
		   
		   JSONObject obj = new JSONObject(tdata);
		   
		   String filename = obj.getString("rid");
		   String quality = obj.getString("quality");
		   // 特殊数据处理
		   if (tableName.equals("SystemIntensifyData")){
			   filename = filename + quality;
		   }
		   String mdir     = "/Users/guoyouchao/Documents/eclipsejee/XZRY/WebContent/JsonData/";
		   String dir      = "/Users/guoyouchao/Desktop/work/client/res/Data_json/"+tableName+"/";
		   
		   filemanager.getFM().createDir(mdir);
		   filemanager.getFM().createDir(dir);
		   filemanager.getFM().writeJSONDataToFile(tdata, mdir+filename+".json"); 
		   filemanager.getFM().writeJSONDataToFile(tdata, dir+filename+".json"); 
	   }
	    
} 
 response.sendRedirect("ShowData.jsp?tablename=HeroStatues"); 


%>