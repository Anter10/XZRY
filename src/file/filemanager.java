package file;
import java.io.*;
import jxl.*;
import jxl.read.biff.BiffException;
import jxl.write.*;
import sun.misc.BASE64Decoder;
 
import org.json.*;

import java.util.Enumeration;  
import java.util.zip.CRC32;  
import java.util.zip.CheckedOutputStream;  
import java.util.zip.ZipEntry;  
import java.util.zip.ZipFile;  
import java.util.zip.ZipOutputStream;  
  
import org.apache.commons.lang.*; 
  
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
public class filemanager {
   
	private static  filemanager  fm = new filemanager();
	
	
	public static filemanager getFM(){
		if(fm == null){
			fm = new filemanager();
		}
		return fm;
	}
	
	// 读取一个excel中的所有数据
	public static JSONArray readAExcelAllData(String path) throws BiffException, IOException, JSONException{
		   WorkbookSettings workbookSettings = new WorkbookSettings();
		    workbookSettings.setEncoding("GBK");
 	   
	        Workbook workbook = Workbook.getWorkbook(new File(path),workbookSettings);
	        int   sheetnum = workbook.getNumberOfSheets();
	        System.out.print("当前的 页面数  = "+sheetnum +"\n");
	        JSONArray allarray = new JSONArray();
	        JSONArray darray   = new JSONArray();
	        
	        
	        JSONArray allsheetnames = new JSONArray();
	        for(int sn = 0 ; sn < sheetnum; sn ++){
	        	Sheet sheet = workbook.getSheet(sn);
	            int col =    sheet.getColumns();
	 	        int row =    sheet.getRows();
	 	        String sheetname = sheet.getName();
 
	 	        String a[] = sheetname.split("_");  
	 	        // 得到字数据库的数据
	 	        sheetname = a[1];
	 	        JSONArray finalArray = new JSONArray();
		        for (int i = 0; i < row; i++) {
		            JSONArray tArray = new JSONArray();
		            for (int j = 0; j < col; j++) {
	                    String value = sheet.getCell(j,i).getContents();
		                tArray.put(j, value);
		            }
		            finalArray.put(i, tArray);
		        }
		        
		        allsheetnames.put(sn, sheetname);
		        darray.put(sn, finalArray); 
	        }
	        allarray.put(0, allsheetnames);
	        allarray.put(1, darray);
		    return allarray;
		
	}
//	读取Excel 数据 将其转换成JSON数据
	 public static JSONArray readExcelData(String path) throws BiffException, IOException, JSONException{
		    WorkbookSettings workbookSettings = new WorkbookSettings();
		    workbookSettings.setEncoding("GBK");
    	   
	        Workbook workbook = Workbook.getWorkbook(new File(path),workbookSettings);
	       
	        Sheet sheet = workbook.getSheet(0);//得到excel第一页的内容
	        int   sheetnum = workbook.getNumberOfSheets();
	        System.out.print("当前的 页面数  = "+sheetnum +"\n");
	        int col =    sheet.getColumns();
	        int row =    sheet.getRows();
	        
	        JSONArray finalArray = new JSONArray();
	        for (int i = 0; i < row; i++) {
	            JSONArray tArray = new JSONArray();
	            for (int j = 0; j < col; j++) {
                    String value = sheet.getCell(j,i).getContents();
	                tArray.put(j, value);
	            }
	            finalArray.put(i, tArray);
	        }
//            System.err.println(finalArray.toString());
	        return finalArray;
	    }
	
	// 将文本写入文件
	public void writeJSONDataToFile(String data,String fielName){
		try{ 
			 System.out.print(fielName);
			 File f1 = createFile(fielName);
		     BufferedWriter writer = new BufferedWriter(new FileWriter(f1));
             writer.write(data);
             writer.flush();
		     writer.close();
		     
		}catch(Exception e){
		}
	}
	//创建文件
	public File createFile(String filename) throws IOException{
		File f1 = new File(filename);
		f1.createNewFile();
		return f1;
	}
	
