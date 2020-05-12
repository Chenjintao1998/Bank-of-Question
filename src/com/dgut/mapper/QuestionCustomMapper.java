package com.dgut.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dgut.bean.Question;

public interface QuestionCustomMapper {
	List<Question> findQuestions();

	List<Question> findQuestionLike(@Param("start_time") String start_time, @Param("end_time") String end_time,
			@Param("question") Question question, @Param("knowledge") ArrayList<String> knowledge);

	List<Question> findKnowledge(@Param("knowledgeId") String knowledgeId);

	Question findQuestion(@Param("qid") Long qid);

	List<Question> extracting(@Param("qtype") long qtype, @Param("dif") String dif,
			@Param("knowledge") ArrayList<String> knowledge);
}
