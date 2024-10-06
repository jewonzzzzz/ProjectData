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

			List<CalSalaryFinalVO> fvoList = new ArrayList<CalSalaryFinalVO>();
			
			//salary_info_id 설정
			String result = sqlSession.selectOne(NAMESPACE+".getSalListId");
			String salary_info_id;
			LocalDate currentDate = LocalDate.now(); // 현재 날짜 가져오기
	        int year = currentDate.getYear(); // 연도 가져오기
	        int month = currentDate.getMonthValue(); // 월 가져오기 (1~12)
			
	        //// 여기작업중
			if(result == null) {
				salary_info_id = "s"+year+month;
			} else {
				salary_info_id = result + 1;
			}
			
			
			for (String employee_id : employeeIds) {
				// 직원정보 가져오기
				MemberInfoForSalaryVO memberInfo = sqlSession.selectOne(NAMESPACE + ".getMemberInfoForSalary",
						employee_id);
				
				//통상근무
				SalaryCalculrator salaryCalculrator = new SalaryCalculrator(basciInfo, rankRankDutyInfo, memberInfo);
				String employee_grade = memberInfo.getEmployee_grade();
				String employee_duty = memberInfo.getEmployee_duty();
				
				int sal_grade = salaryCalculrator.checkRankSalary(employee_grade, rankRankDutyInfo);
				int sal_duty = salaryCalculrator.checkDutySalary(employee_duty, rankRankDutyInfo);
				int sal_allow = (salaryCalculrator.calAllow(sal_grade, sal_duty, memberInfo)/1000)*1000;
				int sal_total_basic = sal_grade + sal_duty + sal_allow;
				int incometax = (salaryCalculrator.calIncomeTax(sal_total_basic, basciInfo)/1000)*1000;
				int pension = ((int)(sal_total_basic * pension_rate)/1000)*1000;
				int heal_ins = ((int)(sal_total_basic * heal_ins_rate)/1000)*1000;
				int long_ins = ((int)(heal_ins * long_ins_rate)/1000)*1000;
				int emp_ins = ((int)(sal_total_basic * emp_ins_rate)/1000)*1000;
				int sal_total_deduct = incometax + pension + heal_ins + long_ins + emp_ins;
				int sal_total = sal_total_basic - sal_total_deduct;
				
				CalSalaryFinalVO fvo = new CalSalaryFinalVO();
				
				
				
			}
			break;

		default:
			break;
		}

		return null;
	}
}

//통상근무
class SalaryCalculrator {
	SalaryBasicInfoVO basciInfo;
	SalaryRankDutyVO rankDutyInfo;
	MemberInfoForSalaryVO memberInfo;
	
	public SalaryCalculrator(SalaryBasicInfoVO basciInfo, SalaryRankDutyVO rankDutyInfo, MemberInfoForSalaryVO memberInfo) {
		this.basciInfo = basciInfo;
		this.rankDutyInfo = rankDutyInfo;
		this.memberInfo = memberInfo;
	}
	
	// 기본급 계산 = 직급급 + 직무급 + 수당
	
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
		int sal_allow = (int)((nomalWage*(memberInfo.getOvertime() + memberInfo.getNighttime())*0.5) + 
				(nomalWage * memberInfo.getSpecialtime()));
		return sal_allow;
	}
	
	//소득세 계산
	public int calIncomeTax(int sal_total_basic, SalaryBasicInfoVO basciInfo) {
		if(sal_total_basic < (int)14000000/12) {
			return (int)(sal_total_basic * basciInfo.getIncometax_rate1());
		} else if(sal_total_basic < (int)50000000/12) {
			return (int)((14000000/12*basciInfo.getIncometax_rate1()) + 
					(sal_total_basic-14000000/12)*basciInfo.getIncometax_rate2());
		} else if(sal_total_basic < (int)88000000/12) {
			return (int)((14000000/12*basciInfo.getIncometax_rate1()) + 
					(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
					(sal_total_basic - 50000000/12)*basciInfo.getIncometax_rate3());
		} else if(sal_total_basic < (int)150000000/12) {
			return (int)((14000000/12*basciInfo.getIncometax_rate1()) + 
					(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
					(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
					(sal_total_basic - 88000000/12)*basciInfo.getIncometax_rate4());
		} else if(sal_total_basic < (int)300000000/12) {
			return (int)((14000000/12*basciInfo.getIncometax_rate1()) + 
					(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
					(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
					(150000000/12 - 88000000/12)*basciInfo.getIncometax_rate4() +
					(sal_total_basic - 150000000/12)*basciInfo.getIncometax_rate5());
		} else if(sal_total_basic < (int)500000000/12) {
			return (int)((14000000/12*basciInfo.getIncometax_rate1()) + 
					(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
					(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
					(150000000/12 - 88000000/12)*basciInfo.getIncometax_rate4() +
					(300000000/12 - 150000000/12)*basciInfo.getIncometax_rate5() +
					(sal_total_basic - 300000000/12)*basciInfo.getIncometax_rate6());
		} else if(sal_total_basic < (int)1000000000/12) {
			return (int)((14000000/12*basciInfo.getIncometax_rate1()) + 
					(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
					(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
					(150000000/12 - 88000000/12)*basciInfo.getIncometax_rate4() +
					(300000000/12 - 150000000/12)*basciInfo.getIncometax_rate5() +
					(500000000/12 - 300000000/12)*basciInfo.getIncometax_rate6() +
					(sal_total_basic - 500000000/12)*basciInfo.getIncometax_rate7());
		} else {
			return (int)((14000000/12*basciInfo.getIncometax_rate1()) + 
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
