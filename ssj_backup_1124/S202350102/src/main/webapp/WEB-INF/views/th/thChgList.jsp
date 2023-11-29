<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린지 리스트</title>
<script type="text/javascript">
	function fn_sortOpt(){
		var sortOpt = $('#sortOpt').val()
 		var state_md 	= 	${chg.state_md}
 		var chg_lg 		= 	${chg.chg_lg}
 		var chg_md 		= 	${chg.chg_md}
		var currentPage	=	${page.currentPage}
		
		location.href= 'thChgList?state_md='+state_md
								+'&chg_lg='+chg_lg
								+'&chg_md='+chg_md
								+'&sortOpt='+sortOpt
								+'&currentPage='+currentPage;
	}

	// yr 작성
	// 찜하기 기능
	function chgPick(p_index) {

		$.ajax({
			url : "/chgPickPro",
			type : "POST",
			data : {chg_id : p_index},
			dataType : 'json',
			success : function(chgPickResult) {
				if(chgPickResult.chgPick > 0) {
					$("#chgPick" + p_index).removeClass("btn-white-primary").addClass("btn-primary");
				} else {
					$("#chgPick" + p_index).removeClass("btn-primary").addClass("btn-white-primary");
				}

			},
			error : function() {
				alert("찜하기 오류");
			}
		});
	}
	
	function confirmPswd(){
		var input_priv_pswd = $('#input_priv_pswd').val()
		var chg_priv_pswd 	= $('#chg_priv_pswd').val()
		var chg_id			= $('#chg_id').val()
// 		alert('input_priv_pswd --> ' + input_priv_pswd )
// 		alert('chg_priv_pswd --> ' + chg_priv_pswd)
		if(input_priv_pswd == chg_priv_pswd){
			location.href = "chgDetail?chg_id="+chg_id
		} else {
			alert('비밀번호가 틀렸습니다');
			$('#modalMatchPswd').modal('hide');
			return false;
		}	
	}
	// 현재 페이지 그대로 이동
	function moveCurrentPage() {
		var sortOpt 	= 	$('#sortOpt').val()
 		var state_md 	= 	${chg.state_md}
 		var chg_lg 		= 	${chg.chg_lg}
 		var chg_md 		= 	${chg.chg_md}
		var currentPage	=	${page.currentPage}
		
		location.href= 'thChgList?state_md='+state_md
								+'&chg_lg='+chg_lg
								+'&chg_md='+chg_md
								+'&sortOpt='+sortOpt
								+'&currentPage='+currentPage;
	}
	// 다른 페이지로 이동
	function movePage() {
		var sortOpt 	= 	$('#sortOpt').val()
 		var state_md 	= 	${chg.state_md}
 		var chg_lg 		= 	${chg.chg_lg}
 		var chg_md 		= 	${chg.chg_md}
		var pageNum		=	document.getElementById('movePage').innerText

		location.href= 'thChgList?state_md='+state_md
								+'&chg_lg='+chg_lg
								+'&chg_md='+chg_md
								+'&sortOpt='+sortOpt
								+'&currentPage='+pageNum;
	}

</script>
<link href="http://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
<style type="text/css">
    body{ font-family: 'Noto Sans KR', sans-serif; } 
</style>
</head>

<body>
	<!-- MODAL -->
	    <!-- 아이디 찾기 MODAL  -->
    
     <div class="modal fade" id="modalMatchPswd" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
    
          <!-- Close -->
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
            <i class="fe fe-x" aria-hidden="true"></i>
          </button>
    
          <!-- Header-->
          <div class="modal-header lh-fixed fs-lg">
            <strong class="mx-auto">비공개 방</strong>
          </div>
    
          <!-- Body -->
          <div class="modal-body text-center">
    
            <!-- Text -->
            <p class="mb-7 fs-sm text-gray-500">
              	비밀번호를 입력해 주세요 
              	
            </p>
    
            <!-- Form -->
