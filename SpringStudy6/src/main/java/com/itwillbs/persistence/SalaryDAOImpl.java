package com.itwillbs.persistence;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.CalSalaryFinalVO;
import com.itwillbs.domain.MemberInfoForSalaryVO;
import com.itwillbs.domain.SalaryBasicInfoVO;
import com.itwillbs.domain.SalaryRankDutyVO;
import com.itwillbs.domain.calSalaryListVO;

@Repository
public class SalaryDAOImpl implements SalaryDAO {
	
	@Autowired
	private SqlSession sqlSession;

	// Mapper namespace 정보 저장
	private static final String NAMESPACE = "com.itwillbs.mapper.SalaryMapper";

	@Override
	public SalaryBasicInfoVO getSalaryBasicInfo() {
		return sqlSession.selectOne(NAMESPACE + ".getSalaryBasicInfo");
	}

	@Override
	public void initSalaryBasicInfo() {
		sqlSession.insert(NAMESPACE + ".initSalaryBasicInfo");
	}

	@Override
	public void updateSalaryBasicInfo(SalaryBasicInfoVO vo) {
		sqlSession.update(NAMESPACE + ".updateSalaryBasicInfo", vo);
	}

	@Override
	public SalaryRankDutyVO getSalaryRankDutyInfo() {
		return sqlSession.selectOne(NAMESPACE + ".getSalaryRankDutyInfo");
	}

	@Override
	public void initSalaryRankDutyInfo() {
		sqlSession.insert(NAMESPACE + ".initSalaryRankDutyInfo");
	}

	@Override
	public void updatesalaryRankDutyInfo(SalaryRankDutyVO vo) {
		sqlSession.update(NAMESPACE + ".updateSalaryRankDutyInfo", vo);
	}

	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoForSalary(String employee_id) {
		return sqlSession.selectList(NAMESPACE + ".getMemberInfoForSalary", employee_id);
	}

	@Override
	public List<MemberInfoForSalaryVO> getMemberAllInfo() {
		return sqlSession.selectList(NAMESPACE + ".getMemberAllInfo");
	}

	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoToId(String employee_id) {
		return sqlSession.selectList(NAMESPACE + ".getMemberInfoForSalary", employee_id);
	}
	
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoToName(String employee_name) {
		return sqlSession.selectList(NAMESPACE + ".getMemberInfoToName", employee_name);
	}
	
	@Override
	public void saveCalSalary(List<CalSalaryFinalVO> calSalaryData) {
		
		for(CalSalaryFinalVO calSalaryFinalInfo : calSalaryData) {
			sqlSession.insert(NAMESPACE+".saveCalSalary", calSalaryFinalInfo);
		}
	}
	
	@Override
	public void saveCalSalaryList(calSalaryListVO vo) {
		
		//salary_list_id 설정
		String sal_list_id = "s"+vo.getYear()+vo.getMonth()+vo.getSal_type();
		//salary_list_subject 설정
		String sal_list_subject = vo.getYear()+"년 "+vo.getMonth()+"월 "+vo.getSal_type()+"내역";
		
		vo.setSal_list_id(sal_list_id);
		vo.setSal_list_subject(sal_list_subject);
		
		// 산출내역 급여내역리스트에 저장
		sqlSession.insert(NAMESPACE+".saveCalSalaryList", vo);
	}
	
	@Override
	public List<calSalaryListVO> getCalSalaryList() {
		return sqlSession.selectList(NAMESPACE+".getCalSalaryList");
	}
	
	// 급여내역리스트에서 특정 제목 조회 시 급여상세내역 불러오기
	@Override
	public List<CalSalaryFinalVO> getCalSalaryFinalList(String sal_list_id) {
		return sqlSession.selectList(NAMESPACE+".getCalSalaryFinalListForView", sal_list_id);
	}
	
