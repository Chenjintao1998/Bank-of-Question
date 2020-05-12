package com.dgut.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.dgut.bean.Questiontype;
import com.dgut.service.QuestiontypeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class QuestiontypeController {

	@Autowired
	private QuestiontypeService questiontypeService;

	@RequestMapping("/addquestiontype")
	@ResponseBody
	public String addquestiontype(Questiontype questiontype, Model model) {
		int i = 0;
		int j = questiontypeService.questiontype_find(questiontype.getQuestiontypeId(),questiontype.getQuestiontypeName());

		if (j == 1)
			i = questiontypeService.questiontype_add(questiontype);
		if (i == 1)
			return "1";
		else
			return "0";

	}

	@RequestMapping(value = "updatequestiontype", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String updatequestiontype(Questiontype questiontype) {
		int i = 0;
		int j = questiontypeService.questiontype_find(questiontype.getQuestiontypeId(),questiontype.getQuestiontypeName());

		if (j == 1)
			i = questiontypeService.questiontype_update(questiontype);
		if (i == 1)
			return "1";
		return "0";

	}

	@RequestMapping(value = "questiontypefind", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String questiontypefind() {

		List<Questiontype> data = questiontypeService.questiontype_findall();
		String datajson = JSON.toJSONString(data);
		// Map<String, Object> map = new HashMap<>();
		// map.put("code", 0);
		// map.put("msg", "courses");
		// map.put("count", countData.size()); // 获得数据的总数
		// map.put("data", datajson); // 本次分页查询的数据

		// System.out.println("---334----------->" + page + "," + limit);
		// System.out.println("---334----------->" + data.get(0));
		// System.out.println(map);
		String json = "{\"data\":" + datajson + "}";
		// System.out.println(json);
		// return map;
		return json;
	}

	@RequestMapping(value = "findquestiontype", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String findquestiontype(int page, int limit) {
		// System.out.println("233");
		// List<Questiontype> countData = questiontypeService.questiontype_findall();//
		// 查询总数
		PageHelper.startPage(page, limit);// 分页查询数据
		List<Questiontype> data = questiontypeService.questiontype_findall();
		String datajson = JSON.toJSONString(data);

		PageInfo<Questiontype> info = new PageInfo<>(data);// 查询总数
		long total = info.getTotal();
		// System.out.println(total);
		// Map<String, Object> map = new HashMap<>();
		// map.put("code", 0);
		// map.put("msg", "courses");
		// map.put("count", countData.size()); // 获得数据的总数
		// map.put("data", datajson); // 本次分页查询的数据

		// System.out.println("---334----------->" + page + "," + limit);
		// System.out.println("---334----------->" + data.get(0));
		// System.out.println(map);
		String json = "{\"code\":0,\"msg\":\"\",\"count\":" + total + ",\"data\":" + datajson + "}";
		// System.out.println(json);
		// return map;
		return json;
	}

	@RequestMapping(value = "queryquestiontypes", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String queryquestiontypes(Questiontype questiontype, int page, int limit) {

		// System.out.println("---222----------->" + start_time + "," + end_time + "," +
		// course + "," + page + "," + limit);
		questiontype.setQuestiontypeName("%" + questiontype.getQuestiontypeName() + "%");
		// List<Questiontype> countData =
		// questiontypeService.questiontype_query(questiontype);// 查询总数
		PageHelper.startPage(page, limit);// 分页查询数据
		List<Questiontype> data = questiontypeService.questiontype_query(questiontype);

		PageInfo<Questiontype> info = new PageInfo<>(data);// 查询总数
		long total = info.getTotal();

		String datajson = JSON.toJSONString(data);
		String json = "{\"code\":0,\"msg\":\"\",\"count\":" + total + ",\"data\":" + datajson + "}";
		// System.out.println("---233----------->" + json);
		return json;
		// return "1";

	}

	@RequestMapping("/deletequestiontype")
	@ResponseBody
	public String deletequestiontype(int[] questiontypeId, Model model) {

		// System.out.println("---334----------->" + couseId.length);
		int i;
		for (int j = 0; j < questiontypeId.length; j++) {
			i = questiontypeService.questiontype_delete(questiontypeId[j]);
			if (i == 0)
				return "0";
		}
		return "1";

	}

}
