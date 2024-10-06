package com.itwillbs.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class SampleController3 {
	
	private static final Logger logger = LoggerFactory.getLogger(SampleController3.class);
	
	//http://localhost:8088/web/doC
	//http://localhost:8088/web/doC?msg=itwill
	@RequestMapping(value = "/doC", method = RequestMethod.GET)
	public String doC(RedirectAttributes rttr /* @ModelAttribute("msg") String msg */) {
		// RedirectAttributes : 기존의 Model객체 기능 + 추가기능(addFlashAttribute)
		// => + 반드시 페이지 redirect 이동시에만 사용 가능
		
		logger.debug("/doC -> doC() 호출");
		
		//logger.debug(" doC - msg : "+msg);
		
		//rttr.addAttribute("msg", "itwillBUSAN");
		// => Model 동작과 동일, 데이터를 주소줄에 표시, 새로고침 시 데이터 유지
		rttr.addFlashAttribute("msg", "itwillBUSAN");
		// => 데이터를 주소줄에 표시하지 않음, 새로고침 시 데이터 유지 안됨
		
		//return "/doD";  -> jsp만 호출
		//return "redirect:/doD"; // = response.sendRedirect() -> doD 메서드 호출
		//return "forward:/doD"; // = forward 동작
		
		//return "redirect:/doD?msg="+msg;
		return "redirect:/doD";
	}
	
	//http://localhost:8088/web/doD
	@RequestMapping(value = "/doD", method = RequestMethod.GET)
	public void doD(@ModelAttribute("msg") String msg) {
		logger.debug("/doD -> doD() 호출");
		
		logger.debug(" doD - msg : "+msg);
		
	}
	
	//http://localhost:8088/web/doE
	@RequestMapping(value = "/doE", method = RequestMethod.GET)
	public @ResponseBody double doE() {
		logger.debug("/doD -> doD() 호출");
		
		return 1000.0;
	}
	// => view가 아니라 데이터값 (JSON형태)로 표현 => RESTful API
	
	
	
	
	
	
	
	
	
}
