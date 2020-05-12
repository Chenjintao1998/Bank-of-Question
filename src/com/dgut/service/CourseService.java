package com.dgut.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dgut.bean.Course;

@Service
public interface CourseService {
	int course_add(Course course);

	int course_delete(int courseId);

	List<Course> course_findall();

	List<Course> course_query(String start_time, String end_time, Course course);

	int course_update(Course course);

	int course_find(Long id, String courseName);

	Course course_getbyId(Long courseId);
}
