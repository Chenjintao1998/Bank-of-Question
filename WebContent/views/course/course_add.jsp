<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>题库管理系统-科目添加</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
</head>
<body>

  <div class="layui-form" lay-filter="course" id="course" style="padding: 20px 30px 0 0;">
    <div class="layui-form-item">
      <label class="layui-form-label">科目名称</label>
      <div class="layui-input-inline">
        <input type="text" name="courseName" lay-verify="required" placeholder="请输入科目名称" autocomplete="off" class="layui-input">
      </div>
    </div>
   
    <div class="layui-form-item">
      <label class="layui-form-label">科目介绍</label>
      <div class="layui-input-inline">
        <textarea name="information" lay-verify="required" placeholder="请介绍下科目" style="width: 400px; height: 150px;" autocomplete="off" class="layui-textarea"></textarea>
      </div>
    </div>
    <div class="layui-form-item layui-hide">
      <input type="button" lay-submit lay-filter="course-add-submit" id="course-add-submit" value="确认添加">
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>  
  <script>
  
  layui.config({
    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'form'], function(){
    var $ = layui.$
    ,form = layui.form;
    
    //监听提交
    form.on('submit(course-add-submit)', function(data){
      var field = data.field; //获取提交的字段
      var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引  
      //提交 Ajax 成功后，关闭当前弹层并重载表格
      $.ajax({
            url:'${pageContext.request.contextPath}/addcourse',
            type:'post',
            data:data.field,
            dataType:"json",
            success:function(data){
				
				if(data){
					
					var popup=parent.layer.alert('添加科目成功！',{closeBtn:0,icon: 1},function(){
						
						parent.layui.table.reload('course-table'); //重载表格
						parent.layer.close(popup);
						parent.layer.close(index); //再执行关闭 
						
					});
				}
				else{
					 
					var popup=parent.layer.alert('添加科目失败！<br/>科目或许已存在',{closeBtn:0,icon: 2},function(){
						parent.layer.close(popup);
						
					});
				}
				
					
			}
            
        });
      
    });
  })
  </script>
</body>
</html>