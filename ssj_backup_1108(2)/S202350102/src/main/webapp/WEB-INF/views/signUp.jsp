<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
 <head>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1" />
    
    <!-- Favicon -->
    <link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
    
    <!-- Libs CSS -->
    <link rel="stylesheet" href="./assets/css/libs.bundle.css" />
    
    <!-- Theme CSS -->
    <link rel="stylesheet" href="./assets/css/theme.bundle.css" />
    
    <!-- Title -->
 </head>
  <body class="bg-light">
  	<c:import url="/WEB-INF/views/header4.jsp"/>

    <!-- MODALS -->
<!--     {{> partials/modals}} -->

    <!-- NAVBAR -->
<!--     {{> navbars/navbar-topbar classList="bg-light"}} -->

    <!-- NAVBAR -->
<!--     {{> navbars/navbar classList="bg-white"}} -->

    <!-- CONTENT -->
    <section class="py-12">
      <div class="container">
        <div class="row">
          <div class="col-7" style="float: none; margin:0 auto;">

            <!-- Card -->
            <div class="card card-lg">
              <div class="card-body">

                <!-- Heading -->
                <h6 class="mb-7"><b>회원 가입</b></h6>

                <!-- Form -->
                <form action="/writeUser1" method="post">
                  <div class="row">
                    <div class="col-12 col-md-6">

                      <!-- 아이디 -->
                      <div class="form-group">
                        <label class="visually-hidden" for="registerFirstName">
                          	아이디 *
                        </label>
                        <input class="form-control form-control-sm" id="registerFirstName" type="text" name="user_id" placeholder="아이디 *" required>
                      </div>

                    </div>
                    
                    <div class="col-12 col-md-4">
	                    <button class="btn btn-sm btn-dark" type="button">
	                        	중복확인
	                    </button>
                    </div>
                        
                    

                      <!-- 비밀번호 -->
                    <div class="col-12 col-md-6"> 
                     
                      <div class="form-group">
                        <label class="visually-hidden" for="registerPassword">
                          Password *
                        </label>
                        <input class="form-control form-control-sm" id="registerPassword" type="password" name="user_pswd" placeholder="비밀번호 *" required>
                      </div>

                    </div>
                    
                    <!-- 비밀번호 확인 -->
                    <div class="col-12 col-md-6">

                      <div class="form-group">
                        <label class="visually-hidden" for="registerPasswordConfirm">
                          Confirm Password *
                        </label>
                        <input class="form-control form-control-sm" id="registerPasswordConfirm" type="password" name="user_confirmPswd" placeholder="비밀번호 확인 *" required>
                      </div>

                    </div>
                    
                    <!-- 닉네임  -->    
                    <div class="col-12">
					
                      <div class="form-group">
                        <label class="visually-hidden" for="registerEmail">
                          	닉네임 *
                        </label>
                        <input class="form-control form-control-sm" id="registerNick"  type="text" name="nick" placeholder="닉네임  *" required>
                      </div>

                    </div>
                    
                    <!-- 이름 -->
                     <div class="col-12 col-md-6">
					
                      <div class="form-group">
                        <label class="visually-hidden" for="registerEmail">
                          Email Address *
                        </label>
                        <input class="form-control form-control-sm" id="registerName" type="text" name="user_name" placeholder="이름 *" required>
                      </div>

                    </div>
                    
					<!-- 성별 -->
					 <div class="col-12 col-md-2">
                      <div class="form-group">
                        <div class="form-check">
                          <input class="form-check-input" id="registerGenderMale" type="radio" name="gender" value="M">
                          <label class="form-check-label" for="registerGenderMale">
                            	남자     
                          </label>
                        </div>
                      </div>
                    </div>
                    
                    <div class="col-12 col-md-2">
                      <div class="form-group">
                        <div class="form-check">
                           <input class="form-check-input" id="registerGenderFemale" type="radio" name="gender" value="F">
                          <label class="form-check-label" for="registerGenderFemale">
                            	여자
                          </label>
                        </div>
                      </div>
                    </div>
                
                       
                    <!-- 이메일 -->
					<div class="col-12">
					
                      <div class="form-group">
                        <label class="visually-hidden" for="registerEmail">
                          Email Address *
                        </label>
                        <input class="form-control form-control-sm" id="registerEmail" type="email" name="email" placeholder="이메일 *" required>
                      </div>

                    </div>
                
                    
                   
                    <!-- 생년월일  -->
                    <div class="col-12">
					
                      <div class="form-group">
                        <label class="visually-hidden" for="registerEmail">
                          Email Address *
                        </label>
                        <input class="form-control form-control-sm" id="registerBirth" type="text" name="birth" placeholder="생년월일  *" required>
                      </div>

                    </div>
                    
                    <!-- 주소 -->
                    <div class="col-12">
					
                      <div class="form-group">
                        <label class="visually-hidden" for="registerAddr">
                          Email Address *
                        </label>
                        <input class="form-control form-control-sm" id="registerAddr" type="text" name="addr" placeholder="주소  *" required>
                      </div>

                    </div>
                    
                    <!-- 전화번호  -->
                    <div class="col-12">
					
                      <div class="form-group">
                        <label class="visually-hidden" for="registerTel">
                          Email Address *
                        </label>
                        <input class="form-control form-control-sm" id="registerTel" type="tel" name="tel" placeholder="전화번호  *" required>
                      </div>

                    </div>
                    
               
                    <div class="col-12 col-md-auto">

                      <!-- Link -->
                      <div class="form-group fs-sm text-muted">
                        By registering your details, you agree with our Terms & Conditions,
                        and Privacy and Cookie Policy.
                      </div>

                    </div>
                    <div class="col-12 col-md">

                      <!-- Newsletter -->
                      <div class="form-group">
                        <div class="form-check">
                          <input class="form-check-input" id="registerNewsletter" type="checkbox">
                          <label class="form-check-label" for="registerNewsletter">
                            Sign me up for the Newsletter!
                          </label>
                        </div>
                      </div>

                    </div>
                    <div class="col-12">

                      <!-- Button -->
                      <button class="btn btn-sm btn-dark" type="submit">
                        	회원가입
                      </button>
					  <button class="btn btn-sm btn-dark" type="reset">
                        	다시 입력
                      </button>
                    </div>
                  </div>
                </form>

              </div>
            </div>

          </div>
        </div>
      </div>
    </section>

    <!-- FOOTER -->
    <c:import url="/WEB-INF/views/footer.jsp"/>

    <!-- JAVASCRIPT -->
    {{> partials/scripts}}

  </body>
</html>
