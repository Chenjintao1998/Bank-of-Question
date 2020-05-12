package com.dgut.mapper;

import com.dgut.bean.Knowledge;
import com.dgut.bean.KnowledgeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface KnowledgeMapper {
    int countByExample(KnowledgeExample example);

    int deleteByExample(KnowledgeExample example);

    int deleteByPrimaryKey(Long knowledgeId);

    int insert(Knowledge record);

    int insertSelective(Knowledge record);

    List<Knowledge> selectByExample(KnowledgeExample example);

    Knowledge selectByPrimaryKey(Long knowledgeId);

    int updateByExampleSelective(@Param("record") Knowledge record, @Param("example") KnowledgeExample example);

    int updateByExample(@Param("record") Knowledge record, @Param("example") KnowledgeExample example);

    int updateByPrimaryKeySelective(Knowledge record);

    int updateByPrimaryKey(Knowledge record);
}