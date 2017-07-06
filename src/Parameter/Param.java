package Parameter;

import org.json.*;

import java.io.*; 
import javax.mail.*;
import java.util.*;
import javax.mail.internet.*;
import java.util.Calendar;  
import java.util.Date; 
import java.net.*;
import java.text.SimpleDateFormat;

import com.aliyun.mns.client.CloudAccount;
import com.aliyun.mns.client.CloudTopic;
import com.aliyun.mns.client.MNSClient;
import com.aliyun.mns.common.ServiceException;
import com.aliyun.mns.model.BatchSmsAttributes;
import com.aliyun.mns.model.MessageAttributes;
import com.aliyun.mns.model.RawTopicMessage;
import com.aliyun.mns.model.TopicMessage;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.sms.model.v20160927.SingleSendSmsRequest;
import com.aliyuncs.sms.model.v20160927.SingleSendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;

import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;
 



public class Param {
	

	 
  // 公司邮箱地址
  public static String COMPANYEAMIL = "892466942@qq.com";
  

  //  上传参数字段
  public static String PJ = "pj";
  //  成功返回参数字段
  public static String PS = "ps";
  //  失败返回参数字段
  public static String PE = "pe";
  public static String[] allspstr = {"\n","\r"};
  // 相关数据类型
  public static int INT          =    4;
  public static int VARCHAR      =    12;
  public static int DOUBLE       =    8;  
  public static int FLOAT        =    7;
  public static int YEAR         =    91;
 
  public static String errorKey  =    "error";
  
  public static String showkey   =    "show";
  public static String successKey  =    "success";
  // 获得当前系统时间
  public static long getCurentServerTime(){
	  long curTime = System.currentTimeMillis();
	  return curTime;
  }
//  得到时间
  public static String getTime(){
	  Date now = new Date(); 
	  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
      String hehe = dateFormat.format( now ); 
	  return hehe;
  }
  public static JSONArray addMessage;
  public static int MAXNUM = 0;
  public static String updateDataSql;
  public static String addDataSql;
  public static JSONArray updateModelData;
  public static String getSysYMD(){
	  String     ftime     =    "";
	  Calendar   now       =    Calendar.getInstance();  
	  String     year      =    now.get(Calendar.YEAR)         +    "年";
	  String     month     =    (now.get(Calendar.MONTH) + 1)  +    "月" ;
      String     day       =    now.get(Calendar.DAY_OF_MONTH) +    "日";
      String     time      =    now.get(Calendar.HOUR_OF_DAY)  +    "时";
      String     minute    =    now.get(Calendar.MINUTE)       +    "分";
      String     second    =    now.get(Calendar.SECOND)       +    "秒";
      ftime                =    year + month + day + time + minute + second;
      return     ftime;
  }
  //  失败的相关数据代号
  public static JSONObject ERROR_CODE = new JSONObject();
  
  
  // 需要导出单条记录的表 
  public static String [] SingleTable = {
	"SystemIntensifyData"	  
  };
  // 所有表名
  public static String [] allgametable = {
     "SystemTavernData","SystemShowWorldData","SystemMapChapterTask","SystemMapChapterData","SystemStrangeData","SystemDevelopmentData", "needdatas","work","SystemChessData","txt","ChatSystemData","SystemEmailTypeData","PropCombineData","SystemAwardTypeData","AllLanguageData","SystemSkillUpLevelData","SystemHeroPromotionData","AllUpLevelData","AllDialogData","RolesAllDialogData","ProperityEffectData","SystemSpecialSkillData","AllHerosData","TerritoryCellData","TerritoryMapData", "RoleSuitData", "SystemEquipData","LoadingLayerData","GameTimes","LinkActionData","HeroStatues","HeroStatueConvert","SystemBattleUnitData","BattleSceneParamData","AllSpecialData","RoleSpecialData","BattleRoleSpecialGrowup","CommonActionData","SystemBuffData","SystemSkillData","SystemSonSkillData","DialogViewData","SoltNameData","SystemBuyDiamondData","SystemPropData","SystemChatTypeData","SystemEmailData","SystemPropTypeData","SystemGameViewsData","SystemUIAudoEffect","SystemRolesAudioEffect","SystemGameMusic",
      "MainCityResData","SystemBuildLevelData","SystemColor","SystemTextFontData","SystemFontData","SystemFontUseData","SystemIconBottom","SystemIconData","SystemIconFramData","SystemShopTypeData","SystemHeroRandomActions",
     "SystemSkillAudioEffect","SystemRolesAudioEffect","SystemUIAudoEffect","SystemOnlyUiTextData","BattleBackgroundMapData","UINpcData","SystemTerritoryMapTreasureData","systemdandata","BattlePVEAreanPosData","systemmonsterdata","systembattlenpcdata","equipitemdata"
  };
  
