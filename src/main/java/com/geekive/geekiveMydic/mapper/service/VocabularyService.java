package com.geekive.geekiveMydic.mapper.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekive.geekiveMydic.common.CryptoUtil;
import com.geekive.geekiveMydic.common.Util;
import com.geekive.geekiveMydic.geekiveCustom.GeekiveConnector;
import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;
import com.geekive.geekiveMydic.mapper.SignMapper;
import com.geekive.geekiveMydic.mapper.VocabularyMapper;


@Service
public class VocabularyService implements VocabularyMapper{
	
	@Autowired
	VocabularyMapper vocabularyMapper;

	@Override
	public List<GeekiveMap> selectVocabularyList(GeekiveMap gMap) {
		return vocabularyMapper.selectVocabularyList(gMap);
	}

	@Override
	public List<GeekiveMap> selectSourceList(GeekiveMap gMap) {
		return vocabularyMapper.selectSourceList(gMap);
	}

	@Override
	public void insertVocabulary(GeekiveMap gMap) {
		try {
			vocabularyMapper.insertVocabulary(gMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
