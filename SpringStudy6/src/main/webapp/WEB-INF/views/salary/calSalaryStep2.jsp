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
  </head>
  <body>
  <%-- ${calSalaryInfo } --%>
  
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
              
              <div class="col-sm-6 col-md-4">
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
            
            
                <div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">직원정보 조회</div>
                  </div>
                  
                  <div class="form-group from-show-notify row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                          <button type="button" id="selectAllMemberBtn" class="btn btn-primary">
                            전체 직원조회
                          </button>
                          <button type="button" id="checkAllBtn" class="btn btn-primary">
                            전체선택
                          </button>
                          <button type="button" id="deleteMemberBtn" class="btn btn-primary">
                            삭제하기
                          </button>
	                          <button
		                        class="btn btn-primary"
		                        id = "modalOpenBtn"
		                        data-bs-toggle="modal"
		                        data-bs-target="#addRowModal"
		                      >
		                        직원조회
	                      </button>
                        </div>
                      </div>
                      
                     
                  <div class="card-body">
                    <table class="table table-striped mt-3" id="resultTable">
                      <thead>
                        <tr>
                          <th style='text-align: center;' >선택</th>
                          <th style='text-align: center;' >사번</th>
                          <th style='text-align: center;' >이름</th>
                          <th style='text-align: center;' >직급</th>
                          <th style='text-align: center;' >직무</th>
                          <th style='text-align: center;' >소정근로시간</th>
                          <th style='text-align: center;' >야간근로시간</th>
                          <th style='text-align: center;' >특별근로시간</th>
                        </tr>
                      </thead>
                      <tbody>
                      </tbody>
                    </table>
                   	<form id="dataForm" action="/salary/calSalaryStep3" method="post">
		            	<input type="hidden" name="sal_type" value="${calSalaryInfo.sal_type }">
		            	<input type="hidden" name="year" value="${calSalaryInfo.year }">
		            	<input type="hidden" name="month" value="${calSalaryInfo.month }">
		            	<input type="hidden" id="employeeIds" name="employeeIds">
		            <button type="submit" id="submitBtn" class="btn btn-primary">
                          다음으로
                    </button>
	            	</form>
                  </div>
                </div>
                </div>
            </div>
            </div>
            
            <!-- 모달 -->
            <div
                      class="modal fade"
                      id="addRowModal"
                      tabindex="-1"
                      role="dialog"
                      aria-hidden="true"
                    >
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header border-0">
                            <h5 class="modal-title">
                              <span class="fw-bold"> 직원 조회</span>
                            </h5>
                            <button
                              type="button"
                              class="close"
                              id="modalOpenBtn"
                              data-bs-dismiss="modal"
                              aria-label="Close"
                            >
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body">
	                          <div id="modalNextContent">
		                          <table class="table table-striped mt-3" id="modalTable">
				                      <thead>
				                        <tr>
				                          <th>선택</th>
				                          <th>사번</th>
				                          <th>이름</th>
				                          <th>직급</th>
				                          <th>부서</th>
				                        </tr>
				                      </thead>
				                      <tbody>
				                      </tbody>
			                      </table>
			                      <div class="modal-footer border-0">
	                            <button
	                              type="button"
	                              id="regBtn"
	                              class="btn btn-primary"
	                            >
	                              등록하기
	                            </button>
	                            <button
	                              type="button"
	                              class="btn btn-danger"
	                              data-bs-dismiss="modal"
	                            >
	                              취소하기
	                            </button>
                          </div>
			                      
			                      
		                      </div>
                          
                          <div id="modalContent">
                            <p class="lead">
                              사원번호 또는 이름을 입력하세요.
                            </p>
                              <div class="row">
                                <div class="col-sm-12">
                                <div class="card-body">
                                  <div class="form-group form-group-default">
                                    <label>사번/이름</label>
                                    <input
                                      id="modalInputText"
                                      type="text"
                                      class="form-control"
                                      placeholder="사번/이름을 입력하세요"
                                      name="employeeInfo"
                                    />
                                  </div>
                                </div>
                              </div>
                            </div>
                            <div class="modal-footer border-0">
                            <button
                              type="button"
                              id="selectBtn"
                              class="btn btn-primary"
                            >
                              조회하기
                            </button>
                            <button
                              type="button"
                              class="btn btn-danger"
                              data-bs-dismiss="modal"
                            >
                              취소하기
                            </button>
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
        	
        	// 전체 선택하기 
        	$('#checkAllBtn').click(function(){
        		var checkStatus = $('input[type="checkBox"]').length === $('input[type="checkBox"]:checked').length;
        		$('input[type="checkBox"]').prop('checked', !checkStatus);
        	});
        	
        	// 선택 정보 삭제하기
        	$('#deleteMemberBtn').click(function() {
        		var selectedRows = $('input[type="checkBox"]:checked').closest('tr');
        		
        		if (selectedRows.length > 0) {
        			//swal("Success!", "삭제완료", "success");
       	            swal({
       	              title: "삭제하시겠습니까?",
       	              text: "삭제 후에는 직원조회를 통해 다시 업로드 가능합니다.",
       	              type: "warning",
       	              buttons: {
       	                cancel: {
       	                  visible: true,
       	                  text: "취소하기",
       	                  className: "btn btn-danger",
       	                },
       	                confirm: {
       	                  text: "삭제하기",
       	                  className: "btn btn-success",
       	                },
       	              },
       	            }).then(function(willDelete) {  // 일반 함수 문법으로 변경
       	             if (willDelete) {
       	            	selectedRows.each(function() {
                            $(this).remove(); // 테이블에서 삭제
                        });
       	            	swal("Success!", "삭제완료", "success");
      	          	} 
       	     	 });
                } else {
                    swal("삭제대상 없음", "삭제할 항목이 선택되지 않았습니다.", "info");
                }
        	});
        	
            // 전체 직원정보 불러오기
            $('#selectAllMemberBtn').click(function(){
            	$.ajax({
            		url:'/salary/getMemberAllInfo',
            		type: 'POST',
            		success: function(response) {
                        // 성공적으로 데이터를 받아온 경우.
            			swal("Success!", "전체 직원정보 업로드 완료", "success");
                        $('#resultTable tbody').empty();
                        response.forEach(function(data){
                        	var row = "<tr>" +
                            "<td style='text-align: center;'><input class='checkItem' type='checkBox' name='checkItem' data-id='"+ data.employee_id +"' </td>" +
                            "<td style='text-align: center;'>" + data.employee_id + "</td>" +
                            "<td style='text-align: center;'>" + data.employee_name + "</td>" +
                            "<td style='text-align: center;'>" + data.employee_grade + "</td>" +
                            "<td style='text-align: center;'>" + data.employee_duty + "</td>" +
                            "<td style='text-align: center;'>" + data.overtime + "</td>" +
                            "<td style='text-align: center;'>" + data.nighttime + "</td>" +
                            "<td style='text-align: center;'>" + data.specialtime + "</td>" +
                            "</tr>";
                            $('#resultTable tbody').append(row);
                        });
                    },
                    error: function(xhr, status, error) {
                        // 오류가 발생한 경우
                        swal("Error!", "직원 정보를 가져오는 데 실패했습니다.", "error");
                    }
            	});
            });
            
            // 다음으로 버튼 시 사번가지고 이동하기
            $('#submitBtn').click(function(event){
            	event.preventDefault();
            	//$('#submitBtn').find('input[name="selectedIds"]').remove();
            	const employeeIds = [];
            	$('.checkItem:checked').each(function () {
            		employeeIds.push($(this).data('id'));
                });
            	$('#employeeIds').val(employeeIds);
            	
            	$('#dataForm').submit(); 
            });
            
         	// 모달반응
         	$('#modalOpenBtn').click(function(){
         		$('#modalInputText').val('');
         		$('#modalContent').show();     
            	$('#modalNextContent').hide();    
         	});
         	
            $("#selectBtn").click(function () {
            	$.ajax({
            		url:'/salary/getMemberInfoForModal',
            		type: 'POST',
            		data: $('#modalInputText').val(),
            		contentType: 'application/json',
            		success: function(response) {
                        // 성공적으로 데이터를 받아온 경우.
            			// swal("Success!", "ajax성공" + response, "success");
                        $('#modalTable tbody').empty();
                        response.forEach(function(data){
                        	var row = "<tr>" +
                            "<td><input class='check-Item' type='radio' name='checkGroup' data-id='"+ data.employee_id +"' </td>" +
                            "<td>" + data.employee_id + "</td>" +
                            "<td>" + data.employee_name + "</td>" +
                            "<td>" + data.employee_grade + "</td>" +
                            "<td>" + data.employee_dept + "</td>" +
                            "</tr>";
                            $('#modalTable tbody').append(row);
                        });
                        $('#modalNextContent').show();
                        $('#modalContent').hide();
                    },
                    error: function(xhr, status, error) {
                        // 오류가 발생한 경우
                        $('#modalContent').show();
                        swal("Error!", "사번 또는 이름을 입력해주세요", "error");
                    }
            	});
            });
            
            // 모달테이블에서 선택된 직원정보 본 테이블로 옮기기
            $('#regBtn').click(function(){
//             	$.ajax({
//             		url:'/salary/transModalToTable',
//             		type: 'POST',
//             		data: $('.check-item:checked').data('id'),
//             		contentType: 'application/json',
//             	});
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