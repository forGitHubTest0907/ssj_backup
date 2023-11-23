<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" integrity="sha384-GLhlTQ8iKUrZMp+UHMAKP5VkCHUFO9giopFv4NcP4EZh1l6z5JmLdpg4V9M34"
    crossorigin="anonymous">
    <!--  CSS  -->
<link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="./assets/css/libs.bundle.css" />
<link rel="stylesheet" href="./assets/css/theme.bundle.css" />
 <link rel="stylesheet" href="https://unpkg.com/flickity@2/dist/flickity.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<meta charset="UTF-8">
<style type="text/css">
<link href="https://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
<style type="text/css">
    body{ font-family: 'Noto Sans KR', sans-serif; } 
       .table td {
       	 padding-top: 5px;
       	  padding-bottom: 5px;
    }
 .table th {
        background-color: #343a40;
        color: #000000;
        text-align: center;
        font-weight: bold; /* 링크 글자를 굵게 조절 */
        border-bottom-width: 3px; /* 밑줄 굵기 조절 */
        border-bottom-color: #191919; /* 밑줄 색상 조절 */
    }
    
    .table td a {
        color: #000000; /* 링크 글자색을 검정색으로 조절 */
        text-decoration: none; /* 기본 링크 텍스트 밑줄 제거 */
    }
      .table td a:hover {
        text-decoration: underline; /* 링크에 마우스 호버 시 밑줄 추가 */
    }
    
.disabled-btn-group .btn {
    pointer-events: none;
}
</style>

<title>쉐어링관리</title>

</head>
<body>
<!-- 필수!! -->
 <div class="container">
    <div class="row profile">
       <div class="col-md-3">
            <%@ include file="../mypageMenu.jsp" %>
       </div>
    <div class="col-md-9 profile-form">
<!-- 필수!! -->

