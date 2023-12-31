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
                    <form method="post" action="/writeShare">
                        <div class="row">
                            <div class="col-12">
                                <!-- 제목 -->
                                <div class="form-group">
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
                            <!-- 내용 -->
                            <div class="form-group mb-7">
                                <div class="col-12">
                                    <label class="form-label" for="conts">내용 *</label>
                                    <input class="form-control form-control-sm" id="conts" name="conts" type="text" value="" required>
                                    <!-- <textarea class="form-control form-control-sm" id="conts" name="conts" rows="5" placeholder="상세내용을 작성해주세요 *" required></textarea> -->
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
