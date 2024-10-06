/**
 * 
 */

// script.js
$(document).ready(function () {
    // 모달 열기 버튼 클릭 시
    $("#openModal").click(function () {
        $("#myModal").fadeIn(300); // 300ms 동안 페이드 인 효과 적용
        $("#modalTable tbody").empty();
        $("#inputText").val('');
        
        
    });

    // 닫기 버튼 클릭 시
    $(".close").click(function () {
        $("#myModal").fadeOut(300); // 300ms 동안 페이드 아웃 효과 적용
    });

    
    // 모든 사원조회 버튼 시
    $("#selectMemberAll").click(function(){
    	
    	$.ajax({
    		url:'/member/selectMemberAll',
    		type:'GET',
    		success: function(response){
    			alert("성공적으로 다녀옴");
    			$("#resultTable tbody").empty();
    			response.forEach(function(index){
    				const row = 
    					`<tr>
    						<td><input type="checkbox" name="itemCheckBox" data-id="${index.userid}"></td>
    						<td>${index.userid}</td>
	    					<td>${index.username}</td>
	    					<td>${index.useremail}</td>
	    					<td>${index.regdata}</td>
    					</tr>`
    				$("#resultTable tbody").append(row);
    			});
    			
    		}
    	});
    	
    	
    });
    
    
    
    
    // 조회버튼 클릭 시 
    $("#selectBtn").click(function(){
    	
    	var requestData = {
			"option":$("#options").val(),
			"inputText":$("#inputText").val()
    	}
    	$.ajax({
    		url:'/member/getMemberInfo',
    		type:'POST',
    		contentType: 'application/json', // 데이터 형식 설정
    		data: JSON.stringify(requestData),
    		success: function(response) {
    	        $("#modalTable tbody").empty();
    			$("#modalTableContainer").show();
    		    
    		    response.forEach(function(index){
    		    	const row =
    		    		`<tr>
    		    			<td><input type="checkbox" data-id="${index.userid}" name="itemCheckbox"> </td>
	    		    		<td>${index.userid} </td>
	    		    		<td>${index.username} </td>
    		    		</tr>`;
    		    	$("#modalTable tbody").append(row);
    		    });    
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.error('실패');
			} 
    	});
    });
    
    $("#registBtn").click(function(){
    	
    	var selectedCheckIds = [];
    	
    	$('input[name="itemCheckbox"]:checked').each(function(){
    		selectedCheckIds.push($(this).data('id'));
    	});
    	
//    	alert(selectedCheckIds);
    	
    	$.ajax({
    		url:'/member/getMemberInfoFormModalToHtml',
    		type:'POST',
    		contentType:'application/json',
    		data: JSON.stringify(selectedCheckIds),
    		success: function(response) {
    			response.forEach(function(index){
    				const row = 
    					`<tr>
    						<td><input type="checkbox" name="itemCheckBox" data-id="${index.userid}"></td>
    						<td>${index.userid}</td>
	    					<td>${index.username}</td>
	    					<td>${index.useremail}</td>
	    					<td>${index.regdata}</td>
    					</tr>`
    				$("#resultTable tbody").append(row);
    			});
    		}
    	});
    });
    
    $("#selectAll").change(function(){
		$('input[name="itemCheckBox"]').prop('checked', this.checked);
	});
    
    $("#nextBtn1").click(function(){
    	var selectedCheckIds = [];
    	
    	$('input[name="itemCheckBox"]:checked').each(function(){
    		selectedCheckIds.push($(this).data('id'));
    	});

    	$("#checkId").val(selectedCheckIds);
    });
    
    
   
});