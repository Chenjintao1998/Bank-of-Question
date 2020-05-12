package com.dgut.bean;

import java.util.ArrayList;
import java.util.List;

public class QuestiontypeExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public QuestiontypeExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andQuestiontypeIdIsNull() {
            addCriterion("questiontype_id is null");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeIdIsNotNull() {
            addCriterion("questiontype_id is not null");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeIdEqualTo(Long value) {
            addCriterion("questiontype_id =", value, "questiontypeId");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeIdNotEqualTo(Long value) {
            addCriterion("questiontype_id <>", value, "questiontypeId");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeIdGreaterThan(Long value) {
            addCriterion("questiontype_id >", value, "questiontypeId");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeIdGreaterThanOrEqualTo(Long value) {
            addCriterion("questiontype_id >=", value, "questiontypeId");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeIdLessThan(Long value) {
            addCriterion("questiontype_id <", value, "questiontypeId");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeIdLessThanOrEqualTo(Long value) {
            addCriterion("questiontype_id <=", value, "questiontypeId");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeIdIn(List<Long> values) {
            addCriterion("questiontype_id in", values, "questiontypeId");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeIdNotIn(List<Long> values) {
            addCriterion("questiontype_id not in", values, "questiontypeId");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeIdBetween(Long value1, Long value2) {
            addCriterion("questiontype_id between", value1, value2, "questiontypeId");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeIdNotBetween(Long value1, Long value2) {
            addCriterion("questiontype_id not between", value1, value2, "questiontypeId");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameIsNull() {
            addCriterion("questiontype_name is null");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameIsNotNull() {
            addCriterion("questiontype_name is not null");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameEqualTo(String value) {
            addCriterion("questiontype_name =", value, "questiontypeName");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameNotEqualTo(String value) {
            addCriterion("questiontype_name <>", value, "questiontypeName");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameGreaterThan(String value) {
            addCriterion("questiontype_name >", value, "questiontypeName");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameGreaterThanOrEqualTo(String value) {
            addCriterion("questiontype_name >=", value, "questiontypeName");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameLessThan(String value) {
            addCriterion("questiontype_name <", value, "questiontypeName");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameLessThanOrEqualTo(String value) {
            addCriterion("questiontype_name <=", value, "questiontypeName");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameLike(String value) {
            addCriterion("questiontype_name like", value, "questiontypeName");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameNotLike(String value) {
            addCriterion("questiontype_name not like", value, "questiontypeName");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameIn(List<String> values) {
            addCriterion("questiontype_name in", values, "questiontypeName");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameNotIn(List<String> values) {
            addCriterion("questiontype_name not in", values, "questiontypeName");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameBetween(String value1, String value2) {
            addCriterion("questiontype_name between", value1, value2, "questiontypeName");
            return (Criteria) this;
        }

        public Criteria andQuestiontypeNameNotBetween(String value1, String value2) {
            addCriterion("questiontype_name not between", value1, value2, "questiontypeName");
            return (Criteria) this;
        }

        public Criteria andOptionsIsNull() {
            addCriterion("options is null");
            return (Criteria) this;
        }

        public Criteria andOptionsIsNotNull() {
            addCriterion("options is not null");
            return (Criteria) this;
        }

        public Criteria andOptionsEqualTo(Boolean value) {
            addCriterion("options =", value, "options");
            return (Criteria) this;
        }

        public Criteria andOptionsNotEqualTo(Boolean value) {
            addCriterion("options <>", value, "options");
            return (Criteria) this;
        }

        public Criteria andOptionsGreaterThan(Boolean value) {
            addCriterion("options >", value, "options");
            return (Criteria) this;
        }

        public Criteria andOptionsGreaterThanOrEqualTo(Boolean value) {
            addCriterion("options >=", value, "options");
            return (Criteria) this;
        }

        public Criteria andOptionsLessThan(Boolean value) {
            addCriterion("options <", value, "options");
            return (Criteria) this;
        }

        public Criteria andOptionsLessThanOrEqualTo(Boolean value) {
            addCriterion("options <=", value, "options");
            return (Criteria) this;
        }

        public Criteria andOptionsIn(List<Boolean> values) {
            addCriterion("options in", values, "options");
            return (Criteria) this;
        }

        public Criteria andOptionsNotIn(List<Boolean> values) {
            addCriterion("options not in", values, "options");
            return (Criteria) this;
        }

        public Criteria andOptionsBetween(Boolean value1, Boolean value2) {
            addCriterion("options between", value1, value2, "options");
            return (Criteria) this;
        }

        public Criteria andOptionsNotBetween(Boolean value1, Boolean value2) {
            addCriterion("options not between", value1, value2, "options");
            return (Criteria) this;
        }

        public Criteria andMultipleIsNull() {
            addCriterion("multiple is null");
            return (Criteria) this;
        }

        public Criteria andMultipleIsNotNull() {
            addCriterion("multiple is not null");
            return (Criteria) this;
        }

        public Criteria andMultipleEqualTo(Boolean value) {
            addCriterion("multiple =", value, "multiple");
            return (Criteria) this;
        }

        public Criteria andMultipleNotEqualTo(Boolean value) {
            addCriterion("multiple <>", value, "multiple");
            return (Criteria) this;
        }

        public Criteria andMultipleGreaterThan(Boolean value) {
            addCriterion("multiple >", value, "multiple");
            return (Criteria) this;
        }

        public Criteria andMultipleGreaterThanOrEqualTo(Boolean value) {
            addCriterion("multiple >=", value, "multiple");
            return (Criteria) this;
        }

        public Criteria andMultipleLessThan(Boolean value) {
            addCriterion("multiple <", value, "multiple");
            return (Criteria) this;
        }

        public Criteria andMultipleLessThanOrEqualTo(Boolean value) {
            addCriterion("multiple <=", value, "multiple");
            return (Criteria) this;
        }

        public Criteria andMultipleIn(List<Boolean> values) {
            addCriterion("multiple in", values, "multiple");
            return (Criteria) this;
        }

        public Criteria andMultipleNotIn(List<Boolean> values) {
            addCriterion("multiple not in", values, "multiple");
            return (Criteria) this;
        }

        public Criteria andMultipleBetween(Boolean value1, Boolean value2) {
            addCriterion("multiple between", value1, value2, "multiple");
            return (Criteria) this;
        }

        public Criteria andMultipleNotBetween(Boolean value1, Boolean value2) {
            addCriterion("multiple not between", value1, value2, "multiple");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}