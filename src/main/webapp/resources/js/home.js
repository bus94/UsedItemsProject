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

$(function(){
  var front = $('.Front'),
      others = ['Left2', 'Left', 'Right', 'Right2'];
      interval = 5000;
      
  function slideNext() {
    var $next = front.next('.best_Items');
    if ($next.length === 0) {
      $next = $('.best_Items').first(); // 마지막 슬라이드 다음은 첫 번째 슬라이드로 돌아감
    }
    
    $.each(others, function(i, cl) {
      if ($next.hasClass(cl)) {
        front.removeClass('Front').addClass(cl);
        front = $next;
        front.addClass('Front').removeClass(cl);
      }
    });
  }    
  
  $('.best_Carousel').on('click', '.best_Items', function() {
    var $this = $(this);
    
    $.each(others, function(i, cl) {
      if ($this.hasClass(cl)) {
        front.removeClass('Front').addClass(cl);
        front = $this;
        front.addClass('Front').removeClass(cl);
      }
    });
  });
  
   setInterval(slideNext, interval);
});




// 구라박스
document.addEventListener('DOMContentLoaded', function () {
    const counters = document.querySelectorAll('.counter');

    counters.forEach(counter => {
        const updateCounter = () => {
            const target = +counter.getAttribute('data-target');
            const count = +counter.innerText;

            const increment = target / 100;
            if (count < target) {
                counter.innerText = Math.ceil(count + increment);
                setTimeout(updateCounter, 8);
            } else {
                counter.innerText = target;
            }
        };

        counter.closest('.mainbox').addEventListener('mouseover', updateCounter);
    });
});

document.addEventListener('DOMContentLoaded', function () {
    const boxes = document.querySelectorAll('.mainbox');

    boxes.forEach(box => {
        box.addEventListener('mouseover', () => {
            box.classList.add('hovered');
        });

        box.addEventListener('mouseout', () => {
        });
    });
});