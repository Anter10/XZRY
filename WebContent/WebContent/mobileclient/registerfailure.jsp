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
<title>Insert title here</title>
</head>
<body>
 <%
 String sql = "Select * from "+"users"+" order by id ASC";
System.out.print("数据 ＝ "+sql);/*  */
String getData = DealDatabase.getQuerryJsonStringData(sql);
request.setCharacterEncoding("utf-8");
response.setCharacterEncoding("utf-8");
System.out.print("\nsss"+request.getParameter("baz"));
Param.sendData(getData, response.getWriter());
  
 %>
</body>
</html>