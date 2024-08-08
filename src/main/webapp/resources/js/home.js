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
	console.log(window.scrollY);
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

document.addEventListener('DOMContentLoaded', function() {
  const prevButton = document.querySelector('.new_arrow.prev');
  const nextButton = document.querySelector('.new_arrow.next');
  const container = document.querySelector('.newItem_container2');
  
  const items = Array.from(document.querySelectorAll('.item2'));
  const itemsToShow = 6; // 화면에 보일 아이템 수
  const totalItems = items.length;
  const itemWidth = 100 / itemsToShow; // 각 아이템의 너비 비율
  
  // 컨테이너에 복제된 아이템을 추가
  const firstItem = items[0];
  const lastItem = items[items.length - 1];
  const firstClone = firstItem.cloneNode(true);
  const lastClone = lastItem.cloneNode(true);
  
  container.appendChild(firstClone); // 끝에 복제 아이템 추가
  container.insertBefore(lastClone, container.firstChild); // 처음에 복제 아이템 추가

  const updatedItems = Array.from(container.querySelectorAll('.item2'));
  const maxIndex = updatedItems.length - itemsToShow; // 최대 슬라이드 인덱스
  let currentIndex = 1; // 초기 인덱스는 1로 설정 (복제된 첫 아이템을 포함하여 시작)

  function updateSlider() {
    const offset = -currentIndex * itemWidth; // 현재 인덱스에 따라 오프셋 계산
    container.style.transform = `translateX(${offset}%)`;

    // 슬라이드가 복제된 첫 아이템을 지나쳤을 때
    if (currentIndex === maxIndex + 1) {
      container.style.transition = 'none';
      container.style.transform = `translateX(${0}%)`; // 이동 위치 초기화
      currentIndex = 1; // 인덱스 초기화
      setTimeout(() => {
        container.style.transition = 'transform 0.5s ease'; // 애니메이션 재설정
      }, 50);
    }
    
    // 슬라이드가 복제된 마지막 아이템에 도달했을 때
    if (currentIndex === 0) {
      container.style.transition = 'none';
      container.style.transform = `translateX(${-maxIndex * itemWidth}%)`; // 마지막 아이템 위치로 이동
      currentIndex = maxIndex; // 인덱스 조정
      setTimeout(() => {
        container.style.transition = 'transform 0.5s ease'; // 애니메이션 재설정
      }, 50);
    }
  }

  nextButton.addEventListener('click', function() {
    if (currentIndex < maxIndex + 1) {
      currentIndex++;
      updateSlider();
    }
  });

  prevButton.addEventListener('click', function() {
    if (currentIndex > 0) {
      currentIndex--;
      updateSlider();
    }
  });
});