	// 급여내역테이블 조회시 급여정보(형태/연/월) 가져오기
	@Override
	public calSalaryListVO getCalSalaryListForView(String sal_list_id) {
		return sqlSession.selectOne(NAMESPACE+".getCalSalaryListForView", sal_list_id);
	}
	
	
	@Override
	public List<CalSalaryFinalVO> calSalary(List<String> employeeIds, calSalaryListVO vo) {

		// 급여 기본정보 가져오기
		SalaryBasicInfoVO basciInfo = sqlSession.selectOne(NAMESPACE + ".getSalaryBasicInfo");
		double pension_rate = basciInfo.getPension_rate();
		double heal_ins_rate = basciInfo.getHeal_ins_rate();
		double long_ins_rate = basciInfo.getLong_ins_rate();
		double emp_ins_rate = basciInfo.getEmp_ins_rate();
		
		// 직급급/직무급 정보 가져오기
		SalaryRankDutyVO rankRankDutyInfo = sqlSession.selectOne(NAMESPACE + ".getSalaryRankDutyInfo");

		// 급여형태에 따른 분류(월급여/성과급/상여금)
		String sal_type = vo.getSal_type();
		
		switch (sal_type) {
		case "월급여":
			
			//최종 반환할 CalSalaryFinalVO 리스트 생성
			List<CalSalaryFinalVO> calSalaryFinalList = new ArrayList<CalSalaryFinalVO>();
			
			//salary_info_id 설정
			String sal_list_id = "s"+vo.getYear()+vo.getMonth()+vo.getSal_type();
			
			for (String employee_id : employeeIds) {
				// 직원정보 가져오기
				MemberInfoForSalaryVO memberInfo = sqlSession.selectOne(NAMESPACE + ".getMemberAllInfoForSalary",
						employee_id);
				
				// 공통사항 계산
				SalaryCalculrator salaryCalculrator = new SalaryCalculrator();
				String employee_grade = memberInfo.getEmployee_grade();
				String employee_duty = memberInfo.getEmployee_duty();
				
				int sal_grade = salaryCalculrator.checkRankSalary(employee_grade, rankRankDutyInfo);
				int sal_duty = salaryCalculrator.checkDutySalary(employee_duty, rankRankDutyInfo);
				int sal_allow = (salaryCalculrator.calAllow(sal_grade, sal_duty, memberInfo)/1000)*1000;
				int sal_total_basic = sal_grade + sal_duty + sal_allow;
				int incometax = (salaryCalculrator.calIncomeTax(sal_total_basic, basciInfo)/1000)*10;
				int pension = ((int)(sal_total_basic * pension_rate)/1000)*10;
				int heal_ins = ((int)(sal_total_basic * heal_ins_rate)/1000)*10;
				int long_ins = ((int)(heal_ins * long_ins_rate)/1000)*10;
				int emp_ins = ((int)(sal_total_basic * emp_ins_rate)/1000)*10;
				int sal_total_deduct = incometax + pension + heal_ins + long_ins + emp_ins;
				int sal_total = sal_total_basic - sal_total_deduct;
				
				CalSalaryFinalVO calSalaryFinalInfo = new CalSalaryFinalVO();
				// 근무유형(WorkType) 분류(통상,교대,시급)
				switch (memberInfo.getWorkType()) {
				case "통상근무":
				case "교대근무":
					calSalaryFinalInfo.setSal_list_id(sal_list_id);
					calSalaryFinalInfo.setEmployee_id(memberInfo.getEmployee_id());
					calSalaryFinalInfo.setEmployee_name(memberInfo.getEmployee_name());
					calSalaryFinalInfo.setEmployee_dept(memberInfo.getEmployee_dept());
					calSalaryFinalInfo.setEmployee_grade(memberInfo.getEmployee_grade());
					calSalaryFinalInfo.setEmployee_duty(memberInfo.getEmployee_duty());
					calSalaryFinalInfo.setWorkType(memberInfo.getWorkType());
					calSalaryFinalInfo.setSal_grade(sal_grade);
					calSalaryFinalInfo.setSal_duty(sal_duty);
					calSalaryFinalInfo.setSal_allow(sal_allow);
					calSalaryFinalInfo.setSal_total_basic(sal_total_basic);
					calSalaryFinalInfo.setIncometax(incometax);
					calSalaryFinalInfo.setPension(pension);
					calSalaryFinalInfo.setHeal_ins(heal_ins);
					calSalaryFinalInfo.setLong_ins(long_ins);
					calSalaryFinalInfo.setEmp_ins(emp_ins);
					calSalaryFinalInfo.setSal_total_deduct(sal_total_deduct);
					calSalaryFinalInfo.setSal_total(sal_total);
					
					calSalaryFinalList.add(calSalaryFinalInfo);
					break;

				case "시급제":
					sal_grade = 0;
					sal_duty = 0;
					sal_allow = basciInfo.getHourwage() * memberInfo.getOvertime();
					sal_total_basic = basciInfo.getHourwage()* memberInfo.getWorktime();
					incometax = (salaryCalculrator.calIncomeTax(sal_total_basic, basciInfo)/1000)*10;
					pension = ((int)(sal_total_basic * pension_rate)/1000)*10;
					heal_ins = ((int)(sal_total_basic * heal_ins_rate)/1000)*10;
					long_ins = ((int)(heal_ins * long_ins_rate)/1000)*10;
					emp_ins = ((int)(sal_total_basic * emp_ins_rate)/1000)*10;
					sal_total_deduct = incometax + pension + heal_ins + long_ins + emp_ins;
					sal_total = sal_total_basic - sal_total_deduct;
					
					calSalaryFinalInfo.setSal_list_id(sal_list_id);
					calSalaryFinalInfo.setEmployee_id(memberInfo.getEmployee_id());
					calSalaryFinalInfo.setEmployee_name(memberInfo.getEmployee_name());
					calSalaryFinalInfo.setEmployee_dept(memberInfo.getEmployee_dept());
					calSalaryFinalInfo.setEmployee_grade(memberInfo.getEmployee_grade());
					calSalaryFinalInfo.setEmployee_duty(memberInfo.getEmployee_duty());
					calSalaryFinalInfo.setWorkType(memberInfo.getWorkType());
					calSalaryFinalInfo.setSal_grade(sal_grade);
					calSalaryFinalInfo.setSal_duty(sal_duty);
					calSalaryFinalInfo.setSal_allow(sal_allow);
					calSalaryFinalInfo.setSal_total_basic(sal_total_basic);
					calSalaryFinalInfo.setIncometax(incometax);
					calSalaryFinalInfo.setPension(pension);
					calSalaryFinalInfo.setHeal_ins(heal_ins);
					calSalaryFinalInfo.setLong_ins(long_ins);
					calSalaryFinalInfo.setEmp_ins(emp_ins);
					calSalaryFinalInfo.setSal_total_deduct(sal_total_deduct);
					calSalaryFinalInfo.setSal_total(sal_total);
					
					calSalaryFinalList.add(calSalaryFinalInfo);
					break;
				}//switch 근무유형
			}//for
			return calSalaryFinalList;
		}//switch 급여형태
		return null;
		
	}//calSalary
}

