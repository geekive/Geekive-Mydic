package com.geekive.geekiveMydic.mapper.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;
import com.geekive.geekiveMydic.mapper.ArchiveMapper;
import com.geekive.geekiveMydic.mapper.HomeMapper;


@Service
public class HomeService implements HomeMapper{
	
	@Autowired
	HomeMapper homeMapper;

	@Override
	public List<GeekiveMap> selectNewArticle() {
		return homeMapper.selectNewArticle();
	}

	@Override
	public List<GeekiveMap> selectRandomArchive() {
		return homeMapper.selectRandomArchive();
	}
}
