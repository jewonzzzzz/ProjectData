package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.CalSalaryFinalVO;
import com.itwillbs.domain.MemberInfoForSalaryVO;
import com.itwillbs.domain.SalaryBasicInfoVO;
import com.itwillbs.domain.SalaryRankDutyVO;
import com.itwillbs.domain.calSalaryListVO;

public interface SalaryDAO {

	// 급여기본설정 페이지 접속 시 기본정보 출력
	public SalaryBasicInfoVO getSalaryBasicInfo();
	
	// 급여기본설정 없을 시 초기화
	public void initSalaryBasicInfo();
	
	// 급여기본설정 수정
	public void updateSalaryBasicInfo(SalaryBasicInfoVO vo);
	
	// 직급급/직무급 페이지 접속 시 기본정보 출력
	public SalaryRankDutyVO getSalaryRankDutyInfo();
	
	// 직급급/직무급 기본설정 없을 시 초기화
	public void initSalaryRankDutyInfo();
	
	// 직급급/직무급 수정
	public void updatesalaryRankDutyInfo(SalaryRankDutyVO vo);
	
	// 급여산출용 직원정보 가져오기
	public List<MemberInfoForSalaryVO> getMemberInfoForSalary(String employee_id);
	
	// 급여산출용 전체 직원정보 가져오기
	public List<MemberInfoForSalaryVO> getMemberAllInfo();
	
	// 급여산출하기
	public List<CalSalaryFinalVO> calSalary(List<String> employeeIds, calSalaryListVO vo);
	
	// 사번으로 직원정보 가져오기
	public List<MemberInfoForSalaryVO> getMemberInfoToId(String employee_id);
	
	// 이름으로 직원정보 가져오기
	public List<MemberInfoForSalaryVO> getMemberInfoToName(String employee_name);
	
	// 급여산출결과 테이블에 저장
	public void saveCalSalary(List<CalSalaryFinalVO> calSalaryData);
	
	// 급여산출결과 급여내역 테이블에 저장
	public void saveCalSalaryList(calSalaryListVO vo);
	
	// 급여내역테이블에서 급여리스트 가져오기
	public List<calSalaryListVO> getCalSalaryList();
	
	// 급여내역테이블 조회시 급여상세내역 가져오기
	public List<CalSalaryFinalVO> getCalSalaryFinalList(String sal_list_id);
	
	// 급여내역테이블 조회시 급여정보(형태/연/월) 가져오기
	public calSalaryListVO getCalSalaryListForView(String sal_list_id);
}
