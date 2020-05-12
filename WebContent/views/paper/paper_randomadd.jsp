<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>题卷系统 - 自定义试卷</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/layuiadmin/style/admin.css" media="all">
</head>
<body>
<div class="layui-fluid">
	<div class="layui-card">
		<div class="layui-form"  style="padding: 20px 30px 0 0;">
			<div class="layui-form-item" >
				<div class="layui-card-body">
					<div class="layui-inline">
			            <label class="layui-form-label">试卷名称</label>
			            <div class="layui-input-inline">
			              <input type="text" name="paperName" id="paperName" lay-verify="required" placeholder="请为试卷命名" autocomplete="off" class="layui-input">
			            </div>
			          </div>
					<div class="layui-inline" >
			            <label class="layui-form-label">设置总分</label>
			            <div class="layui-input-inline">
			              <input type="text" name="total_score" id="total_score" placeholder="请输入试卷总分" lay-verify="required"  onkeyup="value=integer(this.value)" autocomplete="off" class="layui-input">
			            </div>
			        </div>
			        <div class="layui-inline">
			            <label class="layui-form-label">科目</label>
			            <div class="layui-input-inline">
			              <select name="courseId" id="courseId"  lay-filter="courseId" lay-search="">
			          			<option value="">直接选择或搜索选择</option>
			          			
			        		</select>
			            </div>
			          </div>
			        <br/>
			        <div class="layui-inline">
				      <label class="layui-form-label">学年范围</label>
				      <div class="layui-input-inline">
				        <input type="text" class="layui-input" name="time" id="time" placeholder=" - " lay-verify="required" autocomplete="off">
				      </div>
				    </div>
				    <div class="layui-inline">
			            <label class="layui-form-label">学期</label>
			            <div class="layui-input-inline">
			             <select name="semester" id="semester" lay-verify="required">
			  				<option value=""></option>
			  				<option value="一">第一学期</option>
			  				<option value="二">第二学期</option>
						</select>
			            </div>
			          </div>
			          <br/>
			        <div class="layui-inline" >
			            <label class="layui-form-label">备注</label>
			            <div class="layui-input-inline">
			            	<textarea id="remake" style="width: 513px" class="layui-textarea"></textarea>
			            </div>
			        </div>
			        
			        <br/>
			        <div class="layui-inline">
			            <label class="layui-form-label"></label>
			            <div class="layui-input-inline">
			            	<input style="width: 500px;margin:auto  0px;" type="text"  name="number" id="number" value="共有0道大题"   autocomplete="off" class="layui-input" disabled>
			            </div>
			        </div>
					<div style="padding: 10px 0px;padding-left: 70px;">
						<button class="layui-btn layui-btn-lg layui-btn-radius layuiadmin-btn-list" lay-filter="addquestiontype" id="addquestiontype" data-type="addquestiontype"><i class="layui-icon">&#xe654;</i>添加题目</button>
					</div>
				</div>
				<div class="layui-inline" >
					<div id="addquestion"></div>
				</div>
			</div>
			<div class="layui-form-item">
		      <input style="float: right;" type="button" class="layui-btn layui-btn-lg layui-btn-radius layuiadmin-btn-list" lay-submit lay-filter="paper-add-submit" id="paper-add-submit" value="出卷">
		    </div>
		</div>
	</div>
</div>         
<script type="text/javascript" src="${pageContext.request.contextPath}/layuiadmin/xm-select.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layuiadmin/modules/jquery.min.js"></script>           
<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js" charset="utf-8"></script>
<script>
$(function(){
	getCoursers();
})
var demo=new Array();
var count=0,
total=0,
myMap = new Map(),
questionmap= new Map(),
number = new Array(),
new_allquestions=new Array();

