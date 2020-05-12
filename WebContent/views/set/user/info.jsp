<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>设置我的资料</title>
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
          <div class="layui-card-header">设置我的资料</div>
          <div class="layui-card-body" pad15>
          
          
          <div class="layui-form-item">
                <label class="layui-form-label">ID</label>
                <div class="layui-input-inline">
                  <input type="text" name="userId" id="userId" value='${user.userId }' readonly class="layui-input">
                </div>
              </div>
            
            <div class="layui-form" lay-filter="">
              <div class="layui-form-item">
                <label class="layui-form-label">我的角色</label>
                <div class="layui-input-inline">
                  <select name="identity" lay-verify="" disabled>
                    <option value="1" ${user.identity == 1?"selected":"disabled"}>超级管理员</option>
                    <option value="2" ${user.identity == 2?"selected":"disabled"}>普通管理员</option>
                    <option value="3" ${user.identity == 3?"selected":"disabled"}>教师</option>
                  </select> 
                </div>
              </div>
              
              <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-inline">
                  <input type="text" name="username" id="username" value='${user.username }' readonly class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">不可修改。一般用于后台登入名</div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-inline">
                  <input type="text" name="name" id="name" value='${user.name }' class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                  <input type="radio" name="sex" value="1" title="男" ${user.sex eq 1?"checked=\"checked\"":""}>
                  <input type="radio" name="sex" value="0" title="女" ${user.sex eq 0?"checked=\"checked\"":""}>
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">手机</label>
                <div class="layui-input-inline">
                  <input type="text" name="phone" id="phone" value='${user.phone }' lay-verify="phone" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">邮箱</label>
                <div class="layui-input-inline">
                  <input type="text" name="email" id="email" value="${user.email }" lay-verify="email" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-input-block">
                  <button class="layui-btn" lay-submit lay-filter="buton">保存</button>
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
  }).use([ 'jquery','form'], function(){
	  var form = layui.form
		 var $ = layui.jquery;
	  form.on('submit(buton)', function(data){
		  $.ajax({
	    		            url:'${pageContext.request.contextPath}/myupdate',
	    		            type:'post',
	    		            data:{
	    						"userId":$("#userId").val(),
	    						"username":$("#username").val(),
	    						"password":"${user.password}",
	    						"name":$("#name").val(),
	    						"sex":$("input[name='sex']:checked").val(),
	    						"email":$("#email").val(),
	    						"phone":$("#phone").val(),
	    						"identity":$("select[name=identity").val(),
	    					},
	    		            dataType:"json",
	    		            success:function(data){
	    			
	    						if(data){
	    							
	    							var popup=parent.layer.alert('修改信息成功！',{closeBtn:0,icon: 1},function(){
	    								window.parent.location.reload();
	    								parent.layer.close(popup);
	    								
	    							});
	    						}
	    						else{
	    							 
	    							var popup=parent.layer.alert('修改信息失败！',{closeBtn:0,icon: 2},function(){
	    								parent.layer.close(popup);
	    							});
	    						}
	    						
	    							
	    					}
	    		            
	    		        });
	  });
  });
  </script>
</body>
</html>