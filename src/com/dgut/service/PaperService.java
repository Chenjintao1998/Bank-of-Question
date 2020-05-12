package com.dgut.service;

import java.util.ArrayList;
import java.util.List;

import com.dgut.bean.Paper;

public interface PaperService {
	int paper_add(Paper paper);

	List<Paper> paper_findall();

	int paper_delete(int i);

	List<Paper> paper_query(String start_time, String end_time, Paper paper, ArrayList<String> knowledge);

	Paper findbyid(Long id);

	int updatepaper(Paper paper);
}
