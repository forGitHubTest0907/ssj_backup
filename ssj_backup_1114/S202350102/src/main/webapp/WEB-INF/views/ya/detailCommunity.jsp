<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%> 
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
<head>
<!-- CSS -->
<link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="./assets/css/libs.bundle.css" />
<link rel="stylesheet" href="./assets/css/theme.bundle.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
/* 테이블 스타일 */
section.community {
  padding: 300px 0;
}

body {
   font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 0;
}


table {
  font-size: 15px;
  height: 100px;
  width: 70%;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}

table th {

    text-align: center;
}

table th, table td {
    padding: 10px;
    border: 1px solid #ccc;
}


</style>
</head>

<body>
<section class="detailcommunity">
   <div class="page-title">
        <div class="container">
            <h3>상세글</h3>
        </div>
   </div>

<input type="hidden" name="brd_num" value="${board.brd_num}"> 

<c:if test="${loggedIn}">
    <c:if test="${board.user_num == sessionScope.user_num}">
        <div class="button-container">
            <a href="updateCommunityForm?brd_num=${board.brd_num}" class="btn btn-primary">수정</a>
            <a href="deleteCommunity?brd_num=${board.brd_num}" class="btn btn-primary">삭제</a>
        </div>
    </c:if>
</c:if>

<!-- 게시글 상세 내용 확인 -->
<input type="hidden" name="brd_step" value="${board.brd_step}"> 
<input type="hidden" name="brd_group" value="${board.brd_group}"> 
댓글 총 개수 : ${board.replyCount}
<c:choose>
    <c:when test="${board.brd_step == 0}">
        <table>
            <tr>
                <th>제목</th>
                <td>${board.title}</td>
            </tr>
            <tr>
                <th>닉네임</th>
                <td>${board.nick}</td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>${board.view_cnt}</td>
            </tr>
            <tr>
                <th>작성일자</th>
                <td>${board.reg_date}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td id="board-content">${board.conts}</td>
            </tr>
        </table>
    </c:when>
</c:choose>
		
</section>

	
<%@ include file="./commentForm.jsp" %>
<%@ include file="../footer.jsp" %>
</body>
</html>