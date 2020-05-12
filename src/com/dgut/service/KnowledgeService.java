package com.dgut.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dgut.bean.Knowledge;

@Service
public interface KnowledgeService {
	List<Knowledge> knowledge_findall();

	int knowledge_add(Knowledge knowledge);

	int knowledge_update(Knowledge knowledge);

	int knowledge_delete(Long knowledgeId);

	List<Knowledge> knowledge_findlist(Long knowledgeId);

	List<Knowledge> knowledge_findbycourseId(Long courseId);

	Knowledge knowledge_findbyid(Long id);

}
