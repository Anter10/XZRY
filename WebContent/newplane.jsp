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
<title>提出新计划</title>
</head>
<body>
<%@ include file= "../weekwork.jsp" %>
<hr color = "red">
 
<hr color = "red">
   <table border = 1>
    <th>
    <form action ="dealneeddatas.jsp" method = "post">
       <td>
        新计划描述：<br><textarea rows="10" cols="30"  id = "needinfo" name = "needinfo" ></textarea><br> 
	   </td>
 
 
     <td>
      预计完成时间:
      <input type="week" name = "date" id = "date" value="2014-01-13" />
	 
     </td>
	 <td>
	 <input type="submit" value="提交">
	 </td>
    </form>
    </th>
	 
   </table>
</body>
</html>