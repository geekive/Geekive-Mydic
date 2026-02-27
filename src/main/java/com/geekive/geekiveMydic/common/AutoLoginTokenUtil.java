package com.geekive.geekiveMydic.common;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Utility class for auto-login token generation, hashing,
 * secure cookie handling, and client context extraction.
 */
public final class AutoLoginTokenUtil {

    // Auto-login cookie config
    private static final String AUTOLOGIN_COOKIE = "MYDIC_AUTOLOGIN";
    private static final int AUTOLOGIN_MAX_AGE_SEC = 60 * 60 * 24 * 7; // 7 days

    private static final int TOKEN_BYTE_LENGTH = 32;
    private static final int MAX_UA_LENGTH = 400;

    private AutoLoginTokenUtil() {
        // Utility class; prevent instantiation
    }

    /** Generates a cryptographically secure random token (plain), URL-safe Base64 without padding. */
    public static String generateTokenPlain() {
        byte[] b = new byte[TOKEN_BYTE_LENGTH];
        new SecureRandom().nextBytes(b);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(b);
    }

    /** SHA-256 hash of the plain token, URL-safe Base64 without padding. */
    public static String sha256Base64Url(String plain) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] dig = md.digest(plain.getBytes(StandardCharsets.UTF_8));
        return Base64.getUrlEncoder().withoutPadding().encodeToString(dig);
    }

    /**
     * Writes the auto-login cookie (HttpOnly).
     * Enable Secure flag in HTTPS production environments.
     */
    public static void writeAutoLoginCookie(HttpServletResponse response, String tokenPlain) {
        Cookie c = new Cookie(AUTOLOGIN_COOKIE, tokenPlain);
        c.setPath("/");
        c.setMaxAge(AUTOLOGIN_MAX_AGE_SEC);
        c.setHttpOnly(true);
        // Enable in HTTPS production environments:
        // c.setSecure(true);
        response.addCookie(c);
    }

    /** Clears (expires) the auto-login cookie immediately. */
    public static void clearAutoLoginCookie(HttpServletResponse response) {
        Cookie c = new Cookie(AUTOLOGIN_COOKIE, "");
        c.setPath("/");
        c.setMaxAge(0);
        c.setHttpOnly(true);
        // c.setSecure(true);
        response.addCookie(c);
    }

    /** Reads the auto-login cookie value from request. */
    public static String readAutoLoginCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) return null;

        for (Cookie c : cookies) {
            if (AUTOLOGIN_COOKIE.equals(c.getName())) {
                return c.getValue();
            }
        }
        return null;
    }

    /** Safely extracts User-Agent, truncated to a safe maximum length. */
    public static String safeUserAgent(HttpServletRequest request) {
        String ua = request.getHeader("User-Agent");
        if (ua == null) return "";
        return ua.length() > MAX_UA_LENGTH ? ua.substring(0, MAX_UA_LENGTH) : ua;
    }

    /** Resolves client IP considering X-Forwarded-For (first hop). */
    public static String safeIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip != null && !ip.isEmpty()) {
            int comma = ip.indexOf(",");
            return comma > 0 ? ip.substring(0, comma).trim() : ip.trim();
        }
        ip = request.getRemoteAddr();
        return ip == null ? "" : ip;
    }
    
    public static int getAutoLoginMaxAgeSec() {
        return AUTOLOGIN_MAX_AGE_SEC;
    }
}