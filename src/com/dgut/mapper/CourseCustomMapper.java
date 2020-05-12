package com.dgut.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dgut.bean.Course;

public interface CourseCustomMapper {
	List<Course> findCourseLike(@Param("start_time") String start_time, @Param("end_time") String end_time,
			@Param("course") Course course);

	int addCourse(Course course);
}
