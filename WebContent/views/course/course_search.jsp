<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>题卷系统 - 科目列表</title>
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
            <label class="layui-form-label">科目ID</label>
            <div class="layui-input-inline">
              <input type="text" name="courseId" id="courseId"  onkeyup="value=integer(this.value)" autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">科目名称</label>
            <div class="layui-input-inline">
              <input type="text" name="courseName" id="courseName" autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">科目介绍</label>
            <div class="layui-input-inline">
              <input type="text" name="information" id="information"  autocomplete="off" class="layui-input" >
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">创建时间</label>
            <div class="layui-input-inline">
            <input type="text" class="layui-input"name="createDate" id="createDate" placeholder=" - "autocomplete="off">
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
        <table class="layui-hide"lay-filter="course-table" id="course-table"></table>
        
        <script type="text/html" id="table-content-list">
          <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit">编辑</i></a>
		  <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="select"><i class="layui-icon layui-icon-search">查看</i></a>
        </script>
      </div>
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>  
  <script>

  var start_time,end_time;
  layui.config({
    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'contlist', 'table','form'], function(){
    var table = layui.table
    ,form = layui.form;
    
    //监听搜索
    form.on('submit(search-submit)', function(data){
      
      var field = data.field;
     
     time=$("[name='createDate']").val().split(" - ");
     start_time=time[0];
     end_time=time[1];
     //alert(start_time);
     table.reload('course-table', {
			url:'${pageContext.request.contextPath}/querycourses'
			,where: {
				"courseId":data.field.courseId,
	        	 "courseName":data.field.courseName,
	        	 "information":data.field.information,
	        	 "start_time":start_time,
	        	 "end_time":end_time
			}
			,page: {
				curr: 1 //重新从第 1 页开始
			}
			});
	
	
	});		
      
    table.on('row(course-table)', function(obj){

    	    //添加当前行样式，然后移除兄弟样式
    	    // obj.tr.addClass('layui-bg-cyan').siblings().removeClass('layui-bg-cyan');
    		obj.tr.attr('style',"background:#dddddd;color:#000").siblings().attr({"style":"background:#fff"});
    	});
	table.on('tool(course-table)', function(obj) {
    	
    	var data = obj.data;
    	//alert(data.courseId);
    	json = JSON.stringify(data);
    	//obj.tr.find(':checkbox[name="layTableCheckbox"]:not(:checked)+').click();
    	switch(obj.event) {
		case 'edit':
			if("${user.identity}"==""||parseInt("${user.identity}")==2)
				return layer.msg('您没有权限进行此操作！');	
			var index = layer.open({
				type: 2
	            ,title: '编辑科目'
	            ,content: 'course_edit.jsp'
	            ,maxmin: true
	            ,area: ['550px', '550px']
	            ,btn: ['确定', '取消']
				,success: function(layero, index){
					var body = layer.getChildFrame('body', index); // body.html() body里面的内容
					body.find("#courseId").val(data.courseId);
					body.find("#courseName").val(data.courseName);
					body.find("#information").val(data.information);
					body.find("#createDate").val(layui.util.toDateString(data.createDate, 'yyyy-MM-dd HH:mm:ss'));
				}
				,yes: function(index, layero){
					//点击确认触发 iframe 内容中的按钮提交
		              var submit = layero.find('iframe').contents().find("#course-edit-submit");
		              submit.click();
				}
			});
			break;
		case 'select':
			var index = layer.open({
				type: 2
	            ,title: '查看题目'
	            ,content: 'management/question_search.jsp'
	            ,maxmin: true
	            ,area: ['1000px', '600px']
				,success: function(layero, index){
					
					var body = layer.getChildFrame('body', index); // body.html() body里面的内容
					
		            var submit = layero.find('iframe').contents().find("#search-submit");
		            //layui.form.render();
		            body.find("#select-form").css({
		               "display": "none"
		            });
		            //layero.find('iframe')[0].contentWindow.reloadTable(data.courseId);
		            setTimeout(function (){
		            	eachSelect("courseId",data.courseId,body);
		           	 submit.click();
		            }, 40);
		            
				}
			});
			break;
		}
	});
      
	function eachSelect(id, val,body) {
		var selVal="";
		body.find("#" + id).attr("value", val);
		body.find("#" + id).children("option").each(function() {
			if ($(this).val() == val) {
				selVal=$(this).text();
				$(this).attr("selected", "selected");
			} else {
				if ($(this).attr("selected") == "selected") {
					$(this).removeAttr("selected");
				}
			}
		});


	}
    
    
    var $ = layui.$, active = {
      batchdel: function(){
    	 if("${user.identity}"==""||parseInt("${user.identity}")==2)
			return layer.msg('您没有权限进行此操作！');  
        var checkStatus = table.checkStatus('course-table')
        ,checkData = checkStatus.data; //得到选中的数据

        if(checkData.length === 0){
          return layer.msg('请选择数据');
        }
      
        layer.confirm('确定删除共'+checkData.length+'个科目吗？<br/>包括科目中的题目将被删除!', function(index) {
        	
          //alert(checkData[0].courseName);
          var courseId = [];
		  for (i = 0; i < checkData.length; i++) {
			  courseId.push(checkData[i].courseId);
			}
          
          $.ajax({
				url : "${pageContext.request.contextPath}/deletecourse",
				traditional : true,
				type : "post",
				dataType : "json",
				data : {
					'courseId' : courseId
				},
				success : function(callback) {
					if(callback)
						layer.msg('删除成功！');
					else{
						layer.alert('删除失败！',function(){

						});
					}
					
					
					table.reload('course-table');
				}
				
			})
          
          
        });
      },
      add: function(){
    	  if("${user.identity}"==""||parseInt("${user.identity}")==2)
				return layer.msg('您没有权限进行此操作！');	
          layer.open({
            type: 2
            ,title: '添加科目'
            ,content: 'course_add.jsp'
            ,maxmin: true
            ,area: ['550px', '550px']
            ,btn: ['确定', '取消']
            ,yes: function(index, layero){
            	
              //点击确认触发 iframe 内容中的按钮提交
              var submit = layero.find('iframe').contents().find("#course-add-submit");
              
              submit.click();
              
            }
          }); 
        }
    }; 
    table.render({
        elem: '#course-table'
        ,url: '${pageContext.request.contextPath}/findcourses'
        ,toolbar: true 
        ,method:'post'
        ,cols: [[
        	{type:'checkbox'}
          ,{field:'courseId', width:180, title: '科目ID', sort: true}
          ,{field:'courseName', width:180, title: '科目名称'}
          ,{field:'information', width:300, title: '科目介绍'}
          ,{field:'createDate', width:160, title: '创建时间', sort: true}
          ,{field:'modifyDate', width:160, title: '修改时间', sort: true}
          ,{field:'', width:200, title: '操作',toolbar:"#table-content-list" }
        ]]
        ,parseData: function (res) {  //自定义返回格式
            //主要代码:在parseData中做处理,并按照对应格式返回数据即可
            res.data.forEach(function(val){
            	val.createDate=layui.util.toDateString(val.createDate, 'yyyy-MM-dd HH:mm:ss');
            	val.modifyDate=layui.util.toDateString(val.modifyDate, 'yyyy-MM-dd HH:mm:ss');
            });
            return {
                    "code": 0,
                    "msg": res.msg,
                    "count": res.count,
                    "data": res.data
                }
        }
        ,page: true	
      });
    $('.layui-btn.layuiadmin-btn-list').on('click', function(){
      var type = $(this).data('type');
     
      active[type] ? active[type].call(this) : '';
    });
    
  });
  
  layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  laydate.render({
		    elem: '#createDate'
		    ,range: true
		    ,done: function(value, date, endDate){
		    	
		    }
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