//통상근무
class SalaryCalculrator {
	
	// 직급급 확인
	public int checkRankSalary(String employee_grade, SalaryRankDutyVO rankDutyInfo) {
		switch (employee_grade) {
		case "사장":
			return rankDutyInfo.getSalary_rank_ceo();
		case "부사장":
			return rankDutyInfo.getSalary_rank_vice();
		case "본부장":
			return rankDutyInfo.getSalary_rank_director();
		case "부장":
			return rankDutyInfo.getSalary_rank_depart();
		case "팀장":
			return rankDutyInfo.getSalary_rank_team();
		case "과장":
			return rankDutyInfo.getSalary_rank_manager();
		case "대리":
			return rankDutyInfo.getSalary_rank_assist();
		case "사원":
			return rankDutyInfo.getSalary_rank_staff();
		default:
			return 0;
		}
	}

	// 직무급 확인
	public int checkDutySalary(String employee_duty, SalaryRankDutyVO rankDutyInfo) {
		switch (employee_duty) {
		case "직무1":
			return rankDutyInfo.getSalary_duty1();
		case "직무2":
			return rankDutyInfo.getSalary_duty2();
		case "직무3":
			return rankDutyInfo.getSalary_duty3();
		case "직무4":
			return rankDutyInfo.getSalary_duty4();
		case "직무5":
			return rankDutyInfo.getSalary_duty5();
		case "직무6":
			return rankDutyInfo.getSalary_duty6();
		case "직무7":
			return rankDutyInfo.getSalary_duty7();
		case "직무8":
			return rankDutyInfo.getSalary_duty8();
		case "직무9":
			return rankDutyInfo.getSalary_duty9();
		case "직무10":
			return rankDutyInfo.getSalary_duty10();
		default:
			return 0;
		}
	}
	
