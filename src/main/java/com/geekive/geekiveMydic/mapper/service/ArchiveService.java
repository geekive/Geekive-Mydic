package com.geekive.geekiveMydic.mapper.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;
import com.geekive.geekiveMydic.mapper.ArchiveMapper;


@Service
public class ArchiveService implements ArchiveMapper{
	
	@Autowired
	ArchiveMapper archiveMapper;

	@Override
	public String selectUserUid(GeekiveMap gMap) {
		return archiveMapper.selectUserUid(gMap);
	}

	@Override
	public String selectArchiveLogo(GeekiveMap gMap) {
		return archiveMapper.selectArchiveLogo(gMap);
	}

	@Override
	public String selectArchiveUrlPath(GeekiveMap gMap) {
		return archiveMapper.selectArchiveUrlPath(gMap);
	}

	@Override
	public String selectCategoryUid(GeekiveMap gMap) {
		return archiveMapper.selectCategoryUid(gMap);
	}
	
	@Override
	public Boolean checkArticleExistence(GeekiveMap gMap) {
		return archiveMapper.checkArticleExistence(gMap);
	}

	@Override
	public String selectCategoryName(GeekiveMap gMap) {
		return archiveMapper.selectCategoryName(gMap);
	}

	@Override
	public String selectArticleUid(GeekiveMap gMap) {
		return archiveMapper.selectArticleUid(gMap);
	}

	@Override
	public int selectArticleListCount(GeekiveMap gMap) {
		return archiveMapper.selectArticleListCount(gMap);
	}

	@Override
	public List<GeekiveMap> selectArticleList(GeekiveMap gMap) {
		return archiveMapper.selectArticleList(gMap);
	}

	@Override
	public GeekiveMap selectArticle(GeekiveMap gMap) {
		return archiveMapper.selectArticle(gMap);
	}
}
