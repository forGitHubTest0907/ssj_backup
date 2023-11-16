<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="/css/qBoardList.css">
</head>
<body>
	<c:import url="/WEB-INF/views/header4.jsp"/>
	<div class="mainBody">
	  <div class="qe_body">
	    <div class="qe_box">
	      <div class="qe_text_box">
	        <span>문의게시판</span>
	      </div>
	      <div class="qe_write_box">
	        <c:if test="${user1.user_id != null }">
				<a href="qBoardWriteForm"><span>글쓰기</span></a>
			</c:if>
	      </div>
	      <div class="tb_body">
	      <c:set var="num" value="${page.total-page.start+1 }"></c:set>
	        <table>
	          <thead class="tb_thead">
	              <tr>
	                <td>번호</td>
	                <td>제목</td>
	                <td>작성자</td>
	                <td>작성일</td>
	                <td>조회수</td>
	                <!-- https://java119.tistory.com/84 -->
	              </tr>
	          </thead>
	          <tbody>
				<c:forEach var="board" items="${qBoardList}">
					<c:if test="${board.user_num == user1.user_num || user1.status_md == 102 }">	
						<tr>
							<td>${num}</td>
							<td><a href="qBoardDetail?brd_num=${board.brd_num}">${board.title}</a></td>
							<td><img class="Select" src="/images/level/${board.icon}.png">${board.nick}</td>
							<td><fmt:formatDate value="${board.reg_date }" pattern="yy-MM-dd"/></td>
							<td>${board.view_cnt}</td>
							<c:set var="num" value="${num-1 }"></c:set>
						</tr>
					</c:if>
				</c:forEach>
	          </tbody>
	        </table>
	        <div class="page">
	        	<c:if test="${page.startPage > page.pageBlock }">
					<a href="qBoardList?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
				</c:if>
				<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
					<a href="qBoardList?currentPage=${i}">[${i}]</a>
				</c:forEach>
				<c:if test="${page.endPage < page.totalPage }">
					<a href="qBoardList?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
				</c:if>	
			</div>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<c:forEach var="board" items="${qBoardList}">
	
		<div class="popupLayer">
		    <div>
		        Lv.${board.user_level } | exp.${board.user_exp }<!-- <span onmouseover="closeLayer(this)" style="cursor:pointer; font-size:0.5em" title="닫기"></span> -->
		    </div>
		</div>
	</c:forEach>
	
	
	
	<c:import url="/WEB-INF/views/footer.jsp"/>
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript">
		$(function() {
		    var hoverTimer; // 마우스 오버 타이머 변수

		    $('.Select').hover(function(e) {
		        var sWidth = window.innerWidth;
		        var sHeight = window.innerHeight;

		        var oWidth = $('.popupLayer').width();
		        var oHeight = $('.popupLayer').height();

		        // 레이어가 위치 셋팅
		        var divLeft = e.clientX;
		        var divTop = e.clientY;

		        // 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
		        if (divLeft + oWidth > sWidth) divLeft -= oWidth;
		        if (divTop + oHeight > sHeight) divTop -= oHeight;

		        // 레이어 위치를 바꾸었더니 상단 기준점(0,0) 밖으로 벗어난다면 상단 기준점(0,0)에 배치하자.
		        if (divLeft < 0) divLeft = 0;
		        if (divTop < 0) divTop = 0;

		        // 일정 시간 후에 레이어를 보여줌
		        hoverTimer = setTimeout(function() {
		            $('.popupLayer').css({
		                "top": divTop,
		                "left": divLeft,
		                "position": "absolute"
		            }).show();
		        }, 1000); // 1초(1000ms) 후에 레이어를 보여줌
		    }, function() {
		        // 마우스를 빠르게 벗어나면 타이머 취소
		        clearTimeout(hoverTimer);

		        // 마우스를 벗어났을 때 레이어를 숨김
		        $('.popupLayer').hide();
		    });
		});
	
	
	</script>

</body>
</html>