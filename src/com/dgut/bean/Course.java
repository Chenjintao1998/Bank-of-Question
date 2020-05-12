package com.dgut.bean;

import java.util.Date;

public class Course {
	private Long courseId;

	private Long knowledgeId;

	private String courseName;

	private String information;

	private Date createDate;

	private Date modifyDate;

	@Override
	public String toString() {
		return "Course [courseId=" + courseId + ", knowledgeId=" + knowledgeId + ", courseName=" + courseName
				+ ", information=" + information + ", createDate=" + createDate + ", modifyDate=" + modifyDate + "]";
	}

	public Long getCourseId() {
		return courseId;
	}

	public void setCourseId(Long courseId) {
		this.courseId = courseId;
	}

	public Long getKnowledgeId() {
		return knowledgeId;
	}

	public void setKnowledgeId(Long knowledgeId) {
		this.knowledgeId = knowledgeId;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName == null ? null : courseName.trim();
	}

	public String getInformation() {
		return information;
	}

	public void setInformation(String information) {
		this.information = information == null ? null : information.trim();
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
}