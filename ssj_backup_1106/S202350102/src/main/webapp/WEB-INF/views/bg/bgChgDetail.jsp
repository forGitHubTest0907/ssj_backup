<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
	    <meta name="viewport" content="width=device-width, initial-scale=1" />
	
	    <!-- Favicon -->
	    <link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
	
	    <!-- Libs CSS -->
	    <link rel="stylesheet" href="./assets/css/libs.bundle.css" />
	
	    <!-- Theme CSS -->
	    <link rel="stylesheet" href="./assets/css/theme.bundle.css" />
	
	    <!-- Title -->
	    <title>챌린지 상세</title>
		
		<!-- jQuery 라이브러리를 불러옵니다. -->
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript">
			function writeCertBoard() {
				
				alert("writeCertBoard Start");
				
				// EL값을 JavaScript 변수에 저장
				var user_num = ${user1.user_num};
				// chg_id 챌린지 페이지 아직 없어서 임시용으로 변수에 저장함
				var chg_id = 1;
				
				// 사용자가 입력한 내용 가져오기
				var paramData = {
									"title"	:	$('#title').val(),
									"conts"	:	$('#conts').val(),
									"chg_id":	chg_id,
									"user_num":	user_num
				};
				
				alert("paramData $('#title').val() ->"+$('#title').val());
				alert("paramData $('#conts').val() ->"+$('#conts').val());
				alert("paramData chg_id ->"+chg_id);
				alert("paramData user_num ->"+user_num);
				
				// 서버로 데이터 전송
				$.ajax({
					url	:	"/writeCertBoard",
					type:	"POST",
					data:	paramData,
					dataType:	"text",
					success	:	function(rtnStr) {
						alert("success ajax Data -> "+rtnStr);
						// 서버 응답을 처리하는 코드
					},
					error: function() {
						// Ajax 요청 자체가 실패한 경우
						alert("error: 글 등록에 실패했습니다");
					}
				});
			}
			
			
			document.addEventListener("DOMContentLoaded", function() {
				// '더보기' 버튼 클릭 시 모달 창 열기
				document.getElementById("showModalButton").addEventListener("click", function() {
					// 모달 창 표시
					$('#modalProduct').modal('show');
				});
			});
		
		</script>
		
		
	</head>
	<body>
		
		<!-- Nav -->
	            <div class="nav nav-tabs nav-overflow justify-content-start justify-content-md-center border-bottom">
	              <a class="nav-link active" data-bs-toggle="tab" href="#descriptionTab">
					챌린지 소개
	              </a>
	              <a class="nav-link" data-bs-toggle="tab" href="#certBoard">
					인증 게시판
	              </a>
	              <a class="nav-link" data-bs-toggle="tab" href="#shippingTab">
					소시지들
	              </a>
	              <a class="nav-link" data-bs-toggle="tab" href="#shippingTab">
					후기 게시판
	              </a>
	            </div>
	      
	
	    <!-- REVIEWS -->
	    <section class="pt-9 pb-11" id="certBoard">
	      <div class="container">
	        <div class="row">
	          <div class="col-12">
	
	            <!-- Heading -->
	            <h4 class="mb-10 text-center">인증 게시판</h4>
	
	            <!-- Header -->
	            <div class="row align-items-center">
	              <div class="col-12 col-md-auto">
	
	                <!-- Dropdown -->
	                <div class="dropdown mb-4 mb-md-0">
	
	                  <!-- Toggle -->
	                  <a class="dropdown-toggle text-reset" data-bs-toggle="dropdown" href="#">
	                    <strong>Sort by: Newest</strong>
	                  </a>
	
	                  <!-- Menu -->
	                  <div class="dropdown-menu mt-3">
	                    <a class="dropdown-item" href="#!">Newest</a>
	                    <a class="dropdown-item" href="#!">Oldest</a>
	                  </div>
	
	                </div>
	
	              </div>
	              <div class="col-12 col-md text-md-center">
	

	
	                <!-- Count -->
	                <strong class="fs-sm ms-2">Reviews ${totalCert }</strong>
	
	              </div>
	              <div class="col-12 col-md-auto">
	
	                <!-- Button -->
	                <a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#reviewForm">
	                  	인증하기
	                </a>
	
	              </div>
	            </div>
	
	            <!-- New Review -->
	            <div class="collapse" id="reviewForm">
	
	              <!-- Divider -->
	              <hr class="my-8">
	
	              <!-- 인증 글쓰기 Form -->
	              <form id="certForm">
	                <div class="row">
	                  
	                  <div class="col-12 col-md-6">
	                    <!-- 유저 닉네임 표시하는 란 Name -->
	                    <div class="form-group">
		                      <p class="mb-2 fs-lg fw-bold">
		                        ${user1.nick }
		                      </p>
	                    </div>
	                  </div>
	                  
	                  <div class="col-12">
	                    <!-- 제목 입력란  Name -->
	                    <div class="form-group">
	                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
	                      <input class="form-control form-control-sm" id="title" type="text" placeholder="제목을 작성해주세요 *" required>
	                    </div>
	                  </div>
	                  
	                  <div class="col-12">
	                    <!-- 인증글 입력란 Name -->
	                    <div class="form-group">
	                      <label class="visually-hidden" for="reviewText">Review:</label>
	                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="인증글을 작성해주세요 *" required></textarea>
	                    </div>
	                  </div>
	                  
	                  <div class="col-12 text-center">
	                    <!-- 등록 Button -->
	                    <button class="btn btn-outline-dark" type="submit" onclick="writeCertBoard()">
	                      	등록
	                    </button>
	                  </div>
	                </div>
	              </form>
	
	            </div>
	
	            <!-- Reviews -->
	            <div class="mt-8">
	
	              <!-- Review 여기부터 첫번째 인증글 -->
	              <c:forEach var="certBoard" items="${certBoard }">
	              
		              <div class="review">
		                <div class="review-body">
		                  <div class="row">
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
		
		                          
		
		                        </div>
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
		                        <div class="col-auto d-none d-lg-block">
		
		                          <!-- Text -->
		                          <p class="mb-0 fs-sm">좋아요</p>
		
		                        </div>
		                        
		                        <div class="col-auto me-auto">
		                          <!-- Rate -->
		                          <div class="rate">
		                            <a class="rate-item" data-toggle="vote" data-count="3" href="#" role="button">
		                              <i class="fe fe-thumbs-up"></i>
		                            </a>
		                          </div>
		                        </div>
		                        

		                        
		                        <div class="col-auto d-none d-lg-block">
		                          <!-- Text -->
		                          <p class="mb-0 fs-sm">Comments (0)</p>
		                        </div>
		                        
		                        <div class="col-auto">
		                          <!-- comment 버튼을 수정 삭제 버튼으로 바꿈 Button -->
		                          <a class="btn btn-xs btn-outline-border" href="#!" id="showModalButton">
									더보기
		                          </a>
		                          
		                          
		                          
		                          <!-- Button -->
		                          <a class="btn btn-xs btn-outline-border" href="#!">
									삭제
		                          </a>
		                        </div>
		                        
		                      </div>
		
		                    </div>
		                  </div>
		                </div>
		              </div>
	              </c:forEach>
	
	              
	            </div>
	            
	            <!-- 더보기 Product -->
			    <div class="modal fade" id="modalProduct" tabindex="-1" role="dialog" aria-hidden="true">
			      <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
			        <div class="modal-content">
			    
			          <!-- Close -->
			          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
			            <i class="fe fe-x" aria-hidden="true"></i>
			          </button>
			    
			          <!-- Content -->
			          <div class="container-fluid px-xl-0">
			            <div class="row align-items-center mx-xl-0">
			              <div class="col-12 col-lg-6 col-xl-5 py-4 py-xl-0 px-xl-0">
			    
			                <!-- Image -->
			                <img class="img-fluid" src="./assets/img/products/product-7.jpg" alt="...">
			    
			                <!-- Button -->
			                <a class="btn btn-sm w-100 btn-primary" href="./product.html">
			                  More Product Info <i class="fe fe-info ms-2"></i>
			                </a>
			    
			              </div>
			              <div class="col-12 col-lg-6 col-xl-7 py-9 px-md-9">
			    
			                <!-- Heading -->
			                <h4 class="mb-3">Leather Sneakers</h4>
			    
			                <!-- Price -->
			                <div class="mb-7">
			                  <span class="h5">$85.00</span>
			                  <span class="fs-sm">(In Stock)</span>
			                </div>
			    
			                <!-- Form -->
			                <form>
			                  <div class="form-group">
			    
			                    <!-- Label -->
			                    <p>
			                      Color: <strong id="modalProductColorCaption">White</strong>
			                    </p>
			                    
		                    	<div class="col-12 col-md-6">
			                    <!-- 유저 닉네임 표시하는 란 Name -->
			                    <div class="form-group">
				                      <p class="mb-2 fs-lg fw-bold">
				                        ${user1.nick }
				                      </p>
			                    </div>
			                  </div>
			                    
								
								<div class="col-12">
			                    <!-- 제목 입력란  Name -->
			                    <div class="form-group">
			                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
			                      <input class="form-control form-control-sm" id="title" type="text" placeholder="제목을 작성해주세요 *" required>
			                    </div>
			                  </div>
			                  
			                  <div class="col-12">
			                    <!-- 인증글 입력란 Name -->
			                    <div class="form-group">
			                      <label class="visually-hidden" for="reviewText">Review:</label>
			                      <textarea class="form-control form-control-sm" id="conts" rows="5" placeholder="인증글을 작성해주세요 *" required></textarea>
			                    </div>
			                  </div>
			    
			                    <!-- Radio -->
			                    <div class="mb-8 ms-n1">
			                      <div class="form-check form-check-inline form-check-img">
			                        <input type="radio" class="form-check-input" id="modalProductColorOne" name="modalProductColor" data-toggle="form-caption" data-target="#modalProductColorCaption" value="White" style="background-image: url(./assets/img/products/product-7.jpg);" checked>
			                      </div>
			                      <div class="form-check form-check-inline form-check-img">
			                        <input type="radio" class="form-check-input" id="modalProductColorTwo" name="modalProductColor" data-toggle="form-caption" data-target="#modalProductColorCaption" value="Black" style="background-image: url(./assets/img/products/product-49.jpg);">
			                      </div>
			                    </div>
			    
			                  </div>
			                  <div class="form-group">
			    
			                    <!-- Label -->
			                    <p>
			                      Size: <strong><span id="modalProductSizeCaption">7.5</span> US</strong>
			                    </p>
			    
			                    <!-- Radio -->
			                    <div class="mb-2">
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeOne" value="6" data-toggle="form-caption" data-target="#modalProductSizeCaption">
			                        <label class="form-check-label" for="modalProductSizeOne">6</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeTwo" value="6.5" data-toggle="form-caption" data-target="#modalProductSizeCaption" disabled>
			                        <label class="form-check-label" for="modalProductSizeTwo">6.5</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeThree" value="7" data-toggle="form-caption" data-target="#modalProductSizeCaption">
			                        <label class="form-check-label" for="modalProductSizeThree">7</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeFour" value="7.5" data-toggle="form-caption" data-target="#modalProductSizeCaption" checked>
			                        <label class="form-check-label" for="modalProductSizeFour">7.5</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeFive" value="8" data-toggle="form-caption" data-target="#modalProductSizeCaption">
			                        <label class="form-check-label" for="modalProductSizeFive">8</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeSix" value="8.5" data-toggle="form-caption" data-target="#modalProductSizeCaption">
			                        <label class="form-check-label" for="modalProductSizeSix">8.5</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeSeven" value="9" data-toggle="form-caption" data-target="#modalProductSizeCaption" disabled>
			                        <label class="form-check-label" for="modalProductSizeSeven">9</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeEight" value="9.5" data-toggle="form-caption" data-target="#modalProductSizeCaption" disabled>
			                        <label class="form-check-label" for="modalProductSizeEight">9.5</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeNine" value="10" data-toggle="form-caption" data-target="#modalProductSizeCaption">
			                        <label class="form-check-label" for="modalProductSizeNine">10</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeTen" value="10.5" data-toggle="form-caption" data-target="#modalProductSizeCaption">
			                        <label class="form-check-label" for="modalProductSizeTen">10.5</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeEleven" value="11" data-toggle="form-caption" data-target="#modalProductSizeCaption">
			                        <label class="form-check-label" for="modalProductSizeEleven">11</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeTwelve" value="12" data-toggle="form-caption" data-target="#modalProductSizeCaption">
			                        <label class="form-check-label" for="modalProductSizeTwelve">12</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeThirteen" value="13" data-toggle="form-caption" data-target="#modalProductSizeCaption">
			                        <label class="form-check-label" for="modalProductSizeThirteen">13</label>
			                      </div>
			                      <div class="form-check form-check-inline form-check-size mb-2">
			                        <input type="radio" class="form-check-input" name="modalProductSize" id="modalProductSizeFourteen" value="14" data-toggle="form-caption" data-target="#modalProductSizeCaption">
			                        <label class="form-check-label" for="modalProductSizeFourteen">14</label>
			                      </div>
			                    </div>
			    
			                  </div>
			                  <div class="form-group mb-0">
			                    <div class="row gx-5">
			                      <div class="col-12 col-lg-auto">
			    
			                        <!-- Quantity -->
			                        <select class="form-select mb-2">
			                          <option value="1" selected>1</option>
			                          <option value="2">2</option>
			                          <option value="3">3</option>
			                          <option value="4">4</option>
			                          <option value="5">5</option>
			                        </select>
			    
			                      </div>
			                      <div class="col-12 col-lg">
			    
			                        <!-- Submit -->
			                        <button type="submit" class="btn w-100 btn-dark mb-2">
			                          Add to Cart <i class="fe fe-shopping-cart ms-2"></i>
			                        </button>
			    
			                      </div>
			                      <div class="col-12 col-lg-auto">
			    
			                        <!-- Wishlist -->
			                        <button class="btn btn-outline-dark w-100 mb-2" data-toggle="button">
			                          Wishlist <i class="fe fe-heart ms-2"></i>
			                        </button>
			    
			                      </div>
			                    </div>
			                  </div>
			                </form>
			    
			              </div>
			            </div>
			          </div>
			    
			        </div>
			      </div>
			    </div>
	
	            <!-- Pagination -->
	            <nav class="d-flex justify-content-center mt-9">
	              <ul class="pagination pagination-sm text-gray-400">
	                <li class="page-item">
	                  <a class="page-link page-link-arrow" href="#">
	                    <i class="fa fa-caret-left"></i>
	                  </a>
	                </li>
	                <li class="page-item active">
	                  <a class="page-link" href="#">1</a>
	                </li>
	                <li class="page-item">
	                  <a class="page-link" href="#">2</a>
	                </li>
	                <li class="page-item">
	                  <a class="page-link" href="#">3</a>
	                </li>
	                <li class="page-item">
	                  <a class="page-link page-link-arrow" href="#">
	                    <i class="fa fa-caret-right"></i>
	                  </a>
	                </li>
	              </ul>
	            </nav>
	
	          </div>
	        </div>
	      </div>
	    </section>
		
	</body>
</html>