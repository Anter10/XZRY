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
<title>数据更改显示</title>
 <%@ include file= "../weekwork.jsp" %>  
</head>

<body>
<%   
     String TN  = request.getParameter("tb");
     String sql = "select * from "+TN+"";
     if(TN.equals("work") == true){
    	 sql = "select * from "+TN+" order by finish_statue ASC";
     }
     if(TN.equals("work") == true){
    	 myid = session.getAttribute("username").toString();
    	 if (myid.equals("阿源")== true){
    		 sql = "select * from "+TN+" order by finish_statue desc";
    	 }else{
    		 if(myid.equals("老黄")){
    			 sql = "select * from "+TN+" order by finish_statue desc"; 
    		 }else{
    			 sql = "select * from "+TN+" where who = '"+myid+"'" +" order by finish_statue ASC";
    		 }
    		 
    	 }
    	 
     }
     
     
     System.out.print("当前索引 "+sql);  
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
              <td><a href = "finishtask.jsp?dir=1&&tn=<%=TN %>&&id=<%=id %>">完成</a></td>
              <td><a href = "DeleteData.jsp?dir=1&&tn=<%=TN %>&&id=<%=id %>">删除</a></td>  
              <%
                 }
              %>
                <td><a href = "UpdateModelData.jsp?dir=1&&tn=<%=TN %>&&id=<%=id %>">更新</a></td>  
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