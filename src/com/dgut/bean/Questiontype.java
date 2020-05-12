package com.dgut.bean;

import java.util.List;

public class Questiontype {
	private Long questiontypeId;

	private String questiontypeName;

	private Boolean options;

	private Boolean multiple;

	private List<Question> questionlist;

	private int score;

	private int singlscore;

	private int extrascore;

	public int getExtrascore() {
		return extrascore;
	}

	public void setExtrascore(int extrascore) {
		this.extrascore = extrascore;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public int getSinglscore() {
		return singlscore;
	}

	public void setSinglscore(int singlscore) {
		this.singlscore = singlscore;
	}

	public List<Question> getQuestionlist() {
		return questionlist;
	}

	public void setQuestionlist(List<Question> questionlist) {
		this.questionlist = questionlist;
	}

	public Long getQuestiontypeId() {
		return questiontypeId;
	}

	public void setQuestiontypeId(Long questiontypeId) {
		this.questiontypeId = questiontypeId;
	}

	public String getQuestiontypeName() {
		return questiontypeName;
	}

	public void setQuestiontypeName(String questiontypeName) {
		this.questiontypeName = questiontypeName == null ? null : questiontypeName.trim();
	}

	public Boolean getOptions() {
		return options;
	}

	public void setOptions(Boolean options) {
		this.options = options;
	}

	public Boolean getMultiple() {
		return multiple;
	}

	public void setMultiple(Boolean multiple) {
		this.multiple = multiple;
	}

	@Override
	public String toString() {
		return "Questiontype [questiontypeId=" + questiontypeId + ", questiontypeName=" + questiontypeName
				+ ", options=" + options + ", multiple=" + multiple + ", questionlist=" + questionlist + ", score="
				+ score + ", singlscore=" + singlscore + ", extrascore=" + extrascore + "]";
	}

}