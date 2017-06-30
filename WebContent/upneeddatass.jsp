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
<title>数据需求</title>
</head>
<body>
<%@ include file= "../weekwork.jsp" %>
<hr color = "red">
 <% String utype = request.getParameter("type"); %>
<hr color = "red">
   <table border = 1>
    <th>
    <form action ="dealneeddatas.jsp" method = "post">
       <td>
        所缺数据描述：<br><textarea rows="10" cols="30"  id = "needinfo" name = "needinfo" ></textarea><br> 
	   </td>
 
 
     <td>
      <%
        if (utype.equals("s") == true){
      %>
         提交给:<br>
	 <select id = "topeople" name = "topeople">
         <option value = "老徐">老徐</option>
	 </select>
      <%}else{
    	  
     %>
         提交给:<br>
	 <select id = "topeople" name = "topeople">
	     <option value = "小郭">小郭</option>
         <option value = "阿源">阿源</option>
	     <option value = "老王">老王</option>
	 </select>
	 
	  选择版本:<br>
	 <select id = "version" name = "version">
         <option value = "4月版本">4月版本</option>
	     <option value = "5月版本">5月版本</option>
	     <option value = "6月版本">6月版本</option>
	 </select>
     </td>
     
      <%
      }
      %>
    
     </td>
	 <td>
	 <input type="submit" value="提交">
	 </td>
    </form>
    </th>
	 
   </table>
</body>
</html>