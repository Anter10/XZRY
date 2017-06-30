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
<title>处理修改的数据</title>
</head>
<body>
     <%
        
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
      
	   	String startPart = "'";
    	String startPart1 = "'";
    	 
	    String id =        session.getAttribute("username").toString();
	    String uptime    = startPart + Param.getTime() + startPart1;

        String needinfo   = startPart + request.getParameter("needinfo");
        String uppeople  = session.getAttribute("username").toString();
    
        String topeople  = request.getParameter("topeople");
        String version   = request.getParameter("version");
        String time = Param.getSysYMD();
        
        String values = "("+startPart+uppeople+startPart1+","+startPart+version+startPart1+","+startPart+topeople+startPart1+","+needinfo+startPart1+","+startPart+time+startPart1+")";
  
        String addSql = "insert into wneeds(who,version,lookfor,info,time) values"+values;
        System.out.print("谁提交了 bugmodel "+addSql+"\n");
        
       
         boolean success = DealDatabase.updateDatabase(addSql);
        if(success == true){
        	 response.sendRedirect("changedatas.jsp?tb=wneeds");
        }    
     %>
</body>
</html>




















