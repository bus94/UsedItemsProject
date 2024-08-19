/**
 * 
 */
 
// $().ready(function(){
//    console.log('acc_alter.js 연결');
//	});

$(function() {

	console.log('acc_alter.js 연결');

});


$('#alt_pw').click(function(){
	// 비밀번호 '변경하기' 누르면
	// $('#password_reset').toggle();
  
	$('#input_pw_box').css('display','block');
	$('#alt_pw').hide();
	
});


$('#setPWcancel').click(function(){
	// 비밀번호 '취소' 누르면

	$('#input_pw_box').css('display','none');
	$('#alt_pw').show();
	
});



var currPW_input = null;
var neoPW_input = null;
var neoPWconf_input = null;

var currPW_isNull = null;
var neoPW_isNull = null;
var neoPWconf_isNull = null;


function filledAll(){ //비밀번호 필드 전체(현재+새+확인) 체크

	if(currPW_isNull == false && neoPW_isNull == false && neoPWconf_isNull == false){
		$('#setPW').attr('disabled', false);
	}else {
		// console.log("currPW_isNull: "+currPW_isNull);
		// console.log("neoPW_isNull: "+neoPW_isNull);
		// console.log("neoPWconf_isNull: "+neoPWconf_isNull);
		$('#setPW').attr('disabled', true);
	}
}


function currPWcheck(param1){ //현재 비밀번호 입력 시
	//console.log(param1);
	//console.log(param1.value);
	currPW_input = param1.value.trim();
	//console.log(currPW_input);
	
	if(currPW_input != ''){
		//console.log('뭔가 있따');
		currPW_isNull = false;
	}else {
		currPW_isNull = true;
	}
	
	filledAll();
}


function neoPWcheck(param2){ //새 비밀번호 입력 시
	neoPW_input = param2.value.trim();
	//console.log(neoPW_input);
	
	if(neoPW_input != ''){
		neoPW_isNull = false;
	}else {
		neoPW_isNull = true;
	}
	
	filledAll();
}


function neoPW2check(param3){ //새 비밀번호 확인 입력 시
	neoPWconf_input = param3.value.trim();
	//console.log(neoPWconf_input);
	
	if(neoPWconf_input != ''){
		neoPWconf_isNull = false;
	}else {
		neoPWconf_isNull = true;
	}
	
	filledAll();
}



$('#setPW').click(function(){ // 비밀번호 '수정' 누르면
	
	if(neoPW_input != neoPWconf_input){
		alert("'새 비밀번호'가 서로 일치하지 않습니다.");
		return;
	} else if( currPW_input == neoPWconf_input){
		alert("입력한 '현재 비밀번호'와 '새 비밀번호'가 같습니다.");
		return;	
	}else{
		
		//ajax로 넘겨줄 data : 객체({key : value}) 형태
		const queryPW = { currPW_input : currPW_input, neoPWconf_input : neoPWconf_input };
		
		$.ajax({
			type : "POST",
			url : project + "/account/setPW.do", //project는 header.jsp 내부 script에서 선언해 둠
			data : queryPW,
			success : function(data) {
						console.log("AJAXresponse : " + data);
						if(data > 0) {
							alert("비밀번호가 변경되었습니다.");
							//'#setPWcancel' 버튼 클릭 효과 
							$('#setPWcancel').trigger("click");
						} else if(data == 0) {
							alert("'현재 비밀번호'가 일치하지 않습니다.");
						} else {
							alert("오류로 인하여 정상적으로 처리되지 않았습니다.");
						}
					},
			error : function(error) {
					alert("오류로 인하여 정상적으로 처리되지 않았습니다.(AJAX)");
					}
		}); //ajax
		
	}

});



