<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<body>

<form method="post" action="/updateUser1">
	<fieldset>
	   아이디 : <input type="text" name="user_id" value="${user1.user_id}" readonly><p>
	비밀번호 : <input type="text" name="user_pswd" value="" ><p>
	   닉네임 : <input type="text" name="nick" value="" ><p>
	   이름 : 	<input type="text" name="user_name" value="${user1.user_name}" readonly><p> 
	 이메일 : <input type="text" name="email" value="" ><p>	
	생년월일 : <input type="text" name="birth" value="" ><p>	
	 주소 : <input type="text" name="addr" value="" ><p>
	 전화번호 : <input type="text" name="tel" value="" ><p> 		
	
	<input type="radio" name="gender" value="M">남자
	<input type="radio" name="gender" value="F">여자 <p>
	
	
	<input type="submit" value="수정완료">	
	<input type="button" value="취소" onclick="location.href='/mypage'">
	<input type="button" value="탈퇴" onclick="location.href='/deleteUser1Form'"><p>
	</fieldset>
</form>



</body>
<%@ include file="../footer.jsp" %>
</html>