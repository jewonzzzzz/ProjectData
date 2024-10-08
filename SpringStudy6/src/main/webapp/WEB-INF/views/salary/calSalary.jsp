<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
      href="${pageContext.request.contextPath }/resources/assets/img/kaiadmin/favicon.ico?ver=1"
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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js?ver=1.0"></script>
    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css?ver=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/plugins.min.css?ver=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/kaiadmin.min.css?ver=1.0" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css?ver=1.0" />
  </head>
  <body>
  
  <%-- ${salaryRankDutyInfo } --%>
  <%-- ${calSalaryListInfo } --%>
  
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
            
            <div class="row">
              <div class="col-md-10">
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">급여산출내역</div>
                  </div>
                  	<div style="margin-left: 15px; padding-top: 10px;">
                    	<a href="/salary/calSalaryStep1"><button class="btn btn-success">신규생성</button></a>
                    	<button class="btn btn-success" id="deleteBtn">삭제하기</button>
                  	</div>
                  <div class="card-body" style="padding-top: 10px;">
                  	<div class="card-sub">
                      !! 급여산출 이후 실지급이 완료되면 상태를 최종확정으로 수정해주십시오.
                    </div>
                    <table class="table table-hover">
                      <thead>
                        <tr>
                          <th scope="col">구분</th>
                          <th scope="col">연도</th>
                          <th scope="col">월</th>
                          <th scope="col">급여형태</th>
                          <th scope="col">제목</th>
                          <th scope="col">상태</th>
                          <th scope="col">최종작성일</th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="list" items="${calSalaryListInfo }">
                      	<tr>
                      		<td><input type="checkbox" data-id="sal_list_id" name="sal_list_id" value="${list.sal_list_id }"></td>
                      		<td>${list.year }</td>
                      		<td>${list.month }</td>
                      		<td>${list.sal_type }</td>
                      		<td><a href="/salary/calSalaryView?sal_list_id=${list.sal_list_id }">${list.sal_list_subject }</a></td>
                      		<td>${list.sal_list_status }</td>
                      		<td>${list.sal_list_date }</td>
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
           <%@ include file="/resources/assets/inc/footer.jsp" %>
          </div>
         </div>
            
    <script>
        $(document).ready(function() {
        	
        	var checkedValues = $('input[type="checkbox"]:checked').map(function() {
        	    return $(this).data('id'); // 각 체크박스의 값을 반환
        	}).get();
        	
        	$('#deleteBtn').click(function (){
        		$.ajax({
        			url: '/salary/deleteSalaryList',
        			type: 'POST',
            		data: JSON.stringify(checkedValues),
            		contentType: 'application/json',
            		success: function(response) {
            			console.log(checkedValues);
            			swal("Success!", "정상적으로 등록하였습니다", "success");
            		},
            		error: function(xhr, status, error) {
                        swal("Error!", "오류가 발생했습니다: " + error, "error"); 
                    }
        		});
        		
        	});
        	
        	
        	
        	
        	
        	
        	
        	
        });
    </script>
    
    <!--   Core JS Files   -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/core/jquery-3.7.1.min.js?ver=1.0"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/core/popper.min.js?ver=1.0"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js?ver=1.0"></script>

    <!-- jQuery Scrollbar -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js?ver=1.0"></script>

    <!-- Chart JS -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/chart.js/chart.min.js?ver=1.0"></script>

    <!-- jQuery Sparkline -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js?ver=1.0"></script>

    <!-- Chart Circle -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/chart-circle/circles.min.js?ver=1.0"></script>

    <!-- Datatables -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/datatables/datatables.min.js?ver=1.0"></script>

    <!-- Bootstrap Notify -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js?ver=1.0"></script>

    <!-- jQuery Vector Maps -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jsvectormap/jsvectormap.min.js?ver=1.0"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jsvectormap/world.js?ver=1.0"></script>

    <!-- Sweet Alert -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/sweetalert/sweetalert.min.js?ver=1.0"></script>

    <!-- Kaiadmin JS -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/kaiadmin.min.js?ver=1.0"></script>

    <!-- Kaiadmin DEMO methods, don't include it in your project! -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/setting-demo.js?ver=1.0"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/demo.js?ver=1.0"></script>

  </body>
</html>