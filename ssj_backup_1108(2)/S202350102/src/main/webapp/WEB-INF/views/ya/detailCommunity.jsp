<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>

<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%> 
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
<head>
<style type="text/css">
* 게시글 상세내용 페이지 스타일 */

/* 제목 스타일 */
h3 {
    text-align: center;
    font-size: 24px;
    color: #0099cc;
    margin-bottom: 20px;
}

/* 테이블 스타일 */
table {
    border-collapse: collapse;
    width: 80%;
    margin: 0 auto;
}

table, th, td {
    border: 1px solid #ccc;
}

th, td {
    padding: 10px;
    text-align: left;
}

/* 버튼 스타일 (수정, 삭제 버튼) */
.btn {
    display: inline-block;
    padding: 10px 20px;
    background-color: #0099cc;
    color: #fff;
    border: none;
    border-radius: 5px;
    text-decoration: none;
    margin-right: 10px;
}

.btn-danger {
    background-color: #ff0000;
}

.btn:hover {
    background-color: #0077a8;
}

/* 버튼 컨테이너 스타일 */
.button-container {
    text-align: center;
    margin-top: 20px;
}

/* 내용 스타일 */
#board-content {
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

/* 댓글 수정 폼 기본적으로 숨김 */
.comment-edit-form {
    display: none;
}

/* 수정 버튼 클릭 시 댓글 수정 폼 표시 */
.comment-update-btn-clicked + .comment-edit-form {
    display: block;
}

</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

/*댓글 조회 아작스*/
var brd_num = ${board.brd_num}; 
$(document).ready(function(){
    listcomment(brd_num);
});

function listcomment() {
    var brd_num =  ${board.brd_num};
    $.ajax({
        url: "listComment?brd_num="+brd_num,
        type: "GET",
        data: { "brd_num": brd_num },
        dataType: "json",
        success: function(result) {
            var commentList = $("#commentList"); 
            commentList.empty();
            console.log("brd_num: " + brd_num);
            $.each(result, function(index, board) {
                var listItem = $("<li class='list-group-item'></li>");
                listItem.append("작성자: " + board.nick + " &nbsp;&nbsp;&nbsp;&nbsp;");
                listItem.append("작성날짜: " + board.reg_date);
                listItem.append("<br>댓글 내용: <span>" + board.conts + "</span><br>");
                 listItem.append("<button type='button' class='btn btn-outline-success' id='commentupdateBtn' value='" + board.brd_num + "'>댓글 수정</button>"); 
                listItem.append("<button type='button' class='btn btn-outline-success' id='commentdeleteBtn' value='" + board.brd_num + "'>댓글 삭제</button>"); 

                commentList.append(listItem);
            });
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log("Ajax 요청 실패: " + errorThrown);
        }
    });
}

