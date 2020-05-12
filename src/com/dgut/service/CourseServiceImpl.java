package com.dgut.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgut.bean.Course;
import com.dgut.bean.CourseExample;
import com.dgut.bean.CourseExample.Criteria;
import com.dgut.bean.QuestionExample;
import com.dgut.mapper.CourseCustomMapper;
import com.dgut.mapper.CourseMapper;
import com.dgut.mapper.QuestionMapper;

@Service
public class CourseServiceImpl implements CourseService {

	@Autowired
	private CourseMapper courseMapper;

	@Autowired
	private QuestionMapper questionMapper;

	@Autowired
	private CourseCustomMapper customMapper;

	private CourseExample example = new CourseExample();

	private QuestionExample qexample = new QuestionExample();

	@Override
	public int course_add(Course course) {
		// Criteria criteria=exampl.createCriteria();

		return customMapper.addCourse(course);
	}

	@Override
	public List<Course> course_findall() {
		// TODO Auto-generated method stub
		example.clear();
		return courseMapper.selectByExample(example);
	}

	@Override
	public int course_delete(int courseId) {
		// TODO Auto-generated method stub
		qexample.clear();
		Long id = new Long((long) courseId);
		com.dgut.bean.QuestionExample.Criteria criteria = qexample.createCriteria();
		criteria.andCourseIdEqualTo(id);

		questionMapper.deleteByExample(qexample);
		int j = courseMapper.deleteByPrimaryKey(id);
		if (j == 0)
			return 0;
		return 1;
	}

	@Override
	public List<Course> course_query(String start_time, String end_time, Course course) {
		// TODO Auto-generated method stub

		return customMapper.findCourseLike(start_time, end_time, course);

	}

	@Override
	public int course_update(Course course) {
		// TODO Auto-generated method stub
		return courseMapper.updateByPrimaryKeySelective(course);
	}

	@Override
	public int course_find(Long id, String courseName) {

		// TODO Auto-generated method stub
		example.clear();
		int flag = 1;
		Criteria criteria = example.createCriteria();
		criteria.andCourseNameEqualTo(courseName);
		List<Course> courses = courseMapper.selectByExample(example);
		if (courses.size() != 0) {
			for (Course course : courses) {
				if (course.getCourseId() != id && course.getCourseName().equals(courseName))
					flag = 0;
			}
		}
		return flag;
	}

	@Override
	public Course course_getbyId(Long courseId) {
		// TODO Auto-generated method stub
		return courseMapper.selectByPrimaryKey(courseId);
	}

}
