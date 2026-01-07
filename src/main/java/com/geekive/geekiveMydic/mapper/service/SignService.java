package com.geekive.geekiveMydic.mapper.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekive.geekiveMydic.common.CryptoUtil;
import com.geekive.geekiveMydic.common.Util;
import com.geekive.geekiveMydic.geekiveCustom.GeekiveConnector;
import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;
import com.geekive.geekiveMydic.mapper.SignMapper;


@Service
public class SignService implements SignMapper{
	
	@Autowired
    private CryptoUtil cryptoUtil;
	
	@Autowired
	SignMapper signMapper;

	@Override
	public Boolean checkEmailExistence(GeekiveMap gMap) {
		Boolean result = false;
		try {
			result = signMapper.checkEmailExistence(gMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Boolean checkArchiveNameExistence(GeekiveMap gMap) {
		return signMapper.checkArchiveNameExistence(gMap);
	}

	@Override
	public GeekiveMap selectUser(GeekiveMap gMap) {
		GeekiveMap userMap = null;
		try {
		    userMap = signMapper.selectUser(gMap);
		    if(Util.isEmpty(userMap) || !cryptoUtil.checkPassword(gMap.getString("password"), userMap.getString("password"))) {
		        return null;
		    }else {
		    	userMap.remove("password");
		    }
		} catch (Exception e) {
			e.printStackTrace();
		}
	    return userMap;
	}
	
	@Override
	public void insertUser(GeekiveMap gMap) {
		try {
			gMap.put("password", cryptoUtil.encryptPassword(gMap.getString("password")));
			signMapper.insertUser(gMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void insertCategory(GeekiveMap gMap) {
		signMapper.insertCategory(gMap);
	}
}
