package com.itwillbs.domain;

import lombok.Data;

@Data
public class CalSalaryFinalVO {

	private int sal_final_id;
	private String sal_list_id;
	private String employee_id;
	private String employee_name;
	private String employee_dept;
	private String employee_grade;
	private String employee_duty;
	private String workType;
	private String year;
	private String month;
	private String sal_type;
	private int sal_grade;
	private int sal_duty;
	private int sal_allow;
	private int sal_total_basic;
	private int incometax;
	private int pension;
	private int heal_ins;
	private int long_ins;
	private int emp_ins;
	private int sal_total_deduct;
	private int sal_total;
	
}
