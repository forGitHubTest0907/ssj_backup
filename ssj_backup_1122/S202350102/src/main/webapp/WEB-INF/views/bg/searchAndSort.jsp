<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>인증 게시판 Search and Sort</title>
		<script type="text/javascript">
		
			function writeCertBrd() {
				
				//alert("writeCertBrd Start");
				
				// EL값을 JavaScript 변수에 저장
				var user_num = ${user.user_num};
				// chg_id 챌린지 페이지 아직 없어서 임시용으로 변수에 저장함
				//var chg_id = 1;
				var chg_id = ${chg.chg_id};
				
				// 이미지 파일 선택
				var screenshot = $("#screenshot")[0].files[0];
				
				
				// 이미지 파일, 제목, 내용을 FormData 에 추가
				var formData = new FormData();
				formData.append("title", $('#title').val());
				formData.append("conts", $('#conts').val());
				formData.append("chg_id", chg_id);
				formData.append("user_num", user_num);
				formData.append("screenshot", screenshot);
				
				
				// 사용자가 입력한 내용 가져오기 -> ver.1:  이미지도 전달해야 해서 보류
				//var paramData = {
				//					"title"	:	$('#title').val(),
				//					"conts"	:	$('#conts').val(),
				//					"chg_id":	chg_id,
				//					"user_num":	user_num
				//};
				
				// alert("paramData $('#title').val() ->"+$('#title').val());
				// alert("paramData $('#conts').val() ->"+$('#conts').val());
				// alert("paramData chg_id ->"+chg_id);
				// alert("paramData user_num ->"+user_num); 
				
				// 서버로 데이터 전송
				$.ajax({
					url	:	"/writeCertBrd",
					type:	"POST",
					data:	formData,
					dataType:'text',
					processData: false,		// 이미지 파일 처리를 위해 false로 설정
					contentType: false,		// 이미지 파일 처리를 위해 false로 설정
					success:function(data){
						alert(".ajax writeCertBrd->"+data); 
						if (data == '1') {
							// 성공하면 아래라인 수행 
							alert("입력성공");
						}
					},
					error: function() {
						// Ajax 요청 자체가 실패한 경우
						alert("error: 글 등록에 실패했습니다");
					}
				});
			}
			
			
			
			//  '수정', '더보기' 버튼 클릭 시    ->   글 수정용, 더보기용 모달 창 열기
			function updateModalCall(type, index) {
				
				// alert("updateModalCall Start...");
				
				// 모달창에 넘겨줄 값을 저장 
				var brd_num		=	$("#brd_num"+index).val();  		
				var nick		=	$("#nick"+index).val();  		
				var reg_date	=	$("#reg_date"+index).val();  
				var title		=	$("#title"+index).val();  
				var conts		=	$("#conts"+index).val();  
				var img			=	$("#img"+index).val();  
				var brd_step	=	$("#brd_step"+index).val();
				
				// alert("img -> " + img);
				// alert("${pageContext.request.contextPath}/upload/"+img);
				
				/*
					 alert("updateModalCall nick -> "+nick);
				 alert("updateModalCall reg_date -> "+reg_date);
				 alert("updateModalCall title -> "+title);
				 alert("updateModalCall conts -> "+conts); 
				 */
				 
				// 이미지 설정
				$('#updateImage').attr('src', '${pageContext.request.contextPath}/upload/'+img);
				$('#moreImage').attr('src', '${pageContext.request.contextPath}/upload/'+img);
				 
				//  글 수정 모달 창 안의 태그 -> 화면 출력용  <span> <p> -> text
				$('#displayNick').text(nick);     
				$('#moreNick').text(nick);
				
				$('#displayReg_date').text(reg_date); 
				$('#moreReg_date').text(reg_date);
				
				$('#editImage').text(img);
				
				$('#moreTitle').text(title);
				$('#moreConts').text(conts);
				
				//   글 수정 모달 창 안의 태그 input Tag -> Form 전달용		<input> -> <val>
				$('#editBrd_num').val(brd_num);     
				$('#editNick').val(nick);     
				$('#editTitle').val(title);     
				$('#editConts').val(conts);     
				
				
				if (type == 'edit') {
					$('#modalUpdateCertBrdForm').modal('show');
				}
				else $('#modalMoreCertBrdForm').modal('show');
				// 모달 창 표시
			}
			
			
			
			// 수정 시, 업로드 사진 변경할 수 있게
			function fileUpdate() {
				var fileInput = document.getElementById('fileInput');
				if(fileInput.style.display == "none") {
					fileInput.style.display = "block";
					fileInput.removeAttribute('disabled');
					$("#imgOroot").hide();
				} else {
					fileInput.style.display = "none";
					fileInput.setAttribute('disabled', 'true');
					$('#imgOroot').show();
				}
			}
			
			
			
			// '삭제' 버튼 클릭 시 -> 글과, 업로드 삭제
			function deleteCertBrd(type, index) {
				
				alert("type -> " + type);
				// Group 번호 가져오기
	
		 	
			    var arr = new Array();
				var item;
				var idx = 0;
				
			 	<c:forEach items="${certBoard }" var="item" >	
			 		//alert("arr.title1->"+  ${list.title});
			    	// arr.push("${item.title}");
			    	
			    	arr.push({brd_num:"${item.brd_num }"
			    		     ,brd_group:"${item.brd_group}"
			    		     ,idx: idx
			    	});
			    	idx ++ ;
				</c:forEach>
				
	
				// var brd_num = $("#" + type + "brd_num"+index).val();
				// var img		= $("#" + type + "img"+index).val();
				
				var brd_num 	= $("#brd_num"+index).val();
				var img			= $("#img"+index).val();
				var brd_group	= $("#brd_group"+index).val();
				alert("brd_num -> " + brd_num);
				alert("img -> " + img);
	
				alert("JSON.stringify(arr)->"+JSON.stringify(arr));
	
				$.ajax({
					url:"/brdNumDelete",
					data:{
							 brd_num	:	brd_num
						  	,img		:	img
						  	,brd_group	:	brd_group
					  	},
					dataType:'text',
					
					success:function(data){
						alert(".ajax deleteCertBrd data -> "+data);
						
						if (data > '0') {
							// id 가 review +index 성공하면 아래 라인 수행
							if (type == 'review') {
								//$('#review'+index).remove();		/* Delete Tag */
								// 해당 brd_group 을 remove
								
								// 원글의 brd_group 가져오기
								var brd_group = arr[index].brd_group;
								alert("삭제 대상 brd_num -> "+brd_num);
								
								// 댓글 그룹이 동일한 모든 댓글 삭제
								// 'comment'로 시작하는 모든 div 엘리먼트에 대해 아래의 코드를 실행
								for (var i=0; i<arr.length;i++){
									// 같은 댓글 그룹일 때 화면에서 삭제
									if (brd_num == arr[i].brd_group ) {
										//alert("arr.title2.brd_num->"+ i + " :  "+ arr[i].brd_num);
										/// alert("arr.title2.brd_group->"+ i + " :  "+ arr[i].brd_group);
										alert("arr.title2.idx->"+ i + " :  "+ arr[i].idx);
										// 원글인지 댓글인지 판단하여 삭제
										if (arr[i].brd_num ==  arr[i].brd_group) {
											$('#review'+arr[i].idx).remove();
										} else {
											$('#comment'+arr[i].idx).remove();
										}
									}
											
								}
							} else $('#comment'+index).remove();	/* Delete Tag */
							//$("#" + type +index).remove();		
	//						$('#review'+index).remove();		/* Delete Tag */
						}
					}
				});
			}
			
			
			
			// 댓글 공백 체크
			function commentInsertchk(form) {
				form.conts.value = form.conts.value.trim();
				
				// 댓글 미입력시 체크
				if(form.conts.value.length == 0) {
					alert("댓글을 입력해주세요");
					form.conts.focus();
					return false;
				}
				// 댓글 입력시 실행
				return true;
			}
		
		</script>
	</head>
	<body>
		<div class="tab-pane fade" id="certBoardTab">
            <div class="row justify-content-center py-9">
              	<div class="col-12 col-lg-10 col-xl-8">
			        <!-- Heading -->
	          		<h4 class="mb-10 text-center">인증 게시판</h4>
	          
	         		<!-- 인증게시판 C -->
		        	<c:choose>
						<c:when test="${certTotal == 0 }">
			          	<!-- 1. 인증글이 없을 때 -->
			          		<div class="text-center">
			          			<div class="mb-6 fs-1">🙁</div>
			          			<p>
			          				인증글이 없습니다. 첫 인증글을 올려주세요!
			          			</p>
			          			<c:choose>
			              		<c:when test="${chgrYN == 1 }">
			              			<!-- 참여자일 경우 -->
					              	<!-- Button -->
					                <a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#writeForm">
				                		인증하기
				                	</a>
			              		</c:when>
			              		<c:otherwise>
			              			<!-- 로그인 했지만 참여자가 아닌 경우 -->
			              			<!-- Button -->
			              			<a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#writeForm">
				                		인증하기
				                	</a>
			              		</c:otherwise>
			              	</c:choose>
			          		</div>
			          		<!-- 새 인증글 -->
			            <div class="collapse" id="writeForm">
			              <!-- Divider -->
			              <hr class="my-8">
			              <!-- 인증 글쓰기 Form -->
			              <form id="certForm">
			                <div class="row">
				              <c:choose>
				              	<c:when test="${chgrYN == 1 }">
				              	<!-- 1. 참여자일 경우 -->
				                  <div class="col-12 col-md-6">
				                    <!-- 유저 닉네임 표시하는 란 Name -->
				                    <div class="form-group">
					                      <p class="mb-2 fs-lg fw-bold">
					                        ${user.nick }
					                      </p>
				                    </div>
				                  </div>
				                  
				                  <div class="col-12">
				                    <!-- 제목 입력란  Name -->
				                    <div class="form-group">
				                      <label class="visually-hidden" for="reviewTitle">CertBrd Title:</label>
				                      <input class="form-control form-control-sm" id="title" type="text" placeholder="제목을 작성해주세요 *" required>
				                    </div>
				                  </div>
				                  
				                  <div class="col-12">
				                    <!-- 인증글 입력란 Name -->
				                    <div class="form-group">
				                      <label class="visually-hidden" for="reviewText">CertBrd:</label>
				                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="인증글을 작성해주세요 *" required></textarea>
				                    </div>
				                  </div>
				                  
				                  <div class="mb-3">
				                  	<!-- 인증샷 -->
								  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
									<input class="form-control" type="file" id="screenshot" name="screenshot">
								  </div>
										                  
				                  <div class="col-12 text-center">
				                    <!-- 등록 Button -->
				                    <button class="btn btn-outline-dark" type="submit" onclick="writeCertBrd()">
				                      	등록
				                    </button>
				                  </div>
				              	</c:when>
				              	
				              	
				              	<c:when test="${user == null }">
				              	<!-- 2. 비로그인 인터셉터 ing -->
									<div class="col-12 col-md-6">
				                    <!-- 유저 닉네임 표시하는 란 Name -->
				                    <div class="form-group">
					                      <p class="mb-2 fs-lg fw-bold">
					                        ${user.nick }
					                      </p>
				                    </div>
				                  </div>
				                  
				                  <div class="col-12">
				                    <!-- 제목 입력란  Name -->
				                    <div class="form-group">
				                      <label class="visually-hidden" for="reviewTitle">CertBrd Title:</label>
				                      <input class="form-control form-control-sm" id="title" type="text" placeholder="제목을 작성해주세요 *" >
				                    </div>
				                  </div>
				                  
				                  <div class="col-12">
				                    <!-- 인증글 입력란 Name -->
				                    <div class="form-group">
				                      <label class="visually-hidden" for="reviewText">CertBrd:</label>
				                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="인증글을 작성해주세요 *" ></textarea>
				                    </div>
				                  </div>
				                  
				                  <div class="mb-3">
				                  	<!-- 인증샷 -->
								  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
									<input class="form-control" type="file" id="screenshot" name="screenshot">
								  </div>
										                  
				                  <div class="col-12 text-center">
				                    <!-- 등록 Button -->
				                    <button class="btn btn-outline-dark" type="submit" onclick="writeCertBrd()">
				                      	등록
				                    </button>
				                  </div>
				              	</c:when>
				              	
				              	<c:otherwise>
				              	<!-- 3. 참여자가 아닌 회원 -->
				              		<div class="col-12 col-md-6">
				                    <!-- 유저 닉네임 표시하는 란 Name -->
				                    <div class="form-group">
					                      <p class="mb-2 fs-lg fw-bold">
					                        ${user.nick }
					                      </p>
				                    </div>
				                  </div>
				                  
				                  <div class="col-12">
				                    <!-- 제목 입력란  Name -->
				                    <div class="form-group">
				                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
				                      <input class="form-control form-control-sm" id="title" type="text"  placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled">
				                    </div>
				                  </div>
				                  
				                  <div class="col-12">
				                    <!-- 인증글 입력란 Name -->
				                    <div class="form-group">
				                      <label class="visually-hidden" for="reviewText">Review:</label>
				                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled"></textarea>
				                    </div>
				                  </div>
				                  
				                  <div class="mb-3">
				                  	<!-- 인증샷 -->
								  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
									<input class="form-control" type="file" id="screenshot" name="screenshot">
								  </div>
										                  
				                  <div class="col-12 text-center">
				                    <!-- 등록 Button -->
				                    <button class="btn btn-outline-dark" type="submit" disabled="disabled">
				                      	등록
				                    </button>
				                  </div>
				              	</c:otherwise>
				                  
				              </c:choose>
			                </div>
			              </form>
			
			            </div>
			          	</c:when>
			          	<c:otherwise>
		          	<!-- 2. 인증글이 있을 때 -->
		            <!-- Header -->
		            <div class="row align-items-center">
		            
		              <div class="col-12 col-md-auto">
		              
		                
		                
		                <!-- Dropdown -->
		                <div class="dropdown mb-4 mb-md-0">
		
		                  <!-- Toggle -->
		                  <a class="dropdown-toggle text-reset" data-bs-toggle="dropdown" href="/searchAndSort?sortby=newest">
		                    <strong>최신 순</strong>
		                  </a>
		
		                  <!-- Menu -->
		                  <div class="dropdown-menu mt-3">
		                    <a class="dropdown-item" href="/searchAndSort?&chg_id=${chg.chg_id }&sortBy=newest">최신 순</a>
		                    <a class="dropdown-item" href="/searchAndSort?&chg_id=${chg.chg_id }&sortBy=oldest">오래된 순</a>
		                    <a class="dropdown-item" href="/searchAndSort?&chg_id=${chg.chg_id }&sortBy=like">좋아요 순</a>
		                    <input type="hidden" name="chg_id" value="${chg.chg_id }">
		                  </div>
		
		                </div>
		                
		              </div>
		              
		              <div class="col-12 col-md text-md-center">
		                <!-- Count 총 인증 수 -->
		                <strong class="fs-sm ms-2">Total ${certTotal }</strong>
		              </div>
		              
		              
		              <div class="col-12 col-md-auto">
		              	<c:choose>
		              	
		              		<c:when test="${chgrYN == 1 }">
		              			<!-- 참여자일 경우 -->
				              	<!-- Button -->
				                <a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#writeForm">
			                		인증하기
			                	</a>
		              		</c:when>
		              		
		              		
		              		
		              		<c:otherwise>
		              			<!-- 로그인 했지만 참여자가 아닌 경우 -->
		              			<!-- Button -->
		              			<a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#writeForm">
			                		인증하기
			                	</a>
		              			
		              		</c:otherwise>
		              		
		              	</c:choose>
		              </div>
		              
		              
		            </div>
		            <!-- 새 인증글 -->
		            <div class="collapse" id="writeForm">
		
		              <!-- Divider -->
		              <hr class="my-8">
		
		              <!-- 인증 글쓰기 Form -->
		              <form id="certForm">
		                <div class="row">
		                  
			              <c:choose>
			              	<c:when test="${chgrYN == 1 }">
			              	<!-- 1. 참여자일 경우 -->
			                  <div class="col-12 col-md-6">
			                    <!-- 유저 닉네임 표시하는 란 Name -->
			                    <div class="form-group">
				                      <p class="mb-2 fs-lg fw-bold">
				                        ${user.nick }
				                      </p>
			                    </div>
			                  </div>
			                  
			                  <div class="col-12">
			                    <!-- 제목 입력란  Name -->
			                    <div class="form-group">
			                      <label class="visually-hidden" for="reviewTitle">CertBrd Title:</label>
			                      <input class="form-control form-control-sm" id="title" type="text" placeholder="제목을 작성해주세요 *" required>
			                    </div>
			                  </div>
			                  
			                  <div class="col-12">
			                    <!-- 인증글 입력란 Name -->
			                    <div class="form-group">
			                      <label class="visually-hidden" for="reviewText">CertBrd:</label>
			                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="인증글을 작성해주세요 *" required></textarea>
			                    </div>
			                  </div>
			                  
			                  <div class="mb-3">
			                  	<!-- 인증샷 -->
							  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
								<input class="form-control" type="file" id="screenshot" name="screenshot">
							  </div>
									                  
			                  <div class="col-12 text-center">
			                    <!-- 등록 Button -->
			                    <button class="btn btn-outline-dark" type="submit" onclick="writeCertBrd()">
			                      	등록
			                    </button>
			                  </div>
			              	</c:when>
			              	
			              	
			              	<c:when test="${user == null }">
			              	<!-- 2. 비로그인 인터셉터 ing -->
								<div class="col-12 col-md-6">
			                    <!-- 유저 닉네임 표시하는 란 Name -->
			                    <div class="form-group">
				                      <p class="mb-2 fs-lg fw-bold">
				                        ${user.nick }
				                      </p>
			                    </div>
			                  </div>
			                  
			                  <div class="col-12">
			                    <!-- 제목 입력란  Name -->
			                    <div class="form-group">
			                      <label class="visually-hidden" for="reviewTitle">CertBrd Title:</label>
			                      <input class="form-control form-control-sm" id="title" type="text" placeholder="제목을 작성해주세요 *" >
			                    </div>
			                  </div>
			                  
			                  <div class="col-12">
			                    <!-- 인증글 입력란 Name -->
			                    <div class="form-group">
			                      <label class="visually-hidden" for="reviewText">CertBrd:</label>
			                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="인증글을 작성해주세요 *" ></textarea>
			                    </div>
			                  </div>
			                  
			                  <div class="mb-3">
			                  	<!-- 인증샷 -->
							  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
								<input class="form-control" type="file" id="screenshot" name="screenshot">
							  </div>
									                  
			                  <div class="col-12 text-center">
			                    <!-- 등록 Button -->
			                    <button class="btn btn-outline-dark" type="submit" onclick="writeCertBrd()">
			                      	등록
			                    </button>
			                  </div>
			              	</c:when>
			              	
			              	
			              	<c:otherwise>
			              	<!-- 3. 참여자가 아닌 회원 -->
			              		<div class="col-12 col-md-6">
			                    <!-- 유저 닉네임 표시하는 란 Name -->
			                    <div class="form-group">
				                      <p class="mb-2 fs-lg fw-bold">
				                        ${user.nick }
				                      </p>
			                    </div>
			                  </div>
			                  
			                  <div class="col-12">
			                    <!-- 제목 입력란  Name -->
			                    <div class="form-group">
			                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
			                      <input class="form-control form-control-sm" id="title" type="text"  placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled">
			                    </div>
			                  </div>
			                  
			                  <div class="col-12">
			                    <!-- 인증글 입력란 Name -->
			                    <div class="form-group">
			                      <label class="visually-hidden" for="reviewText">Review:</label>
			                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled"></textarea>
			                    </div>
			                  </div>
			                  
			                  <div class="mb-3">
			                  	<!-- 인증샷 -->
							  	<label for="formFile" class="form-label">인증샷을 올려주세요 *</label>
								<input class="form-control" type="file" id="screenshot" name="screenshot">
							  </div>
									                  
			                  <div class="col-12 text-center">
			                    <!-- 등록 Button -->
			                    <button class="btn btn-outline-dark" type="submit" disabled="disabled">
			                      	등록
			                    </button>
			                  </div>
			              	</c:otherwise>
			                  
			              </c:choose>
		                </div>
		              </form>
		
		            </div>
		           </c:otherwise>
		          	</c:choose>
	
	
					<!-- 인증글 게시판 R -->
		          	<div class="mt-8">
	
			            <!--  여기부터 첫번째 인증글 -->
						<c:forEach var="certBoard" items="${certBoard }" varStatus="status">
			             	<c:choose>
			             		<c:when test="${certBoard.brd_step == 0 }">
				             		<!-- 1. 원글 -->
					              	<div class="review" id="review${status.index}">
					                <div class="review-body">
					                  <div class="row" id="certBoard${status.index}">
					                  	<input type="hidden" id="brd_num${status.index}"	value="${certBoard.brd_num }">
					                  	<input type="hidden" id="nick${status.index}"		value="${certBoard.nick }">
					                  	<input type="hidden" id="reg_date${status.index}"	value="${certBoard.reg_date }">
					                  	<input type="hidden" id="title${status.index}"		value="${certBoard.title }">
					                  	<input type="hidden" id="conts${status.index}"		value="${certBoard.conts }">
					                  	<input type="hidden" id="img${status.index}"		value="${certBoard.img }">
					                  	<input type="hidden" id="brd_step${status.index}"	value="${certBoard.brd_step }">
                                        <input type="hidden" id="brd_group${status.index}"  value="${certBoard.brd_group }">
				   						                  	
					                  	
					                  	<div class="col-5 col-md-3 col-xl-2">
											<!-- 인증샷 Image -->
					                    	<img src="${pageContext.request.contextPath}/upload/${certBoard.img }" alt="인증샷" class="img-fluid">
					                    </div>
					                    
					                    
					                    <div class="col-12 col-md">
					                    
											<!-- Avatar -->
					                    	<div class="avatar avatar-lg">
											  <img src="../assets/img/avatars/avatar-1.jpg" alt="..." class="avatar-img rounded-circle">
											</div>
					                    
					                      <!-- Header -->
					                      <div class="row mb-6">
					                        <div class="col-12">
					                          <!-- Time -->
					                          <span class="fs-xs text-muted">
					                            ${certBoard.nick}, <time datetime="2019-07-25">${certBoard.reg_date }</time>
					                          </span>
					                        </div>
					                      </div>
					                      
					
					                      <!-- Title -->
					                      <p class="mb-2 fs-lg fw-bold">
					                        ${certBoard.title }
					                      </p>
					
					                      <!-- Text -->
					                      <p class="text-gray-500">
					                      	${certBoard.conts }
					                      </p>
					                      
					
					                      <!-- Footer -->
					                      <div class="row align-items-center">
					                      
					                        <!-- Text -->
					                        <div class="col-auto me-auto">
					                        
						                        <!-- Rate -->
						                        <div class="rate">
						                          <a class="rate-item" data-toggle="vote" data-count="3" href="#" role="button">
				                            		좋아요 <i class="fe fe-thumbs-up"></i>
						                          </a>
						                          <a class="rate-item" data-toggle="vote" data-count="3" href="#" role="button">
				                            		태우기 <i class="fa-solid fa-fire"></i>
						                          </a>
						                        </div>
						                        
					                        </div>
					                        
					                        <div class="col-auto d-none d-lg-block">
					                          <!-- Text -->
					                          <p class="mb-0 fs-sm">Comments (${certBoard.replyCount })</p>
					                        </div>
					                        
					                        <c:choose>
					                        	<c:when test="${user.user_num == certBoard.user_num }">
					                        	<!-- 작성자 본인일 경우 -->
							                        <div class="col-auto">
							                        
							                          <!-- comment 버튼을 수정 삭제 버튼으로 바꿈 Button -->
							                          <a class="btn btn-xs btn-outline-border" 
							                          	 href="#!" 
							                          	 id="showModalButton"
							                          	 onclick="updateModalCall('edit', ${status.index})"
							                          >
														수정
							                          </a>
							                          
							                          <a class="btn btn-xs btn-outline-border" href="#!" onclick="deleteCertBrd('review', ${status.index})">
														삭제
							                          </a>
							                          
							                        </div>
					                        	</c:when>
					                        	
					                        	<c:otherwise>
				                        			<div class="col-auto">
														<!-- Button -->	
														<a class="btn btn-xs btn-outline-border" href="#!" onclick="updateModalCall('more', ${status.index})">
															더보기
														</a>
														<!-- Button -->
														<button class="btn btn-xs btn-outline-border" data-bs-toggle="collapse" data-bs-target="#commentForm${status.index }" aria-expanded="false" aria-controls="commentForm${status.index }">
															댓글
														</button>
													</div>
					                        	</c:otherwise>
					                        </c:choose>
					                        
					                        
					                      </div>
					                    </div>
					                  </div>
					                </div>
				              	</div>
			              		</c:when>
				           		<c:otherwise>
				           		<!-- 2. 댓글 Child review -->
									<div class="review" id="comment${status.index }">
				   						<div class="review review-child">
						                  	<div class="review-body">
							                  <div class="row" id="certBoard${status.index}">
							                  	<input type="hidden" id="brd_num${status.index}"	value="${certBoard.brd_num }">
							                  	<input type="hidden" id="nick${status.index}"		value="${certBoard.nick }">
							                  	<input type="hidden" id="reg_date${status.index}"	value="${certBoard.reg_date }">
							                  	<input type="hidden" id="title${status.index}"		value="${certBoard.title }">
							                  	<input type="hidden" id="conts${status.index}"		value="${certBoard.conts }">
							                  	<input type="hidden" id="img${status.index}"		value="${certBoard.img }">
					                                        <input type="hidden" id="brd_group${status.index}"  value="${certBoard.brd_group }">
							                  	
							                  	
							                  	
												<div class="col-12 col-md-auto">
							                        <!-- Avatar -->
							                        <div class="avatar avatar-xxl mb-6 mb-md-0">
							                          <span class="avatar-title rounded-circle">
							                            <i class="fa fa-user"></i>
							                          </span>
							                        </div>
												</div>
							                    
							                    
							                    
							                    <div class="col-12 col-md">
							                    
							                    
							                      <!-- Header -->
							                      <div class="row mb-6">
							                        <div class="col-12">
							                          <!-- Time -->
							                          <span class="fs-xs text-muted">
							                            ${certBoard.nick}, <time datetime="2019-07-25">${certBoard.reg_date }</time>
							                          </span>
							                        </div>
							                      </div>
							                      
							
							                      <!-- Title -->
							                      <p class="mb-2 fs-lg fw-bold">
							                        ${certBoard.title }
							                      </p>
							
							                      <!-- Text -->
							                      <p class="text-gray-500">
							                      	${certBoard.conts }
							                      </p>
							                      
							
							                      <!-- Footer -->
							                      <div class="row align-items-center">
							                      
							                      	<div class="col-auto me-auto">
							                      		<!-- Rate -->
								                        <div class="rate">
								                          <a class="rate-item" data-toggle="vote" data-count="3" href="#" role="button">
						                            		좋아요 <i class="fe fe-thumbs-up"></i>
								                          </a>
								                          <a class="rate-item" data-toggle="vote" data-count="3" href="#" role="button">
						                            		태우기 <i class="fa-solid fa-fire"></i>
								                          </a>
								                        </div>
							                      	</div>
							                      
							                        <c:choose>
							                        	<c:when test="${user.user_num == certBoard.user_num }">
							                        	<!-- 작성자 본인일 경우 -->
									                        <div class="col-auto">
									                          <!-- comment 버튼을 수정 삭제 버튼으로 바꿈 Button -->
									                          <a class="btn btn-xs btn-outline-border" href="#!" onclick="deleteCertBrd('comment', ${status.index})">
																삭제
									                          </a>
									                        </div>
							                        	</c:when>
							                        </c:choose>
							                        
							                        
							                      </div>
							                    </div>
							                  </div>
						                	</div>
										</div>	
									</div>
				                </c:otherwise>
			           		</c:choose>		
			               	
			             
			             	<!-- 새 댓글 -->
			           		<div class="collapse" id="commentForm${status.index }">
			
			              	<!-- Divider -->
			              	<hr class="my-8">
			
			              	<!-- 인증 댓글 쓰기 Form -->
			              	<form id="certCommentForm" action="/commentInsert" method="post" onsubmit="return commentInsertchk(this)">
			                	<div class="row">
			                  
					              <c:choose>
					              	<c:when test="${chgrYN == 1 }">
					              	<!-- 1. 참가자일 경우 -->
					                  <div class="col-12 col-md-6">
					                  	<input type="hidden" name="chg_id"		value="${chg.chg_id }">
					                  	<input type="hidden" name="user_num"	value="${user.user_num }">
					                  	<input type="hidden" name="brd_num"		value="${certBoard.brd_num }">
					                    <!-- 유저 닉네임 표시하는 란 Name -->
					                    <div class="form-group">
						                      <p class="mb-2 fs-lg fw-bold">
						                        ${user.nick }
						                      </p>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 제목 입력란  Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewTitle">CertBrd Title:</label>
					                      <input class="form-control form-control-sm" id="commentTitle" name="title" type="text" placeholder="제목을 작성해주세요 *" >
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 댓글 입력란 Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewText">CertBrd:</label>
					                      <textarea class="form-control form-control-sm" id="commentConts" name="conts" rows="5" placeholder="댓글을 작성해주세요 *" ></textarea>
					                    </div>
					                  </div>
					                  
											                  
					                  <div class="col-12 text-center">
					                    <!-- 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" onclick="commentCertBrd()">
					                      	등록
					                    </button>
					                  </div>
					              	</c:when>
					              	
					              	<c:when test="${user == null }">
					              	<!-- 2. 비로그인 -->
					              		<div class="col-12 col-md-6">
					                    <!-- 유저 닉네임 표시하는 란 Name -->
					                    <div class="form-group">
						                      <p class="mb-2 fs-lg fw-bold">
						                        ${user.nick }
						                      </p>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 제목 입력란  Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
					                      <input class="form-control form-control-sm" type="text" name="title"  placeholder="로그인 해주세요" disabled="disabled">
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 댓글 입력란 Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewText">Review:</label>
					                      <textarea class="form-control form-control-sm" rows="5" name="conts" placeholder="로그인 해주세요" disabled="disabled"></textarea>
					                    </div>
					                  </div>
					                  
											                  
					                  <div class="col-12 text-center">
					                    <!-- 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" onclick="commentCertBrd()">
					                      	등록
					                    </button>
					                  </div>
					              	</c:when>
					              	
					              	<c:otherwise>
					              	<!-- 3. 참여자가 아닌 회원 -->
					              		<div class="col-12 col-md-6">
					                    <!-- 유저 닉네임 표시하는 란 Name -->
					                    <div class="form-group">
						                      <p class="mb-2 fs-lg fw-bold">
						                        ${user.nick }
						                      </p>
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 제목 입력란  Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
					                      <input class="form-control form-control-sm" type="text" name="title"  placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled">
					                    </div>
					                  </div>
					                  
					                  <div class="col-12">
					                    <!-- 댓글 입력란 Name -->
					                    <div class="form-group">
					                      <label class="visually-hidden" for="reviewText">Review:</label>
					                      <textarea class="form-control form-control-sm" rows="5" name="conts" placeholder="챌린지 참여자만 글을 쓸 수 있습니다" disabled="disabled"></textarea>
					                    </div>
					                  </div>
					                  
											                  
					                  <div class="col-12 text-center">
					                    <!-- 등록 Button -->
					                    <button class="btn btn-outline-dark" type="submit" disabled="disabled">
					                      	등록
					                    </button>
					                  </div>
					              	</c:otherwise>
					                  
					              </c:choose>
				                </div>
			              	</form>
			
			            	</div>
			           
						</c:forEach>
	          		</div>
	          
	          
					<!-- 인증글 게시판 U: 수정하기 모달 창 Product -->
					<div class="modal fade" id="modalUpdateCertBrdForm" tabindex="-1" role="dialog" aria-hidden="true"><!--  -->
				      <div class="modal-dialog modal-dialog-centered modal-xl" role="document"><!--  -->
				        <div class="modal-content"><!--  -->
				    
				          <!-- Close -->
				          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
				            <i class="fe fe-x" aria-hidden="true"></i>
				          </button>
				    
				          <!-- Content -->
				          <div class="container-fluid px-xl-0">
				            <div class="row align-items-center mx-xl-0">
				           	
								<div class="col-12 col-lg-6 col-xl-5 py-4 py-xl-0 px-xl-0">
				                <!-- Image 수정 모달창 인증샷 -->
					                <img class="img-fluid" alt="수정 모달창 인증샷" id="updateImage">
				             	</div>
				              
				              <div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9">
				                <!-- 수정 Form -->
					            <form action="updateCertBrd" method="post" enctype="multipart/form-data">
					              <input type="hidden" name="brd_num" id="editBrd_num">
					              <input type="hidden" name="nick" id="editNick">
					                
									<div class="avatar avatar-xl">
									  <img src="../assets/img/avatars/avatar-1.jpg" alt="..." class="avatar-img rounded-circle">
									</div>
				                      
				                      
					                <div class="col-12 col-md-6">
				                    <!-- 유저 닉네임 표시하는 란 Name -->
				                    <div class="form-group">
					                      <p class="mb-2 fs-lg fw-bold" id="displayNick">
					                      </p>
				                    </div>
					                </div>
				                  
				                     <!-- Header -->
				                      <div class="row mb-6"><!--  -->
				                        <div class="col-12"><!--  -->
				                          <!-- Time -->
				                          <span class="fs-xs text-muted">
				                            <time datetime="2019-07-25" id="displayReg_date"></time>
				                          </span>
				                        </div>
				                      </div>
					                
				
				      					<div class="col-12"><!--  -->
					                  <!-- Email -->
					                  <div class="form-group"><!--  -->
					                    <label class="form-label" for="accountEmail">
					                     	 제목 *
					                    </label>
					                      <input class="form-control form-control-sm" id="editTitle" name="title" type="text" placeholder="제목을 작성해주세요 *" required>
					                  </div>
					                </div>
				
					                <div class="col-12">
					                  <!-- Email -->
					                  <div class="form-group">
					                    <label class="form-label" for="accountEmail">
					                     	 인증글 *
					                    </label>
					                      <textarea class="form-control form-control-sm" id="editConts" name="conts" rows="4" placeholder="인증글을 작성해주세요 *" required></textarea>
					                  </div>
					                </div>
					                
					                <div class="row">
					                  <div class="col-12 text-center">
					                  	<!-- 파일 변경 -->
					                  	<div class="input-group mb-3">
										  <label class="input-group-text" for="inputGroupFile01">파일 변경</label>
										  <input type="file" name="editFile" class="form-control" id="inputGroupFile01">
										</div>
					                    <!-- 인증 글쓰기에서 가져온 글 수정 Form 등록 Button -->
					                    <!-- onclick(보류) 대신 form으로 작동시킴 --> 
					                    <button class="btn btn-outline-dark" type="submit" onclick="updateCertBoard()">
					                      	수정하기
					                    </button>
					                  </div>
					                </div>
					                
					            </form>
							
							
				    
				              </div><!-- <div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9"> -->
				              
				            </div><!-- <div class="row align-items-center mx-xl-0"> -->
				          </div><!-- <div class="container-fluid px-xl-0"> -->
				    
				        </div><!-- <div class="modal-content"> -->
				      </div><!-- <div class="modal-dialog modal-dialog-centered modal-xl" role="document"> -->
				    </div><!-- <div class="modal fade" id="modalUpdateCertBrdForm" tabindex="-1" role="dialog" aria-hidden="true"> -->
	    
	    
					<!-- 더보기 모달 창 Product -->
				    <div class="modal fade" id="modalMoreCertBrdForm" tabindex="-1" role="dialog" aria-hidden="true"><!--  -->
			      <div class="modal-dialog modal-dialog-centered modal-xl" role="document"><!--  -->
			        <div class="modal-content"><!--  -->
			    
			          <!-- Close -->
			          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
			            <i class="fe fe-x" aria-hidden="true"></i>
			          </button>
			    
			          <!-- Content -->
			          <div class="container-fluid px-xl-0">
			            <div class="row align-items-center mx-xl-0">
			           	
							<div class="col-12 col-lg-6 col-xl-5 py-4 py-xl-0 px-xl-0">
			                <!-- Image 더보기 모달창 인증샷 -->
				                <img class="img-fluid" alt="더보기 모달창 인증샷" id="moreImage">
			             	</div>
			              
			              <div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9">
			                <!-- 더보기 Form -->
				            <form action="moreCertBrd" method="post" enctype="multipart/form-data">
				              <input type="hidden" name="brd_num" id="editBrd_num">
				              <input type="hidden" name="nick" id="editNick">
				                
								<div class="avatar avatar-xl">
								  <img src="../assets/img/avatars/avatar-1.jpg" alt="..." class="avatar-img rounded-circle">
								</div>
			                      
			                      
				                <div class="col-12 col-md-6">
			                    <!-- 유저 닉네임 표시하는 란 Name -->
			                    <div class="form-group">
				                      <p class="mb-2 fs-lg fw-bold" id="moreNick">
				                      </p>
			                    </div>
				                </div>
			                  
			                     <!-- Header -->
			                      <div class="row mb-6"><!--  -->
			                        <div class="col-12"><!--  -->
			                          <!-- Time -->
			                          <span class="fs-xs text-muted">
			                            <time datetime="2019-07-25" id="moreReg_date"></time>
			                          </span>
			                        </div>
			                      </div>
				                
			
			      					<div class="col-12"><!--  -->
				                  <!-- 제목 -->
				                  <div class="form-group"><!--  -->
				                  	<h5 class="modal-title" id="moreTitle"></h5>
				                  	<!-- <h4 id="moreTitle"></h4> -->
				                  	<!-- <strong class="mx-auto" id="moreTitle"></strong> -->
				                    <!-- <h5 class="mb-3" id="moreTitle"></h5> -->
				                  </div>
				                </div>
			
				                <div class="col-12">
				                  <!-- 인증글 -->
				                  <div class="form-group">
				                  	<div class="modal-body" id="moreConts"></div>
				                  	<!-- <p class="mb-7 fs-lg" id="moreConts"></p> -->
				                    	<!-- <h4 class="mb-3" id="moreConts"></h4> -->
				                  </div>
				                </div>
				                
				                <div class="form-group mb-0">
				                    <div class="row gx-2">
				                    
				                    	<div class="rate">
										  <a class="rate-item" data-toggle="vote" data-count="3" href="#" role="button">
									    	좋아요 <i class="fe fe-thumbs-up"></i>
										  </a>
										  <a class="rate-item" data-toggle="vote" data-count="0" href="#" role="button">
									    	태우기 <i class="fa-solid fa-fire"></i>
										  </a>
										</div>
										
				                      
				                    </div>
								</div>
				                
				            </form>
						
						
			    
			              </div><!-- <div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9"> -->
			              
			            </div><!-- <div class="row align-items-center mx-xl-0"> -->
			          </div><!-- <div class="container-fluid px-xl-0"> -->
			    
			        </div><!-- <div class="modal-content"> -->
			      </div><!-- <div class="modal-dialog modal-dialog-centered modal-xl" role="document"> -->
			    </div>
	          
	    
					<!-- Pagination		임시로 chg_id 넣어둠 -->
					<nav class="d-flex justify-content-center mt-9">
			          <ul class="pagination pagination-sm text-gray-400">
			           
			             <li class="page-item">
			            <c:if test="${certBrdPage.startPage > certBrdPage.pageBlock }">
			                <a class="page-link page-link-arrow" href="chgDetail?chg_id=${chg.chg_id}&currentPage=${certBrdPage.startPage-certBrdPage.pageBlock }">
			                  <i class="fa fa-caret-left"></i>
			                </a>
			            </c:if>
			             </li>
			           
			            <c:forEach var="i" begin="${certBrdPage.startPage }" end="${certBrdPage.endPage }">
			              <li class="page-item active">
			                	<a class="page-link" href="chgDetail?chg_id=${chg.chg_id}&currentPage=${i}">${i}</a>
			              </li>
			            </c:forEach>
			           
			             <li class="page-item">
			            <c:if test="${certBrdPage.endPage < certBrdPage.totalPage }">
			                <a class="page-link page-link-arrow" href="chgDetail?chg_id=${chg.chg_id}&currentPage=${certBrdPage.startPage+certBrdPage.pageBlock }">
			                  <i class="fa fa-caret-left"></i>
			                </a>
			            </c:if>
			             </li>
			           </ul>
			        </nav>
	          
		          	<!-- 검색 Search Body: Form -->
					<div class="offcanvas-body">
				        <form action="searchAndSort">
				         	<div class="form-group">
				            	<label class="visually-hidden" for="modalSearchCategories">Categories:</label>
				            	<select class="form-select" id="modalSearchCategories" name="searchType">
					              	<option selected>All Categories</option>
					              	<option value="title">제목</option>
					              	<option value="conts">내용</option>
					              	<option value="nick">닉네임</option>
				            	</select>
				          	</div>
				          	<div class="input-group input-group-merge">
				            	<input class="form-control" type="search" placeholder="Search" name="keyword">
							  	<input type="hidden" name="chg_id" value="${chg.chg_id }">
					            <div class="input-group-append">
					              <button class="btn btn-outline-border" type="submit">
					                <i class="fe fe-search"></i>
					              </button>
					            </div>
				          </div>
				        </form>
					</div>
	
				</div>
         	</div>
        </div>
	</body>
</html>