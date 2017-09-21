 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "com.jspsmart.upload.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script >
    navigator.geolocation.getCurrentPosition( // 该函数有如下三个参数
        function(pos){ // 如果成果则执行该回调函数
            alert(
                '  经度：' + pos.coords.latitude +
                '  纬度：' + pos.coords.longitude +
                '  高度：' + pos.coords.altitude +
                '  精确度(经纬)：' + pos.coords.accuracy +
                '  精确度(高度)：' + pos.coords.altitudeAccuracy +
                '  速度：' + pos.coords.speed
            );
        }, function(err){ // 如果失败则执行该回调函数
            alert(err.message);
        }, { // 附带参数
            enableHighAccuracy: false, // 提高精度(耗费资源)
            timeout: 3000, // 超过timeout则调用失败的回调函数
            maximumAge: 1000 // 获取到的地理信息的有效期，超过有效期则重新获取一次位置信息
        }
    );
</script>

</head>
<body>
   
  <%--  <%
         
		 //获取下载文件名  
		   String fileName = "uiid";  
		   //新建一个smartUpload对象  
		   SmartUpload smartUpload = new SmartUpload();  
		   //初始化  
		   smartUpload.initialize(this.getServletConfig(), request, response);  
		   //设定contentDisposition为null以禁止浏览器自动打开文件  
		   //保证单击链接后是下载文件。  
		   smartUpload.setContentDisposition(null);  
		   //下载文件  
		   try {  
			 String s = application.getRealPath("/")+ fileName +".mobileconfig";
		     System.out.print("ssss = "+s);
		     
			 smartUpload.downloadFile(s,"0");  
		   } catch (SmartUploadException e) {  
		     e.printStackTrace();  
		   }  

   %> --%>
</body>
</html>