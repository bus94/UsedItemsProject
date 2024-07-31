/**
 * 
 */
 
 $().ready(function(){
    console.log('acc_alter.js 연결');
});


$('#alt_pw').click(function(){
	// 비밀번호 '변경하기' 누르면
	// $('#password_reset').toggle();
  
	$('#password_reset').css('display','block');
	$('#alt_pw').hide();
	
});


$('#setPWcancel').click(function(){
	// 비밀번호 '취소' 누르면

	$('#password_reset').css('display','none');
	$('#alt_pw').show();
	
});



$('#setPW').click(function(){
	// 비밀번호 '수정' 누르면
	
	var currPW = $.trim($('#currPW').val());
	var neoPW = $.trim($('#neoPW').val());
	var neoPWcheck = $.trim($('#neoPWcheck').val());
	
	if(!currPW){
		alert("'현재 비밀번호' 입력");
		return;
	}
	
	
	
	if(!neoPW){
		alert("'새 비밀번호' 입력");
		return;
	}
	
	
	if(!neoPWcheck){
		alert("'새 비밀번호 확인' 입력");
		return;
	}



});



 
 
 