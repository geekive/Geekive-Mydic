package com.geekive.geekiveMydic.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;

@Mapper
public interface LogMapper {
	public void insertLogArchiveVisit(GeekiveMap gMap);
	public void insertLogArticleView(GeekiveMap gMap);
}
