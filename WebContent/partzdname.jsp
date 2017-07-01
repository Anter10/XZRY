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
		String filename = f1.getFileName();
		System.out.print("当前上传的文件名称   = "+filename);
		
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
			    
			    JSONArray allfdata  = filemanager.readAExcelAllData(storePath);  
			    JSONArray names     = allfdata.getJSONArray(0);
			    JSONArray darray     = allfdata.getJSONArray(1);
			    
			    int allcount = darray.length();
			    JSONArray darray1     = darray.getJSONArray(0).getJSONArray(0);
			    JSONArray darray2     = darray.getJSONArray(1).getJSONArray(0);	
			    
			    JSONArray darray3     = new JSONArray();
			    JSONArray darray4     = new JSONArray();
			    
			    darray3.put("表1比表2多了的字段: ");
			    for(int zd1index = 0; zd1index < darray1.length(); zd1index ++){
			    	boolean hasit = false;
			    	for(int zd2index = 0; zd2index < darray2.length(); zd2index ++){
			    		System.out.print("当前上传的文件名称   = "+darray1.getString(zd1index) + " = "+darray2.getString(zd2index)+"/r");
				    	if (darray1.getString(zd1index).equals(darray2.getString(zd2index)) == true){
				    		hasit = true;
				    	}
				    }
			    	
			    	if (hasit == false){
			    		darray3.put(" "+String.valueOf(zd1index)+"位置 = "+darray1.getString(zd1index));
			    	}
			    }
			    
			    darray3.put("表2比表1多了的字段: ");
			    for(int zd2index = 0; zd2index < darray2.length(); zd2index ++){
			    	boolean hasit = false;
			    	for(int zd1index = 0; zd1index < darray1.length(); zd1index ++){
			    		 
				    	if (darray2.getString(zd2index).equals(darray1.getString(zd1index)) == true){
				    		hasit = true;
				    	}
				    }
			    	
			    	if (hasit == false){
			    		darray3.put(" "+String.valueOf(zd2index)+" 位置 = " +darray2.getString(zd2index));
			    	}
			    }
			    
			    Param.sendData(darray3.toString(), response.getWriter());
			    
		}else{
			response.sendRedirect("error.jsp");
		}
 	   
   }
   
   
    

%>
<!-- {pageContext.request.contextPath}/servlet/UploadHandleServlet -->
 <form action="partzdname.jsp?has=1" enctype="multipart/form-data" method="post">
       上传Excel文件1：<input type="file" name="file1"><br/>
      
       <input type="submit" value="提交">
 </form>
</body>
</html>