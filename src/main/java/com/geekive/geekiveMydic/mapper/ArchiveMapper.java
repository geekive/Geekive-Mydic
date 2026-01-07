package com.geekive.geekiveMydic.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;

@Mapper
public interface ArchiveMapper {
	public String selectUserUid(GeekiveMap gMap);
	public String selectArchiveLogo(GeekiveMap gMap);
	public String selectArchiveUrlPath(GeekiveMap gMap);
	public String selectCategoryUid(GeekiveMap gMap);
	public Boolean checkArticleExistence(GeekiveMap gMap);
	public String selectCategoryName(GeekiveMap gMap);
	public String selectArticleUid(GeekiveMap gMap);
	public int selectArticleListCount(GeekiveMap gMap);
	public List<GeekiveMap> selectArticleList(GeekiveMap gMap);
	public GeekiveMap selectArticle(GeekiveMap gMap);
}
