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
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	
	var idCheck = 0;
	var pwdCheck = 0;
	var phoneCheck = 0;
	var nameCheck = 0;
	
	function fn_user1IdCheck(){
		if( $("#user_id").val() == "" ) {
	 		alert("아이디를 입력해주세요.");
		} else if(frm.user_id.value.length < 6) {
			alert("아이디를 6자리이상 입력해 주세요")
	 	} else {
					//user_id를 받아오는지 체크
					//alert($("#user_id").val());	
					$.ajax(
							{
								url 		:	"/user1IdCheck",
								type		:	"POST",
								data		:	{user_id : $("#user_id").val()},
								dataType	:	"JSON",
								success		:	function(data) {
													if(data == 1) {
														alert("중복된 ID입니다.");
													} else if(data == 0) {
														$("#user1IdCheck").attr("value", "Y");
														alert("사용가능한 ID 입니다");
													}
												}
							}
					)
	 	}
	}
	
	//정규 표현식 (추후 수정 필요)
	function regUser_id(user_id) {  //영문자 또는 숫자 6~16자
	   var regExp = /^[A-za-z0-9]{5,15}/g;
	   return regExp.test(user_id);   
	}
	function regPassword(user_pswd) { // 영문 숫자 특수기호 조합 8자리 이상
	   var regExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/
	   return regExp.test(user_pswd);
	}
	function regTel(tel) { // 휴대폰번호 : 010 시작 -:있을수도 없을수도 숫자만 들어가면서 3~4길이 , -:있을수도 없을수도, 숫자만 들어가면서 4 길이 문자 
	   var regExp = /^010-?([0-9]{3,4})-?([0-9]{4})$/
	   return regExp.test(tel);
	}
	function regUser_name(user_name) { //이름
	   var regExp = /^[가-힣]{2,6}$/;
	   return regExp.test(user_name);
	}
	
	function regNick(nick) { //닉네임 : 2자 이상 16자 이하, 영어 또는 숫자 또는 한글로 구성
		   var regExp = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/
		   return regExp.test(nick);
	}
	
	function checkName() {
		   var inputed = $('#user_name').val(); //이름에 입력한 값
		   $.ajax({
		      success: function() {
		         if(regUser_name(inputed) == false || inputed.length > 18) { //입력한 값이 정규표현식에 해당되지 않을 때와 18자 이상이 넘을 때 
		            $("#signupbtn").prop("disabled", true); //회원가입 버튼 누르지 못하게 하기
		            $("#signupbtn").css("background-color", "#aaaaaa"); //버튼 회색으로 바꾸기 
		            $("#user_name").css("background-color", "#FFCECE");  // input 배경 붉은색으로 바꾸기
		            nameCheck = 0; // 회원 가입 전 값들 체크하기 위해 (0은 불가, 1은 가능)
		         } else if(regUser_name(inputed) == true) { //정규표현식에 해당할 때
		            $("#user_name").css("background-color", "#B0F6AC"); // input 배경 초록색으로 바꾸기
		            nameCheck = 1;
		         }
		      }
		   })
		}
	
	function checkPwd() {
		   var inputed = $('#user_pswd').val();
		   
		   $.ajax({
		      success: function() {
		         if(regPassword(inputed) == false || inputed.length > 16) {
		            $("#signupbtn").prop("disabled", true);
		            $("#signupbtn").css("background-color", "#aaaaaa");
		            $("#failpwd").css("display", "block");
		            $("#user_pswd").css("background-color", "#FFCECE");
		            pwdCheck = 0;
		         } else if(regPassword(inputed) == true) {
		            $("#user_pswd").css("background-color", "#B0F6AC");
		            $("#failpwd").css("display", "none");
		            pwdCheck = 1;
		         }
		      }
		   })
		}
	

	function checkTel() {
	   var inputed = $('#tel').val();
	   
	   $.ajax({
	      success: function() {
	         if(regTel(inputed) ==  false) {
	            $("#tel").css("background-color", "#FFCECE");
	            $("#failtel").css("display", "block");
	            inputed = $('#tel').val();
	            phoneCheck = 0;
	         }
	         else if(regTel(inputed)== true) {
	            $("#tel").css("background-color", "#B0F6AC");
	            $("#failtel").css("display", "none");
	            phoneCheck = 1;
	         }
	      }
	   })
	}
	
	function checkId() {
		   var inputed = $('#user_id').val();
		   $.ajax({		
			   		data : { user_id : inputed },
			      	url : "user1IdCheck", // data를 checkid url에 보냄 (Controller에서 받아처리한다. 중복이 되면 1, 아니면 0을 반환하는 함수를 구현했다.)
		      success : function(data) {
		         if(data == '1') { //아이디가 중복되었을 때
		            $("#fail").css("display", "block"); //중복 에러메세지를 띄운다
		            $("#failid").css("display","none"); //중복 에러메세지 말고 다른 에러 메세지를 지운다.
		            $("#signupbtn").prop("disabled", true);
		            $("#signupbtn").css("background-color", "#aaaaaa");
		            $("#user_id").css("background-color", "#FFCECE");
		            idCheck = 0;
		         } else if (regUser_id(inputed) == false || inputed.length > 14) {
		            $("#failid").css("display","block");
		            $("#fail").css("display","none");
		            $("#signupbtn").prop("disabled", true);
		            $("#signupbtn").css("background-color", "#aaaaaa");
		            $("#user_id").css("background-color", "#FFCECE");
		            idCheck = 0;
		         } else if( data == '0' && regUser_id(inputed)) { //중복되지않고, 정규식을 통과할 때
		            $("#user_id").css("background-color", "#B0F6AC");
		            $("#failid").css("display","none");
		            $("#fail").css("display","none");
		            idCheck = 1;  
		         }
		      }
		   });
		}

	function activateSignupbtn() {
		   
		   if( idCheck == 1 && pwdCheck == 1  && nameCheck == 1  && pwCheck == 1 && authCheck ==1) {
		      $("#signupbtn").prop("disabled", false);   
		      $("#signupbtn").css("background-color", "#B0F6AC");
		   }
		   else  {
		      $("#signupbtn").css("background-color", "#aaaaaa");
		      $("#signupbtn").prop("disabled", true);
		   }
		}
