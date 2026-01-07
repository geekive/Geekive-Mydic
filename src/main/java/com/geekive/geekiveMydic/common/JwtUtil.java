package com.geekive.geekiveMydic.common;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;

import javax.annotation.PostConstruct;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseCookie;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

@Component
public class JwtUtil {

	@Value("${jwt.secretkey}")
	private String SECRET_KEY;
	private Key KEY;
    private final long EXPIRATION 	= 1000 * 60 * 60; // 1h
    
    @PostConstruct
    public void init() {
        this.KEY = Keys.hmacShaKeyFor(SECRET_KEY.getBytes(StandardCharsets.UTF_8));
    }

    public ResponseCookie generateToken(String value) {
        Date now 	= new Date();
        Date expiry = new Date(now.getTime() + EXPIRATION);

        String token = Jwts.builder()
                .setSubject(value)
                .setIssuedAt(now)
                .setExpiration(expiry)
                .signWith(KEY)
                .compact();
        
        return ResponseCookie.from(Constants.COOKIE_NAME, token)
				.httpOnly(true)
				.secure(false) // 실서버에서 true, 테스트서버에서 false
				.path("/")
				.maxAge(-1)
				.sameSite("Lax")
				.build();
    }
    
    public String getTokenFromCookie(HttpServletRequest request) {
    	if(request.getCookies() != null) {
	        for(Cookie cookie : request.getCookies()) {
	            if(Constants.COOKIE_NAME.equals(cookie.getName())) {
	            	return cookie.getValue();
	            }
	        }
	    }
    	return null;
	}
    
    public boolean hasToken(HttpServletRequest request) {
		return getTokenFromCookie(request) != null;
	}
    
    
    public void invalidateToken(HttpServletRequest request, HttpServletResponse response) {
	    Cookie[] cookies = request.getCookies();
	    if(cookies != null) {
	        for(Cookie cookie : cookies) {
	            if (Constants.COOKIE_NAME.equals(cookie.getName())) {
	                cookie.setValue("");
	                cookie.setPath("/");
	                cookie.setMaxAge(0);
	                response.addCookie(cookie);
	            }
	        }
	    }
	}

    public String extractValue(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(KEY)
                .build()
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }

    public boolean isTokenValid(String token) {
        try {
        	extractValue(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