layui.use(['laydate','form','tree','jquery','transfer', 'layer', 'util'], function(){
  
  var $ = layui.jquery
  ,transfer = layui.transfer
  ,layer = layui.layer
  ,util = layui.util
  ,form=layui.form
  ,tree=layui.tree
  ,laydate=layui.laydate;
  
  laydate.render({
	    elem: '#time'
	    ,type: 'year'
	    ,range: true
	    ,min: -365 //7天前
	    ,max: 365
	  });
  
  form.on('submit(paper-add-submit)', function(data){
	  var knowledge=new Array();
	  var x=0;
	  for(var i=0;i<demo.length;i++)
	  {
		  if(demo[i]!=-1)
		  {
			  knowledge[x]= demo[i].getValue("value");
		  		x++;
		  }
	  }
	  
	  var num=0;
	  var allquestions= new Array();
	  if(total<=0)
	  {
		  layer.msg('至少要有一个大题！', { icon: 5 });
      	  return false;
	  }
	  for(var i=1;i<=total;i++)
	  {
		  num=num+parseInt($("#question_score"+i).val());
	  }  
	  
	  if(num>parseInt($("#total_score").val())||num<parseInt($("#total_score").val()))
	  {
		  
		  layer.msg('分数设置不正确！', { icon: 5 });
      	  return false;
	  }
	  var json = [];

	  for(var i=0;i<knowledge.length;i++)
	  {	
		  if(knowledge[i]=="")
		  {
			  layer.msg('部分大题未选择知识点！', { icon: 5 });
			  return false;
		  }
	  }  
		  
	  

	  
	  
/*	  for(var i=0;i<knowledge.length;i++)
   	  { 
		  var knowledgeId;
		  for(var j=0;j<knowledge[i].length;j++)
  	 	{
			  
			  if(j==0)
  	 			knowledgeId=knowledge[i][j];
			  else
				  knowledgeId=knowledgeId+","+knowledge[i][j];
  	 	}
		knowledge[i]=knowledgeId;
		
   	  }
   	  */
   	  time=$("[name='time']").val().split(" - ");
	  var start_time=time[0];
	  var end_time=time[1];
	  j=0;
	  for(var i=0;i<number.length;i++)
	  {	
		  if(number[i]!=-1)
		  {
			  var row = {};
			  row.questiontypeId=parseInt($("#questiontypeId"+number[i]).val());
			  row.name=document.getElementById("questiontypeId"+number[i]).options[document.getElementById("questiontypeId"+number[i]).selectedIndex].text;
			  row.score=parseInt($("#question_score"+number[i]).val());
			  row.difficulty=$("#difficulty"+number[i]).val();
			  row.number=parseInt($("#question_number"+number[i]).val());
			  row.knowledgeId=knowledge[j];
			  json.push(row);
			  j++;
		  	  
		  }
	  }
	  
	  
	  var totalknowledgeId="";
	  var new_json=sum(json);
	  var numberstring=[];
	  var difficultystring=[];
	  var qtypestring=[];
	  var qtypename=[];
	  var scorestring=[];
	  
	  for(var i=0;i<new_json.length;i++)
	  {  
		  
		  if(i==0)
		  {	  
			  difficultystring=new_json[i].difficulty;
			  numberstring=new_json[i].number;
			  qtypename=new_json[i].name;
			  qtypestring=new_json[i].questiontypeId;
			  scorestring=new_json[i].score;
			  totalknowledgeId=new_json[i].knowledgeId;
		  }
		  else
		  {   
			  difficultystring+="/"+new_json[i].difficulty;
			  numberstring+="/"+new_json[i].number;
			  qtypename+="/"+new_json[i].name;
			  qtypestring+="/"+new_json[i].questiontypeId;
			  scorestring+="/"+new_json[i].score;
			  totalknowledgeId+="/"+new_json[i].knowledgeId;
		  }
		  
	  }
	  if(totalknowledgeId.length==1)
		  totalknowledgeId=totalknowledgeId.toString();
	  var popup=parent.layer.alert('同类型、同难度、同知识点的大题将合并！<br/>试卷将生成A、B两卷<br/>题目重复率不超过30%',{closeBtn:0,icon: 0},function(){
		  $.ajax({
		        url: "${pageContext.request.contextPath}/extracting",    //后台数据请求地址
		        type: "post",
		        dataType : 'json',
		        data:{
		        	type:"A",
		        	semester:$("#semester").val(),
		        	start_time:start_time,
		        	end_time:end_time,
		        	courseId:$("#courseId").val(),
		        	qtypename:qtypename,
		        	knowledge:totalknowledgeId,
		        	difficultystring:difficultystring,
		        	numberstring:numberstring,
		        	founder:"${user.name}",
		        	qtypestring:qtypestring,
		        	scorestring:scorestring,
		        	paperName:$("#paperName").val(),
		        	remake:$("#remake").val(),
		        	totalscore:$("#total_score").val()
		        },
		        async:false,
		        success: function(resut){
		        	var pid=resut.id;
		        	if(!resut.state)
		        	{
 
		        		
		        			
							var popup=parent.layer.alert('创建A试卷失败！<br/>题目不足',{closeBtn:0,icon: 2},function(){
								parent.layer.close(popup);
							});
						
		        	}
		        	else{
		        		$.ajax({
					        url: "${pageContext.request.contextPath}/extracting",    //后台数据请求地址
					        type: "post",
					        dataType : 'json',
					        data:{
					        	type:"B",
					        	a_qid:resut.qid,
					        	semester:$("#semester").val(),
					        	start_time:start_time,
					        	end_time:end_time,
					        	courseId:$("#courseId").val(),
					        	founder:"${user.name}",
					        	qtypename:qtypename,
					        	knowledge:totalknowledgeId,
					        	difficultystring:difficultystring,
					        	numberstring:numberstring,
					        	qtypestring:qtypestring,
					        	scorestring:scorestring,
					        	paperName:$("#paperName").val(),
					        	remake:$("#remake").val(),
					        	totalscore:$("#total_score").val()
					        },
					        async:false,
					        success: function(resut){
					        	if(resut.state){
									
									var popup=parent.layer.alert('创建试卷成功！',{closeBtn:0,icon: 1},function(){
										
										parent.layer.close(popup);
										parent.layui.admin.events.closeThisTabs();
									});
								}
								else{
									$.ajax({
								        url: "${pageContext.request.contextPath}/paperdelectbyid",    //后台数据请求地址
								        type: "post",
								        dataType : 'json',
								        data:{
								        	paperId:pid
								        },
								        async:false,
								        success: function(resut){
								        	
								        }
								        });
									var popup=parent.layer.alert('创建B试卷失败！<br/>题目不足',{closeBtn:0,icon: 2},function(){
										parent.layer.close(popup);
									});
								}
				        	}
		        		});
		        	}
		        }
		        ,error:function(resut){
		        	
		        }
		        
			});
	  });
	 
	  
	    
	  
	  
	  
  });

  function MapTOJson(m) {
      var str = '{';
      var i = 1;
      m.forEach(function (item, key, mapObj) {
    	  
      	if(mapObj.size == i||mapObj.length==i){
      		str += '"'+ key+'":"'+ item + '"';
      	}else{
      		str += '"'+ key+'":"'+ item + '",';
      	}
      	i++;
      });
      str +='}';
      //console.log(str);
      return str;
  }
  function sum(data) {
		var result = [];
		var newData = data;
		var delData = [];
		data1:
			for (var i in data) {
				var json = data[i];
				var countnumber = data[i].number;
				var countscore = data[i].score;
				data2:
					for (var j in newData) {
						if (delData != null) {
							for (var h in delData) {
								if (i == delData[h]) {
									continue data1;
								}
								if (j == delData[h]) {
									continue data2;
								}
							}
						}
						if (i != j && data[i].questiontypeId == newData[j].questiontypeId &&
							data[i].name == newData[j].name && data[i].difficulty==newData[j].difficulty&&data[i].knowledgeId[0]==newData[j].knowledgeId[0]) {	
							delData.push(j);
							countscore += newData[j].score;
							countnumber+=newData[j].number;
						}
					}
				json.number=countnumber;
				json.score = countscore;
				result.push(json);
			}
		return result;
	}
  function unique(arr){
	  var hash=[];
	  for (var i = 0; i < arr.length; i++) {
	     if(hash.indexOf(arr[i])==-1){
	      hash.push(arr[i]);
	     }
	  }
	  return hash;
	}
 
  form.on('select(courseId)', function (data) {
	  
	  $("#addquestion").html("");
	  	number=new Array();
	  	demo=new Array();
	  	count=0;
		total=0;
	   $("#number").val("共有"+0+"道大题");
	   return layer.msg('更换科目清除已设置的大题！');
  });

 
  
  var $ = layui.$, active = {
			
			addquestiontype:function(){
				
				if($("#courseId").val()==""){
					return layer.msg('请先选择科目！');
				}
				count++;
				total++;
				$("#number").val("共有"+total+"道大题");
				number[count-1]=count;
				$("#addquestion").append('<div id="div'+count+'"><button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-xs layui-btn-radius" onclick="deleteoption('+count+')"  lay-filter="del'+count+'" id="del'+count+'"  "><i id="i'+count+'" class="layui-icon layui-icon-delete "></i>删除</button><div class="layui-form layui-card-header layuiadmin-card-header-auto"><div class="layui-form-item"><div class="layui-inline"><label class="layui-form-label">题型</label><div class="layui-input-inline" ><select lay-verify="required" lay-reqtext="题型是必选的"  name="questiontypeId'+count+'" id="questiontypeId'+count+'" lay-filter="questiontypeId" lay-search=""  ><option value="">直接选择或搜索选择</option></select></div></div><div class="layui-inline"> <label class="layui-form-label">知识点</label> <div class="layui-input-inline"> <div id="demo'+count+'" style="width: 200px"></div> </div> </div> <div class="layui-inline"> <label class="layui-form-label">题目难度</label> <div class="layui-input-inline"> <select name="difficulty'+count+'" lay-verify="required" id="difficulty'+count+'" lay-verify=""> <option value="">难度选择</option> <option value="简单">简单</option> <option value="中等">中等</option> <option value="困难">困难</option> </select> </div> </div><div class="layui-inline" ><label class="layui-form-label">设置分数</label><div class="layui-input-inline"><input  type="text" name="question_score'+count+'" id="question_score'+count+'" placeholder="请输入该大题总分" lay-verify="required" lay-reqtext="请输入该大题总分"  onkeyup="value=integer(this.value)" autocomplete="off" class="layui-input"></div></div><div class="layui-inline" ><label class="layui-form-label">设置数量</label><div class="layui-input-inline"><input  type="text" name="question_number'+count+'" id="question_number'+count+'" placeholder="请输入该大题题目数量" lay-verify="required" lay-reqtext="请输入该大题题目数量"  onkeyup="value=integer(this.value)" autocomplete="off" class="layui-input"></div></div></div></div></div>');
				getQuestiontype(count);
				demo[count-1] = xmSelect.render({
					el: '#demo'+count, 
					//显示为text模式
					model: { label: { type: 'text' } },
					//单选模式
					radio: true,
					//选中关闭
					clickClose: true,
					//树
					tree: {
						show: true,
						//非严格模式
						strict: false,
						//默认展开节点
						expandedKeys: [ -1 ],
					},
					height: '100px',
					data:getData(),
					size: 'mini'
					
				})
				layui.form.render();
			}
	}
  
	$('.layui-btn.layuiadmin-btn-list').on('click', function(){
		 var type = $(this).data('type');
		 active[type] ? active[type].call(this) : '';
		});
 




  function getQuestiontype(id){
	  
	  
	    $.ajax({
	        url:'${pageContext.request.contextPath}/questiontypefind',
	        type:"post",
	        success:function(res){
	            	//alert(res.data.length);
	                for(var i =0;i<res.data.length;i++){
	                	myMap.set(res.data[i].questiontypeId,[res.data[i].options,res.data[i].multiple]);
	              	  	//myMap.set('multiple', res.data[i].multiple);
	                    $("#questiontypeId"+id).append("<option value=\""+res.data[i].questiontypeId+"\">"+res.data[i].questiontypeName+"</option>");
	                }
	                //重新渲染
	                layui.use(['form'], function(){
	                	layui.form.render("select");
	                	});
	            
	        }
	    });
	}

  
});
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
  	$("#div"+id).html("");
  	number[id-1]=-1;
  	demo[id-1]=-1;
	total--;
	$("#number").val("共有"+total+"道大题");
	
}
function integer(value){
	  
	  value = value.replace(/[^\d]/g,'');
	  if(''!=value){
	   value = parseInt(value);
	  }
	  return value;
	 }
	 
	  
   function getData(){
	    var data = [];
	    $.ajax({
	        url: "${pageContext.request.contextPath}/findknowledgebycourse?courseId="+$("#courseId").val()+"",    //后台数据请求地址
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
   	        	data[i]["value"]=data[i].knowledgeId;
   	        	data[i]["name"]=data[i].knowledgeName;
   	    //}
   	   //递归 这里递归的时候注意 一定不能写rolemenu[i].children 
   	    SetData(value);
   	}
	    return data;
	}
</script>

</body>
</html>