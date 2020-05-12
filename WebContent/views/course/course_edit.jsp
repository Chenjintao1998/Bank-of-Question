<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>题卷系统-科目修改</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
</head>
<body>

  <div class="layui-form" lay-filter="course" id="course" style="padding: 20px 30px 0 0;">
  	<div class="layui-form-item">
      <label class="layui-form-label">科目ID</label>
      <div class="layui-input-inline">
        <input type="text" name="courseId" id="courseId" lay-verify="required" autocomplete="off" class="layui-input" disabled>
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">创建时间</label>
      <div class="layui-input-inline">
        <input type="text" name="createDate" id="createDate" lay-verify="required" autocomplete="off" class="layui-input" disabled>
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">科目名称</label>
      <div class="layui-input-inline">
        <input type="text" name="courseName" id="courseName" lay-verify="required" autocomplete="off" class="layui-input">
      </div>
    </div>
    
    <div class="layui-form-item">
      <label class="layui-form-label">科目介绍</label>
      <div class="layui-input-inline">
        <textarea name="information" id="information" lay-verify="required" style="width: 400px; height: 150px;" autocomplete="off" class="layui-textarea"></textarea>
      </div>
    </div>
    <div class="layui-form-item layui-hide">
      <input type="button" lay-submit lay-filter="course-edit-submit" id="course-edit-submit" value="确认">
    </div>
  </div>
  <script type="text/javascript" src="${pageContext.request.contextPath}/layuiadmin/modules/jquery.min.js"></script>
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
    form.on('submit(course-edit-submit)', function(data){
    	
      var field = data.field; //获取提交的字段
      console.log(field);
      var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引  
      var createDate=Date.parse(new Date(data.field.createDate));
      //提交 Ajax 成功后，关闭当前弹层并重载表格
      $.ajax({
            url:'${pageContext.request.contextPath}/updatecourse',
            type:'post',
            data:data.field,
            dataType:"json",
            success:function(data){
				
				if(data){
					
					var popup=parent.layer.alert('修改科目成功！',{closeBtn:0,icon: 1},function(){
						
						parent.layui.table.reload('course-table'); //重载表格
						parent.layer.close(popup);
						parent.layer.close(index); //再执行关闭 
						
					});
				}
				else{
					 
					var popup=parent.layer.alert('修改科目失败！<br/>科目或许已存在',{closeBtn:0,icon: 2},function(){
						
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