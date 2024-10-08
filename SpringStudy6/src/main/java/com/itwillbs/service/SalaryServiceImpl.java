package com.itwillbs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.CalSalaryFinalVO;
import com.itwillbs.domain.MemberInfoForSalaryVO;
import com.itwillbs.domain.SalaryBasicInfoVO;
import com.itwillbs.domain.SalaryRankDutyVO;
import com.itwillbs.domain.calSalaryListVO;
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
	
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoForSalary(String employee_id) {
		return sdao.getMemberInfoForSalary(employee_id);
	}
	
	@Override
	public List<MemberInfoForSalaryVO> getMemberAllInfo() {
		return sdao.getMemberAllInfo();
	}
	
	@Override
	public List<CalSalaryFinalVO> calSalary(List<String> employeeIds, calSalaryListVO vo) {
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
	public void saveCalSalaryList(calSalaryListVO vo) {
		sdao.saveCalSalaryList(vo);
	}
	
	@Override
	public List<calSalaryListVO> getCalSalaryList() {
		return sdao.getCalSalaryList();
	}
	
	@Override
	public List<CalSalaryFinalVO> getCalSalaryFinalList(String sal_list_id) {
		return sdao.getCalSalaryFinalList(sal_list_id);
	}
	
	// 급여내역테이블 조회시 급여정보(형태/연/월) 가져오기
	@Override
	public calSalaryListVO getCalSalaryListForView(String sal_list_id) {
		return sdao.getCalSalaryListForView(sal_list_id);
	}
	
}
