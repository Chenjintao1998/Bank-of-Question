<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>题卷系统-题目添加</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
</head>
<body>

  <div class="layui-form"  style="padding: 20px 30px 0 0;">
  	
    <div class="layui-form-item" >
    <div class="layui-inline">
      <label class="layui-form-label">题目ID</label>
      <div class="layui-input-inline">
        <input type="text" name="qid" id="qid" lay-verify="required" autocomplete="off" class="layui-input" disabled>
      </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label">创建时间</label>
      <div class="layui-input-inline">
        <input type="text" name="createDate" id="createDate" lay-verify="required" autocomplete="off" class="layui-input" disabled>
      </div>
    </div>
          <div class="layui-inline">
      <label class="layui-form-label">题型</label>
      <div class="layui-input-inline" >
          <select  name="questiontypeId" id="questiontypeId" lay-filter="questiontypeId" lay-search="" lay-verify="required" lay-reqtext="请选择题型" disabled>
          	<option value="">直接选择或搜索选择</option>
		  </select>
      </div>
    </div>
    
    <div class="layui-inline">
      <label class="layui-form-label">科目</label>
      <div class="layui-input-inline">
         <select name="courseId" id="courseId"  lay-filter="courseId" lay-search="" lay-verify="required" lay-reqtext="请选择所属科目">
          	<option value="">直接选择或搜索选择</option>
         </select>
      </div>
    </div>
    
    <div class="layui-inline">
      <label class="layui-form-label">难度</label>
      <div class="layui-input-inline">
          <select id="difficulty" name="difficulty" lay-verify="required" lay-reqtext="请设置题目难度">
  		  <option value="">难度选择</option>
  		  <option value="简单">简单</option>
  	      <option value="中等">中等</option>
  		  <option value="困难">困难</option>
		  </select>
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
          
    <div class="layui-inline" style="width: 700px;">
      	<label class="layui-form-label">题目</label>
      	<div class="layui-input-inline" style="width: 530px;border: solid 1px;" >
      		<textarea id="question" style="display: none;" lay-verify="edit" ></textarea>
      	</div>
     </div>
     
	<div class="layui-card-body">
		<div style="padding-bottom: 10px;padding-left: 70px;">
     		<button style="display:none;" class="layui-btn layui-btn-lg layui-btn-radius layuiadmin-btn-list" lay-filter="addoptions" id="addoptions" data-type="addoptions"><i class="layui-icon">&#xe654;</i>添加选项</button>
     	</div>
     </div>

	<div class="layui-inline" style="width: 700px;" id="option">
		
	</div>
	
	<div class="layui-inline" style="width: 700px;" id="answerdiv">
