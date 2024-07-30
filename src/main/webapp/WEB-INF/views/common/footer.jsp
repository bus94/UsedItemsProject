<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<footer>
	<p class="footer_p" align="center">
		&lt;Copyright 2022. <strong>Safe Market</strong>. All rights
		reserved.&gt;
	</p>
</footer>

<button id="top_btn">
	▲ <br> TOP
</button>

<script>
	$(document).ready(function() {
		// Top 버튼 클릭시 페이지 상단으로 이동
		$('#top_btn').click(function() {
			$('html, body').animate({
				scrollTop : 0
			}, 50);
			return false;
		});

	});
</script>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

</body>
</html>