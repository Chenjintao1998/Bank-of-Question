package com.dgut.bean;

import java.util.Date;
import java.util.List;

public class Question {
	private Long qid;

	private Long courseId;

	private Long questiontypeId;

	private String question;

	private String slelects;

	private String answer;

	private String analysis;

	private String knowledgeId;

	private String difficulty;

	private Date createDate;

	private Date modifyDate;

	private Course course;

	private Questiontype questiontype;

	private List<String> questionimgpathList;

	private List<String> answerimgpathList;

	private List<String> slelectsimgpathList;

	private List<String> analysisimgpathList;

	private List<String> slelectslist;

	private String imagePath;

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public Questiontype getQuestiontype() {
		return questiontype;
	}

	public void setQuestiontype(Questiontype questiontype) {
		this.questiontype = questiontype;
	}

	public List<String> getQuestionimgpathList() {
		return questionimgpathList;
	}

	public void setQuestionimgpathList(List<String> questionimgpathList) {
		this.questionimgpathList = questionimgpathList;
	}

	public List<String> getAnswerimgpathList() {
		return answerimgpathList;
	}

	public void setAnswerimgpathList(List<String> answerimgpathList) {
		this.answerimgpathList = answerimgpathList;
	}

	public List<String> getSlelectsimgpathList() {
		return slelectsimgpathList;
	}

	public void setSlelectsimgpathList(List<String> slelectsimgpathList) {
		this.slelectsimgpathList = slelectsimgpathList;
	}

	public List<String> getAnalysisimgpathList() {
		return analysisimgpathList;
	}

	public void setAnalysisimgpathList(List<String> analysisimgpathList) {
		this.analysisimgpathList = analysisimgpathList;
	}

	public List<String> getSlelectslist() {
		return slelectslist;
	}

	public void setSlelectslist(List<String> slelectslist) {
		this.slelectslist = slelectslist;
	}

	public Long getQid() {
		return qid;
	}

	public void setQid(Long qid) {
		this.qid = qid;
	}

	public Long getCourseId() {
		return courseId;
	}

	public void setCourseId(Long courseId) {
		this.courseId = courseId;
	}

	public Long getQuestiontypeId() {
		return questiontypeId;
	}

	public void setQuestiontypeId(Long questiontypeId) {
		this.questiontypeId = questiontypeId;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question == null ? null : question.trim();
	}

	public String getSlelects() {
		return slelects;
	}

	public void setSlelects(String slelects) {
		this.slelects = slelects == null ? null : slelects.trim();
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer == null ? null : answer.trim();
	}

	public String getAnalysis() {
		return analysis;
	}

	public void setAnalysis(String analysis) {
		this.analysis = analysis == null ? null : analysis.trim();
	}

	public String getKnowledgeId() {
		return knowledgeId;
	}

	public void setKnowledgeId(String knowledgeId) {
		this.knowledgeId = knowledgeId == null ? null : knowledgeId.trim();
	}

	public String getDifficulty() {
		return difficulty;
	}

	public void setDifficulty(String difficulty) {
		this.difficulty = difficulty == null ? null : difficulty.trim();
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath == null ? null : imagePath.trim();
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