<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>网站用户</title>
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
        
        
          <div class="layui-inline">
            <label class="layui-form-label">ID</label>
            <div class="layui-input-block">
              <input type="text" name="userId"  autocomplete="off" class="layui-input">
            </div>
          </div>
          
          <div class="layui-inline">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
              <input type="text" name="name"  autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-block">
              <input type="text" name="email"  autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">手机</label>
            <div class="layui-input-block">
              <input type="text" name="phone"  autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-inline">
                <label class="layui-form-label">身份</label>
                <div class="layui-input-inline">
                  <select name="identity" id="identity" lay-verify="">
                  	<option value=""></option>
                    <option value="1" >超级管理员</option>
                    <option value="2" >普通管理员</option>
                    <option value="3" >教师</option>
                  </select> 
                </div>
              </div>
          <div class="layui-inline">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
              <select name="sex">
                <option value=""></option>
                <option value="1">男</option>
                <option value="0">女</option>
              </select>
            </div>
          </div>
          <div class="layui-inline">
            <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-user-front-search">
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
        
        <table id="user-table" lay-filter="user-table"></table>
        <script type="text/html" id="table-content-list">
          <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
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
  }).use(['index', 'useradmin', 'table'], function(){
    var $ = layui.$
    ,form = layui.form
    ,table = layui.table;
    
    //监听搜索
    form.on('submit(LAY-user-front-search)', function(data){
      var field = data.field;
      
      //执行重载
      table.reload('user-table', {
			url:'${pageContext.request.contextPath}/queryusers'
			,traditional: true
			,where: field
			,page: {
				curr: 1 //重新从第 1 页开始
			}
		});
    });
    table.on('row(user-table)', function(obj){

    	    //添加当前行样式，然后移除兄弟样式
    	    // obj.tr.addClass('layui-bg-cyan').siblings().removeClass('layui-bg-cyan');
    		obj.tr.attr('style',"background:#dddddd;color:#000").siblings().attr({"style":"background:#fff"});
    	});
    table.render({
	 	id:'user-table'
        ,elem: '#user-table'
        ,url: '${pageContext.request.contextPath}/findusers'
        ,toolbar: true 
        ,method:'post'
        ,cols: [[
           {type:'checkbox'}
          ,{field:'userId', width:100, title: '用户ID', sort: true}
          ,{field:'name', width:100, title: '姓名'}
          ,{field:'sex', width:100, title: '性别'}
          ,{field:'email', width:200, title: '邮箱'}
          ,{field:'phone', width:200, title: '手机'}
          ,{field:'identity', width:160, title: '身份', sort: true}
          ,{field:'', width:100, title: '操作',toolbar:"#table-content-list" }
        ]]
        ,parseData: function (res) {
        	res.data.forEach(function(val){  
        		
        		if(val.sex==1)
        			val.sex="男";
        		else
        			val.sex="女";
        		if(val.identity==1)
        			val.identity="超级管理员";
        		if(val.identity==2)
        			val.identity="普通管理员";
        		if(val.identity==3)
        			val.identity="教师";
        	});
        }
        ,page: true	
      });
    //事件
    var active = {
      batchdel: function(){
    	  if("${user.identity}"==""||parseInt("${user.identity}")==3)
				return layer.msg('您没有权限进行此操作！');	
        var checkStatus = table.checkStatus('user-table')
        ,checkData = checkStatus.data; //得到选中的数据

        if(checkData.length === 0){
          return layer.msg('请选择数据');
        }
        
        
        layer.confirm('确定删除共'+checkData.length+'个用户吗？', function(index) {
        	
            //alert(checkData[0].courseName);
            var userId = [];
  		  for (i = 0; i < checkData.length; i++) {
  			  userId.push(checkData[i].userId);
  			}
            
            $.ajax({
  				url : "${pageContext.request.contextPath}/deleteuser",
  				traditional : true,
  				type : "post",
  				dataType : "json",
  				data : {
  					'userId' : userId
  				},
  				success : function(callback) {
  					if(callback)
  						layer.msg('删除成功！');
  					else{
  						layer.alert('删除失败！',function(){

  						});
  					}
  					
  					
  						table.reload('user-table');
  					}
            	});
  				
        	});
	      }
	    
      ,add: function(){
    	  if("${user.identity}"==""||parseInt("${user.identity}")==3)
				return layer.msg('您没有权限进行此操作！');	
        layer.open({
          type: 2
          ,title: '添加用户'
          ,content: 'adduser.jsp'
          ,maxmin: true
          ,area: ['500px', '550px']
          ,btn: ['确定', '取消']
          ,yes: function(index, layero){
        	  var submit = layero.find('iframe').contents().find("#user-submit");
              submit.click();
          }
        }); 
      }	
    };
	table.on('tool(user-table)', function(obj) {
    	
    	var data = obj.data;
    	//alert(data.courseId);
    	json = JSON.stringify(data);
    	//obj.tr.find(':checkbox[name="layTableCheckbox"]:not(:checked)+').click();
    	switch(obj.event) {
		case 'edit':
			if("${user.identity}"==""||parseInt("${user.identity}")==3)
				return layer.msg('您没有权限进行此操作！');	
			if(data.identity=="超级管理员")
				return layer.msg('不可编辑超级管理员！');	
			if(data.identity=="普通管理员"&&parseInt("${user.identity}")==2)
				return layer.msg('您没有权限编辑普通管理员！');	
			var index = layer.open({
				type: 2
	            ,title: '修改人员信息'
	            ,content: 'userform.jsp'
	            ,maxmin: true
	            ,area: ['550px', '550px']
	            ,btn: ['确定', '取消']
				,success: function(layero, index){
					var body = layer.getChildFrame('body', index); // body.html() body里面的内容
					var iframe= window[layero.find('iframe')[0]['name']];
					body.find("#userId").val(data.userId);
					body.find("#username").val(data.username);
					body.find("#name").val(data.name);
					body.find("#password").val(data.password);
					body.find("#phone").val(data.phone);
					body.find("#email").val(data.email);
					body.find("input[name=sex][value=0]").attr("checked",data.sex == "女" ? true : false);
					body.find("input[name=sex][value=1]").attr("checked",data.sex == "男" ? true : false);
					
					iframe.setidentity(data.identity);
				}
				,yes: function(index, layero){
					//点击确认触发 iframe 内容中的按钮提交
		              var submit = layero.find('iframe').contents().find("#user-submit");
		              submit.click();
				}
			});
			break;
		
		}
	});
    $('.layui-btn.layuiadmin-btn-list').on('click', function(){
        var type = $(this).data('type');
       
        active[type] ? active[type].call(this) : '';
      });
  });
  </script>
</body>
</html>
