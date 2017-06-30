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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>处理bug修改的数据</title>
</head>
<body>
     <%
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
        String bugtable = "GameBugData";
	   	String startPart = "'";
    	String startPart1 = "'";
    	
	    String id =        session.getAttribute("ambuguser").toString();
	    String uptime    = startPart + Param.getTime() + startPart1;

        String buginfo   = startPart + request.getParameter("buginfo") + startPart1;
        String uppeople  = session.getAttribute("ambuguser").toString();
        if(uppeople != null){
        	String selectSql = "select * from AMUsers where id ='"+uppeople+"'";
        	String obj = DealDatabase.getQuerryJsonStringData(selectSql);
        	if(obj != null){
        	    System.out.print("obj = "+obj);
        		JSONObject obj2 = new JSONObject(obj);
        		
        		JSONArray obj1 = obj2.getJSONArray("ps");
        		JSONObject jjb = obj1.getJSONObject(0);
        		uppeople =  startPart + jjb.getString("name") + startPart1;
        	}
        }
        
        String topeopleid  = request.getParameter("topeople");
        String topeople = "";
        if(topeople != null){
        	String selectSql = "select * from AMUsers where id ='"+topeopleid+"'";
        	String obj = DealDatabase.getQuerryJsonStringData(selectSql);
        	if(obj != null){
        	    System.out.print("obj = "+obj);
        		JSONObject obj2 = new JSONObject(obj);
        		
        		JSONArray obj1 = obj2.getJSONArray("ps");
        		JSONObject jjb = obj1.getJSONObject(0);
        		topeople =  startPart + jjb.getString("name") + startPart1;
        	}
        }
        
        System.out.print("topeople = "+topeople);
        String bugtype   = "0"; 
        String starttime = startPart+"还没开始"+startPart1;
       
        String uppng = "1212";
        
        String bugmodel1 = request.getParameter("bugmodel");
        
        if(bugmodel1 != null){
        	String selectSql = "select * from BugModels where id ='"+bugmodel1+"'";
        	String obj = DealDatabase.getQuerryJsonStringData(selectSql);
        	if(obj != null){
        	    System.out.print("obj = "+obj);
        		JSONObject obj2 = new JSONObject(obj);
        		
        		JSONArray obj1 = obj2.getJSONArray("ps");
        		JSONObject jjb = obj1.getJSONObject(0);
        		bugmodel1 = startPart+jjb.getString("type")+startPart1;
        	}
        }
        
        /* SmartUpload upload = new SmartUpload();
		upload.initialize(pageContext);
	    upload.upload();  
	    com.jspsmart.upload.File f1 = upload.getFiles().getFile(0); */  
	    /*if (f1 != null){
			    String types = f1.getFilePathName();
		 	    String fileName = f1.getFileName();
			    String Save_Location= "/res/ExcelData/";
			    String appPath = application.getRealPath(Save_Location);
			    
			    if (filemanager.getFM().isDir(appPath) == false){
			    	filemanager.getFM().createDir(appPath);
			    }
			    Long time = Param.getCurentServerTime();
			    String storePath = appPath+types;
			    uppng = types;
			    f1.saveAs(storePath, upload.SAVE_PHYSICAL);  
		}  
		 */
		 
		String endtime      =  startPart+"还没开始"+startPart1;
        String changetime   =  startPart+"还没开始"+startPart1;
        String uppeople111     =  startPart+session.getAttribute("ambuguser").toString()+startPart1;
        topeopleid = startPart+topeopleid+startPart1;
        String property = startPart+request.getParameter("property")+startPart1;
        String values = "("+property+"," +uptime+","+buginfo+","+uppeople+","+topeople+","+topeopleid+","+bugtype+","+starttime+"," +uppng+"," +endtime+","+changetime+","+bugmodel1+","+uppeople111+")";
  
        String addSql = "insert into GameBugData(property,uptime,buginfo,uppeople,topeople,topeopleid,bugtype,starttime,uppng,endtime,changetime,bugmodel,uppeopleid) values"+values;
        System.out.print("谁提交了 bugmodel "+addSql+"\n");
        
       
         boolean success = DealDatabase.updateDatabase(addSql);
        if(success == true){
        	 response.sendRedirect("Bugs.jsp?type=1");
        }    
     %>
</body>
</html>




















