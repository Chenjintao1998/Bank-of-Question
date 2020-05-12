package com.dgut.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dgut.bean.Questiontype;

@Service
public interface QuestiontypeService {
	List<Questiontype> questiontype_findall();

	List<Questiontype> questiontype_query(Questiontype questiontype);

	int questiontype_delete(int questiontypeId);

	int questiontype_add(Questiontype questiontype);

	int questiontype_update(Questiontype questiontype);

	int questiontype_find(Long id, String questionName);
}
