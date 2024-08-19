/*
 * 
 */
$().ready(function(){
	console.log('home.js 연결');
	
	 window.scrollTo(0,0);
	 
	//홈.jsp에서 스크롤 200 미만이면 navbar에 고유의 ID 'navigator_home' 지정
	$('.navbar').attr('id','navigator_home');
	$('.navbar').removeClass('fixed-top');
	
});

window.addEventListener('scroll', function(){
	//console.log(window.scrollY);


	// 스크롤 Y축 200 초과 시 실행
	if(window.scrollY > '200') {
		$('.navbar').attr('id','navigator');
		$('.navbar').addClass('fixed-top');
	}else {
		//홈.jsp에서 스크롤 200 미만이면 navbar에 고유의 ID 'navigator_home' 지정
		$('.navbar').attr('id','navigator_home');
		$('.navbar').removeClass('fixed-top');
	}
});

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



/* 메인 뉴아이템*/

$('.newItem_container2').slick({
  dots: false,
  infinite: true,
  arrows:true,
  speed: 500,
  slidesToShow: 6,
  slidesToScroll: 1,
  autoplay:true,
  autoplaySpeed:2000,
});







let roller = document.querySelector('.rolling-list');
roller.id = 'roller1'; // 아이디 부여

let clone = roller.cloneNode(true)
clone.id = 'roller2';
document.querySelector('.rolling').appendChild(clone); // rolling 하위 자식으로 부착

document.querySelector('#roller1').style.left = '0px';
document.querySelector('#roller2').style.left = document.querySelector('.rolling-list ul').offsetWidth + 'px';
// offsetWidth : 요소의 크기 확인(margin을 제외한 padding값, border값까지 계산한 값)

roller.classList.add('original');
clone.classList.add('clone');



// 인기상품







// 구라박스
  document.addEventListener('DOMContentLoaded', function () {

    function startCounting(element) {
      const counters = element.querySelectorAll('.counter');
      
      counters.forEach(counter => {
        const updateCount = () => {
          const target = +counter.getAttribute('data-target');
          const count = +counter.innerText;

          const increment = target / 500; // 속도 조절
          if (count < target) {
            counter.innerText = Math.ceil(count + increment); 
            setTimeout(updateCount, 1); // 1ms 후에 다시 업데이트
          } else {
            counter.innerText = target;
          }
        };
        updateCount();
      });
    }

    // Intersection Observer 생성
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          // 섹션이 화면에 들어오면 카운팅 시작
          startCounting(entry.target);
          // 카운팅 시작 후에는 더 이상 관찰하지 않음
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 1 }); // 요소가 화면에 들어왔을 때 시작

    const sections = document.querySelectorAll('.mainbox');
    sections.forEach(section => {
      observer.observe(section);
    });
  });