	// 创建目录
	public void createDir(String dir){
		if(isDir(dir) == false){
		    File f1 = new File(dir);
			f1.mkdirs();
		}
	}
    // 判断是否是文件
	public boolean isFile(String filename){
		File f1 = new File(filename);
		return f1.isFile();
	}
	//判断是否是文件夹
	public boolean isDir(String filename){
		File f1 = new File(filename);
		return f1.isDirectory();
	}
	// 判断当前给定的文件或者目录是否存在
	public boolean isExit(String filename){
		File f1 = new File(filename);
		return f1.exists();
	}
	//重新命名文件
	public boolean renameFile(String oldfile,String newfile){
		File f1 = new File(oldfile);
		File f2 = new File(newfile);
		return f1.renameTo(f2);
	}
	public boolean deleteDictionaryOrFile(String name){
		File f = new File(name);
		return f.delete();
	}

	
	public void printDirOfFiles(String dirname){
		File f = new File(dirname);
		if(f.isDirectory()){
			int i = 0;
			for(;i < f.listFiles().length; i++){
				System.out.println("第 "+ String.valueOf(i)+"文件是 ：" + f.listFiles()[i].getName().toString());
			}
		}
	}
	
	// 返回指定目录中的文件
	public File[] getDirOfFiles(String dirname){
		File f = new File(dirname);
		File[] files = new File[f.listFiles().length];
		if(f.isDirectory()){
			int i = 0;
			for(;i < f.listFiles().length; i++){
				if(f.listFiles()[i].isFile()){
					files[i] = f.listFiles()[i];
				}
			}
		}
		return files;
	}
	
	// 文件拷贝 第一个参数拷贝到那个文件 第二个参数 被拷贝的文件  第三个参数 是否覆盖原来的内容
	public boolean copyFileFromTo(String fromfile ,String tofile,boolean append) throws IOException{
		boolean finish = false;
		@SuppressWarnings("resource")
		FileOutputStream output = new FileOutputStream(tofile,append);
		@SuppressWarnings("resource")
		FileInputStream input = new FileInputStream(fromfile);
		int c = 0;
		while((c = input.read()) != -1){
			output.write(c);
		}
		return finish;
	}
	
	// 带缓冲的文件拷贝 第一个参数拷贝到那个文件 第二个参数 被拷贝的文件  第三个参数 是否覆盖原来的内容 第四个参数表示缓冲区域的大小
	public boolean copyFileFromToWithBuffered(String fromfile ,String tofile,boolean append,int size) throws IOException{
		boolean finish = false;
		FileOutputStream output = new FileOutputStream(tofile,append);
		FileInputStream input = new FileInputStream(fromfile);
		@SuppressWarnings("resource")
		BufferedInputStream bufferedinput = new BufferedInputStream(input,size);
		@SuppressWarnings("resource")
		BufferedOutputStream budderedoutput = new BufferedOutputStream(output,size);
		
		int c = 0;
		while((c = bufferedinput.read()) != -1){
			budderedoutput.write(c);
		}
		budderedoutput.flush();
		budderedoutput.close();
		return finish;
	}
	
