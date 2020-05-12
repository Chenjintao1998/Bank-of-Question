<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>设置我的密码</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
</head>
<body>

  <div class="layui-fluid">
    <div class="layui-row layui-col-space15">
      <div class="layui-col-md12">
        <div class="layui-card">
          <div class="layui-card-header">修改密码</div>
          <div class="layui-card-body" pad15>
            
            <div class="layui-form">
              <div class="layui-form-item">
                <label class="layui-form-label">当前密码</label>
                <div class="layui-input-inline">
                  <input type="password" name="oldPassword" id="oldPassword" lay-verify="required|passw"  class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">新密码</label>
                <div class="layui-input-inline">
                  <input type="password" name="password" id="password" lay-verify="required|passw"  autocomplete="off"  class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">确认新密码</label>
                <div class="layui-input-inline">
                  <input type="password" name="repassword" lay-verify="repassw|required"  autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-input-block">
                  <button class="layui-btn" lay-submit lay-filter="but" >确认修改</button>
                </div>
              </div>
            </div>
            
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>  
  <script>
  layui.config({
    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['form','jquery'],function(){
		 var form = layui.form
		 var $ = layui.jquery;
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
	  	form.on('submit(but)', function(data){
	  		var field = data.field;
		  $.ajax({
				url : "${pageContext.request.contextPath}/updatepassword",
				traditional : true,
				type : "post",
				dataType : "json",
				data :{
					"id":"${user.userId}",
					"oldPassword":$("#oldPassword").val(),
					"password":$("#password").val()
				},
				success : function(callback) {
					if(callback)
					{	
						var popup=parent.layer.alert('修改成功！',{icon: 1},function(){
							parent.layer.close(popup);
							parent.layui.admin.events.closeThisTabs();
						});
						
					}
					else{
						var popup=parent.layer.alert('修改失败！<br/>原始密码不正确',{icon: 2},function(){
							parent.layer.close(popup);
						});
					}
					
				}
				
			})
	  });
  });
  </script>
</body>
</html>