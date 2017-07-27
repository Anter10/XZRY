package Parameter;

import java.io.IOException;
import java.sql.SQLException;

import org.json.JSONException;

import database.*;
import org.json.*;
import file.*;
import java.util.*;

public class ProduceTableClassModel {
    
    private String Info = "//本文档由  hskj-express 在"+Param.getTime()+"创建";
    // 产生单个表的java模版类
    public  String produceClassModel(String tbname) throws SQLException, JSONException{
    	String classinfo = "";
    	// java类名称
    	String javaname = tbname;
    	// java文件名称
    	String filename = tbname;
    	
    	classinfo = "package hskj.express.client.model; \n\n\n " +Info+"\n\n"
    			+ "public class " + javaname +"{\n\n";
    	// 查询给定的表名称
    	String selectsql = "select * from " + tbname ;
    	// 得到表的所有字段名称
    	String []alllabelname = DealDatabase.getTableProNames(tbname);
    	System.out.println("/n"+tbname + "name = "+alllabelname);
    	if(alllabelname != null){
    		for(int lbIndex = 0; lbIndex < alllabelname.length; lbIndex ++){
    			String tstring = "     private String " +alllabelname[lbIndex] + " = null;\n" ;
    			String labelname =alllabelname[lbIndex];
    			String fStr    = labelname.substring(0, 1).toUpperCase();
    			String fiStr   = labelname.substring(1, labelname.length());
    			String setFunc = "     public void set"+fStr+fiStr + "( String "+labelname+")" +"{\n" + "         this." + labelname + " = " + labelname +";\n"+"     }\n";
    			String getFunc = "     public String get"+fStr+fiStr + "()" +"{\n" + "         return this." + labelname + ";"+"\n     }\n\n";
    			classinfo = classinfo + tstring + setFunc + getFunc;
    		}
    		   
    	}else{
    		return null;
    	}
    	
    	return classinfo + "}\n\n";
    }
    
    // 生成所有的数据模型
    public  boolean produceAllJavaModel(String filetype, List<String> dbtable) throws SQLException, JSONException, IOException{
    	for(int tbIndex = 0; tbIndex < dbtable.size(); tbIndex ++){
    		String classinfo = "";
    		if(filetype.equals("java")){
    		   classinfo = this.produceClassModel(dbtable.get(tbIndex));
    		}else if(filetype.equals("lua")){
    			classinfo = this.produceSingleLuaScript(dbtable.get(tbIndex));
    		}	
    		if(classinfo != null){
    		  String name =  "/Users/guoyouchao/Desktop/model/"+dbtable.get(tbIndex)+"."+filetype;	
    		  filemanager.getFM().writeJSONDataToFile(classinfo,name);
    		}
    	}
    	return true;
    }
    
    // 生成Lua脚本文件
    public String produceSingleLuaScript(String tbname) throws SQLException, JSONException{
    	// 写出的文本数据
    	String finInfo = "";
        // 类名称 	
    	String className = tbname;
            	
    	finInfo = "local " + className + " = class(\""+className+"\",{})\n\n";
    	// 查询给定的表名称
//    	String selectsql = "select * from " + tbname ;
    	// 得到表的所有字段名称
    	String []alllabelname = DealDatabase.getTableProNames(tbname);
    	finInfo = finInfo + "\nfunction " + className + ":ctor(data)\n   self.data = data    \nend\n\n\n";
    	if(alllabelname != null){
    		for(int lbIndex = 0; lbIndex < alllabelname.length; lbIndex ++){
    			String labelname = alllabelname[lbIndex];
    			String fStr    = labelname.substring(0, 1).toUpperCase();
    			String fiStr   = labelname.substring(1, labelname.length());
    			String function = "function " + className + ":get"+fStr+fiStr +"()\n    return self.data["+"\""+labelname+"\"]\nend\n\n\n";
    			finInfo = finInfo + function;
    		}
    	    return     finInfo + "\n\n\nreturn " +className +"\n\n\n" ; 
    	}
    	return null;
    }
    
    public static void exportLua(String lan, List<String> dbtable) throws SQLException, JSONException, IOException{
    	ProduceTableClassModel bb = new ProduceTableClassModel();
    	bb.produceAllJavaModel(lan, dbtable);
    }
}