<!--      	<label class="layui-form-label">答案</label>
      	<div class="layui-input-inline" style="width: 530px;border: solid 1px;" >
      		<textarea id="answer" style="display: none;" lay-verify="edit" ></textarea>
      	</div>-->
     </div>  
     	<div class="layui-inline" style="width: 700px;" id="answerdiv">
      	<label class="layui-form-label">解析</label>
      	<div class="layui-input-inline" style="width: 530px;border: solid 1px;" >
      		<textarea id="analysis" style="display: none;" lay-verify="edit" ></textarea>
      	</div>
     </div>
     
     <div class="layui-inline" style="width: 700px;">
     <label class="layui-form-label"></label>
		<div style="padding-bottom: 10px;padding-left: 70px;">
		     <button type="button" class="layui-btn" id="file">
			  <i class="layui-icon">&#xe67c;</i>上传图片
			</button>
		</div>
	</div>
	<div class="layui-inline" style="width: 700px;">
	     <label class="layui-form-label"></label>
		<div class="layui-upload-list">
			<img class="bigImg layui-upload-img" style="height: 160px;width: 250px" id="nationalityimg">
				 <p id="nationalityText"></p>
		</div>
	</div>
    <div class="layui-form-item layui-hide">
      <input type="button" lay-submit lay-filter="question-edit-submit" id="question-edit-submit" value="确认">
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
	var image=null;
  var del="";
  var number = new Array(),
  arr_box = new Array(),
  arr = new Array(),
  arry = new Array(),
  answarry = new Array(),
  myMap = new Map(),
  selectMap = new Map(),
  answMap = new Map(),
  namearry,
  knowId= new Map(),
  answer,
  createData,
  f=0,
  cid,
  title;
  var multiple,count=0,total=0,options,flg=0;
  layui.config({
    base: '${pageContext.request.contextPath}/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['upload','index', 'form','layedit','tree'], function(){
    var $ = layui.$
    ,form = layui.form
    ,layedit = layui.layedit
    ,tree= layui.tree
    ,checkCallback = false;
    var upload = layui.upload;
    upload.render({
  	  elem: '#file'
  	  ,url: '${pageContext.request.contextPath}/uploadFile'
  	  ,exts: 'jpg|png|jpeg'
  	  ,choose: function(obj) {
  		        obj.preview(function(index, file, result) {//index索引 file 文件名.后缀  result 图片数据
  		            var img = new Image();
  		            img.onload = function() {
  		                    $('#nationalityimg').attr('src', result); //图片链接（base64）不支持ie8
  		                    obj.upload(index, file);
  		            };
  		            img.src = result;
  		        });
  		    }
  	  
        , auto: false
        , done: function(res) { //上传成功发生成的事件
      	  image=res.data.src;
            layer.closeAll('loading');
            if (res.code > 0) {
                return layer.msg(res.msg);
            }
        }
        , error: function() {//上传失败的事件
            layer.closeAll('loading');
            layer.alert('上传失败，请重试！');
        }
  	});
    form.on('select(courseId)', function (data) { 
    	if(cid==$("#courseId").val())
    	{	
    		$('#treeclass').html(title);
    		$('#treeclass').attr("title",title);
    	}
    	else
    	{
    		$('#treeclass').removeAttr("title");
    		$('#treeclass').html("");
    	}
 	   tree.render({
 			  elem: "#tree",
 			  data:getData1($("#courseId").val()),
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
    });
    
    
    
 //   layui.layedit.set({
 //       uploadImage: {
 //           url: '${pageContext.request.contextPath}/uploadFile' //接口url
 //           ,type: 'post' //默认post
 //       }
 //   });
    String.prototype.replaceAll=function(s1,s2){
        return this.replace(new RegExp(s1,"gm"),s2);
    };
    var question=layedit.build('question',{
    	height: 180,
    	tool: [
    		//    		  'strong' //加粗
    		//    		  ,'italic' //斜体
    		//    		  ,'underline' //下划线
    		//    		  ,'del' //删除线
    		//    		  ,'|' //分割线
    		//    		  ,'left' //左对齐
    		//    		  ,'center' //居中对齐
    		//    		  ,'right' //右对齐
    		//    		  ,'link' //超链接
    		//    		  ,'unlink' //清除链接
    		//    		  ,'image' //插入图片
    		  ]
    	});	    
            var analysis=layedit.build('analysis',{
            	height: 180,
            	tool: [
            		//    		  'strong' //加粗
            		//    		  ,'italic' //斜体
            		//    		  ,'underline' //下划线
            		//    		  ,'del' //删除线
            		//    		  ,'|' //分割线
            		//    		  ,'left' //左对齐
            		//    		  ,'center' //居中对齐
            		//    		  ,'right' //右对齐
            		//    		  ,'link' //超链接
            		//    		  ,'unlink' //清除链接
            		//    		  ,'image' //插入图片
            		  ]
            	});//建立编辑器    
/*    form.on('select(questiontypeId)', function (data) {
    	var id=$("select[name=questiontypeId").val();
    	options=true;
    	if(id!=="")
    	{
    		
    		options=myMap.get(parseInt(id))[0];
    		multiple=myMap.get(parseInt(id))[1];
    	}
    	//alert(options);
    	setanswerdiv(id,options);
		$("#option").html("");
		arr_box=new Array();;
		arr = new Array();
		total=0;
		count=0;
    		
    })
 */   

    //监听提交
    form.on('submit(question-edit-submit)', function(data){
    	
    	var slelect,answ,letter=65;
    	//alert(String.fromCharCode(letter));
    	var index = parent.layer.getFrameIndex(window.name);
    	var checkData = tree.getChecked('checktree');
    	
		arry=new Array();
		knowledgeName=new Array();
		getCheckData(checkData,arry,knowledgeName);
    	if(arry.length!=0)
    	{ 
    		
    		var knowledge;
    		for(var i=0;i<arry.length;i++)
	     	{ 
	    	 	if(i==0)
	    	 		knowledge=arry[i];
	    	 	else
	    			knowledge=knowledge+","+arry[i];
	     	}
    	}
    	else
    	{
    		layer.msg('至少要选择一个知识点！', { icon: 5 });
        	return false;
    	}
    	if(options)
    	{
    		
        	if(total<2)
        	{
        		
        		layer.msg('至少要有两个选项！', { icon: 5 });
            	return false;
        	}
    		//alert($('input[name="radio"]:checked').val());
    		if(multiple)
        	{
        		var len = $("input:checkbox[name='like']:checked").length;
        		$("input:checkbox[name='like']:checked").each(function(i){
            		arr_box[i] = $(this).val();
                });
            	arr_box.splice(len,arr_box.length-len);
            	if(len<1)
            	{	
            		layer.msg('答案至少需要一个！', { icon: 5 });
                	return false;
            	}
            	
            	flag=0;
        		var l;
        		for(l=0;l<number.length;l++)
        		{	
        			if(number[l]!=-1)
        			{	
        				
        				selectMap.set(String.fromCharCode(letter),layedit.getContent(arr[l]).replaceAll("\"","\'"));
        				if(number[l]==arr_box[flag])
        				{
        					answarry[flag]=String.fromCharCode(letter);
        					flag++;
        				}
        				letter=letter+1;
        			}
        		
        		}
        		selectMap.set("total",total);
        		answMap.set("total",flag);
        		answMap.set("answer",answarry);
            	
            	
        	}
    		else
    		{
    			var obj = document.getElementsByName("radio");
            	var flags = false;  
            	for(var i=0; i<obj.length; i ++){
                    if(obj[i].checked==true){
                    	flags = true;
                    }
                }
            	if (flags == false)  
            	{  
            		layer.msg('答案至少需要一个！', { icon: 5 });
                	return false;
            	}
        		var l;
        		for(l=0;l<number.length;l++)
        		{	
        			if(number[l]!=-1)
        			{	
        				
        				selectMap.set(String.fromCharCode(letter),layedit.getContent(arr[l]));
        				if($('input[name="radio"]:checked').val()-1==l)
        					answarry[0]=String.fromCharCode(letter);
        				letter=letter+1;
        			}
        		
        		}
        		selectMap.set("total",total);
        		answMap.set("answer",answarry);
    			
    		}
    		
    		
    	}
    	else
    		answMap.set("answer",layedit.getContent(answer).replaceAll("\"","\'"));	
    	$.ajax({
    		            url:'${pageContext.request.contextPath}/updatequestion',
    		            type:'post',
    		            data:{
    						"qid":$("#qid").val(),
    						"courseId":$("select[name=courseId").val(),
    						"questiontypeId":$("select[name=questiontypeId").val(),
    						"question":layedit.getContent(question),
    						"slelects":MapTOJson(selectMap),
    						"answer":MapTOJson(answMap),
    						"analysis":layedit.getContent(analysis),
    						"knowledgeId":knowledge,
    						"difficulty":data.field.difficulty,
    						"createData":createData,
    						"imagePath":image
    						
    					},
    		            dataType:"json",
    		            success:function(data){
    			
    						if(data){
    							
    							var popup=parent.layer.alert('修改题目成功！',{closeBtn:0,icon: 1},function(){
    								
    								parent.layui.table.reload('question-table'); //重载表格
    								parent.layer.close(popup);
    								parent.layer.close(index); //再执行关闭 
    								
    							});
    						}
    						else{
    							 
    							var popup=parent.layer.alert('修改题目失败！',{closeBtn:0,icon: 2},function(){
    								parent.layer.close(popup);
    							});
    						}
    						
    							
    					}
    		            
    		        });
    	
      
    });
         
//    form.on('checkbox(like)', function (data) {
//        var len = $("input:checkbox[name='like']:checked").length;
//        alert(total);
//        if (len >= total) {
//          $(data.elem).next().attr("class", "layui-unselect layui-form-checkbox");
//          $(data.elem).prop("checked", false);
//          layer.msg('至少留个非答案项！', { icon: 5 });
//          return false;
//        }
//      });
	
	 
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
    
		 
	
    form.verify({ // value：表单的值、item：表单的DOM对象
    	edit: function (value, item) { // 可4个空格，非空，可以有特殊字符
    		var imgReg = /<img [^>]*src=['"]([^'"]+)[^>]*>/;
            var htmlReg =/<(.+?)[\s]*\/?[\s]*>/gi;
    		var num= item.id.replace(/[^0-9]/ig,"");
    		//alert(layedit.getContent(arr[num-1]));
    		if(item.id=="question")
    		{	if(layedit.getContent(question).replace(imgReg, function (match, capture) {})==""&&layedit.getContent(question).replace(htmlReg,"")=="")
    				return "题目不能为空";
    		}
    		if(item.id=="answer")
    		{	if(layedit.getContent(answer).replace(imgReg, function (match, capture) {})==""&&layedit.getContent(answer).replace(htmlReg,"")=="")
					return "答案不能为空";
			}
    		if(item.id=="analysis")
    		{	if(layedit.getContent(analysis).replace(imgReg, function (match, capture) {})==""&&layedit.getContent(analysis).replace(htmlReg,"")=="")
					return "解析不能为空";
			}
    		if(item.id!="question"&&item.id!="answer"&&item.id!="analysis")
    		{
    			if(layedit.getContent(arr[num-1]).replace(imgReg, function (match, capture) {})==""&&layedit.getContent(arr[num-1]).replace(htmlReg,"")=="")
    			    return "选项不能为空";
    		}
    		
    		
        }
    })
    function getData1(id){
        var data = [];
        $.ajax({
            url: "${pageContext.request.contextPath}/findknowledgebycourse?courseId="+id+"",    //后台数据请求地址
            type: "post",
            async:false,
            success: function(resut){
                data=SetData(resut);
            }
        });
        return data;
    }
    function SetData(data){
    	var j=0;
    	for (var i = 0; i < data.length; i++) {
    	    //重要部分
    	    var value=data[i].children,fag=0;
    	    
    	    //for(var j in data[i]){
    	    for(j=0;j<data[i].children.length;j++)
    	    {	
    	    	
    	    	if(knowId.get(""+data[i].children[j].knowledgeId+"")!=null)
    	    	{	
    	    		fag=1;
    	    	}
    	    }
    	    if(knowId.get(""+data[i].knowledgeId+"")==data[i].knowledgeId&&data[i].knowledgeId!=1)
    	    {
    	    	if(data[i].children.length==0)
    	    	{
    	    		data[i]["checked"]="checked";
        			if(namearry==null)
        				namearry=data[i].knowledgeName;
        			else
        				namearry=namearry+","+data[i].knowledgeName;
    	    	}
    	    	else if(fag==0)
    	    	{
    	    		data[i]["checked"]="checked";
        			if(namearry==null)
        				namearry=data[i].knowledgeName;
        			else
        				namearry=namearry+","+data[i].knowledgeName;
        			for(j=0;j<data[i].children.length;j++)
    				{
    					namearry=namearry+","+data[i].children[j].knowledgeName;
    				}
    	    	}
    	    	else
    	    	{
    	    		if(namearry==null)
        				namearry=data[i].knowledgeName;
        			else
        				namearry=namearry+","+data[i].knowledgeName;
    	    	}
    	    	
    	    }
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
    	    arry[arry.length]=data[i].id;
    	    knowledgeName[knowledgeName.length]=data[i].title;
    	   //递归 这里递归的时候注意 一定不能写rolemenu[i].children 
    	    getCheckData(value,arry,knowledgeName);
    	}
    }
  })
function MapTOJson(m) {
    var str = '{';
    var i = 1;
    m.forEach(function (item, key, mapObj) {
    	if(mapObj.size == i){
    		str += '"'+ key+'":"'+ item + '"';
    	}else{
    		str += '"'+ key+'":"'+ item + '",';
    	}
    	i++;
    });
    str +='}';
    
    return str;
}
  function getQuestiontype(){
	  
	  
	    $.ajax({
	        url:'${pageContext.request.contextPath}/questiontypefind',
	        type:"post",
	        success:function(res){
	            	//alert(res.data.length);
	                for(var i =0;i<res.data.length;i++){
	                	myMap.set(res.data[i].questiontypeId,[res.data[i].options,res.data[i].multiple]);
	              	  	//myMap.set('multiple', res.data[i].multiple);
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
function deleteoption(id){
	if(number[id-1]!=-1)
	{
		var i="i"+id;
		var lab="lab"+id;
		var del="del"+id;
		var div="div"+id;
		var opt="option"+id;
		$("#"+i).remove();
		$("#"+lab).remove();
		$("#"+opt).remove();
		$("#"+div).remove();
		$("#"+del).remove();
		arr[id-1]=null;
		number[id-1]=-1;
		total--;
	}
}
function assignment(id,val)	
{
	var selVal="";
	$("#" + id).attr("value", val);
	$("#" + id).children("option").each(function() {
		if ($(this).val() == val) {
			selVal=$(this).text();
			$(this).attr("selected", "selected");
		} else {
			if ($(this).attr("selected") == "selected") {
				$(this).removeAttr("selected");
			}
		}
	});
	layui.use(['form'], function(){
    	layui.form.render("select");
    	});
}
function Initialize(kid,imag,flag)	
{
	if(flag==0)
		document.getElementById("file").disabled=true;
	if(imag!=null&&imag!="")
	{
		image=imag;
		$("#nationalityimg").attr("src","${pageContext.request.contextPath}"+imag);
	}
	for(var i=0;i<kid.length;i++)
		knowId.set(kid[i],kid[i]);
}
function setanswerdiv(id,opt)
{
	options=opt;
	if(opt)
	{
		if(id!="")
			document.getElementById("addoptions").style.display="";
		$("#answerdiv").html("");
	}
	else
	{
		document.getElementById("addoptions").style.display="none";
		$("#answerdiv").append("<label class=\"layui-form-label\">答案</label>"
				+"<div class=\"layui-input-inline\" style=\"width: 530px;border: solid 1px;\" >"
      			+"<textarea id=\"answer\" style=\"display: none;\" lay-verify=\"edit\" ></textarea></div>"
      	);
		layui.use(['layedit'], function(){
        answer=layui.layedit.build('answer',{
        	height: 180,
        	tool: [
        		//    		  'strong' //加粗
        		//    		  ,'italic' //斜体
        		//    		  ,'underline' //下划线
        		//    		  ,'del' //删除线
        		//    		  ,'|' //分割线
        		//    		  ,'left' //左对齐
        		//    		  ,'center' //居中对齐
        		//    		  ,'right' //右对齐
        		//    		  ,'link' //超链接
        		//    		  ,'unlink' //清除链接
        		//    		  ,'image' //插入图片
        		  ]
        	});
		});	
	}
}	
function setnotedit(id,opt,mu)
{
	if(opt)
	{	
		$("#option"+id).next().find('iframe').contents().find('body').prop("contenteditable",false);
		$("#del"+id).remove();
		if(mu)
		{
			$("#like"+id).attr("disabled","disabled");
		}
		else
		{
			$("#radio"+id).attr("disabled","disabled");
		}
	}
	
	
	
}
function setnotedit1(id)
{
	$(id).next().find('iframe').contents().find('body').prop("contenteditable",false);
	
	layui.use(['form'], function(){
		layui.form.render();
	});
	
}

function settree(id,kid){
	var checkCallback=false;
	setTimeout(function (){
    	checkCallback = true;
    },40);
	
	layui.use(['tree'],function(){
		var tree=layui.tree;
		tree.render({
			  elem: "#tree",
			  data:getData1(id),
			  onlyIconControl:true,
			  showLine:false,
			  showCheckbox:true,
			  id:"checktree",
			  click: function (data) {
				  //alert(data.data.title);
			   }, 
	   	  oncheck:function(){
	   		
	   		
	   		
	   		 }
				 
			   
	   
			 });
	});
	var kidarry=kid.split(",");
	var string={};
	for(var i=0;i<kidarry.length;i++)
	{
		$.ajax({
	        url: "${pageContext.request.contextPath}/findknowledgebyid?id="+kidarry[i]+"",    //后台数据请求地址
	        type: "post",
	        async:false,
	        success: function(resut){
	        	if(i!=0)
	            {
	        		if(i==1)
	            		string=resut.knowledgeName;
	           
	        		else
	            		string+=","+resut.knowledgeName;
	            }
	        }
	    });
	}
	$('#treeclass').html(string);
	$('#treeclass').attr("title",string);
	title=string;
	cid=id;
}
function getData1(id){
    var data = [];
    $.ajax({
        url: "${pageContext.request.contextPath}/findknowledgebycourse?courseId="+id+"",    //后台数据请求地址
        type: "post",
        async:false,
        success: function(resut){
            data=SetData(resut);
        }
    });
    return data;
}
function SetData(data){
	var j=0;
	for (var i = 0; i < data.length; i++) {
	    //重要部分
	    var value=data[i].children,fag=0;
	    
	    //for(var j in data[i]){
	    for(j=0;j<data[i].children.length;j++)
	    {	
	    	
	    	if(knowId.get(""+data[i].children[j].knowledgeId+"")!=null)
	    	{	
	    		fag=1;
	    	}
	    }
	    if(knowId.get(""+data[i].knowledgeId+"")==data[i].knowledgeId&&data[i].knowledgeId!=1)
	    {
	    	if(data[i].children.length==0)
	    	{
	    		data[i]["checked"]="checked";
    			if(namearry==null)
    				namearry=data[i].knowledgeName;
    			else
    				namearry=namearry+","+data[i].knowledgeName;
	    	}
	    	else if(fag==0)
	    	{
	    		data[i]["checked"]="checked";
    			if(namearry==null)
    				namearry=data[i].knowledgeName;
    			else
    				namearry=namearry+","+data[i].knowledgeName;
    			for(j=0;j<data[i].children.length;j++)
				{
					namearry=namearry+","+data[i].children[j].knowledgeName;
				}
	    	}
	    	else
	    	{
	    		if(namearry==null)
    				namearry=data[i].knowledgeName;
    			else
    				namearry=namearry+","+data[i].knowledgeName;
	    	}
	    	
	    }
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
	    arry[arry.length]=data[i].id;
	    knowledgeName[knowledgeName.length]=data[i].title;
	   //递归 这里递归的时候注意 一定不能写rolemenu[i].children 
	    getCheckData(value,arry,knowledgeName);
	}
}
function set(time,json,answerjson,opt,mu)
{
	
	createDate=time;
	var jsarr=eval("("+json+")"),letter=65,j=0;
	
	if(opt)
	{
		layui.use(['layedit'], function(){
			layui.layedit.set({
		        uploadImage: {
		            url: '${pageContext.request.contextPath}/uploadFile' //接口url
		            ,type: 'post' //默认post
		        }
		    });
		});
		if(mu)
		{
			multiple=mu;
			var anw=eval("("+answerjson+")");
			
			for(var o=0;o<jsarr.total;o++)
			{
				
				document.getElementById("addoptions").click();
			}
			for (var key in jsarr) {
				
				
				if(key!="total")
				{
					j++;
					var a = jsarr[key];
					$("#option"+j).val(a);
					if(anw.answer.search(String.fromCharCode(letter))!=-1)
						$("#like"+j).attr("checked","checked");
					letter++;
				}
		  	}
			
		}
		else
		{
			var anw=JSON.parse(answerjson).answer;
			for(var o=0;o<jsarr.total;o++)
			{
				
				document.getElementById("addoptions").click();
			}
			for (var key in jsarr) {
				if(key==String.fromCharCode(letter))
				{
					j++;
					
					
					var a = jsarr[key];
					$("#option"+j).val(a);
					if(String.fromCharCode(letter)==anw)
						$("#radio"+j).attr("checked","checked");
					letter++;
				}
		  	}
		}
		
	}
}
var $ = layui.$, active = {
		
		addoptions:function(){
			
			count++;
			total++;
			var name="option"+count;
			number[count-1]=count;
			if(multiple)
			{
				$("#option").append("<label class=\"layui-form-label\" id=\"lab"+count+"\">选项 <button class=\"layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-xs layui-btn-radius\" onclick=\"deleteoption("+count+")\"  lay-filter=\"del"+count+"\" id=\"del"+count+"\"  \"><i id=\"i"+count+"\" class=\"layui-icon layui-icon-delete \"></i>删除</button>"
    					+"</label><div class=\"layui-input-inline\" style=\"width: 530px;border: solid 1px;margin-bottom:10px\" id=\"div"+count+"\">"
    					+"<input type=\"checkbox\" id=\"like"+count+"\" name=\"like\" value=\""+count+"\" lay-filter=\"like\" title=\"答案\"><textarea id=\"option"+count+"\" style=\"display: none;\" lay-verify=\"edit\" ></textarea></div>");
			}	
			else
			{
				$("#option").append("<label class=\"layui-form-label\" id=\"lab"+count+"\">选项 <button class=\"layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-xs layui-btn-radius\" onclick=\"deleteoption("+count+")\"  lay-filter=\"del"+count+"\" id=\"del"+count+"\"  \"><i id=\"i"+count+"\" class=\"layui-icon layui-icon-delete \"></i>删除</button>"
					+"</label><div class=\"layui-input-inline\" style=\"width: 530px;border: solid 1px;margin-bottom:10px\" id=\"div"+count+"\">"
					+"<input type=\"radio\" id=\"radio"+count+"\" name=\"radio\" value=\""+count+"\" title=\"答案\" lay-filter=\"radio\"><textarea id=\"option"+count+"\" style=\"display: none;\" lay-verify=\"edit\" ></textarea></div>");
				
			}
			
			layui.use(['layedit','form'], function(){
				
				layui.form.render();
				arr[f]=layui.layedit.build(name,{
				    	height: 180,
				    	tool: [
				    		//    		  'strong' //加粗
				    		//    		  ,'italic' //斜体
				    		//    		  ,'underline' //下划线
				    		//    		  ,'del' //删除线
				    		//    		  ,'|' //分割线
				    		//    		  ,'left' //左对齐
				    		//    		  ,'center' //居中对齐
				    		//    		  ,'right' //右对齐
				    		//    		  ,'link' //超链接
				    		//    		  ,'unlink' //清除链接
				    		//    		  ,'image' //插入图片
				    		  ],
				    		  contenteditable:false
				    	});
				f++;
			
			});
			
		}
}
$('.layui-btn.layuiadmin-btn-list').on('click', function(){
	 var type = $(this).data('type');
	 active[type] ? active[type].call(this) : '';
	});
  </script>
</body>
</html>