<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        
<%@ page import = "org.json.*"  %>
<%@ page import = "database.DealDatabase" %>
<%@ page import = "java.io.*" %>
<%@ page import = "javax.sql.*"%>
<%@ page import = "Parameter.*" %>
<%@ page import = "file.*" %>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>提交美术需求</title>
</head>
<body>
<%@ include file= "../weekwork.jsp" %>
<hr color = "red">
 
<hr color = "red">
   <table border = 1>
    <th>
    <form action ="dealneeds.jsp" method = "post">
       <td>
        所缺美术资源描述：<br><textarea rows="10" cols="30"  id = "needinfo" name = "needinfo" ></textarea><br> 
	   </td>
 
 
     <td>
     
       提交给:<br>
	 <select id = "topeople" name = "topeople">
         <option value = "阿源">阿源</option>
	     <option value = "老王">老王</option>
	     <option value = "相如">相如</option>
	 </select>
     </td>
     
     <td>
     
     选择版本:<br>
	 <select id = "version" name = "version">
         <option value = "4月版本">4月版本</option>
	     <option value = "5月版本">5月版本</option>
	     <option value = "6月版本">6月版本</option>
	 </select>
     </td>
     
	 <td>
	 <input type="submit" value="提交">
	 </td>
    </form>
    </th>
	 
   </table>
</body>
</html>