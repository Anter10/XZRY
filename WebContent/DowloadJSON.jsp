<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "com.jspsmart.upload.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
  <%--   <% 
    String tableName = request.getParameter("tb"); %>
    
    
    
    
    <%@page import="java.util.*"%> <%@page import="java.io.*"%> <%@page import="java.net.*"%>
     <%    
     response.setContentType("application/x-download");
     //设置为下载application/x-download    
     String filedownload = "/JsonData/"+tableName+".json";
     System.out.print("下载路径  = "+filedownload);
     //即将下载的文件的相对路径     
     String filedisplay = tableName+".json";
     //下载文件时显示的文件保存名称    
     String filenamedisplay = URLEncoder.encode(filedisplay,"UTF-8");     
     response.addHeader("Content-Disposition","attachment;filename=" + filenamedisplay);     
     try     {        
    	 RequestDispatcher dis = application.getRequestDispatcher(filedownload);  
    	 if(dis!= null)         {      
    		 dis.forward(request,response);         }      
    	     response.flushBuffer();    
    	 }    
     catch(Exception e)   {    
    	 e.printStackTrace();    
    	 }     finally    
    
     {     
    		 
     } %> 
     --%>
   <%
         String tableName = request.getParameter("tb");
		 //获取下载文件名  
		   String fileName = tableName;  
		   //新建一个smartUpload对象  
		   SmartUpload smartUpload = new SmartUpload();  
		   //初始化  
		   smartUpload.initialize(this.getServletConfig(), request, response);  
		   //设定contentDisposition为null以禁止浏览器自动打开文件  
		   //保证单击链接后是下载文件。  
		   smartUpload.setContentDisposition(null);  
		   //下载文件  
		   try {  
			 String s = "/Users/guoyouchao/Desktop/work/client/res/Data_json/"+tableName+".json";
		     System.out.print("ssss = "+s);
			 smartUpload.downloadFile(s,"0");  
		   } catch (SmartUploadException e) {  
		     e.printStackTrace();  
		   }  
   
   %>
</body>
</html>