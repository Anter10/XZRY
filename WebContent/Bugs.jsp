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
 
 
 <% 
     String TN = "GameBugData"; 
 
 
     String sql = "";
     
     response.setCharacterEncoding("UTF-8");
     request.setCharacterEncoding("UTF-8");
     String typ = request.getParameter("type");
     int type = Integer.parseInt(typ);
     String topeople = "";
     if(type == 0){
     	sql = "Select id,property,uptime,uppeople,topeople,bugtype,uppng ,buginfo ,bugmodel from "+TN+" where bugtype = 0 order by id DESC";
      } /* 所有bug */
     else if(type == 1){
    	sql = "Select id,property,uptime,uppeople,topeople,bugtype,uppng ,buginfo,bugmodel  from "+TN+" order by id DESC";
     }
     /* 已经审计 */
     else if(type == 2){
    	 sql = "Select id,property,uptime,uppeople,topeople,bugtype,uppng ,buginfo ,bugmodel from "+TN+" where bugtype = "+type+" order by id DESC";
     /* 已经修改 */
     }else if(type == 3){
    	 sql = "Select id,property,uptime,uppeople,topeople,bugtype,uppng ,buginfo,bugmodel  from "+TN+" where bugtype = "+type+" order by id DESC";
    /* 自己的bug */
	 }else if(type == 4){
		 topeople =        session.getAttribute("ambuguser").toString();
		 sql = "Select id,property,uptime,uppeople,topeople,bugtype,uppng ,buginfo ,bugmodel from "+TN+" where topeopleid = "+topeople+" order by id DESC";
		 /* 自己未修改的bug */
	 }else if(type == 5){
		  topeople =        session.getAttribute("ambuguser").toString();
		 sql = "Select id,property,uptime,uppeople,topeople,bugtype, uppng ,buginfo ,bugmodel from "+TN+" where topeopleid = "+topeople+" and bugtype = 0 order by id DESC";
	 }else if(type == 6){
		 topeople =        session.getAttribute("ambuguser").toString();
		 sql = "Select id,property,uptime,uppeople,topeople ,bugtype,uppng ,buginfo ,bugmodel from "+TN+" where bugtype = 6 order by id DESC";
	 }else if(type == 7){
		 topeople =        session.getAttribute("ambuguser").toString();
		 sql = "Select id,property,uptime,uppeople,topeople,bugtype,uppng ,buginfo ,bugmodel from "+TN+" where topeopleid = "+topeople+" and bugtype = 3 order by id DESC";
	 }else if(type == 8){
		 topeople =        session.getAttribute("ambuguser").toString();
		 System.out.print("topeople - "+topeople);
		 sql = "Select id,property,uptime,uppeople,topeople,bugtype,uppng ,buginfo ,bugmodel from "+TN+" where uppeopleid = "+topeople+" order by id DESC";
	 }
 
	 String rootPath= "/res/bugpngs/";
     String appPath = application.getRealPath(rootPath);
     String storePath = appPath;
     
     System.out.print("\n数据 ＝ "+storePath+"\n");
     String getData = DealDatabase.getQuerryJsonStringData(sql);
     String quuu = "show full fields from "+TN;
     String getDatas = DealDatabase.getTableInfo(quuu);
     System.out.print("数据123 ＝ \n"+getDatas); 
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
              <%
              if(bugtype.equals("0") == true && TOPEOPLE.equals(topeopleid)){
              %>
              <td><a href = "dealBugData.jsp?bugtype=<%=bugtype %>&&id=<%=id %>">开始</a></td>
              <%
              }else if(bugtype.equals("6") == true && TOPEOPLE.equals(topeopleid)){
             
              %>
               <td><a href = "dealBugData.jsp?bugtype=<%=bugtype %>&&id=<%=id %>">完成</a></td>
              <%
              }else if(bugtype.equals("3") == true && TOPEOPLE.equals(topeopleid)){
              %>
              <td><a href = "dealBugData.jsp?bugtype=<%=bugtype %>&&id=<%=id %>">审计</a></td>
              <%
              }
              %>
              
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