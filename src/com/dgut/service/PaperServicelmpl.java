package com.dgut.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgut.bean.Paper;
import com.dgut.bean.PaperExample;
import com.dgut.mapper.PaperCustomMapper;
import com.dgut.mapper.PaperMapper;

@Service
public class PaperServicelmpl implements PaperService {

	@Autowired
	private PaperMapper paperMapper;

	@Autowired
	private PaperCustomMapper customMapper;

	private PaperExample example = new PaperExample();

	@Override
	public int paper_add(Paper paper) {
		// TODO Auto-generated method stub
		return customMapper.addpaper(paper);
	}

	@Override
	public List<Paper> paper_findall() {
		// TODO Auto-generated method stub
		example.clear();
		return paperMapper.selectByExample(example);
	}

	@Override
	public int paper_delete(int i) {
		// TODO Auto-generated method stub
		Long id = new Long((long) i);
		return paperMapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<Paper> paper_query(String start_time, String end_time, Paper paper, ArrayList<String> knowledge) {
		// TODO Auto-generated method stub
		return customMapper.findPaperLike(start_time, end_time, paper, knowledge);
	}

	@Override
	public Paper findbyid(Long id) {
		// TODO Auto-generated method stub
		return paperMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updatepaper(Paper paper) {
		// TODO Auto-generated method stub
		return paperMapper.updateByPrimaryKey(paper);
	}

}
