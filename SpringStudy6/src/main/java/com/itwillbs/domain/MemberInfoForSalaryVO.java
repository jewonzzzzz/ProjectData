package com.itwillbs.domain;

import java.util.List;

import lombok.Data;

@Data
public class MemberInfoForSalaryVO {

	private String employee_id;
	private String employee_name;
	private String employee_dept;
	private String employee_grade;
	private String employee_duty;
	private String workType;
	private int worktime;
	private int overtime;
	private int nighttime;
	private int specialtime;
	
}
