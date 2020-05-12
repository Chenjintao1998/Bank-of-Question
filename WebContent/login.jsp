<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>登入 - 题库管理系统</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="layuiadmin/style/admin.css" media="all">
  <link rel="stylesheet" href="layuiadmin/style/login.css" media="all">
  
</head>
<body onload="getCookie()">

  <div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">

    <div class="layadmin-user-login-main">
      <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2>题库管理系统</h2>
      </div>
      <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
        <div class="layui-form-item">
          <label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-username"></label>
          <input type="text" name="username" id="LAY-user-login-username" lay-verify="required" placeholder="用户名" class="layui-input">
        </div>
        <div class="layui-form-item">
          <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"></label>
          <input type="password" name="password" id="LAY-user-login-password" lay-verify="required" placeholder="密码" class="layui-input">
        </div>
        <div class="layui-form-item">
          <div class="layui-row">
            <div class="layui-col-xs7">
              <label class="layadmin-user-login-icon layui-icon layui-icon-vercode" for="LAY-user-login-vercode"></label>
              <input type="text" name="checkcode" id="checkcode" lay-verify="required" placeholder="图形验证码" class="layui-input">
            </div>
            <div class="layui-col-xs5">
              <div style="margin-left: 10px;">
					<img alt="图片飞了" src="kaptcha" title="看不清,换一张" onclick="changeCode()" id="codeimg">
              </div>
            </div>
          </div>
        </div>
        <div class="layui-form-item" style="margin-bottom: 20px;">
          <input type="checkbox" name="remember" id="remember" lay-filter="remember" lay-skin="primary" title="记住密码">
          <!--  <a href="forget.html" class="layadmin-user-jump-change layadmin-link" style="margin-top: 7px;">忘记密码？</a>-->
        </div>
        <div class="layui-form-item">
          <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-login-submit">登 入</button>
        </div>
        
      </div>
    </div>
    
    <div class="layui-trans layadmin-user-login-footer">
      
      <p>© 2020 <a href="http://www.dgut.edu.cn/" target="_blank">东莞理工学院</a></p>
      
    </div>
 
    
  </div>
  <script type="text/javascript" src="${pageContext.request.contextPath}/layuiadmin/modules/jquery.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/layuiadmin/modules/jquery.cookie.js"></script>
  
  <script src="layuiadmin/layui/layui.js"></script>  
  <script>
 
  layui.config({
    base: 'layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'user','jquery'], function(){
    var $ = layui.$
    ,setter = layui.setter
    ,admin = layui.admin
    ,form = layui.form
    ,router = layui.router()
    ,search = router.search;
    form.verify({
		 passw: function(value) {
			    if (value === "") 
			      return "密码不能为空！";
			    var regExpDigital = /\d/; //如果有数字
			    var regExpLetters = /[a-zA-Z]/; //如果有字母
			    if (!(regExpDigital.test(value) && regExpLetters.test(value) && value.length >= 6 && value.length <= 12)) {
			        return '密码必须包含英文和数字<br/>且长度在6位到12位之间！';
			    }
			},
			repassw: function(value) {
			    if (value === "") 
			      return "请确定重复密码！";
			    var pwd = $('input[name=password').val();
			    if (pwd !== value) 
			      return "两次输入的密码不一致！";
			} 
		});
    

    //提交
    form.on('submit(LAY-user-login-submit)', function(data){
    	
    		
    	if(check()==false)
    	{
    		//layer.alert("验证码错误！",{icon: 2});
    		return;
    	}
    	
    	
    	
    	$.ajax({   
    		                url:'${pageContext.request.contextPath}/login',       
    		                method:'post',       
    		                data:data.field,        
    		                dataType:'json',         
    		                success:function(res){
    							if (res=="用户名或密码错误！") {
    								
    								var tc=layer.alert(res,{icon: 2},function(){changeCode();layer.close(tc);});
    							}
    							else{
    								if(data.field["remember"]=="on")
    									Save();
    								else
    								{
    									$.cookie("rmbUser",null);
    									 $.cookie("username", "", { expires: -1 });
    									 $.cookie("password", "", { expires: -1 });
    										      
    								}
    								layer.alert(res,{closeBtn:0,icon: 1},function(){
    									
    									window.location.href="${pageContext.request.contextPath}/views/index.jsp";
    								});
    								
    							}
    							
    						},
    						error:function(result){
    							 alert("error");
    					    }
    		  }) ;
    	
    });
    
  function check(){
		 var checkcode = $("#checkcode").val();
		 $.ajaxSetup({async: false});
		 var json = {
					"checkcode" : checkcode
				};
		 var result=false;
		 $.post("check", json, function(data) {
				if (data == "1") {
					result=true;
				} else {
					result=false;
				}
			});
		 if (result) {} 
		 else {
			 	layer.alert("验证码错误！",{icon: 2});
				changeCode();
			}
		 
		 return result;
	}
  
	  
	  
  });
  function getCookie(){ //获取cookie 
	  if($.cookie("rmbUser")=="true"){
         var username = $.cookie("username"); //获取cookie中的用户名    
         var pwd =  $.cookie("password"); //获取cookie中的登陆密码    
         $("[name='remember']").attr("checked","true");    
            
         if(username!=""){//用户名存在的话把用户名填充到用户名文本框    
            $("#LAY-user-login-username").val(username);    
         }else{
        	 $("#LAY-user-login-username").val("");
         }
         if(pwd!=""){//密码存在的话把密码填充到密码文本框    
        	  $("#LAY-user-login-password").val(pwd); 
         }else{
        	 $("#LAY-user-login-password").val(""); 
         }
	  }
	  
    } 
  function Save() {
	  
	        var str_username = $("#LAY-user-login-username").val();
	        var str_password = $("#LAY-user-login-password").val();
	        $.cookie("rmbUser", "true", { expires: 7 }); //存储一个带7天期限的cookie
	        $.cookie("username", str_username, { expires: 7 });
	        $.cookie("password", str_password, { expires: 7 });
	      
	      
  }   
  function changeCode() {
	  $("#checkcode").val("");
		var time = new Date().getTime();//得到当前时间
		document.getElementById("codeimg").src = "kaptcha?time=" + time;

	}
  
  </script>
</body>
</html>