<!--내가 개설한 쉐어링 제목 누르면  brd_num으로 해당하는 상세페이지로 이동시키게 설정하기----------------------------------------------------- -->
    <section class="myUploadSharing" style="width: 1000px; height: 350px">
        <div class="page-title">
            <div class="container">
                <h6>내가 올린 쉐어링 </h6>
            </div>
        </div>
      <!-- 게시판리스트  -->
        <div id="board-list">
            <div class="container">
                <table class="table table-sm">
                     <thead class="table-light">
                        <tr>
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-applicants" style="padding-left: 10px; padding-right: 10px;">모집인원</th>
                            <th scope="col" class="th-particpants"style="padding-left: 10px; padding-right: 10px;">승인인원</th>
                            <th scope="col" class="th-bank_duedate">입금기한</th>
                            <th scope="col" class="th-check">지원자</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="board" items="${myUploadSharingList}">
                            <tr>
                                <td>${board.brd_num}</td>
                                <td><a href="detailSharing?brd_num=${board.brd_num}">${board.title}</a></td>
                                <td>${board.applicants}</td>            
                                <td>${board.participants}</td>      
                                <td>${board.bank_duedate}</td>
				         		<td><button type="button" class="btn  btn-sm openModalButton" data-toggle="modal" data-target="#joinInfoModal" 
				         					data-brd_num="${board.brd_num}" style=" background-color: #E56D90; color:#FFFFFF; padding-left: 10px;   padding-right: 10px; padding-top: 5px; padding-bottom: 5px">
				         					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search-heart" viewBox="0 0 16 16">
  											<path d="M6.5 4.482c1.664-1.673 5.825 1.254 0 5.018-5.825-3.764-1.664-6.69 0-5.018Z"/>
  											<path d="M13 6.5a6.471 6.471 0 0 1-1.258 3.844c.04.03.078.062.115.098l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1.007 1.007 0 0 1-.1-.115h.002A6.5 6.5 0 1 1 13 6.5ZM6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11Z"/>
											</svg>		
				         			 조회</button></td>       
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>  
             </div>          
        </div>
			<div class="container text-center">
			     <ul class="pagination pagination-sm justify-content-center">
			        <c:if test="${myUploadSharingPaging.startPage >myUploadSharingPaging.pageBlock}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="sharingManagement?currentPage=${myUploadSharingPaging.startPage-myUploadSharingPaging.pageBlock}">
			                    <i class="fa fa-caret-left"></i>
			                </a>
			            </li>
			        </c:if>
			
			        <c:forEach var="i" begin="${myUploadSharingPaging.startPage}" end="${myUploadSharingPaging.endPage}">
			            <li class="page-item <c:if test='${myUploadSharingPaging.currentPage == i}'>active</c:if>">
			                <a class="page-link" href="sharingManagement?currentPage=${i}">${i}</a>
			            </li>
			        </c:forEach>
			
			        <c:if test="${myUploadSharingPaging.endPage < myUploadSharingPaging.totalPage}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="sharingManagement?currentPage=${myUploadSharingPaging.startPage+myUploadSharingPaging.pageBlock}">
			                    <i class="fa fa-caret-right"></i>
			                </a>
			            </li>
			        </c:if>
			    </ul>
			</div>        
        
        
    </section>
    <!--내가 신청한 쉐어링 joinsharingList ------------------------------------------------------------------------------ -->
	    <section class="myJoinSharing" style="width: 1000px; height: 350px">
        <div class="page-title">
            <div class="container">
                <h6>내가 참가한 쉐어링 </h6>
            </div>
        </div>
      <!-- 게시판리스트  -->
        <div id="board-list">
            <div class="container">

                <table class="table table-sm" >           
                      <thead class="table-light">
                        <tr>
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-applicants">승인상태</th>
                            <th scope="col" class="th-bank_duedate">반려사유</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="sharingList" items="${myJoinSharingList}">
                            <tr>
                                <td>${sharingList.brd_num}</td>
                                <td><a href="detailSharing?brd_num=${sharingList.brd_num}">${sharingList.title}</a></td>
                                 <td>
                                 	<c:choose>
                                 		<c:when test="${sharingList.state_md == 100}">신청완료</c:when>
                                 		<c:when test="${sharingList.state_md == 101}">승인완료</c:when>
                                 		<c:otherwise>반려</c:otherwise>
                                 	</c:choose>                               
                                 </td>                  
                                <td>${sharingList.reject_msg} </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>  
             </div>          
        </div>
        		<div class="container text-center">
			     <ul class="pagination pagination-sm justify-content-center">
			        <c:if test="${ myJoinSharingPaging.startPage >  myJoinSharingPaging.pageBlock}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="sharingManagement?currentPage=${myJoinSharingPaging.startPage-myJoinSharingPaging.pageBlock}">
			                    <i class="fa fa-caret-left"></i>
			                </a>
			            </li>
			        </c:if>
			
			        <c:forEach var="i" begin="${ myJoinSharingPaging.startPage}" end="${ myJoinSharingPaging.endPage}">
			            <li class="page-item <c:if test='${ myJoinSharingPaging.currentPage == i}'>active</c:if>">
			                <a class="page-link" href="sharingManagement?currentPage=${i}">${i}</a>
			            </li>
			        </c:forEach>
			
			        <c:if test="${ myJoinSharingPaging.endPage <  myJoinSharingPaging.totalPage}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="sharingManagement?currentPage=${ myJoinSharingPaging.startPage+ myJoinSharingPaging.pageBlock}">
			                    <i class="fa fa-caret-right"></i>
			                </a>
			            </li>
			        </c:if>
			    </ul>
			</div>        
        
    </section>
    
 <!--승인완료된 쉐어링 정보 -------------------입금액(총금액/모집인원   ?? ------------------------------------------------------------- -->   
    <section class="myUploadSharing" style="width: 1000px; height: 350px">
        <div class="page-title">
       		 <div class="container">
                <h6> 입금정보 </h6>
            </div>
        </div>
      <!-- 게시판리스트  -->
        <div id="board-list">
            <div class="container">
            <input type="hidden" value="${board.brd_num }"> 
                <table class="table table-sm" >
                      <thead class="table-light">
                        <tr>
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-bank_info">계좌정보</th>
                            <th scope="col" class="th-price">입금액</th>
                            <th scope="col" class="th-bank_duedate">입금기한</th>
                            <th scope="col" class="th-addr">거래주소</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="board"  items="${myConfirmSharingList}">
                         <input type="hidden" value="${board.applicants}">
                            <tr>
                                <td>${board.brd_num}</td>
                                <td><a href="detailSharing?brd_num=${board.brd_num}">${board.title}</a></td>
                                <td>${board.bank_info}</td>    
                                <td><fmt:formatNumber value="${board.price div board.applicants}" pattern="#,###"/></td>        
                                <td>${board.bank_duedate}</td>
                                <td>${board.addr}</td>                               
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>  
             </div>          
        </div>
        
        		<div class="container text-center">
			     <ul class="pagination pagination-sm justify-content-center">
			        <c:if test="${myConfirmSharingPaging.startPage > myConfirmSharingPaging.pageBlock}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="sharingManagement?currentPage=${myConfirmSharingPaging.startPage-myConfirmSharingPaging.pageBlock}">
			                    <i class="fa fa-caret-left"></i>
			                </a>
			            </li>
			        </c:if>
			
			        <c:forEach var="i" begin="${myConfirmSharingPaging.startPage}" end="${myConfirmSharingPaging.endPage}">
			            <li class="page-item <c:if test='${myConfirmSharingPaging.currentPage == i}'>active</c:if>">
			                <a class="page-link" href="sharingManagement?currentPage=${i}">${i}</a>
			            </li>
			        </c:forEach>
			
			        <c:if test="${myConfirmSharingPaging.endPage < myConfirmSharingPaging.totalPage}">
			            <li class="page-item">
			                <a class="page-link page-link-arrow" href="sharingManagement?currentPage=${myConfirmSharingPaging.startPage+myConfirmSharingPaging.pageBlock}">
			                    <i class="fa fa-caret-right"></i>
			                </a>
			            </li>
			        </c:if>
			    </ul>
			</div>        
    </section>	
</div>
</div>
</div>
<!-----------내가올린 쉐어링모달창 띄우기------------------------------------------------------------------------------------------------------->
<div class="modal  fade" id="joinInfoModal">
    <div class="modal-dialog  modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title">쉐어링 참가자 조회</h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    			<span aria-hidden="true">&times;</span>
				</button>
            </div>

            <div class="modal-body">
            	<input type="hidden" name="brd_num" value="${board.brd_num}"> 
            	<h6 id="totalParticipants">총 지원자 : </h6>
            	 
            	<table class="table table-hover" id="joinInfoForm" >		
                    <thead class="table-light" >
                        <tr>
                            <th scope="col" class="th-user_num">회원번호</th>
                            <th scope="col" class="th-name">이름</th>
                            <th scope="col" class="th-message">메시지</th>
                            <th scope="col" class="th-tel">연락처</th>
                            <th scope="col" class="th-reg_date">신청일자</th>
                            <th scope="col" class="th-check">승인처리</th>
                            <th scope="col" class="th-check-result">결과</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="sharingList" items="${sharingParticipantsInfo}">

                        <input type="hidden" value="${sharingList.brd_num}">
                            <tr>
                            	<td id="user_num">${sharingList.user_num}</td>                     	
                                <td id="user_name">${sharingList.user_name}</td>
                                <td id="message">${sharingList.message}</td>                  
                                <td id="tel">${sharingList.tel}</td>
                                <td id="reg_date">${sharingList.reg_date}</td>                              
				         		<td>
				         			<button type="button" class="btn btn-dark btn-sm confirmModalButton"  data-brd_num="${sharingList.brd_num}" data-user_num="${sharingList.user_num}"  >승인</button>
        							<button type="button" class="btn btn-dark btn-sm rejectModalButton" data-brd_num="${sharingList.brd_num}" data-user_num="${sharingList.user_num}"
        														data-reject_msg="${sharingList.reject_msg}">반려</button>
				         		</td>  
                                 <td class="th-check-result">
                                 	<c:choose>
                                 		<c:when test="${sharingList.state_md == 101}">승인</c:when>
                                 		<c:when test="${sharingList.state_md == 104}">반려</c:when>
                                 		<c:otherwise>반려</c:otherwise>
                                 	</c:choose>                               
                                 </td>  
                            </tr>
                        </c:forEach>
                    </tbody>                           
                </table>
            </div>
        </div>	  	 
    </div>
</div>



<!-- 반려시 모달창 띄우기------------------------------------------------------------------------------------------------------------>
<div class="modal" tabindex="-1" role="dialog" id="rejectReasonModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">반려사유 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="rejectReasonForm">
                    <div class="form-group">
                        <label for="rejectReason">반려 사유:</label>
                        <textarea class="form-control" id="reject_msg" name="reject_msg" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">확인</button>
                </form>
            </div>
        </div>
    </div>
</div>


<!-------------------------------- 참가자 조회 모달창 자바스크립트 (중복 승인/반려 막기 해야함 )  applicants(모집인원) <= participants(참가인원) ------------------------------------------------------------------------>
<script type="text/javascript">

//참가자 조회 모달창  열때 
var participantCount = 0;
$(document).on('click', '.openModalButton', function () {
    // 버튼의 데이터 속성에서 게시글 번호 가져오기
    var brd_num = $(this).data('brd_num');
    
    // 모달 내부의 숨겨진 입력란에 값 설정
    $('#joinInfoModal input[name="brd_num"]').val(brd_num);

    // 서버에 데이터를 요청하여 참가자 정보 가져오기
    fetch('/sharingParticipantsInfo?brd_num=' + brd_num)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            // 가져온 데이터를 사용하여 모달 내용을 업데이트
            var tbody = $('#joinInfoForm tbody');
            tbody.empty();
            // 참가자 수 초기화
            participantCount = 0;
            
            if (Array.isArray(data) && data.length > 0) {
                data.forEach(sharingList => {
                    // 참가자 정보를 테이블 행으로 추가
                    var regDate = new Date(sharingList.reg_date);
                    var options = { year: '2-digit', month: '2-digit', day: '2-digit' };
                    var formattedRegDate = regDate.toLocaleDateString('en-US', options);
                    
                    // state_md가 101이거나 104이면 버튼을 비활성화
                     var isButtonsDisabled = (sharingList.state_md === 101 || sharingList.state_md === 104);

                    var row = '<tr>' +
                        '<td>' + sharingList.user_num + '</td>' +
                        '<td>' + sharingList.user_name + '</td>' +
                        '<td>' + sharingList.message + '</td>' +
                        '<td>' + sharingList.tel + '</td>' +
                        '<td>' + formattedRegDate + '</td>' +
                        '<td>' + '<div class="btn-group ' + (isButtonsDisabled ? 'disabled' : '') + '" role="group" aria-label="Basic example">' +
                        '<button type="button" class="btn btn-dark btn-sm confirmModalButton" data-brd_num="' + sharingList.brd_num + '" data-user_num="' + sharingList.user_num + '" ' + (isButtonsDisabled ? 'disabled' : '')+'>승인</button>' +
                        '<button type="button" class="btn btn-dark btn-sm rejectModalButton" data-brd_num="' + sharingList.brd_num + '" data-user_num="' + sharingList.user_num + '" '+ (isButtonsDisabled ? 'disabled' : '') + '>반려</button>' +
                        '</td>' + '</div>' +
                        '<td>' + (sharingList.state_md == 101 ? '승인' : (sharingList.state_md == 104 ? '반려' : '')) + '</td>' +
                        '</tr>';
                    tbody.append(row);
                    
                    // 버튼 그룹 상위 엘리먼트에 클래스 추가
                    var buttonGroup = tbody.find('.btn-group[data-brd_num="' + sharingList.brd_num + '"][data-user_num="' + sharingList.user_num + '"]');
                    buttonGroup.addClass('disabled');
                    
                    participantCount++;
                });
                //참가자 수 모달에 표시
                updateVisibleParticipants();
               
            } else {
                console.error('Received JSON data is not in the expected format:', data);
            }
         	// 참가자 수 업데이트 함수
            function updateVisibleParticipants() {
                // 참가자 수 업데이트
                $('#totalParticipants').text('총 지원자 수: ' + participantCount);
            }
           
        })

        });

