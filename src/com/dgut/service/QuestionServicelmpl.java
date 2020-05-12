package com.dgut.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgut.bean.Question;
import com.dgut.bean.QuestionExample;
import com.dgut.bean.QuestionExample.Criteria;
import com.dgut.mapper.QuestionCustomMapper;
import com.dgut.mapper.QuestionMapper;

@Service
public class QuestionServicelmpl implements QuestionService {

	@Autowired
	private QuestionMapper questionMapper;

	@Autowired
	private QuestionCustomMapper customMapper;

	private QuestionExample example = new QuestionExample();

	@Override
	public List<Question> question_findall() {
		// TODO Auto-generated method stub
		return customMapper.findQuestions();
	}

	@Override
	public List<Question> question_query(String start_time, String end_time, Question question,
			ArrayList<String> knowledge) {
		// TODO Auto-generated method stub
		return customMapper.findQuestionLike(start_time, end_time, question, knowledge);
	}

	@Override
	public int question_delete(int qid) {
		// TODO Auto-generated method stub
		Long id = new Long((long) qid);
		return questionMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int question_add(Question question) {
		// TODO Auto-generated method stub

		return questionMapper.insert(question);
	}

	@Override
	public int question_update(Question question) {
		// TODO Auto-generated method stub
		return questionMapper.updateByPrimaryKeySelective(question);
	}

	@Override
	public Question question_find(Long qid) {
		// TODO Auto-generated method stub
		return customMapper.findQuestion(qid);
	}

	@Override
	public List<Question> question_findbytype_course(Long questiontypeId, Long courseId) {
		// TODO Auto-generated method stub
		example.clear();
		if (questiontypeId != null && courseId != null) {
			Criteria criteria = example.createCriteria();
			criteria.andQuestiontypeIdEqualTo(questiontypeId);
			criteria.andCourseIdEqualTo(courseId);
			return questionMapper.selectByExample(example);
		} else if (questiontypeId != null && courseId == null) {
			Criteria criteria = example.createCriteria();
			criteria.andQuestiontypeIdEqualTo(questiontypeId);
			return questionMapper.selectByExample(example);
		} else if (questiontypeId == null && courseId != null) {
			Criteria criteria = example.createCriteria();
			criteria.andCourseIdEqualTo(courseId);
			return questionMapper.selectByExample(example);
		} else {
			return questionMapper.selectByExample(example);
		}
	}

	@Override
	public List<Question> extractingquestion(String qtype, String dif, String knowledge) {
		// TODO Auto-generated method stub
		String[] knowledgeId = knowledge.split(",");

		ArrayList<String> knowledge1 = new ArrayList<String>();
		if (knowledgeId[0] != "")
			for (int i = 0; i < knowledgeId.length; i++) {
				knowledge1.add(knowledgeId[i]);
			}
		dif = "%" + dif + "%";
		return customMapper.extracting(Long.parseLong(qtype), dif, knowledge1);
	}

}
