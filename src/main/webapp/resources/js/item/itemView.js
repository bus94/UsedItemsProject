function btnClick() {

    const deleteBox = document.getElementById('delete_box');



    if (deleteBox.style.visibility === 'hidden' || deleteBox.style.visibility === '') {

        deleteBox.style.visibility = 'visible';

    } else {

        deleteBox.style.visibility = 'hidden';

    }

}


function closeClick() {

    const deleteBox = document.getElementById('delete_box');



    if (deleteBox.style.visibility === 'visible') {

        deleteBox.style.visibility = 'hidden';

    } else {

    }

}



$(document).ready(function(){
$('.itemView_carousel').slick({
    dots: false,
    arrows: true,
    infinite: true,
    speed: 300,
    slidesToShow: 5,
    slidesToScroll: 1,
    responsive: [
        {
            breakpoint: 1024,
            settings: {
                slidesToShow: 3,
                slidesToScroll: 3,
                infinite: true,
                dots: true
            }
        },
        {
            breakpoint: 600,
            settings: {
                slidesToShow: 2,
                slidesToScroll: 2
            }
        },
        {
            breakpoint: 480,
            settings: {
                slidesToShow: 1,
                slidesToScroll: 1
            }
        }

    ]
});
});




