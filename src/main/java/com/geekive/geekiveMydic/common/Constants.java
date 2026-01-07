package com.geekive.geekiveMydic.common;

public class Constants {

	/* common message */
	public static final String SUCCESS 	= "success";
	public static final String FAIL 	= "fail";
	
	/* sign */
	public static final String SIGNIN_TYPE_NORMAL 	= "normal";
	public static final String SIGNIN_TYPE_JWT 		= "jwt";
	
	/* jwt */
	public static final String COOKIE_NAME = "z7aXQ9mLw2TbvKy3";
	
	/* pagination */
	public static int dataCountPerPage 			= 12;	// the number of data in one page
	public static int pageButtonCountPerPage	= 5;	// the number of page button in one page
	
	/* mail */
	public static final String EMAIL_PURPOSE_SIGNUP 	= "signup";
	public static final String EMAIL_PURPOSE_PASSWORD 	= "password";
	
	/* banned archive name */
	public static final String[] BANNED_ARCHIVE_NAME = {"css", "js", "upload", "menu", "error", "sign", "email", "admin", "storage", "list"};
	
	/* exclude path */
	public static final String[] EXCLUDE_PATH = {
		    "/"
		    , "/admin/**"
		    , "/css/**"
		    , "/email/**"
		    , "/error"
		    , "/errorImage"
		    , "/image/**"
		    , "/js/**"
		    , "/list/**"
		    , "/menu"
		    , "/sign/**"
		    , "/upload/**"
	};
}
