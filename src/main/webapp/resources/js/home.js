/**
 * 
 */
$().ready(function(){
	console.log('home.js 연결');
	
	 window.scrollTo(0,0);
	 
	//홈.jsp에서 스크롤 200 미만이면 navbar에 고유의 ID 'navigator_home' 지정
	$('.navbar').attr('id','navigator_home');
	$('.navbar').removeClass('fixed-top');
	
});




<<<<<<< HEAD
window.addEventListener('scroll', function(){
	//console.log(window.scrollY);
	console.log(window.scrollY);
	// 스크롤 Y축 200 초과 시 실행
	if(window.scrollY > '0') {
		
		$('.navbar').attr('id','navigator');
		$('.navbar').addClass('fixed-top');
	}else {
		//홈.jsp에서 스크롤 200 미만이면 navbar에 고유의 ID 'navigator_home' 지정
		$('.navbar').attr('id','navigator_home');
		$('.navbar').removeClass('fixed-top');
=======
>>>>>>> 21531cb2b4639f6ebffc180df8720999358a6bc2

window.addEventListener('scroll', function() {
    // 스크롤 Y축 50 초과 시 실행
    if (window.scrollY > 50) {
        $('.navbar').attr('id', 'navigator');
        $('.navbar').addClass('fixed-top');
    } else {
        // 스크롤 Y축 50 이하 시 실행
        $('.navbar').attr('id', 'navigator_home');
        $('.navbar').removeClass('fixed-top');
    }
});










