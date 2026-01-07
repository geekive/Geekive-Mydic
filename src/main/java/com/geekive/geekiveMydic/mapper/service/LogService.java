package com.geekive.geekiveMydic.mapper.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;
import com.geekive.geekiveMydic.mapper.LogMapper;


@Service
public class LogService implements LogMapper{
	
	@Autowired
	LogMapper logMapper;

	@Override
	public void insertLogArchiveVisit(GeekiveMap gMap) {
		logMapper.insertLogArchiveVisit(gMap);
	}

	@Override
	public void insertLogArticleView(GeekiveMap gMap) {
		logMapper.insertLogArticleView(gMap);
	}
}
