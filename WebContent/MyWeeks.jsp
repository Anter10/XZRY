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
 
<title>游戏bug</title>
</head>
<body>
<%@ include file= "../index.jsp" %>
<hr color = "red">
<table border = 1>
<tr>
<td>
 <a href="Weeks.jsp">填写周报</a>
</td>
<td>
 <a href="MyWeeks.jsp">我的周报</a>
</td>
<td>
 <a href="MyWeeks.jsp">导出周报</a>
</td>



</tr>
</table>

<hr color = "red">
 
 
 <% 
     String TN = "Weeks"; 
 
 
     String sql = "";
     
     response.setCharacterEncoding("UTF-8");
     request.setCharacterEncoding("UTF-8");
 
     String topeople = "";
     
     String myid = session.getAttribute("ambuguser").toString();
     
     sql = "Select * from "+TN+" where userid = '"+myid+"' order by id DESC"; 
     
	 String rootPath= "/res/bugpngs/";
     String appPath = application.getRealPath(rootPath);
     String storePath = appPath;
     
     System.out.print("\n数据 ＝ "+storePath+"\n");
     String getData = DealDatabase.getQuerryJsonStringData(sql);
 
     //filemanager.getFM().writeJSONDataToFile(getData, "/Users/guoyouchao/Desktop/Weimo/JSONData/"+TN+".json");
     if (getData != null){
     JSONObject obj = new JSONObject(getData);
     JSONObject objJSON = new JSONObject();
     if (obj != null){
       JSONArray array = obj.getJSONArray("ps");
       JSONArray array1 = obj.getJSONArray("lb");
   
       Param.addMessage = array1;
         objJSON.put("tb", TN);
         objJSON.put("lb", array1);
         //System.out.print("当前索引 "+objJSON.toString()+"\n");  
       int count = array.length();
      %> 
            
       
        <hr color = "red">
        <table border = "1">
        <caption>游戏bug数据</caption>
      <%
        for(int index = 0; index < array1.length(); index ++){
      %>
           <th><%= array1.get(index).toString() %></th>
              
           <%
            } 
            for(int index1 = 0; index1 < count; index1 ++){
            %>
        
           <tr>
           
           <%
           JSONObject obj1 = new JSONObject();
           String id = "";
           String bugtype = "";
           String TOPEOPLE = "";
           String topeopleid = "";
           String width = "0";
           for(int index2 = 0; index2 < array1.length(); index2 ++){
        	  obj1 = array.getJSONObject(index1);
        	  id  = obj1.getString(array1.get(0).toString());
        	/*   if (index2 == array1.length() - 1 || obj1.getString(array1.get(index2).toString()) == "buginfo"){
        		  width = "320";
        	  }else{
        		  width = "60";
        	  } */
        	  /*  */
           %>  
           
              <%
             
              String ispng = array1.get(index2).toString();
              TOPEOPLE     = array1.get(index2).toString();
              topeopleid   = array1.get(index2).toString();
              if(ispng.equals("bugtype")){
            	  bugtype = obj1.getString(array1.get(index2).toString());
              }
              if(topeopleid.equals("topeopleid")){
            	  bugtype = obj1.getString(array1.get(index2).toString());
              }
              if(ispng.equals("uppng")){
                 String bugpngs =  "/upload/"+ obj1.getString(array1.get(index2).toString());
                 
              %>
              <td height = "120" width="120"> <img height = "120" width="220" src= "res/bugpngs//111000.png"> </td> 
              <%
                 }else {
              %>
                <td height  = "60" width=<%=width %> ><%= obj1.getString(array1.get(index2).toString()) %></td>
              <%}
 
              %>
              
              <%
               }
              %>
              <%
              
              
               if (count > 1){
               %>
              <%-- <td><a href = "DeleteData.jsp?tn=<%=TN %>&&id=<%=id %>">删除</a></td> --%>
              <%
                 }
              %>
              <td><a href = "UpdateModelData.jsp?tn=<%=TN %>&&id=<%=id %>">更新</a></td> 
               
              
            <%--   <td><a href = "dealBugData.jsp?tn=<%=TN %>&&id=<%=id %>">完成</a></td>
              <td><a href = "dealBugData.jsp?tn=<%=TN %>&&id=<%=id %>"></a></td> --%>
           </tr>
           <%
           
             }
           %>
        </table>
     <%}
     else
     
     %>
     <%
        }
     %>
</body>
</html>