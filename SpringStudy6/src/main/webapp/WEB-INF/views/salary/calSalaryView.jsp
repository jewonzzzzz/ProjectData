<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>2조 프로젝트</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="${pageContext.request.contextPath }/resources/assets/img/kaiadmin/favicon.ico"
      type="image/x-icon"
    />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.4.19/sweetalert2.min.css">
    <!-- Fonts and icons -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/webfont/webfont.min.js"></script>
    <script>
      WebFont.load({
        google: { families: ["Public Sans:300,400,500,600,700"] },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["${pageContext.request.contextPath }/resources/assets/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/kaiadmin.min.css" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />
    <style>
    .table-responsive {
  overflow-x: auto; /* 가로 스크롤 활성화 */
}

.table th, .table td {
  white-space: nowrap; /* 텍스트가 줄바꿈되지 않도록 설정 */
}

.table th {
  min-width: 100px; /* 각 열의 최소 너비 설정 */
  text-align: center; /* 텍스트 중앙 정렬 */
}
    
    </style>
    
  </head>
  <body>
  	<%-- ${calSalaryFinalInfo } --%>
  	<%-- ${calSalaryListInfo } --%>
    <div class="wrapper">
    
      <%@ include file="/resources/assets/inc/sidebar.jsp" %>

      <div class="main-panel">
        <%@ include file="/resources/assets/inc/header.jsp" %>

        <div class="container">
          <div class="page-inner">
            <div class="page-header">
              <h3 class="fw-bold mb-3">급여산출</h3>
              <ul class="breadcrumbs mb-3">
                <li class="nav-home">
                  <a href="/salary/main">
                    <i class="icon-home"></i>
                  </a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="/salary/salaryBasicInfo">급여관리</a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="#">급여산출</a>
                </li>
              </ul>
            </div>
            
            <div class="row">
            <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-round">
                  <div class="card-body">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div
                          class="icon-big text-center icon-primary bubble-shadow-small"
                        >
                          <i class="fas fa-users"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div class="numbers">
                          <p class="card-category">Step1</p>
                          <h4 class="card-title">급여형태/귀속연월 설정</h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-round">
                  <div class="card-body" id="second_card">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div
                          class="icon-big text-center icon-primary bubble-shadow-small"
                        >
                          <i class="fas fa-users"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div class="numbers">
                          <p class="card-category">Step2</p>
                          <h4 class="card-title">직원정보 조회</h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="col-sm-6 col-md-4" >
                <div class="card card-stats card-round">
                  <div class="card-body">
                    <div class="row align-items-center" >
                      <div class="col-icon">
                        <div
                          class="icon-big text-center icon-primary bubble-shadow-small"
                        >
                          <i class="fas fa-users"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0" >
                        <div class="numbers">
                          <p class="card-category">Step3</p>
                          <h4 class="card-title">급여산출</h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
              
              <div class="col-md-10">
              	<div style="margin-bottom: 10px; display: flex; justify-content: flex-end;;">
              	<button type="button" id="saveBtn" class="btn btn-primary">
                            저장하기
                 </button>
              	</div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">급여산출 종합내역</div>
                  </div>
                  
                  <div class="card-body">
                    <table class="table table-bordered" id="resultTable">
                      <thead>
                        <tr>
                          <th>급여유형</th>
                          <th>연도</th>
                          <th>월</th>
                          <th>대상 인원</th>
                          <th>(세전)급여 총액</th>
                          <th>공제금 총액</th>
                          <th>(세후)실지급액 총액</th>
                        </tr>
                      </thead>
                      <tbody>
                      	<tr>
                      	  <td>${calSalaryListInfo.sal_type }</td>
                      	  <td>${calSalaryListInfo.year }</td>
                      	  <td>${calSalaryListInfo.month }</td>
                      	  <td id="sumMember"></td>
                      	  <td id="sumSalBasic"></td>
                      	  <td id="sumSalDeduct"></td>
                      	  <td id="sumSalTotal"></td>
                      	</tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              
              	<div class="col-md-10">
              <div class="card">
                  <div class="card-header">
                    <div class="card-title">급여산출 상세내역</div>
                  </div>
                  <div class="card-body">
                    <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                      <table class="table table-bordered" id="calSalaryTable">
                        <thead>
                          <tr>
                            <th>사번</th>
                            <th>이름</th>
                            <th>부서</th>
                            <th>직급</th>
                            <th>직무</th>
                            <th>근무형태</th>
                            <th>직급급</th>
                            <th>직무급</th>
                            <th>법정수당</th>
                            <th>기본급(세전급여액)</th>
                            <th>소득세</th>
                            <th>국민연금</th>
                            <th>건강보험료</th>
                            <th>장기요양보험료</th>
                            <th>고용보험료</th>
                            <th>공제금 합계</th>
                            <th>실지급액(세후급여액)</th>
                          </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="list" items="${calSalaryFinalInfo }">
                        	<tr>
								<td class="employee_id">${list.employee_id }</td>                        	
								<td>${list.employee_name }</td>                        	
								<td>${list.employee_dept }</td>                        	
								<td>${list.employee_grade }</td>                        	
								<td>${list.employee_duty }</td>                        	
								<td>${list.workType }</td>                        	
								<td>${list.sal_grade }</td>                        	
								<td>${list.sal_duty }</td>                        	
								<td>${list.sal_allow }</td>                        	
								<td class="salBasic">${list.sal_total_basic }</td>                        	
								<td>${list.incometax }</td>                        	
								<td>${list.pension }</td>                        	
								<td>${list.heal_ins }</td>                        	
								<td>${list.long_ins }</td>                        	
								<td>${list.emp_ins }</td>                        	
								<td class="salDeduct">${list.sal_total_deduct }</td>                        	
								<td class="salTotal">${list.sal_total }</td>                        	
                        	</tr>
                        </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
                </div>
            </div>
            </div>
           </div>
           <%@ include file="/resources/assets/inc/footer.jsp" %>
          </div>
         </div>
            
    <script>
        $(document).ready(function() {
     		
        	// 테이블 가운대 정렬
        	$('table').wrap('<div style="text-align: center;"></div>');
        	
        	// 화면로드 시 기본급,공제금,실지급액 합 계산 및 출력
        	let sumSalBasic = 0;
        	$('td.salBasic').each(function(){
        		sumSalBasic += parseInt($(this).text());
        	});
            $('#sumSalBasic').text(sumSalBasic);
            
        	let sumSalDeduct = 0;
        	$('td.salDeduct').each(function(){
        		sumSalDeduct += parseInt($(this).text());
        	});
            $('#sumSalDeduct').text(sumSalDeduct);
            
        	let sumSalTotal = 0;
        	$('td.salTotal').each(function(){
        		sumSalTotal += parseInt($(this).text());
        	});
            $('#sumSalTotal').text(sumSalTotal);
            
            // 대상인원 출력
            $('#sumMember').text($('#calSalaryTable tbody tr').length);
            
        });
    </script>
    
    <!--   Core JS Files   -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/core/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/core/popper.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js"></script>

    <!-- jQuery Scrollbar -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

    <!-- Chart JS -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/chart.js/chart.min.js"></script>

    <!-- jQuery Sparkline -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

    <!-- Chart Circle -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/chart-circle/circles.min.js"></script>

    <!-- Datatables -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/datatables/datatables.min.js"></script>

    <!-- Bootstrap Notify -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

    <!-- jQuery Vector Maps -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jsvectormap/jsvectormap.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jsvectormap/world.js"></script>

    <!-- Sweet Alert -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/sweetalert/sweetalert.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.4.19/sweetalert2.min.js"></script>

    <!-- Kaiadmin JS -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/kaiadmin.min.js"></script>

    <!-- Kaiadmin DEMO methods, don't include it in your project! -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/setting-demo.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/demo.js"></script>

  </body>
</html>