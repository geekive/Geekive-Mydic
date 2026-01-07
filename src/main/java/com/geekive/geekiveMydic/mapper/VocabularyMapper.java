package com.geekive.geekiveMydic.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;

@Mapper
public interface VocabularyMapper {
	public void insertVocabulary(GeekiveMap gMap);
}