<!--             <form action="findId"> -->
    			
    		  <!-- 아이디 -->
              <div class="form-group">
                <label class="visually-hidden" for="user_name">
                  	비밀번호 *
                </label>
                <input class="form-control form-control-sm" id="input_priv_pswd" name="input_priv_pswd" type="text"  placeholder="비밀번호 " required>
              </div>
     
              <button class="btn btn-sm btn-dark" onclick="return confirmPswd()">
                	확인
              </button>
    
<!--             </form> -->
    
          </div>
    
        </div>
    
      </div>
    </div>
    
    
    <section class="py-11">
      <div class="container">
        <div class="row">
			<%@ include file="/WEB-INF/views/chgSidebar.jsp" %>
        
        
        
          
      
         
		  <div class="col-12 col-md-8 col-lg-9">
			<!-- Header -->
            <div class="row align-items-center mb-7">
              <div class="col-12 col-md">

                <!-- Heading -->

                	<h3 class="mb-1">챌린지
		                <c:choose>
		                	<c:when test="${chg.chg_md == ''}"></c:when>	
		                	<c:when test="${chg.chg_md == 100}"> - 운동</c:when>
		                	<c:when test="${chg.chg_md == 101}"> - 공부</c:when>
		                	<c:when test="${chg.chg_md == 102}"> - 취미</c:when>
		                	<c:when test="${chg.chg_md == 103}"> - 습관</c:when>
		                </c:choose>
                	</h3>

              </div>
              <div class="col-12 col-md-auto">

                <!-- 필터 조회 -->
                <select class="form-select form-select-xs" id="sortOpt" onchange="fn_sortOpt()"> 
                  <option value="create_date" 	<c:if test="${sortOpt eq 'create_date' }">	selected="selected"</c:if>>최신등록순</option>
                  <option value="pick_cnt" 		<c:if test="${sortOpt eq 'pick_cnt' }">		selected="selected"</c:if>>찜순</option>
                  <option value="participants" 	<c:if test="${sortOpt eq 'participants' }">	selected="selected"</c:if>>참여자순</option>
                </select>

              </div>
            </div> 
             
            <!-- 챌린지 리스트 조회  -->
            <div class="row">
	            <c:set var="num" value="${page.total-page.start+1 }"></c:set>
	            	<c:forEach var="chg" items="${listChg }">
	            		<c:if test="${chg.chg_public == 1 }">
	            			<input type="hidden" id="chg_priv_pswd" name="chg_priv_pswd" value="${chg.priv_pswd }">
	            			<input type="hidden" id="chg_id" name="chg_id" value="${chg.chg_id }">
	            		</c:if>
			            <div class="col-6 col-md-4">
						
			               <!-- Card -->
			              <div class="card mb-7">
			
			                <!-- Image -->
			                <div class="card-img">
			
								<!-- YR 작성 -->
								<!-- 찜하기 -->
								<c:choose>
									<c:when test="${sessionScope.user_num != null}">
										<!-- 로그인 한 상태 -->
										<c:choose>
											<c:when test="${chg.pickyn > 0}">
												<!-- 찜하기 있음 -->
												<button type="button" class="btn btn-xs btn-circle btn-primary card-action card-action-end" data-toggle="button" onclick="chgPick(${chg.chg_id})" id="chgPick${chg.chg_id}">
													<i class="fe fe-heart"></i>
												</button>
											</c:when>
								
											<c:otherwise>
												<!-- 찜하기 없음 -->
												<button type="button" class="btn btn-xs btn-circle btn-white-primary card-action card-action-end" data-toggle="button" onclick="chgPick(${chg.chg_id})" id="chgPick${chg.chg_id}">
													<i class="fe fe-heart"></i>
												</button>
											</c:otherwise>
										</c:choose>
									</c:when>
								
									<c:otherwise>
										<!-- 로그인 안 한 상태 -->
										<button type="button" class="btn btn-xs btn-circle btn-white-primary card-action card-action-end" data-toggle="button"
											onclick="location.href='/loginForm'">
											<i class="fe fe-heart"></i>
										</button>
									</c:otherwise>
								</c:choose>
			
			                  <!-- Button -->
			                  <button class="btn btn-xs w-100 btn-dark card-btn" <c:if test="${chg.chg_public == 1 }"> data-bs-toggle="modal" data-bs-target="#modalMatchPswd"</c:if>
			                  													 <c:if test="${chg.chg_public == 0 }"> onclick ="location.href='chgDetail?chg_id=${chg.chg_id }'"</c:if>
			                  													>
			                    <i class="fe me-2 mb-1"></i>챌린지에 도전하세요!
			                  </button>
			
			                  <!-- Image -->
			                  <a class="text-body" <c:if test="${chg.chg_public == 1 }"> href="#modalMatchPswd" data-bs-toggle="modal"</c:if>
			                  					   <c:if test="${chg.chg_public == 0 }"> href="/chgDetail?chg_id=${chg.chg_id }"</c:if>
			                  					   >
			                  <c:if test="${chg.thumb != null}">
			             		<c:if test="${chg.thumb == 'assets/img/chgDfaultImg.png'}">
			                  		<img class="card-img-top" src="assets/img/chgDfaultImg.png" alt="chgDfault" style="width: 100%; height: 250px; border-radius: 10px;">
			                  	</c:if>
			                  	<c:if test="${chg.thumb != 'assets/img/chgDfaultImg.png'}">
			                  		<img class="card-img-top" src="${pageContext.request.contextPath}/upload/${chg.thumb}" alt="thumb" style="width: 100%; height: 250px; border-radius: 10px;" >
			                  	</c:if>
			                  </c:if>
			                  <c:if test="${chg.thumb == null}">
			                  	<img class="card-img-top" src="assets/img/chgDfaultImg.png" alt="chgDfault" style="width: 100%; height: 250px; border-radius: 10px;">
			                  </c:if>

							  </a>
			              </div>
			              
			              <!-- Body -->
			              <div class="card-body fw-bold text-start px-0 py-2">
			                <a class="text-body fw-bolder fs-6" <c:if test="${chg.chg_public == 1 }"> href="#modalMatchPswd" data-bs-toggle="modal"</c:if>
			                									<c:if test="${chg.chg_public == 0 }"> href="/chgDetail?chg_id=${chg.chg_id }"</c:if>
			                									id="title">${chg.title }</a>
			                <div> 
			                 <fmt:formatDate value="${chg.create_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
			                  ~ 
			                 <fmt:formatDate value="${chg.end_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
			                 </div>
			                <div>참여인원: ${chg.chlgerCnt}명</div>
			                <div>찜수: ${chg.pick_cnt }</div>
			              </div>
							
			            </div>
			            	
					  </div>
					  <c:set var="num" value="${num -1 }"></c:set>
				</c:forEach>
				
				<!-- 페이지네이션  -->
				 <nav class="d-flex justify-content-center justify-content-md-center">
      	   		 <ul class="pagination pagination-sm text-gray-400">
				  	<c:if test="${page.startPage > page.pageBlock }">
				  		<li class="page-item">
							<a class="page-link page-link-arrow" href="thChgList?currentPage=${page.startPage-page.pageBlock }">
							<i class="fa fa-caret-left">이전</i></a>
						</li>
					</c:if>
					
				    <c:forEach var="i" begin="${page.startPage }" end="${page.endPage }">
						<li class="page-item">
							<c:if test="${i == page.currentPage }">
								<a class="page-link" onclick="moveCurrentPage()" href="#" id="moveCurrentPage"><b class="text-primary">${i}</b></a>
							</c:if>
							<c:if test="${i != page.currentPage }">
								<a class="page-link" onclick="movePage()" href="#" id="movePage">${i}</a>
							</c:if>
						</li>
					</c:forEach>
				    <c:if test="${page.endPage < page.totalPage }">
				    	<li class="page-item">
							<a class="page-link page-link-arrow" href="thChgList?currentPage=${page.startPage + page.pageBlock }">
							<i class="fa fa-caret-right">다음</i></a>
						</li>
					</c:if>
				 </ul>
		  		</nav>
			</div>
		
      </div>
      	  
    </div>
  </div>
</section>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>