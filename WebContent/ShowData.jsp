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
<%
   String TN = request.getParameter("tablename");
   String JSONTN = request.getParameter("tablename")+".json";
%>
<title><%= TN %></title>
</head>
<body>
<p>爱米Glory <数据/任务 管理> </p>
<hr color = red>
<a href = "test.jsp">数据首页</a>

<a href = "ExportData.jsp">导出JSON数据</a>

<a href = "ExportSingleRowData.jsp">导出单条记录的JSON数据</a>
<a href = "getZipFile.jsp">压缩文件</a>
<a href = "BeiFen.jsp">备份Excel数据</a>
<a href = "UpExcelData.jsp">上传Excel数据</a>
<a href = "updatemoresheetexcel.jsp">上传多个文件的数据</a>
<a href = "ExportHeroProperty.jsp">导出英雄属性数据</a>
<a href = "heroperits.jsp">英雄等级数据</a>

<hr color = "red">
<a href = "partzdname.jsp">区别Excel不同字段</a>

<a href = "zipFile.jsp">压缩JSON文件夹</a>
<a href = "downloadjson.jsp">下载JSON</a>


<hr color = "red">

 
<!-- <a href = "PlayerExportData.jsp">玩家数据备份</a> -->
 <a href  = "Bugs.jsp?type=1" >项目进度</a>
 
  <a href  = "MyWeeks.jsp?type=1" >周报管理</a>
     <a href = "downloadexcel.jsp?tb=bug日志">下载Bug日志</a>
<a href  = "ShowData.jsp?tablename=AllPkgVersion" >Android版本包下载</a>
<a href  = "ExportLua.jsp">Lua脚本导出</a>
<a href  = "exportallexceldata.jsp">导出总表</a>

<hr color="red">
      输入SQL语句:
      <form  action = "executeSql.jsp?tb=<%=TN %>" method = "post">
            <input style="width:650px;height:30px" type = "text" name = "sql" ><br>
            <input type = "submit" value = "执行">
            <input type = "reset" value = "清空">
      </form>
<hr color="red">

 

   <%@ include file= "../index.jsp" %>
   <hr color = "red">
    <a href = "UpdateData.jsp?tb=<%=TN %>">添加<%=TN %>数据</a>
    <a href = "ExportSingleData.jsp?tb=<%=TN %>"><%=TN %>表导出数据</a>
    <a href = "DowloadJSON.jsp?tb=<%=TN %>">下载<%=TN %>JSON数据</a>
    <a href = "downloadexcel.jsp?tb=<%=TN %>">下载<%=TN %>EXCEL表</a>
    <a href = "downloadlua.jsp?tb=<%=TN %>">下载<%=TN %>LUA脚本</a>
    <br>
    <%-- <a href = "JsonData/<%=JSONTN %>"><%=TN %>表导出数据</a> --%>

   <!-- 显示数据 --> 
    <%
     String sql = "Select * from "+TN+"";
     System.out.print("数据 ＝ "+TN);
     String getData = DealDatabase.getQuerryJsonStringData(sql);
     String quuu = "show full fields from "+TN;
     String getDatas = DealDatabase.getTableInfo(quuu);
    
     //filemanager.getFM().writeJSONDataToFile(getData, "/Users/guoyouchao/Desktop/Weimo/JSONData/"+TN+".json");
     if (getData != null){
     JSONObject obj = new JSONObject(getData);
    
     JSONObject objJSON = new JSONObject();
     if (obj != null){
       JSONArray array = obj.getJSONArray("ps");
       JSONArray array1 = obj.getJSONArray("lb");
       //Param.sendData(obj.toString(), response.getWriter());
       Param.addMessage = array1;
         objJSON.put("tb", TN);
         objJSON.put("lb", array1);
         //System.out.print("当前索引 "+objJSON.toString()+"\n");  
       int count = array.length();
      %> 
            
       
        <hr color = "red">
        <table border = "1">
        <caption><%=TN %></caption>
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
           String width = "0";
           boolean isahref = false;
           for(int index2 = 0; index2 < array1.length(); index2 ++){
        	  obj1 = array.getJSONObject(index1);
        	  id  = obj1.getString(array1.get(0).toString());
        	  if (index2 == array1.length() - 1 || obj1.getString(array1.get(index2).toString()) == "info"){
        		  width = "0";
        	  }/*  */
        	  
        	  /* 是否为超链接 */
        	 /*  System.out.print("标签名 ＝ "+array1.get(index2)+"\n"); */
        	  if(array1.get(index2).toString().equals("pkgpath")){
        		  isahref = true;
        	  }
        	 
           %>  
              <%
             /*  System.out.print("isahrefpkgname ＝ "+isahref); */
                 if(isahref == true){
                	String pkgname = obj1.getString(array1.get(index2).toString());
                	/* System.out.print("pkgname ＝ "+pkgname); */
                	isahref = false;
              %>
              <td height  = "60" width=<%=width %> ><a href = "AndroidVersions/<%=pkgname %>" ><%=pkgname%></a></td> 
              <%
                 }else{
              %>
                <td height  = "60" width=<%=width %> ><%= obj1.getString(array1.get(index2).toString()) %></td>
              <%
                 }
              %>
             <%
              }
             %>
              <%
             /*   System.out.print("iiiiddd "+count); */
               if (count > 1){
               %>
              <%-- <td><a href = "DeleteData.jsp?tn=<%=TN %>&&id=<%=id %>">删除</a></td> --%>
              <%
                 }
              %>
             <td><a href = "UpdateModelData.jsp?tn=<%=TN %>&&id=<%=id %>">更新</a></td> 
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