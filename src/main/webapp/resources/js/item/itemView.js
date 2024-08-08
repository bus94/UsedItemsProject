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

function incrementViews(path,itemId) {
    fetch(path+'/item/incrementViews?item_index=' + item_index, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
        body: JSON.stringify({ itemId: itemId })
    }).then(response => {
        if (!response.ok) {
            response.text().then(text => {
                console.error('Failed to increment views:', text);
            });
        } else {
            console.log('Successfully incremented views');
        }
    }).catch(error => {
        console.error('Error:', error);
    });
}


document.addEventListener('DOMContentLoaded', function() {
	
    console.log(item_index);
    console.log(path);
    
    incrementViews(path,item_index);
 
});
