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
<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/><head>
<style> 
ul 
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>www.vipboys.net</title>
</head>
<body id="example1">
<%-- <%
String quuu = "select * from asuser";
String getDatas = DealDatabase.getQuerryJsonStringData(quuu);
PrintWriter pw = response.getWriter();
Param.sendData(getDatas, pw);
%> --%>
 <ul>
<li><a href="#home">首页</a></li>
<li><a href="#news">精品推荐</a></li>
<li><a href="#contact">产品分类</a></li>
<li><a href="#about">登录/注册</a></li>
</ul>
</body>
</html>