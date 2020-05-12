package com.dgut.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgut.bean.Knowledge;
import com.dgut.bean.KnowledgeExample;
import com.dgut.bean.KnowledgeExample.Criteria;
import com.dgut.bean.Question;
import com.dgut.mapper.KnowledgeCustomMapper;
import com.dgut.mapper.KnowledgeMapper;
import com.dgut.mapper.QuestionCustomMapper;
import com.dgut.mapper.QuestionMapper;

@Service
public class KnowledgeServiceImpl implements KnowledgeService {

	@Autowired
	private KnowledgeMapper knowledgeMapper;

	@Autowired
	private KnowledgeCustomMapper customMapper;

	@Autowired
	private QuestionCustomMapper questioncustomMapper;

	@Autowired
	private QuestionMapper questionMapper;

	private KnowledgeExample example = new KnowledgeExample();

	@Override
	public List<Knowledge> knowledge_findall() {
		// TODO Auto-generated method stub
		example.clear();
		return knowledgeMapper.selectByExample(example);
	}

	@Override
	public int knowledge_add(Knowledge knowledge) {
		// TODO Auto-generated method stub

		return customMapper.addKnowledge(knowledge);
	}

	@Override
	public int knowledge_update(Knowledge knowledge) {
		// TODO Auto-generated method stub
		return knowledgeMapper.updateByPrimaryKeySelective(knowledge);
	}

	@Override
	public int knowledge_delete(Long knowledgeId) {
		// TODO Auto-generated method stub
		List<Question> questions = questioncustomMapper.findKnowledge(String.valueOf(knowledgeId));

		for (Question question : questions) {
			String[] arry = question.getKnowledgeId().split(",");
			String newknowledgeId = null;
			for (int i = 0; i < arry.length; i++) {
				if (!arry[i].equals(String.valueOf(knowledgeId))) {
					if (newknowledgeId == null)
						newknowledgeId = arry[i];
					else
						newknowledgeId = newknowledgeId + "," + arry[i];

				} else if (arry.length == 1) {
					newknowledgeId = "1";
				}

			}
			question.setKnowledgeId(newknowledgeId);
			questionMapper.updateByPrimaryKeySelective(question);

		}
		return knowledgeMapper.deleteByPrimaryKey(knowledgeId);
	}

	@Override
	public List<Knowledge> knowledge_findlist(Long knowledgeId) {
		// TODO Auto-generated method stub
		example.clear();
		Criteria criteria = example.createCriteria();
		criteria.andFatherIdEqualTo(knowledgeId);
		return knowledgeMapper.selectByExample(example);
	}

	@Override
	public List<Knowledge> knowledge_findbycourseId(Long courseId) {
		// TODO Auto-generated method stub
		example.clear();
		Criteria criteria = example.createCriteria();
		criteria.andCourseIdEqualTo(courseId);
		return knowledgeMapper.selectByExample(example);
	}

	@Override
	public Knowledge knowledge_findbyid(Long id) {
		// TODO Auto-generated method stub
		return knowledgeMapper.selectByPrimaryKey(id);
	}
}
