package com.geekive.geekiveMydic.controller;

import java.util.Base64;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.geekive.geekiveMydic.common.Util;
import com.geekive.geekiveMydic.geekiveCustom.GeekiveConnector;
import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;
import com.geekive.geekiveMydic.mapper.service.CommonService;

@Controller
public class CommonController {
	
	@Resource
	CommonService commonService;

	@GetMapping(value = "/menu")
	public String menu(HttpServletRequest request, ModelMap modelMap) throws Exception{
		List<GeekiveMap> socialMediaList 	= null;
		List<GeekiveMap> categoryList 		= null;
		try {
			GeekiveMap gMap = new GeekiveMap();
			gMap.put("currentArchiveUserUid", request.getAttribute("currentArchiveUserUid"));	
			
			socialMediaList = commonService.selectSocialMedia(gMap);
			categoryList 	= commonService.selectAllCategory(gMap);
		} catch (Exception e) {
			e.getStackTrace();
		}
		modelMap.addAttribute("socialMediaList"	, socialMediaList);
		modelMap.addAttribute("categoryList"	, categoryList);
		return "archive/common/menu";
	}
	
	@ResponseBody
	@PostMapping(value = "/uploadCkeditorImage")
	public ModelMap upload(MultipartHttpServletRequest request) throws Exception{
		
		ModelMap modelMap 	= new ModelMap();
		String url 			= Util.getFileServerUploadUrl() + "/ckeditor";

		try {
			MultipartFile multipartFile = request.getFile("image");
			GeekiveMap gMap = new GeekiveMap();
            gMap.put("base64"			, Base64.getEncoder().encodeToString(multipartFile.getBytes()));
            gMap.put("originalFileName"	, multipartFile.getOriginalFilename());
            
            GeekiveConnector gConnector = new GeekiveConnector.Builder(url).data(gMap).build();
			gConnector.sendPost();
			
			modelMap.addAttribute("uploaded", true);
			modelMap.addAttribute("url"		, gConnector.getResponseData());
		} catch (Exception e) {
			modelMap.addAttribute("resultCode"		, "0");
			modelMap.addAttribute("resultMessage"	, e.getMessage());
		}
		return modelMap;
	}
	
	@ResponseBody
	@PostMapping(value = "/errorImage")
	public String errorImage(@RequestBody GeekiveMap gMap) throws Exception{
		String storageServerUrl = Util.getStorageUrl();
		switch (gMap.getString("type")) {
		case "profile":
			storageServerUrl += "/image/profile/basic.jpg";
			break;
		case "thumbnail":
			storageServerUrl += "/image/article/no_thumbnail.png";
			break;
		default:
			break;
		}
		return storageServerUrl;
	}
}