</script>
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
                <form action="/writeUser1" method="post" name="frm">
                  <div class="row">
                    
                     <!-- 아이디 -->
                    <div class="col-12 col-md-7">
                      <div class="form-group">
                     	<div class="form-floating mb-3">
	                        <input class="form-control form-control-sm" type="text" id="user_id" name="user_id" placeholder="아이디 *" onchange="checkId(), activateSignupbtn()">
	                        <label for="floatingInput">아이디</label>
	                        <font color = "red" id= "failid" style = "display:none" size="2 rem"> 5~15자의 영문자와 숫자를 조합해서 입력해주세요.</font>
                        	<font color = "red" id= "fail"   style = "display:none" size="2 rem"> 이미 존재하는 ID입니다.</font>
                        </div>
                      </div>
                    </div>
                    
                    <div class="col-12 col-md-4">
	                    <button class="btn btn-sm btn-dark" id="user1IdCheck" type="button" onclick="fn_user1IdCheck()" value="N">
	                        	중복확인
	                    </button>
                    </div>
                        
                    

                      <!-- 비밀번호 -->
                    <div class="col-10"> 
                      <div class="form-group">
                        <div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" type="password" id="user_pswd" name="user_pswd" placeholder="비밀번호 *" on="checkPwd(), checkPwd2()">
                        	<label for="floatingInput">비밀번호</label>
                        	<font color ="red" id = "failpwd" style = "display:none" size="2 rem">8자리 이상 영문,숫자,특수기호를 조합해서 입력해주세요 </font>
                        </div>	
                      </div>
                    </div>
                    
                    
                    <!-- 비밀번호 확인 -->
                    <div class="col-10">
                      <div class="form-group">
                      	<div class="form-floating mb-3">
                        <input class="form-control form-control-sm" id="registerPasswordConfirm" type="password" name="user_confirmPswd" placeholder="비밀번호 확인 *" required>
                        <label for="floatingInput">비밀번호 확인</label>
                        </div>
                      </div>

                    </div>
                    
                    <!-- 닉네임  -->    
                    <div class="col-12 col-md-6">
                      <div class="form-group">
                      	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" type="text" id="nick" name="nick" placeholder="닉네임  *" required>
                        	<label for="floatingInput">닉네임</label>
                        </div>
                      </div>
                    </div>
                    
                    <div class="col-12 col-md-6">
	                    <button class="btn btn-sm btn-dark" type="button" onclick="nickCheck()" value="N">
	                        	중복확인
	                    </button>
                    </div>
                    
                    <!-- 이름 -->
                     <div class="col-12 col-md-6">
                      <div class="form-group">
                     	 <div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" type="text" id="user_name" name="user_name" placeholder="이름  *" onchange="checkName(),activateSignupbtn()" required>
                        	<label for="floatingInput">이름</label>
                         </div>
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
                      	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" id="registerEmail" type="email" name="email" placeholder="이메일 *" required>
                        	<label for="floatingInput">이메일</label>
                        </div>
                      </div>

                    </div>
                
                    
                   
                    <!-- 생년월일  -->
                    <div class="col-12">
                      <div class="form-group">
                      	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" id="registerBirth" type="text" name="birth" placeholder="생년월일  *" required>
                        	<label for="floatingInput">생년월일</label>
                        </div>
                      </div>
                    </div>
                    
                    <!-- 주소 -->
                    <div class="col-12">
                      <div class="form-group">
                       	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" id="registerAddr" type="text" name="addr" placeholder="주소  *" required>
                        	<label for="floatingInput">주소</label>
                        </div>
                      </div>

                    </div>
                    
                    <!-- 전화번호  -->
                    <div class="col-12">
                      <div class="form-group">
                       	<div class="form-floating mb-3">
                        	<input class="form-control form-control-sm" id="tel" type="tel" name="tel" placeholder="전화번호  *" onchange="checkTel(), activateSignupbtn()">
                        	<label for="floatingInput">휴대폰번호</label>
                        	<font color ="red" id = "failtel" style = "display:none" size="2 rem">010-XXXX-XXXX 형태로 입력해주세요 </font>
                        </div>
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
                      <button class="btn btn-sm btn-dark" type="submit" id="signupbtn">
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
