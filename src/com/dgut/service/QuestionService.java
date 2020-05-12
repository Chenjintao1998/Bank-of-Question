package com.dgut.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.dgut.bean.Question;

@Service
public interface QuestionService {
	List<Question> question_findall();

	List<Question> question_query(String start_time, String end_time, Question question, ArrayList<String> knowledge);

	int question_delete(int qid);

	int question_add(Question question);

	int question_update(Question question);

	Question question_find(Long qid);

	List<Question> question_findbytype_course(Long questiontypeId, Long courseId);

	List<Question> extractingquestion(String qtype, String dif, String knowledge);
}
