/**
 * 
 */
 
// $().ready(function(){
//    console.log('acc_alter.js 연결');
//	});


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
		console.log("currPW_isNull: "+currPW_isNull);
		console.log("neoPW_isNull: "+neoPW_isNull);
		console.log("neoPWconf_isNull: "+neoPWconf_isNull);
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
	}else{
		alert("바꿔줄게");
	}

});



$('#btn_withdraw').click(function(){ //'탈퇴하기' 누르면

	if (confirm("탈퇴하시겠습니까? 탈퇴 시 회원정보를 복구할 수 없습니다.")) {
		$('#wd_hide1').css('display','block');
		$('#wd_hide2').hide();
	}

	
	
});


$('#setStatus').click(function() { // '탈퇴' 버튼 누르면

	//var wd_currPW = $.trim($('#wd_currPW').val());
	
	//if(!wd_currPW){
	//	alert("'현재 비밀번호'를 입력하여 주세요.");
	//	return;
	//}
	
	//if (confirm("탈퇴하시겠습니까? 탈퇴 시 회원정보를 복구할 수 없습니다.")) {
	//	location.href = "/useditems/withdraw.do";
	//}
});



$(function() {

	console.log('acc_alter.js 연결');

	
	

});













 
 
 