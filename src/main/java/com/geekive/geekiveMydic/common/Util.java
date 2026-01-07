package com.geekive.geekiveMydic.common;

import java.net.URI;
import java.net.URLDecoder;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

/**
 * @author geekive
 *
 */
public class Util {

	/**
	 * @name 		isEmpty
	 * @date 		2024. 3. 14.
	 * @author		geekive
	 * @description	check if string variable is null.
	 */
	public static boolean isEmpty(String value) {
	    return value == null || value.isEmpty();
	}
	
	/**
	 * @name 		isEmpty
	 * @date 		2024. 11. 10.
	 * @author		geekive
	 * @description	check if map variable is null.
	 */
	public static boolean isEmpty(Map map) {
	    return map == null;
	}
	
	/**
	 * @name 		isNotEmpty
	 * @date 		2024. 3. 14.
	 * @author		geekive
	 * @description check if string variable isn't null.
	 */
	public static Boolean isNotEmpty(String value) {
	    return value != null && !value.isEmpty();
	}
	
	/**
	 * @name 		isNotEmpty
	 * @date 		2024. 3. 14.
	 * @author		geekive
	 * @description check if map variable isn't null.
	 */
	public static Boolean isNotEmpty(Map map) {
	    return map != null;
	}
	
	/**
	 * @name 		isLogin
	 * @date 		2024. 3. 14.
	 * @author		geekive
	 * @description check if user is logged in or not.
	 */
	public static Boolean isLogin(HttpServletRequest request) {
		HttpSession httpSession = request.getSession();
		Boolean isSignedIn 		= (Boolean) httpSession.getAttribute("isSignedIn");
		return isSignedIn != null && isSignedIn;
	}
	
	/**
	 * @name 		getSubPath
	 * @date 		2024. 3. 14.
	 * @author		geekive
	 * @description return sub path of url.
	 */
	public static String getSubPath(HttpServletRequest request) {
		return request.getRequestURI().replace(request.getContextPath(), "");
	}
	
	/**
	 * @name 		splitSubPath
	 * @date 		2024. 3. 14.
	 * @author		geekive
	 * @description split sub path by "/".
	 */
	public static String[] splitSubPath(String subPath) {
		String editedSubPath = Arrays.stream(subPath.substring(subPath.indexOf('/') + 1).split("/"))
                .limit(2)
                .collect(Collectors.joining("/"));
		return editedSubPath.split("/");
	}
	
	/**
	 * @name 		parseToInt
	 * @date 		2024. 3. 14.
	 * @author		geekive
	 * @description	after checking type of object variable, convert object to integer.
	 */
	public static int parseToInt(Object object) {
		int result = 0;
		if(object instanceof String) {
			String stringValue = (String) object;
			result = Integer.parseInt(stringValue);
		}else {
			result = (int) object;
		}
		return result;
	}
	
