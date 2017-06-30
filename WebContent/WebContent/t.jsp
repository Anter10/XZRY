<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="English">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%!
 String name = "15010215839";
%>

<script>
 function onlick(name){
	 var id = document.getElementById("demo").value;
	 alert("确定你的名称: "+id);
 }
 
 function onload(){
	 var id = document.getElementById("demo").focus();
	 if(localStorage.lastname == null){
		 localStorage.lastname=<%=session.getAttribute("uid")%>;
	 }
	 
	 alert(localStorage.lastname);
 }
 
</script>
</head>
<style type="text/css">

</style>
<body onLoad="onload()">
  <form>
   <input type="text" id="demo" placeholder="你好"/><br>
   <button  type="button" onClick="onlick(1212)">注册</button>
  </form>

</body>
</html>