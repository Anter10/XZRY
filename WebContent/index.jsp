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
<title>数据首页</title>
<style type="text/css">
a{ color:blue;
   text-decoration:none;
 }
a:visited{
  color:blue;
}
a:hover{
  color:blue;
}
</style>

<body>

  <% 
   Object myy = session.getAttribute("ambuguser");
   if(myy != null ){
%>  
     
<%!String myid = "";
   String myname = "";
%>

 <%
/*    System.out.print("myy "+myy); */
    myid = session.getAttribute("ambuguser").toString();
    String selectSql = "select * from AMUsers where id ='"+myid+"'";
	String objj = DealDatabase.getQuerryJsonStringData(selectSql);
	if(objj != null){
	   /*  System.out.print("obj = "+objj); */
		JSONObject obj2 = new JSONObject(objj);
		
		JSONArray obj1 = obj2.getJSONArray("ps");
		JSONObject jjb = obj1.getJSONObject(0);
		myname =  jjb.getString("name");
	}
 %>
 <a href="changedatas.jsp?tb=work">这周情况</a>
 当前账号:
<%=myid %>
 员工:

<%=myname %>  

<%
  session.setAttribute("username",myname);
%>
<a href="Login.jsp?type=1">退出账号</a>  
<hr color = "red">
<table border = "1">
<caption>前端游戏数据</caption>
    <%!
       String red = "red";
       String green = "green";
    %>


   <tr>
      <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemBattleUnitData" ><font color=<%="red" %>>1:英雄</font></a></td>
	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=HeroStatues" ><font color="red">2:英雄状态——音效</font></a></td>
	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=HeroStatueConvert" ><font color="red">3:英雄状态转换</font></a></td>
      <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=RoleSpecialData" ><font color="red">4:英雄随身动作</font></a></td>
	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemSkillData" ><font color="red">5:英雄技能——音效</font></a></td>
	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemSonSkillData" ><font color="red">6:英雄子技能——音效</font></a></td>
	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemBuffData" ><font color="red">7:英雄buff——音效</font></a></td>
      <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemHeroRandomActions"><font color="red"> 8:英雄系统随机动作</font></a></td>
	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=RoleSuitData" ><font color="red">9:英雄套装</font></a></td>
	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=AllHerosData" ><font color="red">10:战斗元素的ID</font></a></td>
  </tr>
  
  <tr>
      <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemSpecialSkillData" ><font color="red">11:英雄特殊技能数据——音效</font></a></td>
      <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=LinkActionData" ><font color="red">12:英雄技能动作关联数据——被击音效</font></a></td>
      <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemHeroPromotionData" ><font color="red">13:英雄晋级数据表</font></a></td>
      <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=AllSpecialData" ><font color="#f000ff">14:特效数据</font></a></td>
      <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=BattleRoleSpecialGrowup" ><font color="#f000ff">15:特效组合</font></a></td> 
      <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SoltNameData" ><font color="#f000ff">16:特效挂点数据</font></a></td>
	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemShopTypeData" >17:商店类型数据</a></td> 
  	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=BattleSceneParamData" >18:战斗场景数据</a></td>
      <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=DialogViewData" >19:对话框数据</a></td>
      <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemBuyDiamondData" >20:充值数据</a></td>
  </tr>
  
  <tr>
    <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=equipitemdata" >31:装备道具数据</a></td>
    <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemChatTypeData" >32:聊天类型数据</a></td>
  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemEmailTypeData" >33:邮件类型数据</a></td>

  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemPropTypeData" >34:消费类型数据</a></td>
  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemGameViewsData" >35:游戏视图数据——音效</a></td>
  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemGameData" >36:游戏数据</a></td>
  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemChapterData" ><font color=<%="green" %>>37:章节数据</font></a></td>
  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemLevelData" >38:关卡数据</a></td>
  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=ActionConditionData" >39:动作随机条件</a></td>
  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=GameEffectData" >40:游戏效果描述</a></td>
  

  </tr>
 
  <tr>

	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemEquipData" >41:装备数据</a></td>
	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=LoadingLayerData" >42:加载界面UI数据</a></td>
	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=PVEAreaData" >43:区域底图数据</a></td>
    <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemTimeInfo" >44:涉及到的时间数据</a></td>
  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=GameTimes" >45:游戏中涉及到常量数据</a></td>
  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=OKSkills" >47:数据调通的技能</a></td>

	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemIntensifyData" >48:装备强化数据</a></td>
	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=RolesAllDialogData" >49:游戏中的角色对话数据</a></td>
	  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=AllDialogData" >50:所有单条对话数据</a></td>
  </tr>
  <tr> 
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=AllLanguageData" >51:所有发布的语言</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemAwardTypeData" >52:所有奖励类型</a></td>
  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=ProperityEffectData" >53:效果库</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemSkillUpLevelData" >54:技能升级数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=PropCombineData" >55:物品合成数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=ChatSystemData" >56:系统聊天/公告类型数据</a>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemMapChapterData" ><font color=<%="green" %>>57:游戏副本地图数据</font></a>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemChessData" ><font color=<%="green" %>>58:棋子数据</font></a>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemDevelopmentData" >59:相关的成长数据</a>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=AllUpLevelData"> 60:英雄等级升级数据</a></td>
  </tr>
  <tr>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemStrangeData" >61:势力数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemMapChapterTask"><font color=<%="green" %>> 62:副本任务数据</font></a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemShowWorldData"> 63:游戏中的显示文本</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemTavernData"> 64:酒馆抽奖数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=Systemdataarmor"> 65:护甲不同等级数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=Systemdatahelmet"> 66:头盔不同等级数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=Systemdatanecklace"> 67:项链不同等级数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=Systemdataring"> 68:戒指不同等级数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=Systemdatashoes"> 69:鞋不同等级数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=Systemdataweapon"> 70:武器不同等级数据</a></td>
  </tr>
  <tr> 
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=MainCityResData"> 71:主城建筑的资源数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=MainCityBuilds"> 72:主城建筑数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemBuildLevelData"> 73:建筑等级数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemColor">74:颜色数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemFontData"> 75:字体数据数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemTextFontData"> 76:具体使用的字体数据</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemFontUseData"> 77:文本显示说明</a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemIconBottom"> <font color="black">78:头像底板数据</font></a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemIconData"><font color="black"> 79:头像数据</font></a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemIconFramData"><font color="black"> 80:头像相框数据</font></a></td>
  </tr>
  
  <tr>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemGameMusic"><font color="000e0fe">81:音乐 数据</font></a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemUIAudoEffect" ><font color="000e0fe">82:UI音效数据</font></a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemRolesAudioEffect" ><font color="000e0fe">83:角色音效数据</font></a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemSkillAudioEffect" ><font color="000e0fe">84:技能音效数据</font></a></td>
    <!--  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemOnlyUiTextData" ><font color="000ff##">85:纯UI显示数据</font></a></td> -->
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=BattleBackgroundMapData" ><font color="000ff##">85:战斗背景数据</font></a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=UINpcData" ><font color="000e0fe">86:UI类型的NPC数据</font></a></td>
     <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemTerritoryMapTreasureData" ><font color="000e0fe">87:副本地图上的物品数据</font></a></td>
   <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=PlayerNameData" ><font color="000e0fe">88:玩家名称数据</font></a></td>
   <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=systemdandata" ><font color="000e0fe">89:玩家排位数据</font></a></td>
   <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=BattlePVEAreanPosData" ><font color="000e0fe">90:PVE阵型数据</font></a></td>
 </tr>
   <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=systemmonsterdata" ><font color="red">91:怪物数据</font></a></td>
   <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=systembattlenpcdata" ><font color="red">92:器械数据</font></a></td>
   <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemRewardTaskData" ><font color="red">93:悬赏任务数据</font></a></td>
  <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SystemRewardPackageData" ><font color="red">94:奖励礼包数据</font></a></td>
 <td width = "120" height = "60"><a href  = "ShowData.jsp?tablename=SkillInfoShowWordData" ><font color="red">95:技能描述文本</font></a></td>
 


</table>
  <% 
 }else{
       /* DealDatabase.connectPG();   */
  	   response.sendRedirect("Login.jsp");  
  }  
%>  

  <%  
/*  DealDatabase.connectPG(); */
  /* Param.SendEmail("15010215839@163.com", "21212","2121212",response.getWriter()); */
%>  
</body>
</html>