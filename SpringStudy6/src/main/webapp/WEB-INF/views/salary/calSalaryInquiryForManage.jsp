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
              <h3 class="fw-bold mb-3">급여조회(관리자)</h3>
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
                  <a href="#">급여조회(관리자)</a>
                </li>
              </ul>
            </div>
            
            <div class="row">
              <div class="col-md-10">
              <div class="form">
                      <div style="display: flex; margin-bottom: 10px;">
                          <select
                          	style="margin-right: 5px;"
                            class="form-select input-fixed"
                            id="yearSelect"
                            name="year"
                          >
                          </select>
                          <div style="width: 200px; margin-right: 5px">
                          <input
                              type="text"
                              class="form-control input-full"
                              id="employeeInfo"
                              placeholder="사번/이름을 입력하세요"
                            />
                           </div>
                          <button type="button" class="btn btn-primary" id="inquiryBtn"> 조회하기 </button>
                    </div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">급여내역 조회</div>
                  </div>
                  
                  <div class="card-body">
                    <div class="table-responsive">
                      <table
                        id="basic-datatables"
                        class="display table table-striped table-hover"
                      >
                        <thead>
                          <tr>
                          <th>사번</th>
                          <th>급여유형</th>
                          <th>연도</th>
                          <th>월</th>
                          <th>(세전)급여액</th>
                          <th>공제금 총액</th>
                          <th>(세후)실지급액</th>
                          <th>비고</th>
                          </tr>
                        </thead>
                        <tbody>
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
        	$('table th td').wrap('<div style="text-align: center;"></div>');
        	
        	// 현재 연도 구하기
            const currentYear = new Date().getFullYear();
            
            for (let year = currentYear; year > currentYear - 10; year--) {
                $('#yearSelect').append(new Option(year, year));  // Option 생성 및 추가
            }
            
         	// 조회 버튼 시 연/월/사번가지고 조회하기
            $('#inquiryBtn').click(function(event){
            	var checkSalaryInfo = [];
            	checkSalaryInfo.push($('#yearSelect').val());
            	checkSalaryInfo.push($('#employeeInfo').val());
            	
            	$.ajax({
            		url:'/salary/getCalSalaryInquiryForManage',
            		type: 'POST',
            		data: JSON.stringify(checkSalaryInfo),
            		contentType: 'application/json',
            		success: function(response) {
            			swal("Success!", "직원 급여정보 조회완료", "success");
                        $('#basic-datatables tbody').empty();
            			response.forEach(function(data){
                        	var row = '<tr>' +
                            '<td style="text-align: center;">' + data.employee_id + '</td>' +
                            '<td style="text-align: center;">' + data.sal_type + '</td>' +
                            '<td style="text-align: center;">' + data.year + '</td>' +
                            '<td style="text-align: center;">' + data.month + '</td>' +
                            '<td style="text-align: center;">' + data.sal_total_basic + '</td>' +
                            '<td style="text-align: center;">' + data.sal_total_deduct + '</td>' +
                            '<td style="text-align: center;">' + data.sal_total + '</td>' +
                            '<td style="text-align: center;"><a href="/salary/salaryDetail?sal_final_id=' + data.sal_final_id + '">상세보기</a></td>' +
                            '</tr>';
                            $('#basic-datatables tbody').append(row);
                        });
            		},
            		error: function(xhr, status, error) {
                        swal("Error!", "실패", "error");
                    }
            	});
            });
            
            $("#basic-datatables").DataTable({
            	pageLength: 5,
            });
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