<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	        <table>
	          <thead class="tb_thead">
	              <tr>
	                <td>번호</td>
	                <td>제목</td>
	                <td>작성자</td>
	                <td>작성일</td>
	                <td>조회수</td>
	              </tr>
	          </thead>
	          <tbody>
				<c:forEach var="board" items="${qBoardList}">
					<c:if test="${board.user_num == user1.user_num || user1.status_md == 102 }">	
						<tr>
							<td>${board.brd_num}</td>
							<td><a href="qBoardDetail?brd_num=${board.brd_num}">${board.title}</a></td>
							<td>${board.nick}</td>
							<td>${board.reg_date}</td>
							<td>${board.view_cnt}</td>
						</tr>
					</c:if>
				</c:forEach>
	          </tbody>
	        </table>
	      </div>
	    </div>
	  </div>
	</div>
<c:import url="/WEB-INF/views/footer.jsp"/>
</body>
</html>