package com.geekive.geekiveMydic.mapper.service;

import java.security.MessageDigest;
import java.util.Base64;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekive.geekiveMydic.common.CryptoUtil;
import com.geekive.geekiveMydic.common.Util;
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
	public void upsertAutologinToken(GeekiveMap gMap) throws Exception {
		signMapper.upsertAutologinToken(gMap);
	}

	@Override
	public void deleteAutologinTokenByUserUid(GeekiveMap gMap) throws Exception {
	}

	@Override
	public GeekiveMap selectUserByAutologinTokenPlain(String tokenPlain) throws Exception {
		String tokenHash = sha256Base64Url(tokenPlain);

		GeekiveMap p = new GeekiveMap();
		p.put("tokenHash", tokenHash);
		p.put("nowEpoch", System.currentTimeMillis() / 1000L);

		return signMapper.selectUserByAutologinTokenHash(p);
	}
	
	private String sha256Base64Url(String plain) throws Exception {
		MessageDigest md 	= MessageDigest.getInstance("SHA-256");
		byte[] dig 			= md.digest(plain.getBytes("UTF-8"));
		return Base64.getUrlEncoder().withoutPadding().encodeToString(dig);
	}

	@Override
	public GeekiveMap selectUserByAutologinTokenHash(GeekiveMap gMap) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}
