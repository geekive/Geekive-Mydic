package com.geekive.geekiveMydic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/myinfo")
public class MyInfoController {

	@GetMapping(value = {"", "/"})
	public String myinfoGet() throws Exception{
		return "myinfo/myinfo";
	}
}
