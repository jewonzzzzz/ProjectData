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
  
  <%-- ${salaryRankDutyInfo } --%>
  
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
              <h3 class="fw-bold mb-3">직급급/직무급 설정</h3>
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
                  <a href="#">직급급/직무급 설정</a>
                </li>
              </ul>
            </div>
            
            <div class="row">
              <div class="col-md-10">
                <div class="card">
                <form action="/salary/salaryRankDutyInfo" method="post">
                  <div class="card-header">
                    <div class="card-title">직급급/직무급 설정</div>
                  </div>
                  <div class="card-body">
                    <div class="row">
                      <div class="col-md-6 col-lg-4">
                        <div class="form-group">
                        <label class="mb-3"><b>직급급 정보</b></label>
                          <div class="input-group mb-3">
                            <span class="input-group-text">사장 직급급&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_rank_ceo"
                              value="${salaryRankDutyInfo.salary_rank_ceo }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">부사장 직급급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_rank_vice"
                              value="${salaryRankDutyInfo.salary_rank_vice }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">본부장 직급급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_rank_director"
                              value="${salaryRankDutyInfo.salary_rank_director }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">부장 직급급&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_rank_depart"
                              value="${salaryRankDutyInfo.salary_rank_depart }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">팀장 직급급&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_rank_team"
                              value="${salaryRankDutyInfo.salary_rank_team }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">과장 직급급&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_rank_manager"
                              value="${salaryRankDutyInfo.salary_rank_manager }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">대리 직급급&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_rank_assist"
                              value="${salaryRankDutyInfo.salary_rank_assist }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">직원 직급급&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_rank_staff"
                              value="${salaryRankDutyInfo.salary_rank_staff }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          
                        </div>
                      </div>
                      
                      <div class="col-md-6 col-lg-4">
                        <div class="form-group">
                        <label class="mb-3"><b>직무급 정보</b></label>
                          <div class="input-group mb-3">
                            <span class="input-group-text">직무1 직무급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_duty1"
                              value="${salaryRankDutyInfo.salary_duty1 }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">직무2 직무급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_duty2"
                              value="${salaryRankDutyInfo.salary_duty2 }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">직무3 직무급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_duty3"
                              value="${salaryRankDutyInfo.salary_duty3 }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">직무4 직무급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_duty4"
                              value="${salaryRankDutyInfo.salary_duty4 }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">직무5 직무급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_duty5"
                              value="${salaryRankDutyInfo.salary_duty5 }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">직무6 직무급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_duty6"
                              value="${salaryRankDutyInfo.salary_duty6 }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">직무7 직무급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_duty7"
                              value="${salaryRankDutyInfo.salary_duty7 }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">직무8 직무급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_duty8"
                              value="${salaryRankDutyInfo.salary_duty8 }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          
                        </div>
                      </div>
                      
                      <div class="col-md-6 col-lg-4">
                        <div class="form-group">
                        <label class="mb-3">&nbsp;</label>
                          <div class="input-group mb-3">
                            <span class="input-group-text">직무9 직무급&nbsp;</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_duty9"
                              value="${salaryRankDutyInfo.salary_duty9 }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">직무10 직무급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="salary_duty10"
                              value="${salaryRankDutyInfo.salary_duty10 }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          
                        </div>
                      </div>
                      
                      
                    </div>
                  </div>
                  <div class="card-action">
                    <button class="btn btn-success" id="alert_demo_3_1" type="submit">저장하기</button>
                  </div>
                  </form>
                </div>
              </div>
          </div>
        </div>

        <%@ include file="/resources/assets/inc/footer.jsp" %>
      </div>
     </div> 
    </div>
    	
    <script>
        $(document).ready(function() {
            // 모든 input 요소의 텍스트를 오른쪽으로 정렬
            $('input').css('text-align', 'right');
            
        	 // 쉼표 추가 함수
            function addCommas(value) {
                return value.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }

            // 페이지 로드 시 특정 입력 필드의 값에 쉼표 추가
            $('input').each(function() {
                var originalValue = $(this).val();  // 입력 필드의 기존 값 가져오기
                if (originalValue) {  // 값이 존재하면 쉼표 추가
                    var formattedValue = addCommas(originalValue);
                    $(this).val(formattedValue);  // 포맷된 값으로 업데이트
                }
            });
            
            
            
            $("#alert_demo_3_1").click(function (event) {
            	  event.preventDefault();  // 기본 동작 막기
            	  
            	  // 1. 모든 쉼표를 제거하는 함수
            	  function removeCommas(value) {
            	    return value.replace(/,/g, '');
            	  }

            	  // 2. 특정 form 안의 모든 input 필드의 쉼표 제거
            	  $(this).closest("form").find("input").each(function() {
            	    var cleanedValue = removeCommas($(this).val());  // 각 input 필드의 쉼표 제거
            	    $(this).val(cleanedValue);  // 제거한 값으로 업데이트
            	  });

            	  swal("저장되었습니다.", {
            	    icon: "success",
            	    buttons: {
            	      confirm: {
            	        className: "btn btn-success",
            	      },
            	    },
            	  }).then(function() {  
            	    $(this).closest("form").submit(); 
            	  }.bind(this)); 
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