package com.geekive.geekiveMydic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	@GetMapping(value = {"", "/index", "/home"})
	public String index(ModelMap modelMap) throws Exception{
		return "home/home";
	}
}
