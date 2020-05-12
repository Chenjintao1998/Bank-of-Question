package com.dgut.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.dgut.bean.Question;
import com.dgut.service.QuestionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class QuestionController {
	@Autowired
	private QuestionService questionService;

	@RequestMapping(value = "findquestions", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String findquestions(int page, int limit) {
		PageHelper.startPage(page, limit);// 分页查询数据
		List<Question> data = questionService.question_findall();
		String datajson = JSON.toJSONString(data);
		PageInfo<Question> info = new PageInfo<>(data);// 查询总数
		long total = info.getTotal();
		System.out.println(datajson);
		String json = "{\"code\":0,\"msg\":\"\",\"count\":" + total + ",\"data\":" + datajson + "}";
		return json;
	}

	@RequestMapping(value = "findquestionsbytype", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String findquestionsbytype(Long questiontypeId, Long courseId) {
		List<Question> data = questionService.question_findbytype_course(questiontypeId, courseId);
		String datajson = JSON.toJSONString(data);
		String json = "{\"data\":" + datajson + "}";
		// System.out.println(data);
		return json;
	}

	@RequestMapping(value = "findquestion", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String findquestion(Long qid) {

		Question data = questionService.question_find(qid);
		// System.out.println(data);
		String datajson = JSON.toJSONString(data);
		String json = "{\"data\":" + datajson + "}";
		return json;
	}

	@RequestMapping(value = "updatequestion", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String updatequestion(HttpServletRequest request, Question question) {

		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
				+ request.getContextPath();
		question.setModifyDate(new Date());
		question.setQuestion(question.getQuestion().replaceAll("\\&[a-zA-Z]{1,10};", "").replaceAll("<[^>]*>", "")
				.replaceAll("[(/>)<]", ""));
		question.setAnalysis(question.getAnalysis().replaceAll("\\&[a-zA-Z]{1,10};", "").replaceAll("<[^>]*>", "")
				.replaceAll("[(/>)<]", ""));
		question.setAnswer(question.getAnswer().replaceAll("\\&[a-zA-Z]{1,10};", "").replaceAll("<[^>]*>", "")
				.replaceAll("[(/>)<]", ""));
		question.setSlelects(question.getSlelects().replaceAll("\\&[a-zA-Z]{1,10};", "").replaceAll("<[^>]*>", "")
				.replaceAll("[(/>)<]", ""));
		question.setImagePath(question.getImagePath().replaceAll(basePath, ""));
		int i = questionService.question_update(question);
		if (i == 0)
			return "0";
		return "1";

	}

	@RequestMapping(value = "queryquestions", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String queryquestions(String start_time, String end_time, Question question, int page, int limit) {

		String[] knowledge1 = question.getKnowledgeId().split(",");
		ArrayList<String> knowledge = new ArrayList<String>();
		if (end_time != null && end_time != "")
			end_time = end_time + " 23:59:59";

		question.setQuestion("%" + question.getQuestion() + "%");
		if (knowledge1[0] != "")
			for (int i = 0; i < knowledge1.length; i++) {
				knowledge.add(knowledge1[i]);
			}
		PageHelper.startPage(page, limit);// 分页查询数据
		List<Question> data = questionService.question_query(start_time, end_time, question, knowledge);
		PageInfo<Question> info = new PageInfo<>(data);// 查询总数
		long total = info.getTotal();

		String datajson = JSON.toJSONString(data);
		String json = "{\"code\":0,\"msg\":\"\",\"count\":" + total + ",\"data\":" + datajson + "}";

		return json;

	}

	@RequestMapping("/deletequestion")
	@ResponseBody
	public String deletequestion(int[] qid, Model model) {

		int i;
		for (int j = 0; j < qid.length; j++) {
			i = questionService.question_delete(qid[j]);
			if (i == 0)
				return "0";
		}
		return "1";

	}

	@RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
	@ResponseBody
	public String uploadImage(HttpServletRequest request, MultipartFile file) {
		Map<String, Object> res = new HashMap<>();
		try {
			return uploadFile(request, file);
		} catch (Exception e) {
			e.printStackTrace();
			res.put("code", -1);
			res.put("msg", "上传失败");
			String result = new JSONObject(res).toString();
			return result;
		}
	}

	@RequestMapping("/addquestion")
	@ResponseBody
	public String addquestion(HttpServletRequest request, Question question) {

		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
				+ request.getContextPath();
		question.setCreateDate(new Date());
		question.setModifyDate(new Date());
		question.setQuestion(question.getQuestion().replaceAll("\\&[a-zA-Z]{1,10};", "").replaceAll("<[^>]*>", "")
				.replaceAll("[(/>)<]", ""));
		question.setAnalysis(question.getAnalysis().replaceAll("\\&[a-zA-Z]{1,10};", "").replaceAll("<[^>]*>", "")
				.replaceAll("[(/>)<]", ""));
		question.setAnswer(question.getAnswer().replaceAll("\\&[a-zA-Z]{1,10};", "").replaceAll("<[^>]*>", "")
				.replaceAll("[(/>)<]", ""));
		question.setSlelects(question.getSlelects().replaceAll("\\&[a-zA-Z]{1,10};", "").replaceAll("<[^>]*>", "")
				.replaceAll("[(/>)<]", ""));
		question.setImagePath(question.getImagePath().replaceAll(basePath, ""));
		int i = questionService.question_add(question);
		if (i == 1)
			return "1";
		else
			return "0";

	}

	@ResponseBody
	@RequestMapping(value = "/uploadFile")
	public String uploadFile(HttpServletRequest request, @Param("file") MultipartFile file) throws IOException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
		String res = sdf.format(new Date());
		// 服务器上使用
		String rootPath = request.getServletContext().getRealPath("\\uploads\\image\\");
		// target的目录
		// 本地使用
		// String rootPath = "H:/uploads/image";
		// 原始名称
		String originalFilename = file.getOriginalFilename();
		// 新的文件名称
		String newFileName = res + originalFilename.substring(originalFilename.lastIndexOf("."));
		// 创建年月文件夹
		Calendar date = Calendar.getInstance();
		File dateDirs = new File(date.get(Calendar.YEAR) + File.separator + (date.get(Calendar.MONTH) + 1));
		// 新文件
		File newFile = new File(rootPath + File.separator + dateDirs + File.separator + newFileName);
		// 判断目标文件所在的目录是否存在
		if (!newFile.getParentFile().exists()) {
			// 如果目标文件所在的目录不存在，则创建父目录
			newFile.getParentFile().mkdirs();
		}
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
				+ request.getContextPath() + "/";
		// 将内存中的数据写入磁盘
		file.transferTo(newFile);
		// 完整的url
		String fileUrl = basePath + "\\uploads\\image\\" + date.get(Calendar.YEAR) + "\\"
				+ (date.get(Calendar.MONTH) + 1) + "\\" + newFileName;
//		String fileUrl = rootPath + date.get(Calendar.YEAR) + "/" + (date.get(Calendar.MONTH) + 1) + "/" + newFileName;
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map2 = new HashMap<String, Object>();
		map.put("code", 0);// 0表示成功，1失败
		map.put("msg", "上传成功");// 提示消息
		map.put("data", map2);
		map2.put("src", fileUrl);// 图片url
		map2.put("title", newFileName);// 图片名称，这个会显示在输入框里
		String result = new JSONObject(map).toString();
		return result;

	}

}