	/**
	 * @name 		generateUID
	 * @date 		2024. 8. 31.
	 * @author		geekive
	 * @description return UID without prefix.
	 */
	public static String generateUID() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	/**
	 * @name 		generateUID
	 * @date 		2024. 3. 14.
	 * @author		geekive
	 * @description return UID.
	 */
	public static String generateUID(String prefix) {
		return prefix + "-" + UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	/**
	 * @name 		getExtension
	 * @date 		2024. 8. 31.
	 * @author		geekive
	 * @description return file's extension.
	 */
	public static String getExtension(String fileName) {
		return fileName.substring(fileName.lastIndexOf("."));
	}
	
	/**
	 * @name 		getExtension
	 * @date 		2024. 8. 31.
	 * @author		geekive
	 * @description return file's extension.
	 */
	public static String getExtensionWithoutDot(String fileName) {
		return fileName.substring(fileName.lastIndexOf(".") + 1);
	}
	
	/**
	 * @name 		getFileName
	 * @date 		2024. 4. 4.
	 * @author		geekive
	 * @description return file name.
	 */
	public static String getFileName(MultipartFile multipartFile) {
		String origianlFileName = multipartFile.getOriginalFilename();
        String extension 		= origianlFileName.substring(origianlFileName.lastIndexOf("."));
		return generateUID("FLE") + extension;
	}
	
	/**
	 * @name 		getFileName
	 * @date 		2024. 4. 4.
	 * @author		geekive
	 * @description return file name.
	 */
	public static String getFileName(String origianlFileName) {
        String extension 		= origianlFileName.substring(origianlFileName.lastIndexOf("."));
		return generateUID("FLE") + extension;
	}
	
	/**
	 * @name 		getAdminUrl
	 * @date 		2025. 3. 24.
	 * @author		geekive
	 * @description return admin server url
	 */
	public static String getAdminUrl() {
		return PropertyUtil.getProperty("admin.server.url");
	}
	
	/**
	 * @name 		getAdminUrl
	 * @date 		2025. 3. 25.
	 * @author		geekive
	 * @description return storage server url
	 */
	public static String getStorageUrl() {
		return PropertyUtil.getProperty("file.server.url");
	}
	
	/**
	 * @name 		getUserServerUrl
	 * @date 		2025. 5. 15.
	 * @author		geekive
	 * @description return user server url
	 */
	public static String getUserServerUrl() {
		return PropertyUtil.getProperty("user.server.url");
	}
	
	/**
	 * @name 		getFileServerUrl
	 * @date 		2024. 4. 4.
	 * @author		geekive
	 * @description return file server upload url
	 */
	public static String getFileServerUploadUrl() {
		return PropertyUtil.getProperty("file.server.upload.url");
	}
	
	/**
	 * @name 		getUploadPath
	 * @date 		2024. 4. 9.
	 * @author		geekive
	 * @description return upload path
	 */
	public static String getUploadPath() {
		return PropertyUtil.getProperty("upload.path");
	}
	
	/**
	 * @name 		arrayToCSV
	 * @date 		2025. 1. 23.
	 * @author		geekive
	 * @description make array CSV(Comma-Separated Valuse)
	 */
	public static String arrayToCSV(String[] array) {
		if(array == null || array.length == 0) {
			return "";
		}
		return String.join(",", array);
	}
	
	/**
	 * @name 		CSVToArray
	 * @date 		2025. 2. 12.
	 * @author		geekive
	 * @description make CSV(Comma-Separated Valuse) into array
	 */
	public static String[] CSVToArray(String value) {
		return isEmpty(value) ? new String[0] : value.split(",");
	}
	
	/**
	 * @name 		extractArchiveNameFromUrl
	 * @date 		2025. 2. 26.
	 * @author		geekive
	 * @description extract archive name from URL
	 */
	public static String extractArchiveNameFromUrl(HttpServletRequest request) {
		String subPath = getSubPath(request);
		String[] paths = subPath.split("/");
        if(paths.length > 1) {
            return paths[1].toLowerCase();
        }
		return "";
	}
	
	/**
	 * @name 		extractCategoryNameFromUrl
	 * @date 		2025. 2. 26.
	 * @author		geekive
	 * @description extract category name from URL
	 */
	public static String extractCategoryNameFromUrl(HttpServletRequest request) {
        try {
    		String subPath = getSubPath(request);
    		String[] paths = subPath.split("/");
            if(paths.length > 2) {
            	paths[2] = URLDecoder.decode(paths[2], "UTF-8");
                return paths[2].toLowerCase();
            }
		} catch (Exception e) {
			e.getStackTrace();
		}
		return "";
	}
	
	/**
	 * @name 		extractCategoryNameFromUrl
	 * @date 		2025. 2. 27.
	 * @author		geekive
	 * @description extract article number from URL
	 */
	public static String extractArticleNumberFromUrl(HttpServletRequest request) {
	    String subPath = getSubPath(request);
	    String[] paths = subPath.split("/");
	    if(paths.length > 3) {
	        String articleNumber = paths[3];
	        try {
	            Integer.parseInt(articleNumber);
	            return articleNumber;
	        } catch (NumberFormatException e) {
	            return "";
	        }
	    }
	    return "";
	}
	
	/**
	 * @name 		getBaseUrl
	 * @date 		2025. 2. 27.
	 * @author		geekive
	 * @description get base url
	 */
	public static String getBaseURL(HttpServletRequest request) {
		try {
			String scheme 	= request.getHeader("X-Forwarded-Proto");
			String fullURL 	= request.getRequestURL().toString();
	        URI uri 		= new URI(fullURL);
	        if(scheme == null) {
	        	scheme 	= uri.getScheme();
	        }
	        String host 	= uri.getHost();
	        int port 		= uri.getPort();

	        String baseURL = scheme + "://" + host;
	        if(port != -1) {
	        	if((scheme.equals("http") && port != 80) || (scheme.equals("https") && port != 443)) {
		            baseURL += ":" + port;
		        }
	        }

	        return baseURL;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
	
	/**
	 * @name 		verificationCodeGenerator
	 * @date 		2025. 2. 27.
	 * @author		geekive
	 * @description return 6 digit auth code
	 */
	public static String verificationCodeGenerator() {
		SecureRandom random 			= new SecureRandom();
        StringBuilder verificationCode 	= new StringBuilder();
        for(int i = 0; i < 6; i++){
            int digit = random.nextInt(10);
            verificationCode.append(digit);
        }
        return verificationCode.toString();
	}
	
	/**
	 * @name 		getIp
	 * @date 		2025. 5. 9.
	 * @author		geekive
	 * @description return request ip
	 */
	public static String getIp(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
	    if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("Proxy-Client-IP");
	    }
	    if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getRemoteAddr();
	    }
        return ip;
	}
	
	/**
	 * @name 		getDevice
	 * @date 		2025. 5. 9.
	 * @author		geekive
	 * @description return request device
	 */
	public static String getDevice(HttpServletRequest request) {
	    String userAgent 	= request.getHeader("User-Agent").toLowerCase();
	    String device 		= "";
	    if (userAgent.contains("mobile")) {
	    	device = "MOBILE";
	    } else if (userAgent.contains("tablet")) {
	    	device = "TABLET";
	    } else {
	    	device = "DESKTOP";
	    }
        return device;
	}
	
	/**
	 * @name 		getBrowser
	 * @date 		2025. 5. 9.
	 * @author		geekive
	 * @description return request browser
	 */
	public static String getBrowser(HttpServletRequest request) {
	    String userAgent 	= request.getHeader("User-Agent");
	    String browser 		= "";
	    if (userAgent.contains("Edg/")) {
	    	browser = "Edge";
	    } else if (userAgent.contains("Chrome/")) {
	    	browser = "Chrome";
	    } else if (userAgent.contains("Safari/") && !userAgent.contains("Chrome/")) {
	    	browser = "Safari";
	    } else if (userAgent.contains("Firefox/")) {
	    	browser = "Firefox";
	    } else if (userAgent.contains("MSIE") || userAgent.contains("Trident/")) {
	    	browser = "Internet Explorer";
	    } else {
	    	browser = "Unknown";
	    }
        return browser;
	}
	
	/**
	 * @name 		hierarchicalSortList
	 * @date 		2024. 3. 14.
	 * @author		geekive
	 * @description sort data in hierarchical order. it's written because MYSQL doesn't have such function like Oracle.
	 */
	public static List<Map<String, Object>> hierarchicalSortList(String pkCoulmnName, String parentPkCoulmnName, String depthColumnName, String orderCoulmnName, List<Map<String, Object>> list){
		
		int fd = 0;
		for(Map<String, Object> m : list) {
			m.put(depthColumnName, parseToInt(m.get(depthColumnName)));
			m.put(orderCoulmnName, parseToInt(m.get(orderCoulmnName)));
			
			int dpth = (int) m.get(depthColumnName);
			if(fd < dpth) {fd = dpth;}
		}
		
		List<List<Map<String, Object>>> ssl = new ArrayList<List<Map<String,Object>>>();
		for(int i = 1; i <= fd; i++) {
			List<Map<String, Object>> odsl = new ArrayList<Map<String,Object>>();
			for(int j = 0; j < list.size(); j++) {
				if(i == (int) list.get(j).get(depthColumnName)) {
					odsl.add(list.get(j));
				}
			}	
			ssl.add(odsl);
		}
		
		for(int i = ssl.size() - 1; i >= 1; i--) {
			List<Map<String, Object>> sdsl 	= ssl.get(i);
			List<Map<String, Object>> bdsl 	= ssl.get(i - 1);
		
			if(i == ssl.size() - 1) {
				sortList(parentPkCoulmnName, orderCoulmnName, true, sdsl);
			}else {
				Collections.reverse(sdsl);
			}
			sortList(parentPkCoulmnName, orderCoulmnName, false, bdsl);
		
			int dpth = 0;
			for(int j = 0; j < bdsl.size(); j++) {
				Map<String, Object> bdm = bdsl.get(j);
				String gu = (String) bdm.get(parentPkCoulmnName);
				String pk = (String) bdm.get(pkCoulmnName);
				
				if(j == 0) {dpth = (int) bdm.get(depthColumnName);}
				if(dpth == (int) bdm.get(depthColumnName)) {bdm.put("gu", i != 1 ? gu : pk);}
	
				for(int k = 0; k < sdsl.size(); k++) {
					Map<String, Object> sdm = sdsl.get(k);
					if(pk.equals((String) sdm.get(i == ssl.size() - 1 ? parentPkCoulmnName : "gu"))) {
						sdm.put("gu", i != 1 ? gu : pk);
						bdsl.add(j + 1, sdsl.get(k));
					}
				}
			}
		}
		
		if(ssl.size() > 1) {
			ssl.subList(1, ssl.size()).clear();
		}
		 
		
		return removeUnnecessaryMenu(parentPkCoulmnName, ssl.get(0));
	}
	
    /**
     * @name 		sortList
     * @date 		2024. 3. 14.
     * @author		geekive
     * @description	this method is used only for the method 'hierarchicalSortList'.
     * 				it's for sorting data.
     */
    private static void sortList(String parentPkCoulmnName, String orderCoulmnName, Boolean flagReverse, List<Map<String, Object>> dataList) {
        Collections.sort(dataList, new Comparator<Map<String, Object>>() {
            @Override
            public int compare(Map<String, Object> map1, Map<String, Object> map2) {
                String p1 = "";
                String p2 = "";
                if(map1.get(parentPkCoulmnName) != null) {
                	p1 = map1.get(parentPkCoulmnName).toString();
                }
                if(map2.get(parentPkCoulmnName) != null) {
                	p2 = map2.get(parentPkCoulmnName).toString();
                }
                
                int c;
                if(flagReverse) {c = p2.compareTo(p1);
                }else {c = p1.compareTo(p2);}

                if(c != 0) {return c;}

                // order 비교
                Integer o1 = Integer.parseInt(map1.get(orderCoulmnName).toString());
                Integer o2 = Integer.parseInt(map2.get(orderCoulmnName).toString());

                if(flagReverse) {return o2.compareTo(o1);
                }else {return o1.compareTo(o2);}
            }
        });
    }
    
	/**
	 * @name 		removeUnnecessaryMenu
	 * @date 		2024. 3. 14.
	 * @author		geekive
	 * @description this method is used only for the method 'hierarchicalSortList'.
	 * 				remove unnecessary data after sorting.
	 */
	private static List<Map<String, Object>> removeUnnecessaryMenu(String parentPkCoulmnName, List<Map<String, Object>> dataList) {
		List<Map<String, Object>> childMenuList = null;
		Map<String, Object> parentMenuMap 		= null;
		String groupUid 						= null;
		for(int i = 0; i < dataList.size(); i++) {
			Map<String, Object> menu = dataList.get(i);
			if(i == 0 || !groupUid.equals((String) menu.get("gu"))) {
				if(i != 0) {
					parentMenuMap.put("childList", childMenuList);						
				}
				
				childMenuList	= new ArrayList<Map<String,Object>>();
				parentMenuMap 	= menu;
				groupUid 		= (String) menu.get("gu");
			}else {
				childMenuList.add(menu);
			}
			
			if(i == dataList.size() - 1) {
				parentMenuMap.put("childList", childMenuList);
			}
		}
		
		for(int i = dataList.size() - 1; i >= 0; i--) {
			Map<String, Object> menu = dataList.get(i);
			if(Util.isEmpty((String) menu.get(parentPkCoulmnName))) {
				continue;
			}else {
				dataList.remove(i);
			}
		}
		return dataList;
	}
}
