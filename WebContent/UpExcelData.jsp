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
<title>上传数据</title>
</head>
<body>
<p>上传数据</p>
<hr color = "red">
<%

   String has = request.getParameter("has");
   if(has != null){
		SmartUpload upload = new SmartUpload();
		upload.initialize(pageContext);
	
		upload.upload();  
	
		com.jspsmart.upload.File f1 = upload.getFiles().getFile(0);
		if (f1 != null){
			    String types = f1.getFilePathName();
		 	    String fileName = f1.getFileName();
			    String Save_Location= "/res/ExcelData/";
			    String appPath = application.getRealPath(Save_Location);
			    
			    if (filemanager.getFM().isDir(appPath) == false){
			    	filemanager.getFM().createDir(appPath);
			    }
			    Long time = Param.getCurentServerTime();
			    String storePath = appPath+types;
			    System.out.print("\n storePath"+storePath+"\n");
			    f1.saveAs(storePath, upload.SAVE_PHYSICAL);  
			    
			    JSONArray fileJSONArray  = filemanager.readExcelData(storePath);  
		        JSONArray zdArray = fileJSONArray.getJSONArray(0);
		        String tablename = fileName.split("\\.")[0];
		        
		        System.out.print("字段名称  = "+zdArray.toString());
		        
		    	String showzds = "describe " +tablename; 
	        	JSONArray allzds = DealDatabase.getDescrible(showzds);
    			 
	        	
	        	
	        	String delete = "delete from " + tablename;
	        	boolean hasupdate = DealDatabase.updateDatabase(delete);
	        	
		        for(int dataIndex = 0; dataIndex < fileJSONArray.length(); dataIndex++){
		        	String updateSql = "";
		        	
		        	 
		        	JSONArray data = fileJSONArray.getJSONArray(dataIndex);
		        	if(data.getString(0).equals("id") == false || data.getString(0).equals("f_id") == false ){
		        	String select = "select * from " + tablename;
		        	
		        	/* System.out.print("数据删除成功12 = "+delete+"\n"); */
	        		
		        	String hasId =  DealDatabase.getQuerryJsonStringData(select);
		        	String partDh = ",";
		        	String partSql = "" ;
		        	
		        
		        	
	        		if(hasupdate == true){
	        			System.out.print("数据删除成功 = "+delete+"\n");
	        		}
	        		 String zdnames = "(";
		        		for(int zdIndex = 0; zdIndex < zdArray.length(); zdIndex ++){
		        			if(zdIndex == zdArray.length() -1){
		        				partDh = "";
		        			}
		        			
		        		
		        			/* 判断字段名称是否存在 */
		        		  
		        		    String zdname = zdArray.getString(zdIndex);
		        		    boolean haszd = false;
		        		    for(int zdnums = 0; zdnums < allzds.length(); zdnums++){
		        		    	if (zdname.equals(allzds.getString(zdnums))){
		        		    		haszd = true;
		        		    		break;
		        		    	}
		        		    }
		        		    
		        		    if (haszd == false){
		        		       System.out.print("zdIndex = " + zdArray.getString(zdIndex));
		        		       String addsql = "ALTER TABLE " + tablename + " add " + zdArray.getString(zdIndex) +" varchar(320) default '0' " + "'"+ allzds.getString(zdIndex) + "'";
		        		       System.out.print(zdname+ " 添加了新的字段了1 "+addsql);
		        		       boolean add = DealDatabase.executeSQL(addsql);
		        		       allzds.put(zdname);
				        	   if(add){
				        		  System.out.print("添加了新的字段了"+zdArray.getString(zdIndex));
				        	   }
		        		    }
		        		    
		        			zdnames = zdnames + zdname + partDh;
		        			String ttstr =  new String(data.getString(zdIndex).toString());
		        			ttstr =   ttstr.replaceAll("'", "\\\\'"); 
		        			System.out.print("str1 = "+ttstr+"\n");
		        			partSql = partSql + "'"+ ttstr +"'" + partDh;
		            	}
		        		
		        		
		        		zdnames = zdnames + ")";
		        		if (dataIndex > 0){
		        			updateSql = "insert into "  + tablename + zdnames + " values(";
			        		partSql = partSql + ")";
			        		updateSql = updateSql + partSql;
	  System.out.print("SLQYUJU = "+updateSql+"\n"+dataIndex); 
				            hasupdate = DealDatabase.updateDatabase(updateSql);
		        		}
		        		
			         }	
		        	
		         
		         }
		        if (tablename != null){
	        		response.sendRedirect("ShowData.jsp?tablename="+tablename);
	        	}
		}else{
			response.sendRedirect("error.jsp");
		}
 	   
   }
   
   
    

%>
<!-- {pageContext.request.contextPath}/servlet/UploadHandleServlet -->
 <form action="UpExcelData.jsp?has=1" enctype="multipart/form-data" method="post">
       上传Excel文件1：<input type="file" name="file1"><br/>
      
       <input type="submit" value="提交">
 </form>
</body>
</html>