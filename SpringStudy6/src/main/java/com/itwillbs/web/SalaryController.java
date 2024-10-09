package com.itwillbs.web;

import java.util.List;
import java.util.Map;

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
import com.itwillbs.domain.CalSalaryListVO;
import com.itwillbs.service.SalaryService;

@Controller
@RequestMapping(value = "salary/*")
public class SalaryController {

	@Autowired
	private SalaryService sService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(SalaryController.class);
	
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
		logger.debug("salaryRankDutyInfoGet(Model model) 실행");
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
		logger.debug("calSalary(Model model) 실행");
		
		// 급여산출내역 가져오기
		List<CalSalaryListVO> calSalaryList = sService.getCalSalaryList();
		model.addAttribute("calSalaryListInfo", calSalaryList);
	
		return "/salary/calSalary";
	}
	
	// 급여산출 페이지 Step1
	// http://localhost:8088/salary/calSalaryStep1
	@GetMapping(value = "/calSalaryStep1")
	public String calSalaryStep1(){
		logger.debug("calSalaryStep1() 실행");
		return "/salary/calSalaryStep1";
	}
	
	// 급여 중복 작성여부 체크
	// http://localhost:8088/salary/checkCreateSalary
	@PostMapping(value = "/checkCreateSalary")
	@ResponseBody
	public String checkCreateSalary(@RequestBody List<String> checkSalaryInfo){
		logger.debug("checkCreateSalary() 실행");
		logger.debug(checkSalaryInfo.toString());
		CalSalaryListVO vo = new CalSalaryListVO();
		vo.setSal_type(checkSalaryInfo.get(0));
		vo.setYear(checkSalaryInfo.get(1));
		vo.setMonth(checkSalaryInfo.get(2));
		CalSalaryListVO cvo = sService.checkCreateSalary(vo);
		if(cvo == null) { //입력정보 없으면 ok
			return "ok";
		}
		return null; //입력정보 있으면 null
	}
	
	// 급여산출 페이지 Step2
	// http://localhost:8088/salary/calSalaryStep2
	@PostMapping(value = "/calSalaryStep2")
	public String calSalaryStep2(CalSalaryListVO vo, Model model){
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
	
	// 조회 시 직원정보 가져오기(모달테이블 추가)
	// http://localhost:8088/salary/getMemberInfoForSalary
	@PostMapping(value = "/getMemberInfoForModal")
	@ResponseBody
	public List<MemberInfoForSalaryVO> getMemberInfoForModal(@RequestBody String employeeInfo){
		logger.debug("getMemberInfoForModal(@RequestBody String employeeInfo) 실행");
		logger.debug("employeeInfo:" + employeeInfo);
	
	//사번으로 먼저 select
	List<MemberInfoForSalaryVO> memberInfoList = sService.getMemberInfoToId(employeeInfo);
	
	//사번으로 검색 없으면
	if(memberInfoList.size() == 0) {
		memberInfoList = sService.getMemberInfoToName(employeeInfo);
	}
	logger.debug(memberInfoList.toString());
	
		return memberInfoList;
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
	public String calSalaryStep3(@RequestParam("employeeIds") List<String> employeeIds, CalSalaryListVO vo, Model model){
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
	
	// 모달테이블에서 조회된 사원정보 본 테이블로 이동하기
	// http://localhost:8088/salary/transModalToTable
	@PostMapping(value = "/transModalToTable")
	@ResponseBody
	public List<MemberInfoForSalaryVO> transModalToTable(@RequestBody String employee_id){
		logger.debug(employee_id);
		return sService.getMemberInfoForSalary(employee_id);
	}
	
	// 최종 급여산출내용을 테이블로 저장하기
	@PostMapping(value = "/saveSalaryInfo")
	@ResponseBody
	public String saveSalaryInfo(@RequestBody Map<String, Object> data){
		
		// 전달된 정보 저장 idList, (급여유형, 연도, 월) => 객체 저장
		List<String> employeeIds = (List<String>) data.get("employeeIds");
		CalSalaryListVO vo = new CalSalaryListVO();
		vo.setSal_type((String)data.get("sal_type"));
		vo.setYear((String)data.get("year"));
		vo.setMonth((String)data.get("month"));
		
		//급여산출
		List<CalSalaryFinalVO> CalSalaryFinalInfo = sService.calSalary(employeeIds, vo);
		logger.debug(CalSalaryFinalInfo.toString());
		
		// 급여내역테이블 저장
		sService.saveCalSalaryList(vo);
		
		//산출된 급여 급여상세내역 테이블 저장
		sService.saveCalSalary(CalSalaryFinalInfo);
		
		return "ok";
	}
	
	// 급여내역페이지에서 조회시 급여조회 페이지 이동
	// http://localhost:8088/salary/calSalaryView
	@GetMapping(value = "/calSalaryView")
	public String calSalaryView(@RequestParam("sal_list_id") String sal_list_id, Model model){
		logger.debug("calSalaryView(@RequestParam(\"sal_list_id\") String sal_list_id, Model model) 실행");
		logger.debug(sal_list_id);
		
		// 급여상세내역 가져오기
		List<CalSalaryFinalVO> calSalaryFinalInfo = sService.getCalSalaryFinalList(sal_list_id);
		model.addAttribute("calSalaryFinalInfo", calSalaryFinalInfo);
		
		// 기본내용가져오기(급여형태/연/월)
		CalSalaryListVO calSalaryListInfo = sService.getCalSalaryListForView(sal_list_id);
		model.addAttribute("calSalaryListInfo", calSalaryListInfo);
		
		return "/salary/calSalaryView";
	}
	
	// 급여내역리스트에서 삭제하기
	@PostMapping(value = "/deleteSalaryInfo")
	public String deleteSalaryInfo(@RequestParam("sal_list_id") String sal_list_id){
		logger.debug("deleteSalaryList(@RequestParam(\"sal_list_id\") String sal_list_id) 실행");
		// 급여내역리스트 및 급여상세테이블 삭제하기
		sService.deleteSalaryInfo(sal_list_id);
		
		return "redirect:/salary/calSalary";
	}
	
	// 급여내역리스트에서 최종확정 하기
	@PostMapping(value = "/confirmSalaryList")
	public String confirmSalaryList(@RequestParam("sal_list_id") String sal_list_id){
		logger.debug("confirmSalaryList(@RequestParam(\"sal_list_id\") String sal_list_id) 실행");
		logger.debug(sal_list_id);
		// 급여내역리스트 상태 최종확정으로 변경
		sService.confirmSalaryList(sal_list_id);
		
		return "redirect:/salary/calSalary";
	}
	
	
	// 급여조회(관리자) 페이지
	@GetMapping(value = "calSalaryInquiryForManage")
	public String calSalaryInquiryForManage() {
		return "/salary/calSalaryInquiryForManage";
	}
	
	// 급여조회(관리자)
	@PostMapping(value = "getCalSalaryInquiryForManage")
	@ResponseBody
	public List<CalSalaryFinalVO> getCalSalaryInquiryForManage(@RequestBody List<String> checkSalaryInfo) {
		logger.debug(checkSalaryInfo.toString());
		
		CalSalaryListVO vo = new CalSalaryListVO();
		vo.setYear(checkSalaryInfo.get(0));
		vo.setEmployee_id(checkSalaryInfo.get(1));
		vo.setEmployee_name(checkSalaryInfo.get(1));
		
		//사번으로 먼저 select
		List<CalSalaryFinalVO> calSalaryInquiryList = sService.getCalSalaryInquiryForManageToId(vo) ;
		
		//사번으로 검색 없으면
		if(calSalaryInquiryList.size() == 0) {
			calSalaryInquiryList = sService.getCalSalaryInquiryForManageToName(vo);
		}
		logger.debug(calSalaryInquiryList.toString());
		
			return calSalaryInquiryList;
	}
	
	// 급여조회 상세페이지
	@GetMapping(value = "salaryDetail")
	public String salaryDetail(@RequestParam("sal_final_id") int sal_final_id, Model model) {
		logger.debug(""+sal_final_id);
		
		// 해당 급여번호 급여정보 가져가기
		CalSalaryFinalVO calSalaryFinalInfo = sService.salaryDetail(sal_final_id);
		model.addAttribute("calSalaryFinalInfo", calSalaryFinalInfo);
		
		return "/salary/salaryDetail";
	}
	
	
	
	
	
	
	
}
