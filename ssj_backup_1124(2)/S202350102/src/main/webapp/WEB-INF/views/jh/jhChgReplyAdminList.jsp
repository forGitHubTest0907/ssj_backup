<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<section class="pt-7 pb-12">
 <div class="container">
        <div class="row">
        
        
        
          <div class="col-12 text-center">
			
            <!-- Heading -->
            <div class="col-12 text-center">
            
            	<h3 class="mb-10"> < ${reviewContent.title } > 후기 댓글 관리</h3>
            </div>

          </div>
        </div>
        
        <div class="row">
        <!--사이드바   -->
		<%@ include file="adminSidebar.jsp" %>	
		
		<div class="col-md-10 ">
		<div class="col-12">
		<div class="col-12">
		총 댓글 수 : ${replyCount }
		</div>
		<c:set var="num" value="${replyPage.total-replyPage.start+1 }"></c:set>
		
			<table class="table table-bordered table-sm mb-0   table-hover">
                    <thead class="table-dark">
				<tr class="p-2 text-center">
					<th>번호</th>
					<th>댓글 내용</th>
					<th>작성자 닉네임</th>
					<th>작성일자</th>
					<th>삭제</th>
				</tr>
			  </thead>
			  <tbody>
			  	<c:forEach var="reply" items="${reviewReplyList }" varStatus="status">
				  	<tr class="text-center" id="reply${status.index }">
				  		<td>${num }</td>
						<td>${reply.conts }</td>
						<td>${reply.nick }</td>
						<td><fmt:formatDate value="${reply.reg_date }" pattern="yyyy-MM-dd"></fmt:formatDate></td>
						<td class="justify-content-center">
								<button type="button" class="btn btn-secondary btn-xxs" onclick="replyAdminDelete('${reply.brd_num}')">삭제</button>
						</td> 
				  	</tr>
					<c:set var="num" value="${num -1 }"></c:set>
				</c:forEach>
			  </tbody>
			  </table>
			 </div>
			  
			  
			 
       		<!-- Pagination -->
			<nav class="d-flex justify-content-center mt-9">
			  <ul class="pagination pagination-sm text-gray-400">
			  <c:if test="${replyPage.startPage > replyPage.pageBlock}">
			    <li class="page-item">
			      <a class="page-link page-link-arrow" href="replyAdminList?currentPage=${replyPage.startPage-replyPage.pageBlock }&brd_num=${brd_num}">
			        <i class="fa fa-caret-left"></i>
			      </a>
			    </li>
              </c:if>
	          <c:forEach var="i" begin="${replyPage.startPage }" end="${replyPage.endPage }">
			    <li class="page-item">
			    	<c:if test="${i == replyPage.currentPage}">
			      		<a class="page-link" href="replyAdminList?currentPage=${i}&brd_num=${brd_num}"><b class="text-primary">${i}</b></a>
			    	</c:if>
			    	<c:if test="${i != replyPage.currentPage}"> 
			     		<a class="page-link" href="replyAdminList?currentPage=${i}&brd_num=${brd_num}">${i}</a>
			    	</c:if>
			    </li>
	          </c:forEach>
	          <c:if test="${replyPage.endPage < replyPage.totalPage }">
			    <li class="page-item">
			      <a class="page-link page-link-arrow" href="replyAdminList?currentPage=${replyPage.startPage+replyPage.pageBlock }&brd_num=${brd_num}">
			        <i class="fa fa-caret-right"></i>
			      </a>
			    </li>
	          </c:if>
			  </ul>
			</nav>
			</div>
</div>
</div>
</section>
</body>
</html>
</body>
</html>