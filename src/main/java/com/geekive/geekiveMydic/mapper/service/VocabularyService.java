package com.geekive.geekiveMydic.mapper.service;

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
	public void insertVocabulary(GeekiveMap gMap) {
		try {
			vocabularyMapper.insertVocabulary(gMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
