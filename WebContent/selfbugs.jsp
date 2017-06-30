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
<title>我的bug</title>
</head>
<body>
<%@ include file= "../index.jsp" %>
<hr color = "red">
 <a href  = "Bugs.jsp" >游戏BUG</a>
<a href="UpBugs.jsp">提交bug</a>
<a href="haspass.jsp">已审计的bug</a>
<a href="HadChangeBug.jsp">已经修改的bug</a>
<hr color = "red">

</body>
</html>