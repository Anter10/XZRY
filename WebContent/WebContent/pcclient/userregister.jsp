<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>

function isPhone(s){
	    var length = s.length;  
	    if(length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[0-9]{1})|)+\d{8})$/.test(s))  
	    {  
	        return true;  
	    }else{  
	        return false;  
	    }  
}

function sendCode(){
	var phoneNumber = document.getElementById("phone").value;
	if(isPhone(phoneNumber) == true){
		alert("你当前注册的手机号码为:"+phoneNumber);
		
	}else{
		alert("手机号码格式不对");
		return;
	}
	
	
}

</script>
</head>
<body>

     <table border="1">
           <s:form action="Sendcode.action">
               <s:textfield id="phone" name = "phone" label="用户帐号" placeholder="帐号/手机号/邮箱"/>
               <s:submit onclick="sendCode()" value="发送验证码"/><br>
           </s:form>
      </table>
</body>
</html>