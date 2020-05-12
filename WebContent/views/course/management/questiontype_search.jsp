<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>题卷系统 - 题型列表</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
</head>
<body>

  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-form layui-card-header layuiadmin-card-header-auto">
        <div class="layui-form-item">
          
          <div class="layui-inline" >
            <label class="layui-form-label">题型ID</label>
            <div class="layui-input-inline">
              <input type="text" name="questiontypeId" id="questiontypeId"  onkeyup="value=integer(this.value)" autocomplete="off" class="layui-input">
            </div>
          </div>
          
          <div class="layui-inline">
            <label class="layui-form-label">题型名称</label>
            <div class="layui-input-inline">
              <input type="text" name="questiontypeName" id="questiontypeName" autocomplete="off" class="layui-input">
            </div>
          </div>
          
          <div class="layui-inline">
            <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="search-submit">
              <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
            </button>
          </div>
        </div>
      </div>

      <div class="layui-card-body">
        <div style="padding-bottom: 10px;">
          <button class="layui-btn layui-btn-lg layui-btn-radius layuiadmin-btn-list" data-type="add">添加</button>
          <button class="layui-btn layui-btn-lg layui-btn-radius layuiadmin-btn-list" data-type="batchdel">删除</button>
        </div>
        <table class="layui-hide"lay-filter="questiontype-table" id="questiontype-table"></table>
        
        <script type="text/html" id="table-content-list">
          <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit">编辑</i></a>
        </script>
      </div>
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>  
  <script>

  layui.config({
    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'contlist', 'table'], function(){
    var table = layui.table
    ,form = layui.form;
    
    table.render({
        elem: '#questiontype-table'
        ,url: '${pageContext.request.contextPath}/findquestiontype'
        ,toolbar: true 
        ,method:'post'
        ,cols: [[
        	{type:'checkbox'}
          ,{field:'questiontypeId', width:180, title: '题型ID', sort: true}
          ,{field:'questiontypeName', width:780, title: '题型名称'}
          ,{field:'', width:200, title: '操作',toolbar:"#table-content-list" }
        ]]
        ,page: true	
      });
    
  //监听搜索
    form.on('submit(search-submit)', function(data){
      
      var field = data.field;
     table.reload('questiontype-table', {
			url:'${pageContext.request.contextPath}/queryquestiontypes'
			,where: {
				"questiontypeId":data.field.questiontypeId,
	        	 "questiontypeName":data.field.questiontypeName
			}
			,page: {
				curr: 1 //重新从第 1 页开始
			}
			});
	
	
	});	
    table.on('row(questiontype-table)', function(obj){

    	    //添加当前行样式，然后移除兄弟样式
    	    // obj.tr.addClass('layui-bg-cyan').siblings().removeClass('layui-bg-cyan');
    		obj.tr.attr('style',"background:#dddddd;color:#000").siblings().attr({"style":"background:#fff"});
    	});
	table.on('tool(questiontype-table)', function(obj) {
    	
    	var data = obj.data;
    	//alert(data.courseId);
    	json = JSON.stringify(data);
    	if(data.questiontypeId==1||data.questiontypeId==2||data.questiontypeId==3||data.questiontypeId==4||data.questiontypeId==5)
			  return layer.msg('默认题型禁止编辑！');
    	switch(obj.event) {
		case 'edit':
			if("${user.identity}"==""||parseInt("${user.identity}")==2)
				return layer.msg('您没有权限进行此操作！');
			var index = layer.open({
				type: 2
	            ,title: '编辑题型'
	            ,content: 'questiontype_edit.jsp'
	            ,maxmin: true
	            ,area: ['550px', '550px']
	            ,btn: ['确定', '取消']
				,success: function(layero, index){
					var body = layer.getChildFrame('body', index); // body.html() body里面的内容
					body.find("#questiontypeId").val(data.questiontypeId);
					body.find("#questiontypeName").val(data.questiontypeName);
					if(data.options!=0)
					{
						body.find("#open").attr('checked', 'checked');
						body.find("#answer").css('display', '');
						//body.find("#optionsNumber").val(data.optionsNumber);
						if(data.multiple!=0)
							body.find("#multiple").attr('checked', 'checked');
					}
				}
				,yes: function(index, layero){
					//点击确认触发 iframe 内容中的按钮提交
		              var submit = layero.find('iframe').contents().find("#questiontype-edit-submit");
		              submit.click();
				}
			});
			break;

		}
	});
    
    var $ = layui.$, active = {
    	      batchdel: function(){
    	    	  if("${user.identity}"==""||parseInt("${user.identity}")==2)
    					return layer.msg('您没有权限进行此操作！');
    	        var checkStatus = table.checkStatus('questiontype-table')
    	        ,checkData = checkStatus.data; //得到选中的数据

    	        if(checkData.length === 0){
    	          return layer.msg('请选择数据');
    	        }
    	        
    	        
    	        layer.confirm('确定删除共'+checkData.length+'个题型吗？<br/>题目是该题型这些都将删除!', function(index) {
    	        	
    	          //alert(checkData[0].questiontypeId);
    	          var questiontypeId = [];
    			  for (i = 0; i < checkData.length; i++) {
    				  
    				  if(checkData[i].questiontypeId==1||checkData[i].questiontypeId==2||checkData[i].questiontypeId==3||checkData[i].questiontypeId==4||checkData[i].questiontypeId==5)
    					  return layer.msg('内含默认题型，默认题型禁止删除！');
    				  questiontypeId.push(checkData[i].questiontypeId);
    				}
    	          
    	          $.ajax({
    					url : "${pageContext.request.contextPath}/deletequestiontype",
    					traditional : true,
    					type : "post",
    					dataType : "json",
    					data : {
    						'questiontypeId' : questiontypeId
    					},
    					success : function(callback) {
    						if(callback)
    							layer.msg('删除成功！');
    						else{
    							layer.alert('删除失败！',function(){

    							});
    						}
    						
    						
    						table.reload('questiontype-table');
    					}
    					
    				})
    	          
    	          
    	        });
    	      },
    	      add: function(){
    	    	  if("${user.identity}"==""||parseInt("${user.identity}")==2)
    					return layer.msg('您没有权限进行此操作！');
    	          layer.open({
    	            type: 2
    	            ,title: '添加题型'
    	            ,content: 'questiontype_add.jsp'
    	            ,maxmin: true
    	            ,area: ['550px', '550px']
    	            ,btn: ['确定', '取消']
    	            ,yes: function(index, layero){
    	            	
    	              //点击确认触发 iframe 内容中的按钮提交
    	              var submit = layero.find('iframe').contents().find("#questiontype-add-submit");
    	              
    	              submit.click();
    	            }
    	          }); 
    	        }
    	    }; 
    $('.layui-btn.layuiadmin-btn-list').on('click', function(){
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
      });
  });
 function integer(value){
	  
	  value = value.replace(/[^\d]/g,'');
	  if(''!=value){
	   value = parseInt(value);
	  }
	  return value;
	 }
  </script>
</body>
</html>
