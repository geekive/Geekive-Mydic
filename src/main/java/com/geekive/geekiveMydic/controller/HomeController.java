package com.geekive.geekiveMydic.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import com.geekive.geekiveMydic.mapper.service.VocabularyService;

@Controller
public class HomeController {
	
	@Resource
	VocabularyService vocabularyService;

	@GetMapping(value = {"", "/index", "/home"})
	public String index(ModelMap modelMap) throws Exception{
		modelMap.put("wordMap", vocabularyService.selectWordOfTheDay());
		return "home/home";
	}
}