/*댓글 작성 아작스 */
    $(document).ready(function () {
        $("#submit-comment").click(function () {
            var user_num = $("#user_num").val();
            var brd_num = $("#brd_num").val();
            var conts = $("#conts").val();
            console.log("brd_num: " + brd_num);
            // 여기에서 유효성 검사를 수행할 수 있음

            // 댓글 작성을 서버로 전송
            $.ajax({
                url: "commentWrite",
                type: "POST",
                data: {
                	user_num: user_num,
                    brd_num: brd_num,
                    conts: conts
                },
                dataType: "json",
                success: function (result) {
                    if (result.result === "success") {
                        // 댓글 작성이 성공한 경우, 댓글 목록 조회 아작스를 호출하여 댓글을 즉시 가져옴
                        listcomment();
                    } else {
                        alert("댓글 작성에 실패했습니다.");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Ajax 요청 실패: " + errorThrown);
                }
            });
        });
    });
    
    
    $(document).on("click", "#commentupdateBtn", function() {
        var brd_num = $(this).data("value");
        var conts = $(this).closest("li").find("span").text();

        // 댓글 수정 폼 표시 스타일 업데이트
        $(".comment-edit-form").hide();
        $(this).siblings(".comment-edit-form").show();

        renderEditCommentForm(brd_num, conts);
    });

    function renderEditCommentForm(brd_num, conts) {
        // 수정 폼을 생성하여 특정 댓글 아래에 추가
        var editForm = `
            <div class="comment-edit-form">
                <textarea id="editCommentContent">${conts}</textarea>
                <button class="btn btn-primary" onclick="updateComment(${brd_num})">수정 완료</button>
            </div>
        `;

        // 이전 수정 폼이 있으면 삭제
        $('.comment-edit-form').remove();

        // 해당 댓글 아래에 수정 폼 추가
        $("#commentupdateBtn").parent().append(editForm);
    }

    function updateComment(brd_num) {
        var newContent = $('#editCommentContent').val();

        // 댓글 수정을 서버로 전송
        $.ajax({
            url: "commentUpdate",
            type: "POST",
            data: {
                brd_num: brd_num,
                conts: newContent
            },
            dataType: "json",
            success: function(result) {
                if (result.result === "success") {
                    // 수정이 성공하면 댓글 목록을 다시 불러오기
                    listcomment();
                } else {
                    alert("댓글 수정에 실패했습니다.");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("Ajax 요청 실패: " + errorThrown);
            }
        });
    }
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<h3>게시글 상세내용 확인</h3>

<input type="hidden" name="brd_num" value="${board.brd_num}"> 
		
<c:if test="${loggedIn}">
    <c:if test="${board.user_num == sessionScope.user_num}">
        <div class="button-container">
            <a href="updateCommunityForm?brd_num=${board.brd_num}" class="btn btn-primary">수정</a>
            <a href="deleteCommunity?brd_num=${board.brd_num}" class="btn btn-primary">삭제</a>
        </div>
    </c:if>
</c:if>
<!--게시글 상세 내용 확인  -->
<table>
	<tr>
		<th>제목</th><td>${board.title}</td>
	</tr>
	<tr>
		<th>닉네임</th><td>${board.nick}</td>
	</tr>
	<tr>
		<th>조회수</th><td>${board.view_cnt}</td>
	</tr>
	<tr>
		<th>작성일자</th><td>${board.reg_date}</td>
	</tr>
	<tr>
		<th>내용</th><td id="board-content">${board.conts}</td>
	</tr>
</table>

 <!--댓글작성-->
<c:choose>
    <c:when test="${empty sessionScope.user_num}">
        <!-- 로그인되지 않은 사용자에게는 댓글 작성 폼을 표시하지 않음 -->
        <p>댓글을 작성하려면 로그인이 필요합니다.</p>
    </c:when>
    <c:otherwise>
        <!-- 세션에 user_num이 있는 경우에만 댓글 작성 폼을 표시 -->
	 <div class="card my-4">
	    <h5 class="card-header">댓글 작성</h5>
	    <div class="card-body">
	        <form name="comment-form" action="/commentWrite" method="post" autocomplete="off">
	            <div class="form-group">
	                <input type="hidden" name="user_num" value="${sessionScope.user_num}">
	               <input type="hidden" name="brd_num" id="brd_num" value="${board.brd_num }">
	                <textarea name="conts" id="conts" class="form-control" rows="3" placeholder="댓글을 남겨주세요"></textarea>
	            </div>
	            <button id="submit-comment" type="button" class="btn btn-primary">댓글 작성</button>
	        </form>
	    </div>
	</div>
    </c:otherwise>
</c:choose>


<!--댓글 조회 -->
<div class="container">
 <ul class = "list-group list-group-flush" id ="commentList">
  	 <c:forEach var="board" items="${listComment}">
   		<li class="list-group-item">
 		작성자: ${board.nick} &nbsp;&nbsp;&nbsp;&nbsp;
 		작성날짜 : ${board.reg_date}
 		댓글 내용: <span>${board.conts}</span>
 		
	 	<!-- 로그인한 사용자와 댓글 작성자가 같을 때만 수정 및 삭제 버튼 표시 -->
		<c:if test="${loggedIn}">
	    	<c:if test="${board.user_num == sessionScope.user_num}">
	        	<button type='button'  id='commentupdateBtn' data-value='${board.brd_num}'>댓글 수정</button>
	        	<button type='button'  id= 'commentdeleteBtn' data-value='${board.brd_num}'>댓글 삭제</button>
	   		</c:if>
		</c:if>        
	    </li>
   	 </c:forEach>
  </ul>
</div>
 
</body>
</html>