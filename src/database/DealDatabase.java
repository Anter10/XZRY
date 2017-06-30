package database;
import java.sql.*; 
import org.json.*;
import org.postgresql.jdbc.PgStatement;

import com.mysql.jdbc.ResultSetMetaData;
import java.sql.Statement;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import Parameter.Param;
import file.filemanager;

import javax.naming.*;





public class DealDatabase {
	
	public static boolean connectPG() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
		String Citys = "public anteruser";
		String publics = Citys;
		String sql = "create view mn as select id , name from anteruser where id > 1";  
		
		System.out.print("name = "+sql);
		// 连接字符串，格式： "jdbc:数据库驱动名称://数据库服务器ip/数据库名称"  
		String url = "jdbc:postgresql://localhost:5432/NowFaimily";  
		String username = "gyc";  
		String password = "123456";  
		  
		Class.forName("org.postgresql.Driver").newInstance();  
		  
		Connection conn = DriverManager.getConnection(url, username, password);   
		PgStatement  stmt = (PgStatement) conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE  
		                                     , ResultSet.CONCUR_UPDATABLE);  
		boolean  rs   = stmt.execute(sql);
//		while(rs.next()){
//			String name = rs.getString("receiveaddress");
//			System.out.print("name = "+name);
//		}
//		  
//		rs.close();  

		return false;
	}
	
    // 执行某条SQL语句
	public static boolean executeSQL(String sql) throws SQLException{
		Statement stmt1 = null;
		try {
			try {
				stmt1 = (Statement) DB.getInstance().getStamt();
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    boolean stmt2 = stmt1.execute(sql);
		return stmt2;
	}
	
	//得到数据表的相关信息
	public static String getTableInfo(String sql) throws SQLException, JSONException{
		String info = "";
	    Statement stmt1 = null;
		try {
			try {
				stmt1 = (Statement) DB.getInstance().getStamt();
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    boolean stmt2 = stmt1.execute(sql);
	    ResultSet rs = (ResultSet) stmt1.getResultSet();
	  
	  	 
	  	   JSONArray ta = new JSONArray();
	       int index = 0;
	       while(rs.next()){
	    	   ta.put(index, rs.getString("Comment"));
	                      	
	       } 
	       JSONObject sendobj = new JSONObject();
	       
	       sendobj.put("ps", ta);
	       
	       
	       if (index == 0){
	    	   return null;
	       }
	       
	  	   return sendobj.toString();
 
	}
	
	// 得到某个数据表的所有标签
	public static String[] getTableProNames(String tableName) throws SQLException{
		   String sql = "select * from "+tableName;
		   Statement stmt1 = null;
		try {
			try {
				stmt1 = (Statement) DB.getInstance().getStamt();
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	  	   ResultSet rs = stmt1.executeQuery(sql);
	  	    
	  	   ResultSetMetaData rsmd = (ResultSetMetaData) rs.getMetaData();
	  	   String tbname = rsmd.getTableName(1);
//	  	   System.out.print("biaoming "+tbname);
	  	   int colum = rsmd.getColumnCount();
	  	   String [] labelName = new String[colum];
	  	
	  	   for(int index = 0; index < colum; index ++){
	  		 labelName[index] = rsmd.getColumnName(index +1);
	  	   }
	  	   return labelName;
	}
	
    //	得到ResultSet查询结果
	public static String getQuerryJsonStringData(String sql) throws SQLException, JSONException{
	   Statement stmt1 = null;
	try {
		try {
			stmt1 = (Statement) DB.getInstance().getStamt();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	} catch (NamingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
  	   ResultSet rs = stmt1.executeQuery(sql);
  	    
  	   ResultSetMetaData rsmd = (ResultSetMetaData) rs.getMetaData();
  	   String tbname = rsmd.getTableName(1);
//  	   System.out.print("biaoming "+tbname);
  	   int colum = rsmd.getColumnCount();
  	   String [] labelName = new String[colum];
  	
  	   for(int index = 0; index < colum; index ++){
  		 labelName[index] = rsmd.getColumnName(index +1);
  	   }
  	 
  	   JSONArray ta = new JSONArray();
       int index = 0;
       while(rs.next()){
    	   
      	   JSONObject appts  = new JSONObject();
       	   for(int ji = 1; ji <= colum; ji ++){
       		  String name = rsmd.getColumnName(ji);
       		  int type = rsmd.getColumnType(ji);
       		  if(type == Param.DOUBLE){
       			 appts.put(name, rs.getDouble(name));
       		  }else if(type == Param.INT){
       			 appts.put(name, rs.getInt(name));
       		  }else if(type == Param.FLOAT){
        		 appts.put(name, rs.getFloat(name));
        	  }else{
//        		 String ts = new String(rs.getString(name),"UTF-8");
        		 // 去掉特殊的符号
        		 String fstr = rs.getString(name);
         		 if (fstr != null){
         			String gtfstr = fstr;
	       			for(int indexs = 0; indexs < Param.allspstr.length; indexs ++){
	         		 	gtfstr = gtfstr.replaceAll(Param.allspstr[indexs], ""); 
	         		 	appts.put(name,gtfstr);
	       			}
         		 }
        		 
        		 
       		  }
       		  
       	   }
          
       	   ta.put(index, appts);
           index = index + 1;              	
       } 
       JSONObject sendobj = new JSONObject();
  
       sendobj.put("ps", ta);
       sendobj.put("lb",labelName);
       
       if (index == 0){
    	   return null;
       }
       int tindex = 0;
 
       String str = sendobj.toString();
       

  	   return str;
  	   
  	   
	}
	
	 
	
    // 导出数据
	public static String ExportGameData(String sql) throws SQLException, JSONException{
		 Statement stmt1 = null;
		try {
			try {
				stmt1 = (Statement) DB.getInstance().getStamt();
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	  	   ResultSet rs = stmt1.executeQuery(sql);
	  	 
	  	   ResultSetMetaData rsmd = (ResultSetMetaData) rs.getMetaData();
	  	   String tbname = rsmd.getTableName(1);
//	  	   System.out.print("biaoming "+tbname);
	  	   int colum = rsmd.getColumnCount();
	  	   String [] labelName = new String[colum];
	  	
	  	   for(int index = 0; index < colum; index ++){
	  		 labelName[index] = rsmd.getColumnName(index +1);
	  	   }
	  	 
	  	   JSONArray ta = new JSONArray();
	       int index = 0;
	       boolean canexport = true;
	       while(rs.next()){
	    	   canexport = true;
	      	   JSONObject appts = new JSONObject();
	       	   for(int ji = 1; ji <= colum; ji ++){
	       		  String name = rsmd.getColumnName(ji);
	       		  int type = rsmd.getColumnType(ji);
	       		  if(type == Param.INT && rs.getInt(name) == -101){
	       		    continue;
	       		  }
	       		  
	       		  if(type == Param.DOUBLE){
	       			 appts.put(name, rs.getDouble(name));
	       		  }else if(type == Param.INT){
	       			 appts.put(name, rs.getInt(name));
	       			 
	       			 if(rs.getInt(name) == -10045){
	       				canexport = false;
	       			 }
	       		  }else if(type == Param.FLOAT){
	        		 appts.put(name, rs.getFloat(name));
	        	  }else{
	        		 String str  = rs.getString(name);
	        		 String tstr = new String();
	        		
         		     if (str != null){
         		    	String allstr = str; 
 	         			for(int indexs = 0; indexs < Param.allspstr.length; indexs ++){
 	         			  allstr = allstr.replaceAll(Param.allspstr[indexs], ""); 
	         			  if (indexs == Param.allspstr.length - 1){
	         				 tstr = allstr;
	         			  }
 	         			}
 	         		 }
         		    if(tstr.equals("-10045")){
	        			 canexport = false; 
	        		 }
	       			 appts.put(name, tstr);
	       		  }
	       		  
	       	   }
	       	   if(canexport == true){
	       		 ta.put(index, appts);
		         index = index + 1;   
	       	   }
	       	              	
	       } 
	       
	       if (index == 0){
	    	   return null;
	       }
	       String str = ta.toString();
	      
	  	   return str;
	}
	
	
	
	
	
	// 更新数据库 返回true说嘛更新成功
	public static boolean updateDatabase(String sql) throws SQLException{
		  Statement stmt = null;
		try {
			try {
				stmt = (Statement) DB.getInstance().getStamt();
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
          int a = stmt.executeUpdate(sql);
          boolean yes = false;
          if (a != -1){
        	 yes = true;
          }
          return yes;
	}
	
//	到处单条数据
	   public static void exportSingleData(String dicName, String sql) throws SQLException, JSONException{
		   Statement stmt1 = null;
		try {
			try {
				stmt1 = (Statement) DB.getInstance().getStamt();
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	  	   ResultSet rs = stmt1.executeQuery(sql);
	  	 
	 	   ResultSetMetaData rsmd = (ResultSetMetaData) rs.getMetaData();
	  	   String tbname = rsmd.getTableName(1);
//	  	   System.out.print("biaoming "+tbname);
	  	   int colum = rsmd.getColumnCount();
	  	   String [] labelName = new String[colum];
	  	  
	  	   for(int index = 0; index < colum; index ++){
	  		 labelName[index] = rsmd.getColumnName(index +1);
	  	   }
	  while(rs.next()){
 	   JSONObject appts = new JSONObject();
  	   for(int ji = 1; ji <= colum; ji ++){
  		  String name = rsmd.getColumnName(ji);
  		  int type = rsmd.getColumnType(ji);
  		  if(type == Param.DOUBLE){
  			 appts.put(name, rs.getDouble(name));
  		  }else if(type == Param.INT){
  			 appts.put(name, rs.getInt(name));
  		  }else if(type == Param.FLOAT){
   		   appts.put(name, rs.getFloat(name));
   	      }else{
   	    	String tstr = rs.getString(name).replaceAll("\r", "");
  			appts.put(name, tstr);
  		  }
  	    }
       // 导出文件
  	   String fileName = appts.getString("id");
  	   if(dicName == ""){
  		   
  		 filemanager.getFM().writeJSONDataToFile(appts.toString(), "/Users/ammini/Desktop/xzry/res/JsonData/"+dicName+"/"+fileName+".json");  
  	   }else{
  		 filemanager.getFM().writeJSONDataToFile(appts.toString(), "/Users/ammini/Desktop/xzry/res/JsonData/"+dicName+"/"+fileName+".json");
  	   }
  	  
    } 
	   }
}
