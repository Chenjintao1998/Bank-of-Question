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
			        <br/>
			        <div class="layui-inline">
				      <label class="layui-form-label">学年范围</label>
				      <div class="layui-input-inline">
				        <input type="text" class="layui-input" name="time" id="time" placeholder=" - "autocomplete="off" lay-verify="required">
				      </div>
				    </div>
				    <div class="layui-inline">
			            <label class="layui-form-label">学期</label>
			            <div class="layui-input-inline">
			             <select name="semester" id="semester" lay-verify="required" >
			  				<option value=""></option>
			  				<option value="一">第一学期</option>
			  				<option value="二">第二学期</option>
						</select>
			            </div>
			          </div>
			          <div class="layui-inline">
			            <label class="layui-form-label">试卷类型</label>
			            <div class="layui-input-inline">
			             <select name="type" id="type" lay-verify="required">
			  				<option value=""></option>
			  				<option value="A">A卷</option>
			  				<option value="B">B卷</option>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/layuiadmin/modules/jquery.min.js"></script>         
<script src="${pageContext.request.contextPath}/layuiadmin/layui/layui.js" charset="utf-8"></script>
<script>
var arry= new Array();
var count=0,
total=0,
myMap = new Map(),
questionmap= new Map(),
number = new Array(),
new_allquestions=new Array();;
layui.use(['form','laydate','jquery','transfer', 'layer', 'util'], function(){
  
  var $ = layui.jquery
  ,transfer = layui.transfer
  ,layer = layui.layer
  ,util = layui.util
  ,form=layui.form
  ,laydate=layui.laydate;
  

  laydate.render({
	    elem: '#time'
	    ,type: 'year'
	    ,range: true
	    ,min: -365 
	    ,max: 365
	  });
  
  form.on('submit(paper-add-submit)', function(data){
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
	  for(var i=0;i<number.length;i++)
	  {	
		  if(number[i]!=-1)
		  {
			  
			  allquestions=new Array();;
			  var getData = transfer.getData('question'+number[i]);
			  console.log(getData);
			  if(getData.length==0)
			  {  
				  layer.msg('部分大题中没有小题！', { icon: 5 });
			  	  return false;
			  }
			  if(getData.length>parseInt($("#question_score"+number[i]).val()))
			  {  
				  layer.msg('部分大题中小题数量大于分数！', { icon: 5 });
			  	  return false;
			  }
			  for(var j=0;j<getData.length;j++)
				  allquestions[allquestions.length]=getData[j].value;
			  
			  var row = {};
			  row.questiontypeId=parseInt($("#questiontypeId"+number[i]).val());
			  row.name=document.getElementById("questiontypeId"+number[i]).options[document.getElementById("questiontypeId"+number[i]).selectedIndex].text;
			  row.qid=allquestions;
			  row.score=parseInt($("#question_score"+number[i]).val());
			  json.push(row);
		  	  
		  }
	  } 
	  time=$("[name='time']").val().split(" - ");
	  var start_time=time[0];
	  var end_time=time[1];
	  questionmap.set("paperName",$("#paperName").val());
	  questionmap.set("remake",$("#remake").val());
	  var new_json=sum(json);
	  var qidstring=[];
	  var qtypestring=[];
	  var scorestring=[];
	  for(var i=0;i<new_json.length;i++)
	  {  
		  
		  new_json[i].qid=JSON.stringify(new_json[i].qid)
		  new_json[i].qid=new_json[i].qid.substring(new_json[i].qid.indexOf("[") + 1, new_json[i].qid.indexOf("]"));
		  if(i==0)
		  {	  
			  qidstring=new_json[i].qid;
			  qtypestring=new_json[i].name;
			  scorestring=new_json[i].score;
		  }
		  else
		  {    
			  qidstring+="/"+new_json[i].qid;  
			  qtypestring+="/"+new_json[i].name;
			  scorestring+="/"+new_json[i].score;
		  }
		  
	  }
	  
	  var popup=parent.layer.alert('重复题目将会去除,同类型题目将合并！',{closeBtn:0,icon: 0},function(){
		  $.ajax({
		        url: "${pageContext.request.contextPath}/addpaper",    //后台数据请求地址
		        type: "post",
		        dataType : 'json',
		        data:{
		        	type:$("#type").val(),
		        	semester:$("#semester").val(),
		        	start_time:start_time,
		        	end_time:end_time,
		        	qidstring:qidstring,
		        	qtypestring:qtypestring,
		        	scorestring:scorestring,
		        	founder:"${user.name}",
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
						 
						var popup=parent.layer.alert('创建试卷失败！',{closeBtn:0,icon: 2},function(){
							parent.layer.close(popup);
						});
					}
		            
		        }
		        
			});
	  });
	  
	    
	  
	  
	  //console.log(unique(allquestions));
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
				var countqid=data[i].qid;
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
							data[i].name == newData[j].name ) {
							delData.push(j);
							countqid=countqid.concat(data[i].qid).concat(newData[j].qid);
							countscore += newData[j].score;
						}
					}
				json.qid=unique(countqid);
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
  form.on('select(questiontypeId)', function (data) {
	  
	  var id = data.elem.id.replace(/[^0-9]/ig,"");
	  transfer.render({
		    elem: "#question"+id
		    ,data: getQuestions(data.elem.value,$("#courseId"+id).val())
		    ,width:500
		    ,id:"question"+id
		    ,title: ['未选题目', '已选题目']
		    ,showSearch: true
		    ,parseData:function(res){
		    	var imgReg = /<img.*?(?:>|\/>)/gi;
		        var htmlReg =/<(.+?)[\s]*\/?[\s]*>/gi;
		    	res.question=res.question.replace(imgReg,"[图片]");
		    	res.question=res.question.replace(htmlReg,"");
		    	return{
		    		"value":res.qid,
		    		"title":res.question
		    	}
		    }
		  })
  });
  form.on('select(courseId)', function (data) {
	  var id = data.elem.id.replace(/[^0-9]/ig,"");
	  transfer.render({
		    elem: "#question"+id
		    ,data: getQuestions($("#questiontypeId"+id).val(),data.elem.value)
		    ,width:500
		    ,title: ['未选题目', '已选题目']
		    ,showSearch: true
		    ,id:"#question"+id
		    ,parseData:function(res){
		    	var imgReg = /<img.*?(?:>|\/>)/gi;
		        var htmlReg =/<(.+?)[\s]*\/?[\s]*>/gi;
		    	res.question=res.question.replace(imgReg,"[图片]");
		    	res.question=res.question.replace(htmlReg,"");
		    	return{
		    		"value":res.qid,
		    		"title":res.question
		    	}
		    }
		  })
  });

  window.search_question=function (btn){
		var index = layer.open({
			type: 2
	        ,title: '查看题目'
	        ,content: '${pageContext.request.contextPath}/views/course/management/question_edit.jsp'
	        ,maxmin: true
	        ,btn: ['关闭']
	        ,area: ['750px', '550px']
			,success: function(layero, index){
				var data;
				$.ajax({
			        url: "${pageContext.request.contextPath}/findquestion",    //后台数据请求地址
			        type: "post",
			        data:{qid:btn.id},
			        async:false,
			        success: function(resut){
			            data=resut.data;
			            
			        }
			        
				});
				var body = layer.getChildFrame('body', index); // body.html() body里面的内容
				var iframe= window[layero.find('iframe')[0]['name']];
				
				iframe.Initialize(data.knowledgeId.split(","),data.imagePath,0);
				iframe.setanswerdiv(data.questiontypeId,data.questiontype.options);
				body.find("#qid").val(data.qid);
				body.find("#question").val(data.question);
				body.find("#analysis").val(data.analysis);
				body.find("#createDate").val(layui.util.toDateString(data.createDate, 'yyyy-MM-dd HH:mm:ss'));
				var i=0;
				if(data.questiontype.options)
				{	
					iframe.set(data.createDate,data.slelects,data.answer,data.questiontype.options,data.questiontype.multiple);
					
					setTimeout(function (){	
						for(var j=1;j<=eval("("+data.slelects+")").total;j++)
							iframe.setnotedit(j,data.questiontype.options,data.questiontype.multiple);
					},40);
					body.find("#addoptions").css("display","none");
				}
				else
				{
					var jsonmap=eval("("+data.answer+")");
					body.find("#answer").val(jsonmap.answer);
					setTimeout(function (){
						iframe.setnotedit1("#answer");
					},200);
				}
				setTimeout(function (){
					iframe.assignment("courseId",data.courseId);
					iframe.assignment("questiontypeId",data.questiontypeId);
					iframe.assignment("difficulty",data.difficulty);

					iframe.settree(data.courseId,data.knowledgeId);
					
				},40);
				setTimeout(function (){
					body.find("#difficulty").attr("disabled","disabled");
					body.find("#questiontypeId").attr("disabled","disabled");
					body.find("#courseId").attr("disabled","disabled");
					body.find("#downpanel").css('pointer-events','none');
					iframe.setnotedit1("#question");
					iframe.setnotedit1("#analysis");
					
				},200);
			}
			
		});
	}
  
  var $ = layui.$, active = {
			
			addquestiontype:function(){
				
				count++;
				total++;
				$("#number").val("共有"+total+"道大题");
				number[count-1]=count;
				$("#addquestion").append('<div id="div'+count+'"><button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-xs layui-btn-radius" onclick="deleteoption('+count+')"  lay-filter="del'+count+'" id="del'+count+'"  "><i id="i'+count+'" class="layui-icon layui-icon-delete "></i>删除</button><div class="layui-form layui-card-header layuiadmin-card-header-auto"><div class="layui-form-item"><div class="layui-inline"><label class="layui-form-label">题型</label><div class="layui-input-inline" ><select lay-verify="required" lay-reqtext="题型是必选的"  name="questiontypeId'+count+'" id="questiontypeId'+count+'" lay-filter="questiontypeId" lay-search=""  ><option value="">直接选择或搜索选择</option></select></div></div><div class="layui-inline"><label class="layui-form-label">科目</label><div class="layui-input-inline"><select name="courseId'+count+'" id="courseId'+count+'" lay-filter="courseId"  lay-search="" ><option value="">直接选择或搜索选择</option></select></div></div><div class="layui-inline" ><label class="layui-form-label">设置分数</label><div class="layui-input-inline"><input  type="text" name="question_score'+count+'" id="question_score'+count+'" placeholder="请输入该大题总分" lay-verify="required" lay-reqtext="请输入该大题总分"  onkeyup="value=integer(this.value)" autocomplete="off" class="layui-input"></div></div></div></div><div id="question'+count+'"   class="demo-transfer"></div></div>');
				getQuestiontype(count);
				getCoursers(count);
				transfer.render({
				    elem: "#question"+count
				    ,data: getQuestions()
				    ,width:500
				    ,id:"question"+count
				    ,title: ['未选题目', '已选题目']
				    ,showSearch: true
				    ,parseData:function(res){
				    	var imgReg = /<img.*?(?:>|\/>)/gi;
				        var htmlReg =/<(.+?)[\s]*\/?[\s]*>/gi;
				    	res.question=res.question.replace(imgReg,"[图片]");
				    	res.question=res.question.replace(htmlReg,"");
				    	return{
				    		"value":res.qid,
				    		"title":res.question
				    	}
				    }
					
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
  function getQuestions(questiontypeId,courseId){
	  var data;
	    $.ajax({
	        url:'${pageContext.request.contextPath}/findquestionsbytype',
	        type:"post",
	        data:{questiontypeId:questiontypeId,courseId:courseId},
	        async:false,
	        success:function(res){
	        	data=res.data;	
	        }
	    });
	    return data;
	}
  function getCoursers(id){
	    $.ajax({
	        url:'${pageContext.request.contextPath}/coursersfind',
	        type:"post",
	        success:function(res){
	            	//alert(res.data.length);
	                for(var i =0;i<res.data.length;i++){
	                    $("#courseId"+id).append("<option value=\""+res.data[i].courseId+"\">"+res.data[i].courseName+"</option>");
	                }
	                //重新渲染
	                layui.use(['form'], function(){
	                	layui.form.render("select");
	                	});
	            
	        }
	    });
	}
});
function deleteoption(id){
  	$("#div"+id).html("");
  	number[id-1]=-1;
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
</script>

</body>
</html>