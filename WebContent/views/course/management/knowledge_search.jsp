<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>题卷系统 - 知识点列表</title>
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
            <label class="layui-form-label">知识点名称</label>
            <div class="layui-input-inline">
              <input type="text" name="knowledgeName" id="knowledgeName" autocomplete="off" class="layui-input">
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
          <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" id="unfold">
   			 <i class="layui-icon">&#xe663;</i>
  		  </button>
        </div>
        <div id="list" class="demo-tree demo-tree-box"></div>
        
        
      </div>
    </div>
  </div>
  
  <script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js"></script>  
  <script>
  layui.config({
    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'contlist', 'tree','jquery'], function(){
	 var tree = layui.tree
	 ,layer = layui.layer
	 ,form = layui.form
	 ,util = layui.util;
    
	 var $ = layui.$;
     window.jQuery = layui.$;
     $("#unfold").click(function(){
    	 $("#list").find('.layui-tree-txt').parents('.layui-tree-pack').prev().find('.layui-tree-iconClick').click(); //展开选项
    	});
    //监听搜索
	
    $('#search-submit').click(function () {
    	var name = $("#knowledgeName").val(); //搜索值
        var elem = $("#list").find('.layui-tree-txt').css('color', ''); //搜索文本与设置默认颜色
        if (!name) {
          return; //无搜索值返回
        }
        
        elem.filter(':contains(' + name + ')').css('color', 'red'); //搜索文本并设置标志颜色
        
        elem.parents('.layui-tree-pack').prev().find('.layui-tree-iconClick').click(); //展开选项
        
    })
      
  //开启节点操作图标
    tree.render({
      elem: '#list'
      ,data: getData()
      //,spread:true
      //,showLine: false  //连接线
      //,accordion:true // 手风琴
      ,edit: ['add', 'update', 'del'] //操作节点的图标
      ,id: 'list'
      , icon: {        //三种图标样式，更改几个都可以，用的是layui的图标
                        open: "&#xe625;"       //节点打开的图标
                        , close: "&#xe623;"    //节点关闭的图标
                        , end: "&#xe643;"      //末尾节点的图标
                    }
      ,click: function(obj){
        layer.msg(JSON.stringify(obj.data));
      }
      ,operate:function(obj){
    	  var type=obj.type;//得到操作类型：add、edit、del 
    	  var data=obj.data;//得到当前节点的数据
    	  var elem=obj.elem;//得到当前节点元素
    	  var knowledgeName=data.title;
    	  var knowledgeId=data.id;//得到节点索引
    	  var fatherId=data.fatherId;//父节点
    	  console.log(data);
    	  if(type==='add'){
    		  if("${user.identity}"==""||parseInt("${user.identity}")==2)
    		  {
    			  
    			  return layer.msg('您没有权限进行此操作！',{
    				  icon: 2,
    				  time: 700 //2秒关闭（如果不配置，默认是3秒）
    				}, function(){
    					location.reload();
    				});
    			  
    			    
    		  }
    		  if(knowledgeId==1)
    		  {
    			  return layer.msg('禁止创建科目<br/>请移步科目模块创建！',{
    				  icon: 2,
    				  time: 700 //2秒关闭（如果不配置，默认是3秒）
    				}, function(){
    					location.reload();
    				});
    		  }	  
    		  var key=-1;
    		  $.ajax({
    		        url: "${pageContext.request.contextPath}/addknowledge",    
    		        type: "post",
    		        //async:false ,
    		        data:{
    		        	"fatherId":knowledgeId
    		        },
    		        async:false,
    		        success: function(resut){
    		        	//alert(resut);
    		        	if(resut.knowledgeId!=null)
    					{
    		        		key=resut.knowledgeId;
    		        		layer.msg('添加一个新知识点');
    		        		
    		        	}
    					else{
    						var popup=parent.layer.alert('添加一个新知识点失败！',function(){
    							parent.layer.close(popup);
    						});
    					}
    		        }
    		    });
    		  return key;
    	  }
		  if(type==='update'){
			  if("${user.identity}"==""||parseInt("${user.identity}")==2)
    		  {
    			  
    			  return layer.msg('您没有权限进行此操作！',{
    				  icon: 2,
    				  time: 700 
    				}, function(){
    					location.reload();
    				});
    			  
    			    
    		  } 
			  
			  if(knowledgeId==1)
			  { 
				  layer.alert('禁止修改根目录！');
			  	
			  	tree.reload('list', {data: getData()});
			  	  return ;
			  }
			  if(fatherId==1)
    		  {
    			  return layer.msg('禁止修改科目<br/>请移步科目模块修改！',{
    				  icon: 2,
    				  time: 700 //2秒关闭（如果不配置，默认是3秒）
    				}, function(){
    					location.reload();
    				});
    		  }
			  $.ajax({
  		        url: "${pageContext.request.contextPath}/updateknowledge",    
  		        type: "post",
  		        data:{
  		        	"knowledgeId":knowledgeId,
  		        	"knowledgeName":knowledgeName,
  		        	"fatherId":fatherId
  		        },
  		        async:false,
  		        success: function(resut){
  		        	if(resut)
  						layer.msg('修改知识点成功！');
  					else{
  						var popup=parent.layer.alert('修改知识点失败！',function(){
  							parent.layer.close(popup);
  						});
  					}
  		        }
  		    });
    	  }
		  if(type==='del'){
			  if("${user.identity}"==""||parseInt("${user.identity}")==2)
    		  {
    			  
    			  return layer.msg('您没有权限进行此操作！',{
    				  icon: 2,
    				  time: 700 //2秒关闭（如果不配置，默认是3秒）
    				}, function(){
    					location.reload();
    				});
    			  
    			    
    		  } 
			  if(knowledgeId==1)
			  { 
				//console.log(elem.find('.layui-tree-txt').html());
				  return layer.msg('禁止删除根目录！',{
    				  icon: 2,
    				  time: 700
    				}, function(){
    					location.reload();
    				});
			  }
			  if(fatherId==1)
    		  {
    			  return layer.msg('禁止删除科目<br/>请移步科目模块删除！',{
    				  icon: 2,
    				  time: 700 //2秒关闭（如果不配置，默认是3秒）
    				}, function(){
    					location.reload();
    				});
    		  }
			  $.ajax({
	  		        url: "${pageContext.request.contextPath}/deleteknowledge",    
	  		        type: "post",
	  		        data:{
	  		        	"knowledgeId":knowledgeId
	  		        },
	  		        async:false,
	  		        success: function(resut){
	  		        	if(resut)
	  						layer.msg('删除知识点成功');
	  					else{
	  						var popup=parent.layer.alert('删除知识点失败！',function(){
	  							parent.layer.close(popup);
	  						});
	  					}
	  		        }
	  		    });
		  }
      }
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
    
  
  });
  
  </script>
</body>
</html>
