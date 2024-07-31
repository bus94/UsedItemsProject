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







 
 
 