<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>题库管理系统--用户</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
</head>
<body>

  <div class="layui-form" lay-filter="layuiadmin-form-useradmin" id="layuiadmin-form-useradmin" style="padding: 20px 0 0 0;">
  	<div class="layui-form-item">
        <label class="layui-form-label">ID</label>
         <div class="layui-input-inline">
            <input type="text" name="userId" id="userId"  readonly class="layui-input">
         </div>
    </div>  
    <div class="layui-form-item">
                <label class="layui-form-label">身份</label>
                <div class="layui-input-inline">
                  <select name="identity" id="identity" lay-verify="" disabled>
                    <option value="1" >超级管理员</option>
                    <option value="2"  >普通管理员</option>
                    <option value="3" >教师</option>
                  </select> 
                </div>
              </div>                          
    <div class="layui-form-item">
      <label class="layui-form-label">用户名</label>
      <div class="layui-input-inline">
        <input type="text" name="username" id="username" lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input" disabled>
      </div>
    </div>
    <div class="layui-form-item">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-inline">
                  <input type="text" name="name" id="name" lay-verify="required"  class="layui-input">
                </div>
              </div>
    <div class="layui-form-item">
      <label class="layui-form-label">密码</label>
      <div class="layui-input-inline">
        <input type="password" name="password" id="password" lay-verify="required|passw" placeholder="请输入密码" autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">手机号码</label>
      <div class="layui-input-inline">
        <input type="text" name="phone" id="phone" lay-verify="phone|required" placeholder="请输入手机号码" autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-form-item">
    	<label class="layui-form-label">邮箱</label>
           <div class="layui-input-inline">
               <input type="text" name="email" id="email" placeholder="请输入邮箱"  lay-verify="email|required" autocomplete="off" class="layui-input">
           </div>
    </div>                 
    <div class="layui-form-item" lay-filter="sex">
      <label class="layui-form-label">性别</label>
      <div class="layui-input-block">
        <input type="radio" name="sex" value="1" title="男">
        <input type="radio" name="sex" value="0" title="女">
      </div>
    </div>
    <div class="layui-form-item layui-hide">
      <input type="button" lay-submit lay-filter="user-submit" id="user-submit" value="确认">
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>  
  <script>
  layui.config({
    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'form', 'upload'], function(){
    var $ = layui.$
    ,form = layui.form
    ,upload = layui.upload ;
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
    form.on('submit(user-submit)', function(data){
    	var field = data.field; //获取提交的字段
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引  
    	$.ajax({
    		            url:'${pageContext.request.contextPath}/update',
    		            type:'post',
    		            data:data.field,
    		            dataType:"json",
    		            success:function(data){
    						
    						if(data){
    							
    							var popup=parent.layer.alert('修改用户成功！',{closeBtn:0,icon: 1},function(){
    								
    								parent.layui.table.reload('user-table'); //重载表格
    								parent.layer.close(popup);
    								parent.layer.close(index); //再执行关闭 
    								
    							});
    						}
    						else{
    							 
    							var popup=parent.layer.alert('修改用户失败！',{closeBtn:0,icon: 2},function(){
    								
    								parent.layer.close(popup);
    								
    							});
    						}
    						
    							
    					}
    		            
    		        });
    });
  })
  function setidentity(identity){
	  
	  layui.use(['jquery','form'],function(){
		  var $ = layui.jquery;
		  switch (identity) {
		case "教师":
			 $("#identity").find("option[value=3]").prop("selected",true);
			break;
		case "普通管理员":
			 $("#identity").find("option[value=2]").prop("selected",true);
			break;
		case "超级管理员":
			 $("#identity").find("option[value=1]").prop("selected",true);
			break;
		}
	  layui.form.render();
  	});
  }
  </script>
</body>
</html>