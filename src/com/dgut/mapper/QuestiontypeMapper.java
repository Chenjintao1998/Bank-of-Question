package com.dgut.mapper;

import com.dgut.bean.Questiontype;
import com.dgut.bean.QuestiontypeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface QuestiontypeMapper {
    int countByExample(QuestiontypeExample example);

    int deleteByExample(QuestiontypeExample example);

    int deleteByPrimaryKey(Long questiontypeId);

    int insert(Questiontype record);

    int insertSelective(Questiontype record);

    List<Questiontype> selectByExample(QuestiontypeExample example);

    Questiontype selectByPrimaryKey(Long questiontypeId);

    int updateByExampleSelective(@Param("record") Questiontype record, @Param("example") QuestiontypeExample example);

    int updateByExample(@Param("record") Questiontype record, @Param("example") QuestiontypeExample example);

    int updateByPrimaryKeySelective(Questiontype record);

    int updateByPrimaryKey(Questiontype record);
}