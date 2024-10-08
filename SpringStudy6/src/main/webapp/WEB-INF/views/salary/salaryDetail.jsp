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
                  <a href="#">급여조회</a>
                </li>
              </ul>
            </div>
            
            <div class="row">
                <div class="col-md-10">
					<div class="card">
						<div class="card-header" style="display: flex; justify-content: space-between;">
							<h3 class="card-title">급여조회 상세내역</h3>
							<button type="button" class="btn btn-primary" onclick="history.back()">
                            	이전으로
                            </button>
						</div>
								<div class="card-body">
									<div class="row">
										<div class="col-5 col-md-3">
											<div class="nav flex-column nav-pills nav-secondary" id="v-pills-tab" role="tablist" aria-orientation="vertical">
												<a class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">종합내역</a>
												<a class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">급여 항목</a>
												<a class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false">공제금 항목</a>
											</div>
										</div>
										<div class="col-8 col-md-9">
											<div class="tab-content" id="v-pills-tabContent">
												<div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
													<label class="mb-3"><b>직원 기본정보</b></label>
													<table class="table table-bordered" id="calSalaryTable">
                        <thead>
                          <tr>
                            <th>사번</th>
                            <th>이름</th>
                            <th>직급</th>
                            <th>직무</th>
                            <th>근무형태</th>
                          </tr>
                        </thead>
                        <tbody>
                        	<tr>
								<td>${calSalaryFinalInfo.employee_id }</td>                        	
								<td>${calSalaryFinalInfo.employee_name }</td>                        	
								<td>${calSalaryFinalInfo.employee_grade }</td>                        	
								<td>${calSalaryFinalInfo.employee_duty }</td>                        	
								<td>${calSalaryFinalInfo.workType }</td>                        	
                        	</tr>
                        </tbody>
                      </table>
                      <label class="mb-3"><b>급여 종합내역</b></label>
                      <table class="table table-bordered" id="calSalaryTable">
                        <thead>
                          <tr>
                            <th>귀속연도</th>
                            <th>귀속월</th>
                            <th>(세전)급여액</th>
                            <th>공제금</th>
                            <th>(세후)실지급액</th>
                          </tr>
                        </thead>
                        <tbody>
                        	<tr>
								<td>${calSalaryFinalInfo.year }</td>                        	
								<td>${calSalaryFinalInfo.month }</td>                        	
								<td>${calSalaryFinalInfo.sal_total_basic }</td>                        	
								<td>${calSalaryFinalInfo.sal_total_deduct }</td>                        	
								<td>${calSalaryFinalInfo.sal_total }</td>                        	
                        	</tr>
                        </tbody>
                      </table>
						</div>
						<div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
						<label class="mb-3"><b>급여 항목</b></label>
						<table class="table table-bordered" id="calSalaryTable">
                        <thead>
                          <tr>
                            <th>(세전)급여액</th>
                            <th>직급급</th>
                            <th>직무급</th>
                            <th>법정수당</th>
                          </tr>
                        </thead>
                        <tbody>
                        	<tr>
								<td>${calSalaryFinalInfo.sal_total_basic }</td>                        	
								<td>${calSalaryFinalInfo.sal_grade }</td>                        	
								<td>${calSalaryFinalInfo.sal_duty }</td>                        	
								<td>${calSalaryFinalInfo.sal_allow }</td>                        	
                        	</tr>
                        </tbody>
                      </table>
                      <p> * (세전)급여액 산출식 : 직급급 + 직무급 + 법정수당<br>
                       * 법정수당 산출식 : 통상임금 * ((초과근무시간 + 야간근로시간) * 0.5) + 특별근로시간)</p>
                      
						</div>
						<div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
						<label class="mb-3"><b>공제금 항목</b></label>
						<table class="table table-bordered" id="calSalaryTable">
                        <thead>
                          <tr>
                            <th>공제금</th>
                            <th>소득세</th>
                            <th>국민연금</th>
                            <th>건강보험료</th>
                            <th>장기요양보험료</th>
                            <th>고용보험료</th>
                          </tr>
                        </thead>
                        <tbody>
                        	<tr>
								<td>${calSalaryFinalInfo.sal_total_deduct }</td>                        	
								<td>${calSalaryFinalInfo.incometax }</td>                        	
								<td>${calSalaryFinalInfo.pension }</td>                        	
								<td>${calSalaryFinalInfo.heal_ins }</td>                        	
								<td>${calSalaryFinalInfo.long_ins }</td>                        	
								<td>${calSalaryFinalInfo.emp_ins }</td>                        	
                        	</tr>
                        </tbody>
                      </table>
                      <p> * 공제금 산출식 : 소득세 + 국민연금 + 건강보험료 + 장기요양보험료 + 고용보험료</p>
												</div>
											</div>
										</div>
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