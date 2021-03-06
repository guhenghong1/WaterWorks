<%-- 
    Document   : index
    Created on : May 28, 2014, 10:05:39 AM
    Author     : xiangfei
--%>

<%@page import="java.util.Calendar" %>
<%@page import="java.util.Date" %>
<%@page import="com.water.works.common.util.DateUtil" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Map" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   int nowHour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
   Date now = new Date();
   String greetings;
   if (nowHour >= 6 && nowHour < 8) {
      greetings = "早上好，";
   } else if (nowHour >= 8 && nowHour < 12) {
      greetings = "上午好，";
   } else if (nowHour >= 11 && nowHour < 14) {
      greetings = "中午好，";
   } else if (nowHour >= 14 && nowHour < 19) {
      greetings = "下午好，";
   } else if (nowHour >= 19 && nowHour < 24) {
      greetings = "晚上好，";
   } else {
      greetings = "凌晨好，";
   }

   pageContext.setAttribute("greetings", greetings);
%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>远程抄表云服务平台</title>
      <link rel="stylesheet" type="text/css" href="../css/qz.css">
      <link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.2/themes/default/easyui.css">
      <link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.2/themes/icon.css">
      <script type="text/javascript" src="../jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
      <script type="text/javascript" src="../jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script>
      <script type="text/javascript" src="../jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
      <script type="text/javascript" src="../js/main.js"></script>
      <style type="text/css">
      .easyui-panel{
          background-color: #E0ECFF;
   		  border: 1px solid transparent
      }
      </style>
   </head>
   <body style="margin:0;overflow-y: auto;">
      <input id="hidden-domain" type="hidden" value="${domain}"/>
      <input id="hidden-uploader-url" type="hidden" value="http://upload${domain}/imgUtil/uploadFile.php"/>
      <input id="hidden-agentId" type="hidden" value="${agentId}"/>
      <input id="hidden-gid" type="hidden" value="${gid}"/>
      <input id="hidden-enddate" type="hidden" value=""/>
      <div class="easyui-layout" fit="true">
         <div region="north" border="none" class="qz-top" style="z-index: 9999">
              <div style="float:left; margin-top: 10px">远程抄表云服务平台</div>
            <div id="exit">
               <a href="javascript:;">退出</a>
            </div>
            <div id="qz_menu">
               <li class="qz_menu_li">
                  <a href="javascript:;" class="qz_set">系统设置</a>
                  <!--菜单列表-->
                  <div id="setMenu" class ="setMenu" style="display:none;">
                     <a href="personalSetting.jsp?gid=${gid}" target="_blank" id="qz_detail" >个人资料</a>
                     <a href="modifyPsw.jsp" id="qz_safe">修改密码</a>
                  </div>
               </li>
            </div>

            <a style="float:right; margin:10px 20px 0 0"><span id="time"></span></a>
         </div>
         <div class="qz-left" region="west" title="管理列表">
	         <div id="menu" class="easyui-accordion" data-options="fit:true,border:false">
	                <div title="设备导航" style="padding:10px;">
	                    <ul id="device" class="easyui-tree" data-options="url:'',method:'get',animate:true,dnd:true"></ul>
	                </div>
	                <div title="系统管理" style="padding:10px;">
	                 	<div><a href="#" class="easyui-linkbutton"  onclick="openTab('用户管理')" style="width:100px" data-options="plain:true">用户管理</a></div>
	                 	<div><a href="#" class="easyui-linkbutton"  onclick="openTab('区域管理')" style="width:100px" data-options="plain:true">区域管理</a></div>
	                 	<div><a href="#" class="easyui-linkbutton"  onclick="openTab('仪表分组')" style="width:100px" data-options="plain:true">仪表分组</a></div>
	                </div>
	                <div title="资产管理" data-options="selected:true" style="padding:10px;">
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('DTU新建')" style="width:100px" data-options="plain:true">DTU新建</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('DTU定位')" style="width:100px" data-options="plain:true">DTU定位</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('DTU')" style="width:100px" data-options="plain:true">DTU</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('仪表监控')" style="width:100px" data-options="plain:true">仪表监控</a></div>
	                </div>
	                <div title="报警管理" style="padding:10px">
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('报警')" style="width:100px" data-options="plain:true">报警</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('报警历史')" style="width:100px" data-options="plain:true">报警历史</a></div>
	                </div>
	                <div title="报表管理" style="padding:10px">
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('流量统计报表')" style="width:100px" data-options="plain:true">流量统计报表</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('故障分析报表')" style="width:100px" data-options="plain:true">故障分析报表</a></div>
	                </div>
	                <div title="参数配置" style="padding:10px">
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('系统参数')" style="width:100px" data-options="plain:true">系统参数</a></div>
	                </div>
	                <div title="日志管理" style="padding:10px">
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('登入日志')" style="width:100px" data-options="plain:true">登入日志</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('运行日志')" style="width:100px" data-options="plain:true">运行日志</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('操作日志')" style="width:100px" data-options="plain:true">操作日志</a></div>
	                </div>
            </div>
         </div>
         <div id="w_tabs" region="center" class="easyui-tabs"  fit="true">
         </div>
      </div>
      <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
      <!--区长安全设置dialog-->
      <div id="qz_psw_dialog" style="height: 300px;width: 700px;"></div>
   </body>
   <script>
   startTime();  
   function startTime() {  
           var today = new Date();  
           var y = today.getFullYear();  
           var M = today.getMonth()+1;  
           var d = today.getDate();  
           var w = today.getDay();  
           var h = today.getHours();  
           var m = today.getMinutes();  
           var s = today.getSeconds();  
           var week=['星期天','星期一','星期二','星期三','星期四','星期五','星期六'];  
           // add a zero in front of numbers<10  
           m = checkTime(m);  
           s = checkTime(s);
           var time = y+'年'+M+'月'+d+'日 '+h+':'+m+':'+s+' '+week[w];
           $('#time').html(time);//可改变格式  
           t = setTimeout(startTime, 500);  
           function checkTime(i) {  
               if (i < 10) {  
                   i = "0" + i;  
               }  
               return i;  
           }  
       }  
   </script>
</html>
