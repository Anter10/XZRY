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
<td width="200" height = "60"><a href="UpBugs.jsp">提交任务</a></td>
<td width="200" height = "60"><a href="Bugs.jsp?type=4">自己的任务</a> </td>
<td width="200" height = "60"><a href="Bugs.jsp?type=7">自己已修改任务</a></td>
<td width="200" height = "60"><a href="Bugs.jsp?type=5">自己未修改任务</a></td>
</tr>
<tr>
<td width="200" height = "60"><a href="Bugs.jsp?type=0">未修改任务</a> </td>
<td width="200" height = "60"><a href="Bugs.jsp?type=6">正在进行的任务</a><br></td>
<td width="200" height = "60"><a href="Bugs.jsp?type=3">已经修改的任务</a></td>
<td width="200" height = "60"><a href="Bugs.jsp?type=2">已审计的任务</a></td>
</tr>
<tr>
<td width="200" height = "60"><a href="Bugs.jsp?type=8">我提交的BUG</a> </td>
</tr>
</table>
<hr color = "red">
   <table border = 1>
    <th>
    <form action ="dealupbugs.jsp" method = "post">
       <td>
        bug描述：<br>
        <textarea rows="10" cols="20"  id = "buginfo" name = "buginfo" >
	    </textarea><br> 
	   </td>
	 <td>
	 上传bug图片：<br>
	 <input type="file" name="file1"><br/>
	 
	 </td>
	   <td>
       优先级:<br>
	 <select id = "property" name = "property">
	     <option value = "1级">1级</option>
	     <option value = "2级">2级</option>
	     <option value = "3级">3级</option>
	     <option value = "4级">4级</option>
	     <option value = "5级">5级</option>
	     <option value = "6级">6级</option>
	 </select>
     </td>
     <td>
     
    </td>
	 <td>
      系统:<br>
	 <select id = "bugmodel" name = "bugmodel">
	     <option value = "1111">战斗</option>
	     <option value = "1112">战斗->技能</option>
	     <option value = "1113">战斗->行走</option>
	     <option value = "1114">战斗->buff</option>
         <option value = "1115">战斗->死亡</option>
         <option value = "1116">战斗->镜头</option>
         <option value = "1117">战斗->胜利</option>
	     <option value = "d1">队伍</option>
	     <option value = "d3">大地图</option>
	 </select>
     </td>
     <td>
     
       提交给:<br>
	 <select id = "topeople" name = "topeople">
	     <option value = "789654">老乔</option>
	     <option value = "456456">东东</option>
	     <option value = "321123">小郭</option>
<!--  	     <option value = "123321">阿源</option>
	     <option value = "456789">老王</option>
	     <option value = "543210">相如</option>
	     <option value = "789654">老乔</option>
	     <option value = "987654">老徐<option> --> -->
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