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