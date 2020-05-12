<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>题库系统 - 知识点列表</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
</head>
<body>

  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-form layui-card-header layuiadmin-card-header-auto" id="select-form">
        <div class="layui-form-item">
          <div class="layui-inline" >
            <label class="layui-form-label">题目ID</label>
            <div class="layui-input-inline">
              <input type="text" name="qid" id="qid"  onkeyup="value=integer(this.value)" autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">问题</label>
            <div class="layui-input-inline">
              <input type="text" name="question" id="question" autocomplete="off" class="layui-input">
            </div>
          </div>
		  <div class="layui-inline">
            <label class="layui-form-label">知识点</label>
 			<div class="layui-input-inline">
  				<div class="layui-unselect layui-form-select downpanel" id="downpanel">
  					<div class="layui-select-title" id="layui-select-title">
   						<span class="layui-input layui-unselect" id="treeclass"  style="padding-top: 10px;text-overflow:ellipsis;overflow: hidden; white-space:nowrap; "></span>
   						<input type="hidden" name="selectID" value="0">
   							<i class="layui-edge"></i>
  					</div>
  					<dl class="layui-anim layui-anim-upbit">
   						<dd>
   							<ul id="tree"></ul>
   						</dd>
  					</dl>
  				</div>
 			</div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">题型</label>
            <div class="layui-input-inline" >
            	<select  name="questiontypeId" id="questiontypeId" lay-search="">
          			<option value="">直接选择或搜索选择</option>
          			
        		</select>
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">科目</label>
            <div class="layui-input-inline">
              <select name="courseId" id="courseId"  lay-search="">
          			<option value="">直接选择或搜索选择</option>
          			
        		</select>
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">题目难度</label>
            <div class="layui-input-inline">
             <select name="difficulty" lay-verify="">
  				<option value="">难度选择</option>
  				<option value="简单">简单</option>
  				<option value="中等">中等</option>
  				<option value="困难">困难</option>
			</select>
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">创建时间</label>
            <div class="layui-input-inline">
            <input type="text" class="layui-input"name="createDate" id="createDate" placeholder=" - "autocomplete="off">
            </div>
          </div>
          
          <div class="layui-inline">
            <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="search-submit" id="search-submit">
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
        
        <table class="layui-hide"lay-filter="question-table" id="question-table"></table>
        
        <script type="text/html" id="table-content-list">
		  <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="select"><i class="layui-icon layui-icon-search">查看</i></a>
        </script>
        
      </div>
    </div>
  </div>
  
  <script type="text/javascript" src="${pageContext.request.contextPath}/layuiadmin/modules/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>  
  <script>
  $(function(){	 
	 getQuestiontype();
	 getCoursers();
	})
  var myMap = new Map();
  var arry=null,knowledge,knowledgeName,time;
  layui.config({
    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['table', 'jquery','tree','form'], function(){
	 var form = layui.form
	 ,tree= layui.tree
	 ,table = layui.table;
	 var $ = layui.jquery;

	 
	 form.on('submit(search-submit)', function(data){
		 form.render("select");
	     var field = data.field;
	     time=$("[name='createDate']").val().split(" - ");
	     start_time=time[0];
	     end_time=time[1];
	     knowledge=null;
	     if(arry!=null)
	     	for(var i=0;i<arry.length;i++)
	     	{ 
	    	 	if(i==0)
	    	 		knowledge=arry[i];
	    	 	else
	    			knowledge=knowledge+","+arry[i];
	     	}
	     
	     table.reload('question-table', {
				url:'${pageContext.request.contextPath}/queryquestions'
				,traditional: true
				,width:1250
				,height:520
				,where: {
					"qid":data.field.qid,
		        	 "courseId":data.field.courseId,
		        	 "questiontypeId":data.field.questiontypeId,
		        	 "question":data.field.question,
		        	 "difficulty":data.field.difficulty,
		        	 "knowledgeId":knowledge,
		        	 "start_time":start_time,
		        	 "end_time":end_time
				}
				,page: {
					curr: 1 //重新从第 1 页开始
				}
				});
		
		
		});
	 table.on('row(question-table)', function(obj){

	     	    //添加当前行样式，然后移除兄弟样式
	     	    // obj.tr.addClass('layui-bg-cyan').siblings().removeClass('layui-bg-cyan');
	     		obj.tr.attr('style',"background:#dddddd;color:#000").siblings().attr({"style":"background:#fff"});
	     	});
	 var $ = layui.$, active = {
		      batchdel: function(){
		    	  if("${user.identity}"==""||parseInt("${user.identity}")==2)
	    		  {
	    			  
	    			  return layer.msg('您没有权限进行此操作！',{
	    				  icon: 2,
	    				  time: 700 //2秒关闭（如果不配置，默认是3秒）
	    				}, function(){
	    				});
	    			  
	    			    
	    		  }
		        var checkStatus = table.checkStatus('question-table')
		        ,checkData = checkStatus.data; //得到选中的数据

		        if(checkData.length === 0){
		          return layer.msg('请选择数据');
		        }
		      
		        layer.confirm('确定删除共'+checkData.length+'个题目吗？<br/>数据删除后无法复原!', function(index) {
		        	
		          //alert(checkData[0].courseName);
		          var questionId = [];
				  for (i = 0; i < checkData.length; i++) {
					  questionId.push(checkData[i].qid);
					}
		          
		          $.ajax({
						url : "${pageContext.request.contextPath}/deletequestion",
						traditional : true,
						type : "post",
						dataType : "json",
						data : {
							'qid' : questionId
						},
						success : function(callback) {
							if(callback)
								layer.msg('删除成功！');
							else{
								var popup=parent.layer.alert('删除失败！',function(){
									parent.layer.close(popup);
								});
							}
							
							
							table.reload('question-table');
						}
						
					})
		          
		          
		        });
		      },
		      add: function(){
		    	  if("${user.identity}"==""||parseInt("${user.identity}")==2)
	    		  {
	    			  
	    			  return layer.msg('您没有权限进行此操作！',{
	    				  icon: 2,
	    				  time: 700 //2秒关闭（如果不配置，默认是3秒）
	    				}, function(){
	    				});
	    			  
	    			    
	    		  }
		          layer.open({
		            type: 2
		            ,title: '添加题目'
		            ,content: 'question_add.jsp'
		            ,maxmin: true
		            ,area: ['750px', '550px']
		            ,btn: ['确定', '取消']
		            ,yes: function(index, layero){
		            	
		              //点击确认触发 iframe 内容中的按钮提交
		              var submit = layero.find('iframe').contents().find("#question-add-submit");
		              
		              submit.click();
		              
		            }
		          }); 
		        }
		    }; 
	    $('.layui-btn.layuiadmin-btn-list').on('click', function(){
	        var type = $(this).data('type');
	        active[type] ? active[type].call(this) : '';
	      });
	 table.render({
		 	id:'question-table'
	        ,elem: '#question-table'
	        ,url: '${pageContext.request.contextPath}/findquestions'
	        ,toolbar: true 
	        ,width:1250
			,height:520
	        ,method:'post'
	        ,cols: [[
	           {type:'checkbox'}
	          ,{field:'qid', width:100, title: '题目ID', sort: true}
	          ,{field:'course', width:100, title: '所属题库',templet: '<div>{{d.course.courseName}}</div>'}
	          ,{field:'question', width:350, title: '问题'}
	          ,{field:'questiontype', width:100, title: '题型',templet: '<div>{{d.questiontype.questiontypeName}}</div>'}
	          ,{field:'difficulty', width:100, title: '难度'}
	          ,{field:'createDate', width:160, title: '创建时间', sort: true}
	          ,{field:'modifyDate', width:160, title: '修改时间', sort: true}
	          ,{field:'', width:100, title: '操作',toolbar:"#table-content-list" }
	        ]]
	        ,parseData: function (res) {  //自定义返回格式
                //主要代码:在parseData中做处理,并按照对应格式返回数据即可
                
                var imgReg = /<img.*?(?:>|\/>)/gi;
                var htmlReg =/<(.+?)[\s]*\/?[\s]*>/gi;
                
                res.data.forEach(function(val){  
                	myMap.set(val.qid,val.question);
                	val.createDate=layui.util.toDateString(val.createDate, 'yyyy-MM-dd HH:mm:ss');
                	val.modifyDate=layui.util.toDateString(val.modifyDate, 'yyyy-MM-dd HH:mm:ss');
                	val.question=val.question.replace(imgReg,"[图片]");
                	val.question=val.question.replace(htmlReg,""); 
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
//	    $('.layui-btn.layuiadmin-btn-list').on('click', function(){
//	      var type = $(this).data('type');
//	      active[type] ? active[type].call(this) : '';
//	    });
	 table.on('tool(question-table)', function(obj) {
		 if("${user.identity}"==""||parseInt("${user.identity}")==2)
		  {
			  
			  return layer.msg('您没有权限进行此操作！',{
				  icon: 2,
				  time: 700 //2秒关闭（如果不配置，默认是3秒）
				}, function(){
				});
			  
			    
		  }
		 var data = obj.data;
	    	//alert(data.courseId);
	    	json = JSON.stringify(data);
	    	//obj.tr.find(':checkbox[name="layTableCheckbox"]:not(:checked)+').click();
	    	switch(obj.event) {
			case 'select':
				var index = layer.open({
					type: 2
		            ,title: '编辑题目'
		            ,content: 'question_edit.jsp'
		            ,maxmin: true
		            ,area: ['750px', '550px']
		            ,btn: ['确定', '取消']
					,success: function(layero, index){
						var body = layer.getChildFrame('body', index); // body.html() body里面的内容
						var iframe= window[layero.find('iframe')[0]['name']];
						setTimeout(function (){
							iframe.assignment("courseId",data.courseId);
							iframe.assignment("questiontypeId",data.questiontypeId);
							iframe.assignment("difficulty",data.difficulty);
							iframe.settree(data.courseId,data.knowledgeId);
						},60);
						iframe.Initialize(data.knowledgeId.split(","),data.imagePath,1);
						iframe.setanswerdiv(data.questiontypeId,data.questiontype.options);
						if(data.questiontype.options)
						{	
							iframe.set(data.createDate,data.slelects,data.answer,data.questiontype.options,data.questiontype.multiple);
						}
						else
						{
							var jsonmap=eval("("+data.answer+")");
							body.find("#answer").val(jsonmap.answer);
						}
						body.find("#qid").val(data.qid);
						body.find("#question").val(myMap.get(data.qid));
						body.find("#analysis").val(data.analysis);
						body.find("#createDate").val(layui.util.toDateString(data.createDate, 'yyyy-MM-dd HH:mm:ss'));
					}
					,yes: function(index, layero){
						//点击确认触发 iframe 内容中的按钮提交
			              var submit = layero.find('iframe').contents().find("#question-edit-submit");
			              submit.click();
					}
				});
				break;
	    	}
	 })
	 
	 function getSimpleText(d){
		    var re1 = new RegExp("<.+?>","g");//匹配html标签的正则表达式，"g"是搜索匹配多个符合的内容
		    var msg = d.replace(re1,'');//执行替换成空字符
		    return msg;
		}  
	 tree.render({
		  elem: "#tree",
		  data:getData(),
		  onlyIconControl:true,
		  showLine:false,
		  showCheckbox:true,
		  id:"checktree",
		  click: function (data) {
			  //alert(data.data.title);
		   }, 
     	  oncheck:function(){
     		 var checkData = tree.getChecked('checktree');
     		 arry=new Array();
     		 knowledgeName=new Array();
     		 getCheckData(checkData,arry,knowledgeName);
     		 var string={};
     		 for(var i=0;i<knowledgeName.length;i++)
     		 {	
     			 if(i==0);
     			 else if(i==1)
     			 	string=knowledgeName[i];
     			 else 
     				string=string+","+knowledgeName[i];
     		 }
     		 $('#treeclass').html(string);
     		 if(knowledgeName.length==0)
     			$('#treeclass').removeAttr("title");
     		 else
     		 	$('#treeclass').attr("title",string);
       	  }
     
		 });
	 
	 $("#downpanel").on("click", "#layui-select-title", function (e) {
		  $("#downpanel").not($(this).parents("#downpanel")).removeClass("layui-form-selected");
		  $(this).parents("#downpanel").toggleClass("layui-form-selected");
		  layui.stope(e);
		 }).on("click", "dl i", function (e) {
		  layui.stope(e);
		 });
		 $(document).on("click", function (e) {
		  $("#downpanel").removeClass("layui-form-selected");
		  
		 });	
 
    function getData(){
	    var data = [];
	    $.ajax({
	        url: "${pageContext.request.contextPath}/findknowledge",    //后台数据请求地址
	        type: "post",
	        async:false,
	        success: function(resut){
	            data=SetData(resut);
	        }
	    });
	    return data;
	}
    function SetData(data){
    	for (var i = 0; i < data.length; i++) {
    	    //重要部分
    	    var value=data[i].children;
    	    //for(var j in data[i]){
    	        	data[i]["id"]=data[i].knowledgeId;
    	        	data[i]["title"]=data[i].knowledgeName;
    	    //}
    	   //递归 这里递归的时候注意 一定不能写rolemenu[i].children 
    	    SetData(value);
    	}
	    return data;
	}

	function getCheckData(data,arry,knowledgeName){
		for (var i = 0; i < data.length; i++) {
    	    //重要部分
    	    //alert(data[i].id);
    	    var value=data[i].children;
    	    if(data[i].id!=1)
    	    	arry[arry.length]=data[i].id;
    	    knowledgeName[knowledgeName.length]=data[i].title;
    	   //递归 这里递归的时候注意 一定不能写rolemenu[i].children 
    	    getCheckData(value,arry,knowledgeName);
    	}
	}
    
  });
 function integer(value){
	  
	  value = value.replace(/[^\d]/g,'');
	  if(''!=value){
	   value = parseInt(value);
	  }
	  return value;
	 }

 layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  laydate.render({
		    elem: '#createDate'
		    ,range: true
		    ,done: function(value, date, endDate){
		    	//time=value.split(" - ");
		    	
		        //console.log(date); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
		        //console.log(endDate); //得结束的日期时间对象，开启范围选择（range: true）才会返回。对象成员同上。
		    	//start_time=new Date(time[0]).getTime();
		        //start_time=time[0];
		        //end_time=time[1];
		    	//end_time=new Date(time[1]).getTime();
		    	
		    }
		  });
 });
 function getQuestiontype(){
	    $.ajax({
	        url:'${pageContext.request.contextPath}/questiontypefind',
	        type:"post",
	        success:function(res){
	            	//alert(res.data.length);
	                for(var i =0;i<res.data.length;i++){
	                    $("#questiontypeId").append("<option value=\""+res.data[i].questiontypeId+"\">"+res.data[i].questiontypeName+"</option>");
	                }
	                //重新渲染
	                layui.use(['form'], function(){
	                	layui.form.render("select");
	                	});
	            
	        }
	    });
	}
 function getCoursers(){
	    $.ajax({
	        url:'${pageContext.request.contextPath}/coursersfind',
	        type:"post",
	        success:function(res){
	            	//alert(res.data.length);
	                for(var i =0;i<res.data.length;i++){
	                    $("#courseId").append("<option value=\""+res.data[i].courseId+"\">"+res.data[i].courseName+"</option>");
	                }
	                //重新渲染
	                layui.use(['form'], function(){
	                	layui.form.render("select");
	                	});
	            
	        }
	    });
	}


  </script>
</body>
</html>
