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
   <table border = "1">
   <%
      int datacount = Param.allheroproperty.length;
      int pagenum   = 8;
      int allcount  = (int)Math.ceil(datacount / pagenum);
      int allcountindex  = 0;
      for(int i = 0; i < allcount; i ++){
   %>
       <tr>
      <%
        for(int j = 0; j < pagenum; j ++ ){
      %>
      <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=Systemdata<%=Param.allheroproperty[allcountindex] %>" >英雄<%=Param.allheroproperty[allcountindex] %>对应等级数据</a></td>
      <%
      allcountindex = allcountindex + 1;	
        }
      %>
        <tr>
   <%
      }
   %>
   
   </table>
</body>
</html>