  public static String [] allheroproperty = {
		  "100101","100201","100301","100401","100501","100601","100701","100801","100901","101001","101101","101201","101301","101401","101501","101601",
			"101701","101801","101901","102001","160101","160201","160301","160401","160501","160601","160701","160801","160901","161001","180101","191001",
			"192001","193001"
  };


  
  // 发送数据
  public static void sendData(String data,PrintWriter pw){
	  pw.write(data);
	  pw.flush();
	  pw.close();
  }
  public static String [] alluserdata = {
		   };
  // 获的JSON对象
  public static JSONObject getJsonObj(){
	  return new JSONObject();
  }
  // 获的JSON数组
  public static JSONArray getJSONArray(){
	  return new JSONArray();
  }
  // 发送数据
  public static void getDatas(String data,PrintWriter pw){
	  pw.write(data);
	  pw.flush();
	  pw.close();
  }
 
  // 产生随机数
  public static String getYZM(){
	  String randStr = "";
	  randStr += (int)(Math.random()*9+1);
	  for(int i = 0; i < 5; i++){
          randStr += (int)(Math.random()*10);
	  }
      return randStr;
  }
  
  public static void sendMSGBYAlm(String param, String Phone){
	  try {
	        IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAI3vOaTlcUbNQQ", "pUwd0GaZIZKyo4cBXOWy7oMmrV9qdA");
	         DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", "Sms",  "sms.aliyuncs.com");
	        IAcsClient client = new DefaultAcsClient(profile);
	        SingleSendSmsRequest request = new SingleSendSmsRequest();
	            request.setSignName("黑色科技");//控制台创建的签名名称
	             request.setTemplateCode("SMS_53070214");//控制台创建的模板CODE
	            request.setParamString(param);//短信模板中的变量；数字需要转换为字符串；个人用户每个变量长度必须小于15个字符。"
	            //request.setParamString("{}");
	            request.setRecNum(Phone);//接收号码
	            SingleSendSmsResponse httpResponse = client.getAcsResponse(request);
	            System.out.print(httpResponse.getRequestId());
	        } catch (ServerException e) {
	            e.printStackTrace();
	        }
	        catch (ClientException e) {
	            e.printStackTrace();
	        }
  }
  
  
  //  发送邮件的方法
  public static boolean SendEmail(String emailaddress,String emailtitle,String message,PrintWriter pw) throws MessagingException{
	  boolean hassend = false;
	  String qm ="xzntxMM323425_"; //您的QQ密码
	  String tu = "qq.com"; //你邮箱的后缀域名
	  Properties props=new Properties();
      props.setProperty("www.anters.net","smtp."+tu);//发信的主机，这里我填写的是我们公司的主机！可以不用修改！
      props.setProperty("mail.smtp.auth","true");
      Session s = Session.getInstance(props);
      s.setDebug(true);
      MimeMessage msg = new MimeMessage(s);
      //给消息对象设置发件人/收件人/主题/发信时间
      InternetAddress from= new InternetAddress("892466942@qq.com"); //这里的115798090 改为您发信的QQ号
      msg.setFrom(from);
      InternetAddress to=new InternetAddress(emailaddress);
      msg.setRecipient(Message.RecipientType.TO,to);
      msg.setSubject(emailtitle);
      msg.setSentDate(new Date());
      //给消息对象设置内容
      BodyPart mdp=new MimeBodyPart();//新建一个存放信件内容的BodyPart对象
      mdp.setContent(message,"text/html;charset=UTF-8");//给BodyPart对象设置内容和格式/编码方式
      MimeMultipart mm = new MimeMultipart();//新建一个MimeMultipart对象用来存放BodyPart对
      //象(事实上可以存放多个)
      mm.addBodyPart(mdp);//将BodyPart加入到MimeMultipart对象中(可以加入多个BodyPart)
      msg.setContent(mm);//把mm作为消息对象的内容
      msg.saveChanges();
      Transport transport=s.getTransport("smtp");
      transport.connect("smtp."+tu,"892466942",qm); //这里的115798090也要修改为您的QQ号码
      try{
    	  transport.sendMessage(msg,msg.getAllRecipients()); 
          transport.close();
          hassend = true;
      }catch(SendFailedException ex){
    	  JSONObject errorObj = new JSONObject();
		  try {
			errorObj.put(Param.errorKey, "验证码已经发到你的邮箱, 请注意查收");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  Param.sendData(errorObj.toString(), pw);
		  hassend = false;
      }
      System.out.print("邮箱发送成功  ＝"+hassend);
	  return hassend;
  }
  
  // 使用阿里大鱼短信平台发送
  public static JSONObject sendMSGBydy(String toPhone, String msg) throws ApiException{
//	                                                 http://gw.api.taobao.com/router/rest
	  TaobaoClient client = new DefaultTaobaoClient("http://gw.api.taobao.com/router/rest", "23406282", "261aac88b72a489a5f515dc6359e54f4");
      AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
	  req.setExtend("123456");
	  req.setSmsType("normal");
	  req.setSmsFreeSignName("郭有超");
	  req.setSmsParamString(  "{code:'"+msg+"'}"  );
	  req.setRecNum( "15010215839" );
	  req.setSmsTemplateCode( "SMS_12200925" );
	  AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
	  System.out.println(rsp.getBody());
      
	  JSONObject obj = null;
		try {
			System.out.println("发送短信返回数据 ＝ "+rsp.getBody());
			obj = new JSONObject( rsp.getBody());
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return obj; 
  }
  
  
  
  // 用手机号发送短信
  public static JSONObject sendMessageToPhoneNumber(String toPhone, String message){
	  
	  String httpUrl = "http://apis.baidu.com/kingtto_media/106sms/106sms";
	  String httpArg = "mobile="+toPhone+"&content="+message+"&tag=2";
	  String jsonResult = request(httpUrl, httpArg);
	  
	  JSONObject obj = null;
	try {
		obj = new JSONObject(jsonResult);
	} catch (JSONException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	System.out.println(obj.toString());
	  return obj;
  }
  
  public static String request(String httpUrl, String httpArg) {
      BufferedReader reader = null;
      String result = null;
      StringBuffer sbf = new StringBuffer();
      httpUrl = httpUrl + "?" + httpArg;

      try {
          URL url = new URL(httpUrl);
          HttpURLConnection connection = (HttpURLConnection) url
                  .openConnection();
          connection.setRequestMethod("GET");
          // 填入apikey到HTTP header
          connection.setRequestProperty("apikey",  "586e025c76f3d64c1048d1fc642fdb83");
          connection.connect();
          InputStream is = connection.getInputStream();
          reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
          String strRead = null;
          while ((strRead = reader.readLine()) != null) {
              sbf.append(strRead);
              sbf.append("\r\n");
          }
          reader.close();
          result = sbf.toString();
      } catch (Exception e) {
          e.printStackTrace();
      }
      return result;
  }
  
  public static void Log(String key,String msg){
	  System.out.println(key + " = " + msg);
  }
  
  public static void sendPhone(){
	  /**
       * Step 1. 获取主题引用
       */
	  CloudAccount account = new CloudAccount("LTAI3vOaTlcUbNQQ", "pUwd0GaZIZKyo4cBXOWy7oMmrV9qdA", "http://1630782170870867.mns.cn-hangzhou.aliyuncs.com/");
      MNSClient client = account.getMNSClient();
      CloudTopic topic = client.getTopicRef("sms.topic-cn-hangzhou");
      
     
      /**
       * Step 2. 设置SMS消息体（必须）
       *
       * 注：目前暂时不支持消息内容为空，需要指定消息内容，不为空即可。
       */
      RawTopicMessage msg = new RawTopicMessage();
      msg.setMessageBody("sms-subscription");
      /**
       * Step 3. 生成SMS消息属性
       */
      MessageAttributes messageAttributes = new MessageAttributes();
      BatchSmsAttributes batchSmsAttributes = new BatchSmsAttributes();
      // 3.1 设置发送短信的签名（SMSSignName）
      batchSmsAttributes.setFreeSignName("黑色科技");
      // 3.2 设置发送短信使用的模板（SMSTempateCode）
      batchSmsAttributes.setTemplateCode("SMS_53070214");
      // 3.3 设置发送短信所使用的模板中参数对应的值（在短信模板中定义的，没有可以不用设置）
      BatchSmsAttributes.SmsReceiverParams smsReceiverParams = new BatchSmsAttributes.SmsReceiverParams();
      smsReceiverParams.setParam("name", "郭有超");
      smsReceiverParams.setParam("code", "879021");
      // 3.4 增加接收短信的号码
      batchSmsAttributes.addSmsReceiver("15010215839", smsReceiverParams);
//      batchSmsAttributes.addSmsReceiver("$YourReceiverPhoneNumber2", smsReceiverParams);
      messageAttributes.setBatchSmsAttributes(batchSmsAttributes);
      try {
          /**
           * Step 4. 发布SMS消息
           */
          TopicMessage ret = topic.publishMessage(msg, messageAttributes);
       
          System.out.println("MessageId: " + ret.getMessageId());
          System.out.println("MessageMD5: " + ret.getMessageBody());
      } catch (ServiceException se) {
          System.out.println(se.getErrorCode() + se.getRequestId());
          System.out.println(se.getMessage());
          se.printStackTrace();
      } catch (Exception e) {
          e.printStackTrace();
      }
      client.close();
  }
 
  

}
