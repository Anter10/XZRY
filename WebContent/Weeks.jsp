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
<title>提交BUG</title>
</head>
<body>
<%@ include file= "../index.jsp" %>
<hr color = "red">
<table border = 1>
<tr>
<td width="200" height = "60"><a href="preweek.jsptype=1">以前周报</a></td>
 
</tr>
 
<tr>
<td width="200" height = "60"><a href="Bugs.jsp?type=8">所有人周报</a> </td>
</tr>

</table>
<hr color = "red">
   <table border = 1>
    <th>
    <form action ="DealPostWeeks.jsp" method = "post">
       <td>
        周一：<br>
        <textarea   rows="10" cols="20"  id = "w1" name = "w1" >
周一工作内容
	    </textarea><br> 
	   </td>
	  
	    <td>
        周二：<br>
        <textarea rows="10" cols="20"  id = "w2" name = "w2" >
周二工作内容
	    </textarea><br> 
	   </td>
	  
	    <td>
        周三：<br>
        <textarea   rows="10" cols="20"  id = "w3" name = "w3" >
周三工作内容
	    </textarea><br> 
	   </td>
	    <td>
        周四：<br>
        <textarea  rows="10" cols="20"  id = "w4" name = "w4" >
周四工作内容
	    </textarea><br> 
	   </td>
	    <td>
        周五：<br>
        <textarea  rows="10" cols="20"  id = "w5" name = "w5" >
周五工作内容
	    </textarea><br> 
	   </td>
	 <td>
	 <input type="submit" value="提交">
	 </td>
    </form>
    </th>
	 
   </table>
</body>
</html>