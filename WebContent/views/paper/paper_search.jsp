<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>题卷系统 - 试卷列表</title>
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
            <label class="layui-form-label">试卷ID</label>
            <div class="layui-input-inline">
              <input type="text" name="paperId" id="paperId"  onkeyup="value=integer(this.value)" autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">试卷名称</label>
            <div class="layui-input-inline">
              <input type="text" name="paperName" id="paperName" autocomplete="off" class="layui-input">
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">创建者</label>
            <div class="layui-input-inline">
              <input type="text" name="founder" id="founder" autocomplete="off" class="layui-input">
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
          <button class="layui-btn layui-btn-lg layui-btn-radius layuiadmin-btn-list" data-type="batchdel">删除</button>
        </div>
        
        <table  class="layui-hide"lay-filter="paper-table" id="paper-table"></table>
        
        <script type="text/html" id="table-content-list">
		  <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="downloadpaper"><i class="layui-icon">&#xe601;试题卷</i></a>
		  <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="downloadanswer"><i class="layui-icon">&#xe601;答案卷</i></a>
        </script>
        
      </div>
    </div>
  </div>
  
  <script type="text/javascript" src="${pageContext.request.contextPath}/layuiadmin/modules/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>  
  <script>
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
		  
		  table.render({
		        elem: '#paper-table'
		        ,url: '${pageContext.request.contextPath}/findpapers'
		        ,toolbar: true 
		        ,method:'post'
		        ,cols: [[
		        	{type:'checkbox'}
		          ,{field:'paperId', width:120, title: '试卷ID', sort: true}
		          ,{field:'paperName', width:180, title: '试卷名称'}
		          ,{field:'type', width:80, title: '类型'}
		          ,{field:'founder', width:130, title: '创建者'}
		          ,{field:'remark', width:120, title: '备注'}
		          ,{field:'createDate', width:160, title: '创建时间', sort: true}
		          ,{field:'zt', width:130, title: '状态'}
		          ,{field:'', width:270, title: '操作',toolbar:"#table-content-list" }
		        ]]
		        ,parseData: function (res) {  //自定义返回格式
		            //主要代码:在parseData中做处理,并按照对应格式返回数据即可
		            res.data.forEach(function(val){
		            	
		            	if(val.state==0)
		            		val.zt='<input type="checkbox" name="close" id="'+val.paperId+'" lay-skin="switch" lay-filter="stat" lay-text="允许下载|禁止下载" ${user.identity == null?"disabled":""}${user.identity == 3?"disabled":""}>';
		            	else
		            		val.zt='<input type="checkbox" checked="" name="close" id="'+val.paperId+'" lay-skin="switch" lay-filter="stat" lay-text="允许下载|禁止下载" ${user.identity == null?"disabled":""} ${user.identity == 3?"disabled":""}>';	
		            	val.createDate=layui.util.toDateString(val.createDate, 'yyyy-MM-dd HH:mm:ss');
		            	val.modifyDate=layui.util.toDateString(val.modifyDate, 'yyyy-MM-dd HH:mm:ss');
		            	if(val.type!=""&&val.type!=null)
		            	val.type=val.type+'卷';
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
		  form.on('switch(stat)', function(data){

			
			  if(this.checked)
			  {
					  $.ajax({
				  
	  					url : "${pageContext.request.contextPath}/paperstatus",
	  					traditional : true,
	  					type : "post",
	  					dataType : "json",
	  					data : {
	  						'id' : data.elem.id,
	  						'status':1
	  					},
	  					success : function(callback) {
	  						if(callback)
	  						{	
	  							layer.msg('开放下载');
	  							table.reload('paper-table');
	  						}
	  						else
	  						{	
	  							layer.msg('开放下载失败');
	  							table.reload('paper-table');
	  						}
	  					}
	  				});
			  } 
			  else
			  {
				  $.ajax({
					  
	  					url : "${pageContext.request.contextPath}/paperstatus",
	  					traditional : true,
	  					type : "post",
	  					dataType : "json",
	  					data : {
	  						'id' : data.elem.id,
	  						'status':0
	  					},
	  					success : function(callback) {
	  						if(callback)
	  						{	
	  							layer.msg('关闭下载');
	  							table.reload('paper-table');
	  						}
	  						else
	  						{	
	  							layer.msg('关闭下载失败');
	  							table.reload('paper-table');
	  						}
	  						
	  					}
	  				}); 
			  }
			  
		  });
		  table.on('tool(paper-table)', function(obj) {
			  
		    	var data = obj.data;
		    	if("${user.identity}"== ""||parseInt("${user.identity}")== 3)
		    	{
		    		if(data.state==0)
		    			return layer.msg('未开放下载');
		    	}
		    	
		    	switch(obj.event) {
				case 'downloadanswer':
					window.location.href="${pageContext.request.contextPath}/download?path="+encodeURI(encodeURI(data.answerurl));
					
					break;
				case 'downloadpaper':
					window.location.href="${pageContext.request.contextPath}/download?path="+encodeURI(encodeURI(data.paperurl));
					break;
				}
			});
		  
		  table.on('row(paper-table)', function(obj){

		    	    //添加当前行样式，然后移除兄弟样式
		    	    // obj.tr.addClass('layui-bg-cyan').siblings().removeClass('layui-bg-cyan');
		    		obj.tr.attr('style',"background:#dddddd;color:#000").siblings().attr({"style":"background:#fff"});
		    	});  
		  form.on('submit(search-submit)', function(data){
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
			  table.reload('paper-table', {
					url:'${pageContext.request.contextPath}/querypapers'
					,traditional: true
					,where: {
						"paperId":data.field.paperId,
			        	"paperName":data.field.paperName,
			        	"founder":data.field.founder,
			        	"knowledgeId":knowledge,
			        	"start_time":start_time,
			        	"end_time":end_time
					}
					,page: {
						curr: 1 //重新从第 1 页开始
					}
					});
		  });
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
			    var $ = layui.$, active = {
			    		
			    	      batchdel: function(){
			    	    	  if("${user.identity}"==""||parseInt("${user.identity}")==3)
									return layer.msg('您没有权限进行此操作！');
			    	        var checkStatus = table.checkStatus('paper-table')
			    	        ,checkData = checkStatus.data; //得到选中的数据

			    	        if(checkData.length === 0){
			    	          return layer.msg('请选择数据');
			    	        }
			    	      
			    	        layer.confirm('确定删除共'+checkData.length+'张试卷吗？', function(index) {
			    	        	
			    	          //alert(checkData[0].courseName);
			    	          var paperId = [];
			    	          var answerurl = [];
			    	          var paperurl = [];
			    			  for (i = 0; i < checkData.length; i++) {
			    				  paperId.push(checkData[i].paperId);
			    				  answerurl.push(checkData[i].answerurl);
			    				  paperurl.push(checkData[i].paperurl);
			    				}
			    	          
			    	          $.ajax({
			    					url : "${pageContext.request.contextPath}/deletepaper",
			    					traditional : true,
			    					type : "post",
			    					dataType : "json",
			    					data : {
			    						'paperId' : paperId,
			    						'answerurl':answerurl,
			    						'paperurl':paperurl
			    					},
			    					success : function(callback) {
			    						if(callback)
			    							layer.msg('删除成功！');
			    						else{
			    							var popup=parent.layer.alert('删除失败！',function(){
			    								parent.layer.close(popup);
			    							});
			    						}
			    						
			    						
			    						table.reload('paper-table');
			    					}
			    					
			    				})
			    	          
			    	          
			    	        });
			    	      }
			    	    }; 
			 $('.layui-btn.layuiadmin-btn-list').on('click', function(){
			      var type = $(this).data('type');
			     
			      active[type] ? active[type].call(this) : '';
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
			    jg=data;
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
		    layui.use('laydate', function(){
		  	  var laydate = layui.laydate;
		  	  laydate.render({
		  		    elem: '#createDate'
		  		    ,range: true
		  		    ,done: function(value, date, endDate){
		  		    }
		  		  });
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