$('#setNickname').click(function(){ // 별명 '수정' 누르면
	
	var nickname_input = $.trim($('#nickname').val());

	if(!nickname_input) {
		alert("새로운 별명을 입력하여 주시기 바랍니다");
		return;
	} else {
		
		const queryNickname = { nickname_input : nickname_input };
		
		$.ajax({
			type : "POST",
			url : project + "/account/setNickname.do", //project는 header.jsp 내부 script에서 선언해 둠
			data : queryNickname,
			success : function(data) {
						console.log("AJAXresponse : " + data);
						if(data > 0) {
							alert("별명이 변경되었습니다.");
						} else if(data == 0) {
							alert("현재 별명과 같습니다.");
						} else {
							alert("이미 존재하는 별명입니다. 다른 별명을 지어주세요");
						}
					},
			error : function(error) {
					alert("오류로 인하여 정상적으로 처리되지 않았습니다.(AJAX)");
					}
		}); //ajax
	}

});



$('#setPhone').click(function(){ // 전화번호 '수정' 누르면
	
	var phone_input = $.trim($('#phone').val());

	if(!phone_input) {
		alert("새로운 전화번호를 입력하여 주시기 바랍니다");
		return;
	} else {
		
		const queryPhone = { phone_input : phone_input };
		
		$.ajax({
			type : "POST",
			url : project + "/account/setPhone.do", //project는 header.jsp 내부 script에서 선언해 둠
			data : queryPhone,
			success : function(data) {
						console.log("AJAXresponse : " + data);
						if(data > 0) {
							alert("전화번호가 변경되었습니다.");
						} else if(data == 0) {
							alert("현재 전화번호와 같습니다.");
						} else {
							alert("이미 등록된 전화번호입니다. 다른 사용자와 같은 전화번호를 등록할 수 없습니다.");
						}
					},
			error : function(error) {
					alert("오류로 인하여 정상적으로 처리되지 않았습니다.(AJAX)");
					}
		}); //ajax
	}

});




//기존값 변수 저장
var name = $.trim($('#name').val());
var birthDate = $.trim($('#birthDate').val());
var address = $.trim($('#address').val());

var addressDetail = $.trim($('#addressDetail').val());
if($('#addressDetail').val() == null) {
	addressDetail ='';
}
	console.log("상세주소:" + addressDetail);


$('#setRedunds').click(function(){ // [이름,생년월일,주소] '수정' 누르면
	
	var name_input = $.trim($('#name').val());
	var birthDate_input = $.trim($('#birthDate').val());
	var address_input = $.trim($('#address').val());
	
	var addressDetail_input = $.trim($('#addressDetail').val());
	
	if($('#addressDetail').val() == null) {
		addressDetail_input ='';
	}
	
	console.log("상세주소:" + addressDetail_input);
	
	if(name == name_input && birthDate == birthDate_input 
		&& address == address_input && addressDetail == addressDetail_input) {
		
		alert("변경된 값이 없습니다.");
		return;
	} else {
		
		const queryRedunds = { name_input : name_input, birthDate_input : birthDate_input, 
			address_input : address_input, addressDetail_input : addressDetail_input };
		
		$.ajax({
			type : "POST",
			url : project + "/account/setRedunds.do", //project는 header.jsp 내부 script에서 선언해 둠
			data : queryRedunds,
			success : function(data) {
						console.log("AJAXresponse : " + data);
						if(data > 0) {
							alert("정보가 변경되었습니다.");
							
							//바뀐값을 기존값 변수에 저장
							name = $.trim($('#name').val());
							birthDate = $.trim($('#birthDate').val());
							address = $.trim($('#address').val());
							addressDetail = $.trim($('#addressDetail').val());
							
						} else {
							alert("오류로 인하여 정상적으로 처리되지 않았습니다.");
						}
					},
			error : function(error) {
					alert("오류로 인하여 정상적으로 처리되지 않았습니다.(AJAX)");
					}
		}); //ajax
	}

});



$('#btn_withdraw').click(function(){ //'탈퇴하기' 누르면

	if (confirm("탈퇴하시겠습니까? 탈퇴 시 회원정보를 복구할 수 없습니다.")) {
		$('#wd_hide1').css('display','block');
		$('#wd_hide2').hide();
	}
});

