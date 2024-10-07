package com.itwillbs.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.domain.CalSalaryFinalVO;
import com.itwillbs.domain.MemberInfoForSalaryVO;
import com.itwillbs.domain.SalaryBasicInfoVO;
import com.itwillbs.domain.SalaryRankDutyVO;
import com.itwillbs.domain.calSalaryListVO;
import com.itwillbs.service.SalaryService;

@Controller
@RequestMapping(value = "salary/*")
public class SalaryController {

	@Autowired
	private SalaryService sService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(SalaryController.class);
	
	// http://localhost:8088/salary/salaryCal
	@GetMapping(value = "/main")
	public String salaryCal() {
		
		return "/salary/main";
	}
	
	// 급여기본정보 설정 페이지
	// http://localhost:8088/salary/salaryBasicInfo
	@GetMapping(value = "/salaryBasicInfo")
	public String salaryBasicInfoGet(Model model) {
		
		logger.debug("salaryBasicInfoGet(Model model) 실행");
		
		SalaryBasicInfoVO result = sService.getSalaryBasicInfo();
		
		if(result == null) {
			logger.debug("null임");
			sService.initSalaryBasicInfo();
			result = sService.getSalaryBasicInfo();
		}
		
		model.addAttribute("salaryBasicInfo", result);
		return "/salary/salaryBasicInfo";
	}
	
	// 급여기본정보 수정
	@PostMapping(value = "/salaryBasicInfo")
	public String salaryBasicInfoPost(SalaryBasicInfoVO vo ,Model model) {
		logger.debug("salaryBasicInfoPost(SalaryBasicInfoVO vo ,Model model) 실행");
		
		sService.updateSalaryBasicInfo(vo); //수정
		SalaryBasicInfoVO result = sService.getSalaryBasicInfo(); //조회
		
		model.addAttribute("salaryBasicInfo", result);
		return "/salary/salaryBasicInfo";
	}
	
	// 직급급/직무급 설정 페이지
	// http://localhost:8088/salary/salaryRankDutyInfo
	@GetMapping(value = "/salaryRankDutyInfo")
	public String salaryRankDutyInfoGet(Model model) {
		SalaryRankDutyVO result = sService.getSalaryRankDutyInfo();
		
		if(result == null) {
			logger.debug("null임");
			sService.initSalaryRankDutyInfo();
			result = sService.getSalaryRankDutyInfo();
		}
		
		model.addAttribute("salaryRankDutyInfo", result);
		return "/salary/salaryRankDutyInfo";
	}
	
	// 직급급/직무급 수정
	@PostMapping(value = "/salaryRankDutyInfo")
	public String salaryRankDutyInfoPost(SalaryRankDutyVO vo ,Model model) {
		logger.debug("salaryRankDutyInfoPost(SalaryRankDutyVO vo ,Model model) 실행");
		
		sService.updatesalaryRankDutyInfo(vo); //수정
		SalaryRankDutyVO result = sService.getSalaryRankDutyInfo(); //조회
		
		model.addAttribute("salaryRankDutyInfo", result);
		return "/salary/salaryRankDutyInfo";
	}
	
	
	// 급여산출 페이지
	// http://localhost:8088/salary/calSalary
	@GetMapping(value = "/calSalary")
	public String calSalary(Model model){
		logger.debug("calSalary(Model model) 호출");
		
	
		return "/salary/calSalary";
	}
	
	// 급여산출 페이지
	// http://localhost:8088/salary/calSalaryStep1
	@GetMapping(value = "/calSalaryStep1")
	public String calSalaryStep1(){
		logger.debug("calSalaryStep1() 호출");
		return "/salary/calSalaryStep1";
	}
	
	// 급여산출 페이지 Step2
	// http://localhost:8088/salary/calSalaryStep2
	@PostMapping(value = "/calSalaryStep2")
	public String calSalaryStep2(calSalaryListVO vo, Model model){
		logger.debug("calSalaryStep2() 호출");
		logger.debug(vo.toString());
		
		model.addAttribute("calSalaryInfo", vo);
	
		return "/salary/calSalaryStep2";
	}
	
	// 급여산출 관련 직원정보 가져오기
	// http://localhost:8088/salary/getMemberInfoForSalary
	@PostMapping(value = "/getMemberInfoForSalary")
	@ResponseBody
	public List<MemberInfoForSalaryVO> getMemberInfoForSalary(@RequestBody String employee_id){
	logger.debug(employee_id);
	
		return sService.getMemberInfoForSalary(employee_id);
	}
	
	// 급여산출 관련 전체직원정보 가져오기
	// http://localhost:8088/salary/getMemberAllInfo
	@PostMapping(value = "/getMemberAllInfo")
	@ResponseBody
	public List<MemberInfoForSalaryVO> getMemberAllInfo(){
		return sService.getMemberAllInfo();
	}
	
	// 급여산출 페이지 Step3
	// http://localhost:8088/salary/calSalaryStep3
	@PostMapping(value = "/calSalaryStep3")
	public String calSalaryStep3(@RequestParam("employeeIds") List<String> employeeIds, calSalaryListVO vo, Model model){
		logger.debug("calSalaryStep3() 호출");
		logger.debug(employeeIds.toString());
		logger.debug(vo.toString());
		
		//급여산출 메서드
		List<CalSalaryFinalVO> CalSalaryFinalInfo = sService.calSalary(employeeIds, vo);
		
		logger.debug(CalSalaryFinalInfo.toString());
		model.addAttribute("CalSalaryFinalInfo", CalSalaryFinalInfo);
		model.addAttribute("calSalaryInfo", vo);
		
		return "/salary/calSalaryStep3";
	}
	
	
}