function handleButtonClick(brd_num, user_num) {
    // 버튼 그룹 상위 엘리먼트에서 클래스를 추가하여 버튼들을 동시에 비활성화
   var buttonGroup = $('.btn-group[data-brd_num="' + brd_num + '"][data-user_num="' + user_num + '"]');
    buttonGroup.addClass('disabled-btn-group');
}        



<!--참가 승인 반려  버튼처리----------------------------------------------------------------------------------->
document.getElementById('joinInfoForm').addEventListener('click', function (event) {
	  event.stopPropagation();
	// 클릭된 요소가 버튼인지 확인
    if (event.target.tagName === 'BUTTON') {
        // 버튼의 속성 출력
        console.log('Button attributes:', event.target.attributes);

        // 버튼의 데이터 속성에서 필요한 정보를 가져옵니다.
        var brd_num = event.target.dataset.brd_num;
        var user_num = event.target.dataset.user_num;

        console.log('brd_num:', brd_num);
        console.log('user_num:', user_num);
    }
             
    // 승인 버튼이 클릭된 경우-------------------------------------------------------------------
    if (event.target.classList.contains('confirmModalButton')) {
        var formData = new FormData();
    	formData.append('brd_num', parseInt(brd_num, 10));
    	formData.append('user_num', parseInt(user_num, 10));
    	
    	var button = $(event.target);
     	if (!button.hasClass('disabled')) {
    		button.addClass('disabled');
    	} 
    	
      
    	// 서버로 데이터를 전송하는 fetch API 사용
        fetch('/sharingConfirm', {
            method: 'POST',
             headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body:  'brd_num=' + encodeURIComponent(brd_num) + '&user_num=' + encodeURIComponent(user_num),  
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {

                // 성공적으로 처리된 경우
                alert(data.message); // "승인이 완료되었습니다" 메시지를 띄웁니다.
           
                // 페이지를 새로 고침합니다.
                location.reload(true);
   
            } else {
                // 처리에 실패한 경우
                alert(data.message); // "승인 실패되었습니다" 메시지를 띄웁니다.
            }
            
        })
        .catch(error => {
            // 서버 요청 중 에러가 발생한 경우
            alert("서버 오류가 발생했습니다.");
        });
    }

 // 반려 버튼이 클릭된 경우----------------------------------------------------------------------------
    else if (event.target.classList.contains('rejectModalButton')) {
        var brd_num = event.target.dataset.brd_num;
        var user_num = event.target.dataset.user_num;	
    	var button = $(event.target);
    	
        // 반려 이유 모달을 표시합니다.
        $('#rejectReasonModal').modal('show');

        // 반려 이유 폼 제출을 처리합니다.
        $('#rejectReasonForm').on('submit', function (e) {
            e.preventDefault();
            var reject_msg = $('#reject_msg').val();

            // 서버에 반려 이유를 전송합니다.
            fetch('/sharingReject', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'brd_num=' + encodeURIComponent(brd_num) + '&user_num=' + encodeURIComponent(user_num) + '&reject_msg=' + encodeURIComponent(reject_msg),
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message); // 성공 메시지를 표시합니다.
                 	
                	if (!button.hasClass('disabled')) {
                		button.addClass('disabled');
                	}
                    
                    // 페이지를 새로 고침합니다.
                    location.reload(true);
                    
                    $('#rejectReasonModal').modal('hide'); // 반려 이유 모달을 닫습니다.
                    
                    
                    
                } else {
                    alert(data.message); // 실패 메시지를 표시합니다.
                }
            })
            .catch(error => {
                alert("서버 오류가 발생했습니다.");
            });
        });
        // 반려 이유 모달 닫기 버튼 클릭 이벤트 핸들러
        document.getElementById('closeRejectReasonModalButton').addEventListener('click', function () {
            $('#rejectReasonModal').modal('hide');
        });
    }

    function closeModal() {
        $('#joinInfoModal').modal('hide');
    }

}); 

</script>

<%@ include file="../footer.jsp" %>
</body>
</html>