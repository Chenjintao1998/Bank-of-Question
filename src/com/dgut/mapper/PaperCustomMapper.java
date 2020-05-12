package com.dgut.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dgut.bean.Paper;

public interface PaperCustomMapper {

	List<Paper> findPaperLike(@Param("start_time") String start_time, @Param("end_time") String end_time,
			@Param("paper") Paper paper, @Param("knowledge") ArrayList<String> knowledge);

	int addpaper(Paper paper);

}
