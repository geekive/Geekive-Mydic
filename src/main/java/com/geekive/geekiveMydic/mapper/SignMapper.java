package com.geekive.geekiveMydic.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;

@Mapper
public interface SignMapper {
	public Boolean checkEmailExistence(GeekiveMap gMap);
	public GeekiveMap selectUser(GeekiveMap gMap);
	public void insertUser(GeekiveMap gMap);
	
	// NEW: autologin token persistence
	void upsertAutologinToken(GeekiveMap gMap) throws Exception;
	void deleteAutologinTokenByUserUid(GeekiveMap gMap) throws Exception;
	// NEW: cookie token plain -> userMap
	GeekiveMap selectUserByAutologinTokenPlain(String tokenPlain) throws Exception;
	// NEW
	GeekiveMap selectUserByAutologinTokenHash(GeekiveMap gMap) throws Exception;
}
