<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css?ver=1.1">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<h1>test.jsp</h1>
	
	${salType }
	
	<!-- 모달 버튼 -->
    <button id="openModal">사원조회</button>
    <button id="selectMemberAll">모든 사원조회</button>


	<!-- 모달창에서 가져온 데이터를 보여주는 테이블 -->
	<table id="resultTable">
		<thead>
			<tr>
				<th><input type="checkbox" id="selectAll"></th>	
				<th>사번</th>	
				<th>이름</th>	
				<th>email</th>	
				<th>가입일시</th>	
			</tr>
		</thead>
		<tbody>
			<tr>
			</tr>
		</tbody>
	</table>

	<form action="/member/calSalaryPage" method="post">
		<input id="checkId" type="hidden" name="useridList">
		<button type="submit" id="nextBtn1">다음으로</button>
	</form>










    <!-- 모달 창 -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <select id="options">
                <option value="userid">사번</option>
                <option value="username">이름</option>
            </select>
            <input type="text" id="inputText" placeholder="입력하세요" />
            <button id="selectBtn">조회하기</button>
            <button id="registBtn">등록하기</button>
            
            <div id="modalTableContainer">
            	<table id="modalTable">
            		<thead>
				        <tr>
				          <th>구분</th>
				          <th>사번</th>
				          <th>이름</th>
				        </tr>
			        </thead>
			        <tbody>
			        	<!-- 결과가 여기에 추가됩니다. -->
			        </tbody>
            	</table>
            </div>
            
        </div>
    </div>
	
	
	
	<script src="${pageContext.request.contextPath }/resources/js/script.js?ver=1.0"></script>
</body>
</html>