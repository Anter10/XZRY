<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
</head>
<body>
     <form action="Login.action">
     <input type = "text" name="username" label="用户帐号" placeholder="帐号/手机号/邮箱"/><br>
     <input type = "password" name="password" label="用户密码"  placeholder="密码"/>
     
     <input type= "submit" value="登录"/>
     </form>
     <a href ="RegisterUser.jsp">注册</a>
  
</body>
</html>