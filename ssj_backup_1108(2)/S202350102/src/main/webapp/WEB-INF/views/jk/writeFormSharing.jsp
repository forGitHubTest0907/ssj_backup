<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<!--  CSS  -->
<link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="./assets/css/libs.bundle.css" />
<link rel="stylesheet" href="./assets/css/theme.bundle.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

 <meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css); 
    	body{
    	font-family: 'Noto Sans KR', sans-serif;} 
			
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    $('form').submit(function(e) {
        e.preventDefault();

        var formData = new FormData($(this)[0]); // 양식 데이터 가져오기

        var fileInput = $('#img')[0].files[0]; // 파일 입력 가져오기

        // 파일이 선택되었는지 확인
        if (fileInput) {
            // 파일이 이미지인지 확인
            if (!fileInput.type.match('image.*')) {
                alert('이미지 파일을 선택해 주세요');
                return;
            }

            formData.append('file', fileInput); // 파일을 양식 데이터에 첨부

            $.ajax({
                url: '/sharingUpload', // 이미지 업로드 처리할 URL
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(data) {
                    alert('이미지가 성공적으로 업로드되었습니다.');

                    var imgUrl = data; // 업로드된 이미지의 URL

                    sendImageURL(imgUrl);
                },
                error: function() {
                    alert('이미지 업로드에 실패했습니다.');
                }
            });
        } else {
            alert('이미지 파일을 선택해 주세요');
        }
    });

    // 선택한 이미지 미리보기를 표시하는 기능
    $('#img').change(function() {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#imgPreview').attr('src', e.target.result);
        };
        reader.readAsDataURL(this.files[0]);
    });

    // 서버로 이미지 URL을 전송 및 '/writeShare' 엔드포인트 호출
    function sendImageURL(imgUrl) {
        $('#imgURLInput').val(imgUrl);

        // 이전 'submit' 이벤트 핸들러 제거
        $('form').off('submit');

        // '/writeShare' 엔드포인트로 폼을 제출
        $('form').attr('action', '/writeShare');
        $('form').attr('enctype', 'application/x-www-form-urlencoded');
        $('form').submit();
    }
});
</script>


</head>
<body>
   <section class="pt-7 pb-12">
      <div class="container">
        <div class="row">
          <div class="col-12 text-center">

            <!-- Heading -->
            <h3 class="mb-10">게시글 올리기</h3>

          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-3">

            <!-- Nav -->
            <nav class="mb-10 mb-md-0">
              <div class="list-group list-group-sm list-group-strong list-group-flush-x">
                <a class="list-group-item list-group-item-action dropend-toggle " href="account-orders.html">
                  	전체 쉐어링
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="account-wishlist.html">
                 	찜한 쉐어링
                </a>
               <a class="btn w-100 btn-dark mb-2" href="checkout.html" style=" margin-top: 50px;">게시글 작성하기
               </a>
                
              </div>
            </nav>
 		  </div>
             <!-- Nav End --> 
        
          <div class="col-12 col-md-9 col-lg-8 offset-lg-1">

             <!-- Form -->
                    <form method="post" action="/writeShare" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-12">
                                <!-- 제목 -->
                                <div class="form-group">
                                <input class="form-control form-control-sm" id="user_num" name="user_num" type="hidden" value="${user_num}" required>
                                
                                    <label class="form-label" for="title">게시글 제목 *</label>
                                    <input class="form-control form-control-sm" id="title" name="title" type="text" value="" required>
                                </div>
                            </div>
                            <!-- 작성자명 및 연락처 -->
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="nick">닉네임 *</label>
                                        <input class="form-control form-control-sm" id="nick" name="nick" type="text" value="${user1.nick}" readonly>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="user_tel">연락처 *</label>
                                        <input class="form-control form-control-sm" id="user_tel" name="user_tel" type="text" value="" required>
                                    </div>
                                </div>
                            </div>
                            <!-- 금액 및 모집 인원 -->
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="price">금액 *</label>
                                        <input class="form-control form-control-sm" id="price" type="number" name="price" value="" required>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="applicants">모집인원 *</label>
                                        <input class="form-control form-control-sm" id="applicants" name="applicants" type="number" value="" required>
                                    </div>
                                </div>
                            </div>
                            <!-- 계좌번호 및 입금기한 -->
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="bank_info">계좌번호 *</label>
                                        <input class="form-control form-control-sm" id="bank_info" name="bank_info" type="text" value="" required>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="form-label" for="bank_duedate">입금기한 *</label>
                                        <input class="form-control form-control-sm" id="bank_duedate" name="bank_duedate" type="date" value="" required>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 주소 -->
                            <div class="form-group">
                                <div class="col-12">
                                    <label class="form-label" for="addr">주소 *</label>
                                    <input class="form-control form-control-sm" id="addr" name="addr" type="text" value="" required>
                                </div>
                            </div>
                                                    
                             <!-- 이미지 업로드 -->
							<div class="form-group mb-7">
							    <label class="form-label" for="img">이미지 *</label>
							    <input class="form-control form-control-sm me-3" id="img" name="img" type="file" required>
							    <img id="imgPreview" style="max-width: 200px; margin-top: 10px;" />
							</div>

 							<!-- 상세내용 -->
							<div class="form-group mb-7">
							    <label class="form-label" for="conts">상세내용 *</label>
							    <div class="d-flex align-items-start" style="margin-top: 10px;">
							        <textarea class="form-control form-control-sm" id="conts" name="conts" rows="5" required></textarea>
							    </div>
							</div>



                            <!-- Button -->
                            <button class="btn btn-dark" type="submit">작성완료</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
  
  
  
  
  
  
  
  
  
  
   
</body>
<%@ include file="../footer.jsp" %>
</html>
