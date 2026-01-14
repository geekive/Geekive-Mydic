package com.geekive.geekiveMydic.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;

@Mapper
public interface SignMapper {
	public Boolean checkEmailExistence(GeekiveMap gMap);
	public GeekiveMap selectUser(GeekiveMap gMap);
	public void insertUser(GeekiveMap gMap);
}
