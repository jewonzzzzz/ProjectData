<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>test1.jsp</h1>
	
	<form action="/member/test" method="post">
	<Input type="text" name="salType">
	<Input type="text" name="year">
	<Input type="text" name="month">
	
	<input type="hidden" id="salInfo" name="salInfo">
	<button type="submit" id="nextStep1">다음으로</button>
	</form>
	
	<script type="text/javascript">
		$(document).ready(function(){
			
			$('#nextStep1').click(function(){
				var salInfo = {
						"salType":$('input[name="salType"]').val(),
						"year":$('input[name="year"]').val(),
						"month":$('input[name="month"]').val()
				};
				
				alert(JSON.stringify(salInfo));
				
				$('#salInfo').val(JSON.stringify(salInfo));
				
			});

		}); //jquery
	
	
	
	</script>
	
	
	
	
	
</body>
</html>