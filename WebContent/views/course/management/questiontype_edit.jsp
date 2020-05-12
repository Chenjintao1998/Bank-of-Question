<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>题卷系统-题型修改</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
</head>
<body>

  <div class="layui-form" lay-filter="questiontype" id="questiontype" style="padding: 20px 30px 0 0;">
  	<div class="layui-form-item">
      <label class="layui-form-label">题型ID</label>
      <div class="layui-input-inline">
        <input type="text" name="questiontypeId" id="questiontypeId" lay-verify="required" autocomplete="off" class="layui-input" disabled>
      </div>
    </div>
    
    <div class="layui-form-item">
      <label class="layui-form-label">题型名称</label>
      <div class="layui-input-inline">
        <input type="text" name="questiontypeName" id="questiontypeName" lay-verify="required" autocomplete="off" class="layui-input">
      </div>
    </div>
    
    <div class="layui-form-item">
      <label class="layui-form-label">选项开关</label>
      <div class="layui-input-inline">
        <input type="checkbox" id="open" name="open" class="layui-input-inline" lay-skin="switch" lay-filter="switchTest-project" lay-text="开启|关闭" disabled>
      </div>
    </div>
    
 <!-- <div class="layui-form-item" style="display:none;" id="options">
      <label class="layui-form-label">选项数量</label>
      <div class="layui-input-inline">
        <input   type="text" name="optionsNumber" id="optionsNumber" placeholder="请输入2-10" onkeyup="value=integer(this.value)"  autocomplete="off" class="layui-input" >
      </div>
    </div>
 -->   
    <div class="layui-form-item" style="display:none;" id="answer">
      <label class="layui-form-label">多选</label>
      <div class="layui-input-inline">
        <input type="checkbox" id="multiple" name="multiple" class="layui-input-inline" lay-skin="switch" lay-filter="switchTest"   lay-text="开启|关闭" disabled>      
      </div>
    </div>
    
    <div class="layui-form-item layui-hide">
      <input type="button" lay-submit lay-filter="questiontype-edit-submit" id="questiontype-edit-submit" value="确认">
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>  
  <script>
  var multiple=0,options=0;//optionsNumber=0;
  layui.config({
    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'form'], function(){
    var $ = layui.$
    ,form = layui.form;
    
    form.on('switch(switchTest-project)', function (data) {
   	 
        if(this.checked)
        {
        	//document.getElementById("options").style.display="";
        	document.getElementById("answer").style.display="";
        	//$("#optionsNumber").attr("lay-verify","required");
        }
        else
        {
        	//document.getElementById("options").style.display="none";
        	document.getElementById("answer").style.display="none";
        	//$("#optionsNumber").removeAttr("lay-verify");
        }

    });

    
    //监听提交
    form.on('submit(questiontype-edit-submit)', function(data){
    	
      var field = data.field; //获取提交的字段
      var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引  
      if(field.open=="on")
      {
    	  	options=1;
    	  	//optionsNumber=field.optionsNumber;
    	  	if(field.multiple=="on")
    	 		multiple=1;
      }
      //提交 Ajax 成功后，关闭当前弹层并重载表格
      $.ajax({
            url:'${pageContext.request.contextPath}/updatequestiontype',
            type:'post',
            data:{
				"questiontypeId":field.questiontypeId,
				"questiontypeName":field.questiontypeName,
				"options":options,
				//"optionsNumber":optionsNumber,
				"multiple":multiple,
			},
            dataType:"json",
            success:function(data){
				
				if(data){
					
					var popup=parent.layer.alert('修改题型成功！',{closeBtn:0,icon: 1},function(){
						
						parent.layui.table.reload('questiontype-table'); //重载表格
						parent.layer.close(popup);
						parent.layer.close(index); //再执行关闭 
						
					});
				}
				else{
					 
					var popup=parent.layer.alert('修改题型失败！<br/>题型或许已存在',{closeBtn:0,icon: 2},function(){
						parent.layer.close(popup);
					});
				}
				
					
			}
            
        });
      
    });
  })
//   function integer(value){
	  
//      var patrn = /^([2-9]||10)$/ig;
//	  if(!patrn.test(value)||value==""){
//	   	 value="";
//	  }
//	  else
//	  	value = parseInt(value);
//	  return value;
//	 }
  </script>
</body>
</html>