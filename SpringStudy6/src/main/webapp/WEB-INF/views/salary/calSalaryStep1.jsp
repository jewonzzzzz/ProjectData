<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  </head>
  <body>
  
  
    <div class="wrapper">
      <!-- Sidebar -->
      <%@ include file="/resources/assets/inc/sidebar.jsp" %>
      <!-- End Sidebar -->

      <div class="main-panel">
        <!-- Navbar Header -->
        <%@ include file="/resources/assets/inc/header.jsp" %>
        <!-- End Navbar Header -->

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
            
            <form id="submitForm" action="/salary/calSalaryStep2" method="post">
            <div class="row">
            <div class="col-sm-6 col-md-4">
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
                          <p class="card-category">Step3</p>
                          <h4 class="card-title">급여산출</h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            
            
              <div class="col-md-10">
                <div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">급여형태/귀속연월 설정</div>
                    <div class="card-category">
                      급여형태와 귀속연도를 설정합니다. <b>기존과 동일한 내역이 있으면 작성되지 않습니다.</b>
                    </div>
                  </div>
                  <div class="card-body">
                    <div class="form">
                      <div class="form-group form-show-notify row">
                        <div class="col-lg-3 col-md-3 col-sm-4 text-end">
                          <label>급여형태 :</label>
                        </div>
                        <div class="col-lg-4 col-md-9 col-sm-8">
                          <select
                            class="form-select input-fixed"
                            id="notify_placement_from"
                            name="sal_type"
                          >
                            <option value="월급여">월급여</option>
                            <option value="성과급">성과급</option>
                            <option value="상여금">상여금</option>
                          </select>
                        </div>
                      </div>
                      <div class="form-group form-show-notify row">
                        <div class="col-lg-3 col-md-3 col-sm-4 text-end">
                          <label>연도 :</label>
                        </div>
                        <div class="col-lg-4 col-md-9 col-sm-8">
                          <select
                            class="form-select input-fixed"
                            id="yearSelect"
                            name="year"
                          >
                          </select>
                        </div>
                      </div>
                      <div class="form-group form-show-notify row">
                        <div class="col-lg-3 col-md-3 col-sm-4 text-end">
                          <label>월 :</label>
                        </div>
                        <div class="col-lg-4 col-md-9 col-sm-8">
                          <select
                            class="form-select input-fixed"
                            id="monthSelect"
                            name="month"
                          >
                          </select>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="card-footer">
                    <div class="form">
                      <div class="form-group from-show-notify row">
                        <div class="col-lg-3 col-md-3 col-sm-12"></div>
                        <div class="col-lg-4 col-md-9 col-sm-12">
                          <button id="nextBtn" class="btn btn-primary">
                            다음으로
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              </div>
            </div>
            </form>
            
            </div>
           </div>
           <%@ include file="/resources/assets/inc/footer.jsp" %>
          </div>
         </div>
            
    
    
    <script>
        $(document).ready(function() {
        	
            // 현재 연도 구하기
            const currentYear = new Date().getFullYear();
            
            // 최근 10년간의 연도 추가
            for (let year = currentYear; year > currentYear - 3; year--) {
                $('#yearSelect').append(new Option(year, year));  // Option 생성 및 추가
            }
            
            for (let month = 1; month <= 12; month++) {
                $('#monthSelect').append(new Option(month, month));  // Option 생성 및 추가
            }
            
         // 다음으로 버튼 시 사번가지고 이동하기
            $('#nextBtn').click(function(event){
            	event.preventDefault();
            	
            	var checkSalaryInfo = [];
            	$('option:checked').each(function () {
            		checkSalaryInfo.push($(this).val());
                });
            	
            	$.ajax({
            		url:'/salary/checkCreateSalary',
            		type: 'POST',
            		data: JSON.stringify(checkSalaryInfo),
            		contentType: 'application/json',
            		success: function(response) {
            			// 중복여부 체크
            			if(response === 'ok'){
            				$('#submitForm').submit();
            			} else{
                        	swal("Error!", "중복된 입력정보가 있습니다." , "error");
            			}
            		},
            		error: function(xhr, status, error) {
                        swal("Error!", "실패", "error");
                    }
            	});
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

    <!-- Kaiadmin JS -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/kaiadmin.min.js"></script>

    <!-- Kaiadmin DEMO methods, don't include it in your project! -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/setting-demo.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/demo.js"></script>

  </body>
</html>