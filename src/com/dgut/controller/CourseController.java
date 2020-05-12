package com.dgut.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.dgut.bean.Course;
import com.dgut.bean.Knowledge;
import com.dgut.service.CourseService;
import com.dgut.service.KnowledgeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class CourseController {

	@Autowired
	private CourseService courseService;

	@Autowired
	private KnowledgeService knowledgeService;

	@RequestMapping("/addcourse")
	@ResponseBody
	public String addcourse(Course course, Model model) {

		int i = 0;
		course.setCreateDate(new Date());
		course.setModifyDate(new Date());
		int j = courseService.course_find(course.getCourseId(), course.getCourseName());

		if (j == 1) {
			course.setKnowledgeId(new Long((long) -1));
			i = courseService.course_add(course);
			Knowledge knowledge = new Knowledge();
			knowledge.setFatherId(new Long((long) 1));
			knowledge.setKnowledgeName(course.getCourseName());
			knowledge.setCourseId(course.getCourseId());
			j = knowledgeService.knowledge_add(knowledge);
			course.setKnowledgeId(knowledge.getKnowledgeId());
			updatecourse(course.getCourseId(), course.getCourseName(), course.getInformation(),
					course.getKnowledgeId());
			System.out.println(course + "," + knowledge);
			// knowledgeService.knowledge_update(knowledge);

			if (i == 1 && j == 1)
				return "1";
		}

		return "0";

	}

	@RequestMapping(value = "coursersfind", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String coursersfind() {
		List<Course> data = courseService.course_findall();
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

	@RequestMapping(value = "findcourses", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String findcourses(int page, int limit) {
		// List<Course> countData = courseService.course_findall();// 查询总数
		PageHelper.startPage(page, limit);// 分页查询数据
		List<Course> data = courseService.course_findall();
		String datajson = JSON.toJSONString(data);
		PageInfo<Course> info = new PageInfo<>(data);// 查询总数
		long total = info.getTotal();
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

	@RequestMapping("/deletecourse")
	@ResponseBody
	public String deletecourse(int[] courseId, Model model) {

		// System.out.println("---334----------->" + couseId.length);
		int i;
		int k;
		for (int j = 0; j < courseId.length; j++) {
			i = courseService.course_delete(courseId[j]);
			List<Knowledge> list = knowledgeService.knowledge_findbycourseId(new Long((long) courseId[j]));
			delectList(list.get(0).getKnowledgeId());
			if (i == 0)
				return "0";
		}
		return "1";

	}

	@RequestMapping(value = "querycourses", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String querycourses(String start_time, String end_time, Course course, int page, int limit) {
		if (end_time != null && end_time != "")
			end_time = end_time + " 23:59:59";
		System.out
				.println("---222----------->" + start_time + "," + end_time + "," + course + "," + page + "," + limit);
		course.setCourseName("%" + course.getCourseName() + "%");
		course.setInformation("%" + course.getInformation() + "%");
		// List<Course> countData = courseService.course_query(start_time, end_time,
		// course);
		PageHelper.startPage(page, limit);// 分页查询数据
		List<Course> data = courseService.course_query(start_time, end_time, course);

		PageInfo<Course> info = new PageInfo<>(data);// 查询总数
		long total = info.getTotal();
		// System.out.println(total);

		String datajson = JSON.toJSONString(data);
		String json = "{\"code\":0,\"msg\":\"\",\"count\":" + total + ",\"data\":" + datajson + "}";
		// System.out.println("---233----------->" + json);
		return json;
		// return "1";

	}

	@RequestMapping(value = "updatecourse", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String updatecourse(Long courseId, String courseName, String information, Long knowledgeId) {
		int i = 0;
		Course course = new Course();
		course.setCourseId(courseId);
		Course old_course = courseService.course_getbyId(course.getCourseId());
		course.setKnowledgeId(old_course.getKnowledgeId());
		course.setCourseName(courseName);
		course.setInformation(information);
		course.setKnowledgeId(knowledgeId);
		course.setModifyDate(new Date());

		int j = courseService.course_find(course.getCourseId(), course.getCourseName());

		if (j == 1) {
			i = courseService.course_update(course);
			Knowledge knowledge = new Knowledge();
			knowledge.setKnowledgeId(old_course.getKnowledgeId());
			knowledge.setKnowledgeName(courseName);
			j = knowledgeService.knowledge_update(knowledge);
		}
		if (i == 1 && j == 1)
			return "1";
		return "0";

	}

	private void delectList(Long knowledgeId) {
		List<Knowledge> knowledges = knowledgeService.knowledge_findlist(knowledgeId);
		knowledges.forEach(knowledge -> {
			delectList(knowledge.getKnowledgeId());
		});
		knowledgeService.knowledge_delete(knowledgeId);
	}
}
