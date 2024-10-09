package com.itwillbs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.CalSalaryFinalVO;
import com.itwillbs.domain.MemberInfoForSalaryVO;
import com.itwillbs.domain.SalaryBasicInfoVO;
import com.itwillbs.domain.SalaryRankDutyVO;
import com.itwillbs.domain.CalSalaryListVO;
import com.itwillbs.persistence.SalaryDAO;

@Service
public class SalaryServiceImpl implements SalaryService {

	@Autowired
	private SalaryDAO sdao;
	
	@Override
	public SalaryBasicInfoVO getSalaryBasicInfo() {
		return sdao.getSalaryBasicInfo();
	}
	
	@Override
	public void initSalaryBasicInfo() {
		sdao.initSalaryBasicInfo();;
	}
	
	@Override
	public void updateSalaryBasicInfo(SalaryBasicInfoVO vo) {
		sdao.updateSalaryBasicInfo(vo);
	}
	
	@Override
	public SalaryRankDutyVO getSalaryRankDutyInfo() {
		return sdao.getSalaryRankDutyInfo();
	}
	
	@Override
	public void initSalaryRankDutyInfo() {
		sdao.initSalaryRankDutyInfo();
	}
	
	@Override
	public void updatesalaryRankDutyInfo(SalaryRankDutyVO vo) {
		sdao.updatesalaryRankDutyInfo(vo);
	}
	
	// 급여형태/연/월 중복작성 막기 위한 급여리스트 존재 조회
	@Override
	public CalSalaryListVO checkCreateSalary(CalSalaryListVO vo) {
		return sdao.checkCreateSalary(vo);
	}
	
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoForSalary(String employee_id) {
		return sdao.getMemberInfoForSalary(employee_id);
	}
	
	@Override
	public List<MemberInfoForSalaryVO> getMemberAllInfo() {
		return sdao.getMemberAllInfo();
	}
	
	@Override
	public List<CalSalaryFinalVO> calSalary(List<String> employeeIds, CalSalaryListVO vo) {
		return sdao.calSalary(employeeIds, vo);
	}
	
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoToId(String employee_id) {
		return sdao.getMemberInfoToId(employee_id);
	}
	
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoToName(String employee_name) {
		return sdao.getMemberInfoToName(employee_name);
	}
	
	@Override
	public void saveCalSalary(List<CalSalaryFinalVO> calSalaryData) {
		sdao.saveCalSalary(calSalaryData);
	}
	
	@Override
	public void saveCalSalaryList(CalSalaryListVO vo) {
		sdao.saveCalSalaryList(vo);
	}
	
	@Override
	public List<CalSalaryListVO> getCalSalaryList() {
		return sdao.getCalSalaryList();
	}
	
	@Override
	public List<CalSalaryFinalVO> getCalSalaryFinalList(String sal_list_id) {
		return sdao.getCalSalaryFinalList(sal_list_id);
	}
	
	// 급여내역테이블 조회시 급여정보(형태/연/월) 가져오기
	@Override
	public CalSalaryListVO getCalSalaryListForView(String sal_list_id) {
		return sdao.getCalSalaryListForView(sal_list_id);
	}
	
	// 삭제시 급여내역 및 상세정보 테이블 삭제
	@Override
	public void deleteSalaryInfo(String sal_list_id) {
		sdao.deleteSalaryInfo(sal_list_id);
	}
	
	// 급여내역리스트 상태 최종확정으로 변경
	@Override
	public void confirmSalaryList(String sal_list_id) {
		sdao.confirmSalaryList(sal_list_id);
	}
	
	// 급여조회하기 급여정보(연/월/사번)
	@Override
	public List<CalSalaryFinalVO> getCalSalaryInquiryForManageToId(CalSalaryListVO vo) {
		return sdao.getCalSalaryInquiryForManageToId(vo);
	}
	
	// 급여조회(이름)하기 급여정보(연/월/이름)
	@Override
	public List<CalSalaryFinalVO> getCalSalaryInquiryForManageToName(CalSalaryListVO vo) {
		return sdao.getCalSalaryInquiryForManageToName(vo);
	}
	
	// 급여번호로 급여정보 가져오기
	@Override
	public CalSalaryFinalVO salaryDetail(int sal_final_id) {
		return sdao.salaryDetail(sal_final_id);
	}
	
	
	
	
}