	 private static void zip(String srcRootDir, File file, ZipOutputStream zos) throws Exception  
	    {  
	        if (file == null)   
	        {  
	            return;  
	        }                 
	          
	        //如果是文件，则直接压缩该文件  
	        if (file.isFile())  
	        {             
	            int count, bufferLen = 1024;  
	            byte data[] = new byte[bufferLen];  
	              
	            //获取文件相对于压缩文件夹根目录的子路径  
	            String subPath = file.getAbsolutePath();  
	            int index = subPath.indexOf(srcRootDir);  
	            if (index != -1)   
	            {  
	                subPath = subPath.substring(srcRootDir.length() + File.separator.length());  
	            }  
	            ZipEntry entry = new ZipEntry(subPath);  
	            zos.putNextEntry(entry);  
	            BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));  
	            while ((count = bis.read(data, 0, bufferLen)) != -1)   
	            {  
	                zos.write(data, 0, count);  
	            }  
	            bis.close();  
	            zos.closeEntry();  
	        }  
	        //如果是目录，则压缩整个目录  
	        else   
	        {  
	            //压缩目录中的文件或子目录  
	            File[] childFileList = file.listFiles();  
	            for (int n=0; n<childFileList.length; n++)  
	            {  
	                childFileList[n].getAbsolutePath().indexOf(file.getAbsolutePath());  
	                zip(srcRootDir, childFileList[n], zos);  
	            }  
	        }  
	    } 
	 
	   /** 
     * 对文件或文件目录进行压缩 
     * @param srcPath 要压缩的源文件路径。如果压缩一个文件，则为该文件的全路径；如果压缩一个目录，则为该目录的顶层目录路径 
     * @param zipPath 压缩文件保存的路径。注意：zipPath不能是srcPath路径下的子文件夹 
     * @param zipFileName 压缩文件名 
     * @throws Exception 
     */  
    public static void zip(String srcPath, String zipPath, String zipFileName) throws Exception  
    {  
      
        CheckedOutputStream cos = null;  
        ZipOutputStream zos = null;                       
        try  
        {  
            File srcFile = new File(srcPath);  
              
            //判断压缩文件保存的路径是否为源文件路径的子文件夹，如果是，则抛出异常（防止无限递归压缩的发生）  
            
            //判断压缩文件保存的路径是否存在，如果不存在，则创建目录  
            File zipDir = new File(zipPath);  
            if (!zipDir.exists() || !zipDir.isDirectory())  
            {  
                zipDir.mkdirs();  
            }  
              
            //创建压缩文件保存的文件对象  
            String zipFilePath = zipPath + File.separator + zipFileName;  
            File zipFile = new File(zipFilePath);             
            if (zipFile.exists())  
            {  
                //检测文件是否允许删除，如果不允许删除，将会抛出SecurityException  
                SecurityManager securityManager = new SecurityManager();  
                securityManager.checkDelete(zipFilePath);  
                //删除已存在的目标文件  
                zipFile.delete();                 
            }  
              
            cos = new CheckedOutputStream(new FileOutputStream(zipFile), new CRC32());  
            zos = new ZipOutputStream(cos);  
              
            //如果只是压缩一个文件，则需要截取该文件的父目录  
            String srcRootDir = srcPath;  
            if (srcFile.isFile())  
            {  
                int index = srcPath.lastIndexOf(File.separator);  
                if (index != -1)  
                {  
                    srcRootDir = srcPath.substring(0, index);  
                }  
            }  
            //调用递归压缩方法进行目录或文件压缩  
            zip(srcRootDir, srcFile, zos);  
            zos.flush();  
        }  
        catch (Exception e)   
        {  
            throw e;  
        }  
        finally   
        {             
            try  
            {  
                if (zos != null)  
                {  
                    zos.close();  
                }                 
            }  
            catch (Exception e)  
            {  
                e.printStackTrace();  
            }             
        }  
    } 
    
	// 拷贝文件夹下面所有文件到另一个文件夹
	public void copyDirToDir(String oldDir, String newDir) throws IOException{
		File olddir = new File(oldDir);
		if(olddir.isDirectory() == true){
			File files[] = olddir.listFiles();
			int a = 123;
			for(int fileIndex = 0; fileIndex < files.length; fileIndex ++){
				if(files[fileIndex].isFile()){
					String oldname = files[fileIndex].getPath();
					
					String newname = newDir + files[fileIndex].getName();
					FileOutputStream fo = new FileOutputStream(newname);
					FileInputStream  fi = new FileInputStream(oldname);
					int c = 0;
					while((c = fi.read()) != -1){
						System.out.println(c);
						c = c ^ a;
						fo.write(c);
					}
					fo.flush();
					fo.close();
				}
				
 
//				
//				
//				
//				copyFileFromTo(oldname,newname,true);
			}
		}
	}
	
}
