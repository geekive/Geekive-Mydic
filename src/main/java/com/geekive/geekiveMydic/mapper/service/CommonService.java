package com.geekive.geekiveMydic.mapper.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;
import com.geekive.geekiveMydic.mapper.CommonMapper;

@Service
public class CommonService implements CommonMapper{
	
	@Autowired
	CommonMapper commonMapper;

	@Override
	public List<GeekiveMap> selectSocialMedia(GeekiveMap gMap) {
		return commonMapper.selectSocialMedia(gMap);
	}

	@Override
	public List<GeekiveMap> selectAllCategory(GeekiveMap gMap) {
	    List<GeekiveMap> categoryAllList = commonMapper.selectAllCategory(gMap);

	    Map<Integer, List<GeekiveMap>> categoryMapByDepth = categoryAllList.stream()
	            .collect(Collectors.groupingBy(map -> map.getInt("depth")));

	    List<GeekiveMap> categoryDepth1List = categoryMapByDepth.getOrDefault(1, Collections.emptyList());
	    List<GeekiveMap> categoryDepth2List = categoryMapByDepth.getOrDefault(2, Collections.emptyList());

	    Map<String, List<GeekiveMap>> childMap = categoryDepth2List.stream()
	            .collect(Collectors.groupingBy(map -> map.getString("parentCategoryUid")));

	    categoryDepth1List.forEach(depth1Map ->
	            depth1Map.put("childList", childMap.getOrDefault(depth1Map.getString("categoryUid"), Collections.emptyList()))
	    );

	    return categoryDepth1List;
	}
}
