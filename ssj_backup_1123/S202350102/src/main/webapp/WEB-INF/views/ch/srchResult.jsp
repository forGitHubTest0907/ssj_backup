<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
function sh(){
	if($("#shList").css("display") == "none" || $("#shList").css("display") == ""){
	    $("#shList").show();
	} else {
	    $("#shList").hide();
	    
	}
}
</script>
<style type="text/css">
	#shList{
		z-index: 999;
		position: absolute;
	}
	
	#srch_btn{
		background-color: transparent;
	}
	
	#searchVar{
		width: 30%
	}
</style>
<title>Insert title here</title>
</head>
<body>
	<div id="searchVar" class="container">
		<form action="searching">
			<div class="input-group">				
				<input type="search" name="srch_word" id="srch_word" class="form-control form-control-underline form-control-sm border-dark" onclick="sh()" >
				<button type="submit" class="btn-underline btn-sm border-dark" id="srch_btn">
					<i class="fe fe-search"></i>
				</button>
			
			</div>			
		</form>
		<div class="card" id="shList" style="display: none;">
			<c:if test="${user_num != 0 }">
				<div class="card-body">
					<table>
						<c:forEach items="${shList }" var="shList">
							<tr>
								<td>
									<a href="searching?srch_word=${shList.srch_word }">${shList.srch_word }</a>
								</td>
								<td>
									<a href="deleteHis?srch_word=${shList.srch_word }">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
										  <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
										</svg>
									</a>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</c:if>
		</div>
	</div>
	<h2>${srch_word }에 대한 검색결과 입니다.</h2>
	<section>
		
		<div class="container">
			<h4>챌린지</h4>
			<c:if test="${empty srch_chgResult }">
				<h6>검색결과가 없습니다.</h6>
			</c:if>
			<table>
				<c:set var="num" value="1"/>
				<c:forEach items="${srch_chgResult }" var="chResultList" varStatus="status">
					<c:if test="${num < 6 }">
						<tr>
							<td>
								<a href="challengeDetail?chg_id=${chResultList.chg_id }">${chResultList.title }</a>
							</td>
							<td><fmt:formatDate value="${chResultList.reg_date }" pattern="yyyy-MM-dd"/></td>
							<td>${chResultList.nick }</td>
						</tr>
					<c:set var="num" value="${num+1 }"/>
					</c:if>	
				</c:forEach>
			</table>
		</div>
	
	</section>
	
	<hr>
	<section>
		<div class="container">
			<h3>쉐어링</h3>
			<c:if test="${empty srch_shareResult }">
				<h6>검색결과가 없습니다.</h6>
			</c:if>
			<table>
				
				<c:set var="num" value="1"/>
				<c:forEach items="${srch_shareResult }" var="shrResultList" varStatus="status">
					<c:if test="${num < 6 }">
						<tr>
							<td>
								<a href="detailCommunity?user_num=${shrResultList.user_num}&brd_num=${shrResultList.brd_num}">${shrResultList.title }</a>
							</td>
							<td><fmt:formatDate value="${shrResultList.reg_date }" pattern="yyyy-MM-dd"/></td>
							<td>${shrResultList.nick }</td>
						</tr>
						<c:set var="num" value="${num+1 }"/>
					</c:if>
				</c:forEach>
			</table>
		</div>
	</section>
	
	<hr>
	
	<section>
		<div class="container">
			<h3>자유게시판</h3>
			<c:if test="${empty srch_brdResult }">
				<h6>검색결과가 없습니다.</h6>
			</c:if>
			<table class="table">
				<c:set var="num" value="1"/>	
				<c:forEach items="${srch_brdResult }" var="brdResultList">
					<c:if test="${num < 6 }">
						<tr>
							<td>
								<a href="detailCommunity?user_num=${brdResultList.user_num}&brd_num=${brdResultList.brd_num}">${brdResultList.title }</a>
							</td>
							<td><fmt:formatDate value="${brdResultList.reg_date }" pattern="yyyy-MM-dd"/></td>
							<td>${brdResultList.nick }</td>
						</tr>
						<c:set var="num" value="${num+1 }"/>
					</c:if>			
				</c:forEach>
				
			</table>
			<a href="srchcommunity?srch_word=${srch_word }">더보기</a>
		</div>
	</section>
<%@ include file="/WEB-INF/views/footer.jsp" %>

</body>
</html>