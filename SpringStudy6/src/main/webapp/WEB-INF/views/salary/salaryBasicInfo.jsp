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

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/kaiadmin.min.css" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />
  </head>
  <body>
  	<%-- ${salaryBasicInfo } --%>
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
              <h3 class="fw-bold mb-3">기본급여정보 설정</h3>
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
                  <a href="#">급여기본정보 설정</a>
                </li>
              </ul>
            </div>
            
            <div class="row">
              <div class="col-md-10">
                <div class="card">
                <form action="/salary/salaryBasicInfo" method="post">
                  <div class="card-header">
                    <div class="card-title">시급/세율정보 설정</div>
                  </div>
                  <div class="card-body">
                    <div class="row">
                      
                      <div class="col-md-6 col-lg-4">
                        <div class="form-group">
                          <label class="mb-3"><b>시급정보</b></label>
                          <div class="input-group mb-3">
                            <span class="input-group-text">시급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="hourwage"
                              value="${salaryBasicInfo.hourwage }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                        </div>
                        
                        <div class="form-group">
                          <label class="mb-3"><b>4대보험 보험료율</b></label>
                          <div class="input-group mb-3">
                            <span class="input-group-text">국민연금 보험료율</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="pension_rate"
                              value="${salaryBasicInfo.pension_rate }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">건강보험 보험료율</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="heal_ins_rate"
                              value="${salaryBasicInfo.heal_ins_rate }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">장기요양 보험료율</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="long_ins_rate"
                              value="${salaryBasicInfo.long_ins_rate }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">고용보험 보험료율</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="emp_ins_rate"
                              value="${salaryBasicInfo.emp_ins_rate }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          
                        </div>
                      </div>
                      
                      <div class="col-md-6 col-lg-4">
                        <div class="form-group">
                        <label class="mb-3"><b>소득세율</b></label>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 1구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate1"
                              value="${salaryBasicInfo.incometax_rate1 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 2구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate2"
                              value="${salaryBasicInfo.incometax_rate2 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 3구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate3"
                              value="${salaryBasicInfo.incometax_rate3 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 4구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate4"
                              value="${salaryBasicInfo.incometax_rate4 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 5구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate5"
                              value="${salaryBasicInfo.incometax_rate5 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 6구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate6"
                              value="${salaryBasicInfo.incometax_rate6 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 7구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate7"
                              value="${salaryBasicInfo.incometax_rate7 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 8구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate8"
                              value="${salaryBasicInfo.incometax_rate8 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                        </div>
                      </div>
                      
                      <div class="col-md-6 col-lg-4">
                        <div class="form-group">
                        <label class="mb-3"><b>소득세율정보</b></label>
                          <div class="input-group mb-3">
                            <p>
                             * 소득세율 1구간 : 1400만원 이하<br>
                             * 소득세율 2구간 : 1400만원 초과 5000만원 이하<br>
                             * 소득세율 3구간 : 5000만원 초과 8800만원 이하<br>
                             * 소득세율 4구간 : 8800만원 초과 1억5000만원 이하<br>
                             * 소득세율 5구간 : 1억5000만원 초과 3억 이하<br>
                             * 소득세율 6구간 : 3억원 초과 5억 이하<br>
                             * 소득세율 7구간 : 5억원 초과 10억 이하<br>
                             * 소득세율 8구간 : 10억 초과<br>
                           </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="card-action">
                    <button class="btn btn-success" type="submit">저장하기</button>
                  </div>
                  </form>
                </div>
              </div>
          </div>
        </div>

        <footer class="footer">
          <div class="container-fluid d-flex justify-content-between">
            <nav class="pull-left">
              <ul class="nav">
                <li class="nav-item">
                  <a class="nav-link" href="http://www.themekita.com">
                    ThemeKita
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#"> Help </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#"> Licenses </a>
                </li>
              </ul>
            </nav>
            <div class="copyright">
              2024, made with <i class="fa fa-heart heart text-danger"></i> by
              <a href="http://www.themekita.com">ThemeKita</a>
            </div>
            <div>
              Distributed by
              <a target="_blank" href="https://themewagon.com/">ThemeWagon</a>.
            </div>
          </div>
        </footer>
      </div>
    </div>
    </div>
    
    <script>
        $(document).ready(function() {
            // 모든 input 요소의 텍스트를 오른쪽으로 정렬
            $('input').css('text-align', 'right');
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