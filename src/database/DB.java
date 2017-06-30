package database;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource; 
import java.sql.Statement;
public class DB{
	  private Connection conn = null;
	  private Statement stat = null;
      //加载数据库驱动类
	  DataSource ds;
                                                        
	   
    private String url = "jdbc:mysql://localhost:3306/Xuzhirongyao?useUnicode=true&characterEncoding=UTF-8";
//    private String url = "jdbc:postgresql://localhost:5432/Citys?useUnicode=true&characterEncoding=UTF-8";
    
      //数据库用户名
    private String user = "root";
      //数据库密码 
       private String password = "Abc123456";
      
//      private String url = "jdbc:mysql://121.42.53.24:3306/WMDATABASE?useUnicode=true&characterEncoding=UTF-8";
//      //数据库用户名
//      private String user = "root";
//      //数据库密码 
//      private String password = "e20yEIOd6Ugl";
 
//	  private String url = "jdbc:mysql://mysql.sql88.eznowdata.com/sq_games1?useUnicode=true&characterEncoding=UTF-8";
//	  //数据库用户名
//	  private String user = "sq_games1";
//	  //数据库密码
//	  private String password = "Xzmm323425";    
	    
 
      
      private static DB dbm;
      public DB()  {
    	    Context c = null;
    	    Context ctx = null;
			try {
				c = new InitialContext();
				 ctx = (Context) c.lookup("java:comp/env"); 
			} catch (NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 
			try {
				 
				  ds =(DataSource)ctx.lookup("jdbc/Xuzhirongyao"); 
			} catch (NamingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			  try {
					conn = ds.getConnection();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}   	 
   	  
      }
      public static DB  getInstance() throws NamingException, SQLException, InstantiationException, IllegalAccessException{
    	  if(dbm == null){
    		  dbm = new DB();
    	  }
    	  return dbm;
      }
      public void closeConn(){
    	  try {
			if (conn != null){
				conn.close();
//				conns.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
      } 
      public Statement getStamt(){
    	
    	  try {
			stat = conn.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
    	  return stat;
      }
      
      
	 
}
