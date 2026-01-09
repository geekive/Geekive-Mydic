package com.geekive.geekiveMydic.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;

@Mapper
public interface VocabularyMapper {
	public List<GeekiveMap> selectVocabularyList(GeekiveMap gMap);
	public List<GeekiveMap> selectSourceList(GeekiveMap gMap);
	public void insertVocabulary(GeekiveMap gMap);
	public void updateVocabulary(GeekiveMap gMap);
	public void deleteVocabulary(GeekiveMap gMap);
}
