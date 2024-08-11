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
    const itemsToShow = 6;
    const itemWidth = 100 / itemsToShow;

    // 컨테이너에 복제된 아이템을 추가
    const firstItem = items[0];
    const lastItem = items[items.length - 1];
    const firstClone = firstItem.cloneNode(true);
    const lastClone = lastItem.cloneNode(true);

    container.appendChild(firstClone);
    container.insertBefore(lastClone, container.firstChild);

    // 업데이트된 아이템 리스트 및 최대 인덱스 계산
    const updatedItems = Array.from(container.querySelectorAll('.item2'));
    const maxIndex = updatedItems.length - itemsToShow - 1; // 클론을 제외한 최대 인덱스
    let currentIndex = 1; // 슬라이드 시작 인덱스 (클론 첫 번째 위치)

    function updateSlider() {
        container.style.transform = `translateX(${-currentIndex * itemWidth}%)`;

        // 슬라이드가 클론 마지막 아이템에 도달했을 때
        if (currentIndex === updatedItems.length - itemsToShow) {
            setTimeout(() => {
                container.style.transition = 'none'; // 애니메이션 비활성화
                container.style.transform = `translateX(${-itemWidth}%)`; // 위치를 초기화
                currentIndex = 1; // 인덱스 초기화
                setTimeout(() => {
                    container.style.transition = 'transform 0.5s ease'; // 애니메이션 재설정
                }, 20); // 짧은 시간 후 애니메이션 재설정
            }, 500); // 슬라이드가 끝난 후 잠시 대기
        }

        // 슬라이드가 클론 첫 아이템에 도달했을 때
        if (currentIndex === 0) {
            setTimeout(() => {
                container.style.transition = 'none'; // 애니메이션 비활성화
                container.style.transform = `translateX(${-maxIndex * itemWidth}%)`; // 마지막 아이템 위치로 이동
                currentIndex = maxIndex; // 인덱스 조정
                setTimeout(() => {
                    container.style.transition = 'transform 0.5s ease'; // 애니메이션 재설정
                }, 20); // 짧은 시간 후 애니메이션 재설정
            }, 500); // 슬라이드가 끝난 후 잠시 대기
        }
    }

    nextButton.addEventListener('click', function() {
        if (currentIndex < updatedItems.length - itemsToShow) {
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

    // 자동 슬라이드
    let autoSlideInterval = setInterval(() => {
        if (currentIndex < updatedItems.length - itemsToShow) {
            currentIndex++;
            updateSlider();
        } else {
            // 슬라이드가 끝나면 부드럽게 처음으로 돌아가도록
            container.style.transition = 'none'; // 애니메이션 비활성화
            container.style.transform = `translateX(${-itemWidth}%)`; // 위치를 초기화
            currentIndex = 1; // 인덱스 초기화
            setTimeout(() => {
                container.style.transition = 'transform 0.5s ease'; // 애니메이션 재설정
            }, 20); // 짧은 시간 후 애니메이션 재설정
        }
    }, 3000); // 3초마다 슬라이드

});




// 인기상품

document.addEventListener('DOMContentLoaded', function () {
    const popularProduct = document.querySelector('.popular_product');
    const homePage = document.querySelector('.home_page');

    popularProduct.addEventListener('mouseenter', function () {
        homePage.classList.add('bg-black');
    });

    popularProduct.addEventListener('mouseleave', function () {
        homePage.classList.remove('bg-black');
    });
    
    
});

 document.addEventListener('DOMContentLoaded', () => {
    const popularProduct = document.querySelector('.popular_product');
    const rightSection = document.querySelector('.right_section');

    // 오른쪽 섹션의 스크롤과 전체 페이지 스크롤을 위한 변수
    let isScrolling = false;

    popularProduct.addEventListener('wheel', (event) => {
      if (event.deltaY !== 0) {
        event.preventDefault(); // 기본 스크롤 동작 방지

        if (!isScrolling) {
          isScrolling = true; // 스크롤이 진행 중임을 표시

          // right_section을 스크롤
          rightSection.scrollBy({
            top: event.deltaY,
            behavior: 'smooth'
          });

          // right_section의 끝에 도달했는지 확인
          const isAtBottom = rightSection.scrollHeight === rightSection.scrollTop + rightSection.clientHeight;

          if (isAtBottom) {
            // right_section이 바닥에 도달하면 전체 페이지를 스크롤
            window.scrollBy({
              top: event.deltaY,
              behavior: 'smooth'
            });
          }

          // 스크롤이 완료될 때까지 대기
          setTimeout(() => {
            isScrolling = false;
          }, 500); // 500ms는 스크롤 애니메이션 시간에 맞게 조정 가능
        }
      }
    });
  });