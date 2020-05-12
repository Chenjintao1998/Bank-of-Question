package com.dgut.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgut.bean.QuestionExample;
import com.dgut.bean.Questiontype;
import com.dgut.bean.QuestiontypeExample;
import com.dgut.bean.QuestiontypeExample.Criteria;
import com.dgut.mapper.QuestionMapper;
import com.dgut.mapper.QuestiontypeMapper;

@Service
public class QuestiontypeServiceImpl implements QuestiontypeService {

	@Autowired
	private QuestiontypeMapper questiontypeMapper;

	@Autowired
	private QuestionMapper questionMapper;

	private QuestiontypeExample example = new QuestiontypeExample();

	private QuestionExample qexample = new QuestionExample();

	@Override
	public List<Questiontype> questiontype_findall() {
		// TODO Auto-generated method stub
		example.clear();
		return questiontypeMapper.selectByExample(example);
	}

	@Override
	public List<Questiontype> questiontype_query(Questiontype questiontype) {
		// TODO Auto-generated method stub
		example.clear();
		Criteria criteria = example.createCriteria();
		if (questiontype.getQuestiontypeId() != null)
			criteria.andQuestiontypeIdEqualTo(questiontype.getQuestiontypeId());
		if (questiontype.getQuestiontypeName() != null && questiontype.getQuestiontypeName() != "")
			criteria.andQuestiontypeNameLike(questiontype.getQuestiontypeName());
		return questiontypeMapper.selectByExample(example);
	}

	@Override
	public int questiontype_delete(int questiontypeId) {
		// TODO Auto-generated method stub
		qexample.clear();
		Long id = new Long((long) questiontypeId);
		com.dgut.bean.QuestionExample.Criteria criteria = qexample.createCriteria();
		criteria.andQuestiontypeIdEqualTo(id);

		questionMapper.deleteByExample(qexample);
		int j = questiontypeMapper.deleteByPrimaryKey(id);
		if (j == 0)
			return 0;
		return 1;
	}

	@Override
	public int questiontype_add(Questiontype questiontype) {
		// TODO Auto-generated method stub
		return questiontypeMapper.insert(questiontype);
	}

	@Override
	public int questiontype_update(Questiontype questiontype) {
		// TODO Auto-generated method stub
		return questiontypeMapper.updateByPrimaryKeySelective(questiontype);
	}

	@Override
	public int questiontype_find(Long id, String questionName) {
		// TODO Auto-generated method stub
		example.clear();
		int flag = 1;
		Criteria criteria = example.createCriteria();
		criteria.andQuestiontypeNameEqualTo(questionName);
		List<Questiontype> questiontypes = questiontypeMapper.selectByExample(example);

		if (questiontypes.size() != 0) {
			for (Questiontype questiontype : questiontypes) {
				if (questiontype.getQuestiontypeId() != id && questiontype.getQuestiontypeName().equals(questionName))
					flag = 0;
			}
		}
		return flag;
	}

}
