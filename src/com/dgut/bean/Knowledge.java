package com.dgut.bean;

import java.util.ArrayList;
import java.util.List;

public class Knowledge {
	private Long knowledgeId;

	private Long courseId;

	private String knowledgeName;

	private Long fatherId;

	private List<Knowledge> children = new ArrayList<Knowledge>();

	@Override
	public String toString() {
		return "Knowledge [knowledgeId=" + knowledgeId + ", courseId=" + courseId + ", knowledgeName=" + knowledgeName
				+ ", fatherId=" + fatherId + ", children=" + children + "]";
	}

	public List<Knowledge> getChildren() {
		return children;
	}

	public void setChildren(List<Knowledge> children) {
		this.children = children;
	}

	public Long getKnowledgeId() {
		return knowledgeId;
	}

	public void setKnowledgeId(Long knowledgeId) {
		this.knowledgeId = knowledgeId;
	}

	public Long getCourseId() {
		return courseId;
	}

	public void setCourseId(Long courseId) {
		this.courseId = courseId;
	}

	public String getKnowledgeName() {
		return knowledgeName;
	}

	public void setKnowledgeName(String knowledgeName) {
		this.knowledgeName = knowledgeName == null ? null : knowledgeName.trim();
	}

	public Long getFatherId() {
		return fatherId;
	}

	public void setFatherId(Long fatherId) {
		this.fatherId = fatherId;
	}
}