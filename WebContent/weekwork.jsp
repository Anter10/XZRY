<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>周况</title>
</head>
<body>
<%!String myid = "";
   String myname = "";
%>

 <%
/*    System.out.print("myy "+myy); */
/* session.setAttribute("username",myname); */
    myid = "NN";
%>


<a href = "index.jsp"><h2>返回</h2></a>
<%=myid %>
<hr color = "red">
<!-- <a href = "newplane.jsp">提出新计划</a> -->
<a href = "upneeds.jsp">提出资源需求</a>
<a href = "upneeddatass.jsp?type=c">提出前端数据需求</a>
<a href = "upneeddatass.jsp?type=s">提出后端数据需求</a>

<hr color = "red">
 <a href = "changedatas.jsp?tb=GameSystem">游戏功能系统信息</a>
 <a href = "UpdateData.jsp?tb=GameSystem">添加游戏功能系统信息</a>
<hr color = "red">
<a href = "changedatas.jsp?tb=work">这周完成情况</a>

<a href = "changedatas.jsp?tb=wneeds">所缺美术资源</a>
<a href = "changedatas.jsp?tb=needdatas">所缺数据资源</a>
<hr color = "red">
<a href = "beifensingle.jsp?tb=wneeds">导出资源需求</a>
<a href = "beifensingle.jsp?tb=needdatas&&type=c">导出前端数据需求</a>
<a href = "beifensingle.jsp?tb=needdatas&&type=s">导出后端数据需求</a>
<a href = "beifensingle.jsp?tb=work">导出周况</a>
<a href = "versionbugs.jsp">导出bug日志</a>

<hr color = "red">
<a href = "beifensingle.jsp?tb=wneeds">导出资源需求</a>
<a href = "beifensingle.jsp?tb=needdatas&&type=c">导出前端数据需求</a>
</body>
</html>