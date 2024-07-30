<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="item_content" style="padding-top: 100px;">
	<div class="category">
		<div class="form-check">
			<input class="form-check-input" type="checkbox" value=""
				id="flexCheckDefault"> <label class="form-check-label"
				for="flexCheckDefault"> 상세검색 </label>
		</div>
		<div class="form-check">
			<input class="form-check-input" type="checkbox" value=""
				id="flexCheckDefault"> <label class="form-check-label"
				for="flexCheckDefault"> 필터링 </label>
		</div>
		<div class="form-check">
			<input class="form-check-input" type="checkbox" value=""
				id="flexCheckDefault"> <label class="form-check-label"
				for="flexCheckDefault"> 어쩌구 </label>
		</div>
		<div class="form-check">
			<input class="form-check-input" type="checkbox" value=""
				id="flexCheckDefault"> <label class="form-check-label"
				for="flexCheckDefault"> 저쩌구 </label>
		</div>
	</div>
	<div class="item_title">
		<h3>검색 결과 &gt;</h3>
	</div>
	<div class="item_container">
		<div class="item">
			<img src="${path}/resources/img/item1.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item2.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item3.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item4.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item5.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item1.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item2.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item3.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item4.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item5.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item1.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item2.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item3.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item4.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img src="${path}/resources/img/item5.jpg" alt="1">
			<div class="item_view">
				<h3>제품명입니다</h3>
				<div class="item_price">
					<h4>9999원</h4>
					<h5>몇분 전</h5>
				</div>
				<div class="item_like">
					<p>관심 22</p>
					<p>채팅 10</p>
				</div>
				<div class="item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>인천광역시 계양구</p>
				</div>
			</div>
		</div>
	</div>
	

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>