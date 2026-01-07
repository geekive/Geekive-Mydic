package com.geekive.geekiveMydic.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.geekive.geekiveMydic.common.Util;
import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;
import com.geekive.geekiveMydic.mapper.service.VocabularyService;

@Controller
@RequestMapping("/vocabulary")
public class VocabularyController {
	
	@Resource
	VocabularyService vocabularyService;

	@GetMapping(value = {"", "/"})
	public String listGet() throws Exception{
		return "vocabulary/list";
	}
	
	@ResponseBody
	@PostMapping(value = "/save")
	public GeekiveMap savePost(@RequestBody GeekiveMap gMap) throws Exception{
		try {
			gMap.put("vocabularyUid", Util.generateUID("VCB"));
			vocabularyService.insertVocabulary(gMap);
		} catch (Exception e) {
			gMap.setResultCode(0);
			gMap.setResultMessage(e.getMessage());
		}
		return gMap;
	}
}