	// 수당계산(초과,야간 = 50%, 특근 = 100%)
	public int calAllow(int sal_grade, int sal_duty, MemberInfoForSalaryVO memberInfo) {
		//통상임금 계산
		int nomalWage = (sal_grade + sal_duty)/209;
		System.out.println("nomalWage:"+nomalWage);
		int sal_allow = (int)((nomalWage*(memberInfo.getOvertime() + memberInfo.getNighttime())*0.5) + 
				(nomalWage*memberInfo.getSpecialtime()));
		System.out.println("Overtime:" +memberInfo.getOvertime());
		System.out.println("Nighttime:" +memberInfo.getNighttime());
		
		
		System.out.println("sal_allow :" +sal_allow);
		return sal_allow;
	}
	
	//소득세 계산
	public int calIncomeTax(int sal_total_basic, SalaryBasicInfoVO basciInfo) {
		if(sal_total_basic*12 < 14000000) {
			return (int)(sal_total_basic * basciInfo.getIncometax_rate1());
		} else if(sal_total_basic*12 < 50000000) {
			return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
					(sal_total_basic-14000000/12)*basciInfo.getIncometax_rate2());
		} else if(sal_total_basic < (int)88000000/12) {
			return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
					(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
					(sal_total_basic - 50000000/12)*basciInfo.getIncometax_rate3());
		} else if(sal_total_basic < (int)150000000/12) {
			return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
					(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
					(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
					(sal_total_basic - 88000000/12)*basciInfo.getIncometax_rate4());
		} else if(sal_total_basic < (int)300000000/12) {
			return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
					(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
					(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
					(150000000/12 - 88000000/12)*basciInfo.getIncometax_rate4() +
					(sal_total_basic - 150000000/12)*basciInfo.getIncometax_rate5());
		} else if(sal_total_basic < (int)500000000/12) {
			return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
					(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
					(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
					(150000000/12 - 88000000/12)*basciInfo.getIncometax_rate4() +
					(300000000/12 - 150000000/12)*basciInfo.getIncometax_rate5() +
					(sal_total_basic - 300000000/12)*basciInfo.getIncometax_rate6());
		} else if(sal_total_basic < (int)1000000000/12) {
			return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
					(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
					(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
					(150000000/12 - 88000000/12)*basciInfo.getIncometax_rate4() +
					(300000000/12 - 150000000/12)*basciInfo.getIncometax_rate5() +
					(500000000/12 - 300000000/12)*basciInfo.getIncometax_rate6() +
					(sal_total_basic - 500000000/12)*basciInfo.getIncometax_rate7());
		} else {
			return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
					(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
					(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
					(150000000/12 - 88000000/12)*basciInfo.getIncometax_rate4() +
					(300000000/12 - 150000000/12)*basciInfo.getIncometax_rate5() +
					(500000000/12 - 300000000/12)*basciInfo.getIncometax_rate6() +
					(1000000000/12 - 500000000/12)*basciInfo.getIncometax_rate7() +
					(sal_total_basic - 1000000000/12)*basciInfo.getIncometax_rate8());
		}
	}

}
