package com.dgut.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.dgut.bean.Knowledge;
import com.dgut.service.CourseService;
import com.dgut.service.KnowledgeService;

@Controller
public class KnowledgeController {

	@Autowired
	private KnowledgeService knowledgeService;

	@Autowired
	private CourseService courseService;

	@RequestMapping(value = "findknowledge", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String findknowledge() {
		List<Knowledge> knowledges = knowledgeService.knowledge_findall();
		// System.out.println("-------123-------->" + knowledges);
		List<Knowledge> knowledgeList = buildTree(knowledges, (long) 0);
		// System.out.println("-------123-------->" + knowledgeList);
		String json = JSON.toJSONString(knowledgeList);
		return json;
	}

	@RequestMapping(value = "findknowledgebyid", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String findknowledgebyid(Long id) {
		Knowledge knowledge = knowledgeService.knowledge_findbyid(id);
		String json = JSON.toJSONString(knowledge);
		return json;
	}

	@RequestMapping(value = "addknowledge", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String addknowledge(Knowledge knowledge) {
		// System.out.println("-------123-------->" + knowledge);
		if (knowledge.getKnowledgeName() == "" || knowledge.getKnowledgeName() == null)
			knowledge.setKnowledgeName("未命名");
		knowledge.setCourseId(new Long((long) -1));
		knowledgeService.knowledge_add(knowledge);
		String json = JSON.toJSONString(knowledge);
		// System.out.println(json);
		return json;
	}

	@RequestMapping(value = "updateknowledge", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String updateknowledge(Knowledge knowledge) {
		// System.out.println("-------123-------->" + knowledge);
		int i = knowledgeService.knowledge_update(knowledge);
		if (i == 1)
			return "1";
		else
			return "0";
	}

	@RequestMapping(value = "deleteknowledge", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String deleteknowledge(Long knowledgeId) {
		// System.out.println("-------123-------->" + knowledgeId);
		delectList(knowledgeId);
		return "1";
	}

	@RequestMapping(value = "findknowledgebycourse", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String findknowledgebycourse(Long courseId) {

		List<Knowledge> knowledges = knowledgeService.knowledge_findall();
		List<Knowledge> knowledgeList = buildTree(knowledges, (long) 0);
		List<Knowledge> new_knowledges = new ArrayList<Knowledge>();
		for (Knowledge knowledge : knowledgeList.get(0).getChildren()) {
			if (knowledge.getCourseId() == courseId) {

				new_knowledges.add(knowledge);
				break;
			}
		}
		// System.out.println("-------123-------->" + knowledges);

		String json = JSON.toJSONString(new_knowledges);
		return json;
	}

	private List<Knowledge> buildTree(List<Knowledge> knowledges, Long pid) {
		List<Knowledge> treeList = new ArrayList<>();
		knowledges.forEach(knowledge -> {
			if (Objects.equals(pid, knowledge.getFatherId())) {
				knowledge.setChildren(buildTree(knowledges, knowledge.getKnowledgeId()));
				treeList.add(knowledge);
			}
		});
		return treeList;
	}

	private void delectList(Long knowledgeId) {
		List<Knowledge> knowledges = knowledgeService.knowledge_findlist(knowledgeId);
		knowledges.forEach(knowledge -> {
			delectList(knowledge.getKnowledgeId());
		});
		knowledgeService.knowledge_delete(knowledgeId);
	}
}
