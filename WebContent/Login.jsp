<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆</title>
</head>
<body>
   <%
     String type = request.getParameter("type");
     if(type != null && type.equals("1")){
    	session.setAttribute("ambuguser",null);
     }
     Object hasuser = session.getAttribute("ambuguser");
     if(hasuser == null){
    	 System.out.print("session ＝ ");  
     %>
  	 <form action="deallogin.jsp" method = "">
     <table>
     <td>
     ID:
       <input type="text" id = "id" name = "id">
     </td>
     <td>
       Password:
     <input type="password" id = "pwd" name = "pwd">
     </td>
    <td>
     <input type = "submit" value = "Login">
    </td>
     </table>
   
   </form>
    <% 
     }else{
    	 response.sendRedirect("Bugs.jsp?type=0");
     }
    %>	 
    	 
  
    

   
   
   
</body>
</html>