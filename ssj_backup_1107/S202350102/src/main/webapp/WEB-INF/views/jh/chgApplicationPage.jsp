<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>챌린지 신청</h1>
<form action="chgApplication">

<!-- 각 요소 마다 required넣기 -->
<div class="input-group mb-3">
  <span class="input-group-text" id="inputGroup-sizing-default">카테고리</span>
	<div class="input-group-text">
	  <input class="form-check-input" type="radio" name="category" id="exercise" value="100">
	  <label class="form-check-label" for="exercise">운동</label>
	</div>
	<div class="input-group-text">
	  <input class="form-check-input" type="radio" name="category" id="studying" value="101">
	  <label class="form-check-label" for="studying">공부</label>
	</div>
	<div class="input-group-text">
	  <input class="form-check-input" type="radio" name="category" id="hobby" value="102">
	  <label class="form-check-label" for="hobby">취미</label>
	</div>
	<div class="input-group-text">
	  <input class="form-check-input" type="radio" name="category" id="habit" value="103">
	  <label class="form-check-label" for="habit">습관</label>
	</div><p>
	아작스 추가 예정
</div>

<div class="input-group mb-3">
  <span class="input-group-text" id="inputGroup-sizing-default">챌린지명</span>
  <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
</div>

<div class="input-group mb-3">
  <span class="input-group-text" id="inputGroup-sizing-default">참여 기간</span>
  <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
</div>

<div class="input-group mb-3">
  <span class="input-group-text" id="inputGroup-sizing-default">참여 인원</span>
  <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
</div>

<div class="input-group mb-3">
  <span class="input-group-text" id="inputGroup-sizing-default">인증 방법</span>
  <input type="text" class="form-control" placeholder="예)하루 만보 걷기 챌린지 : 매일 만보를 걷고 만보가 적힌 만보기 사진을 올려주세요 " >
  <span class="input-group-text" id="inputGroup-sizing-default">인증 예시</span>
  <input type="file" class="form-control" id="inputGroupFile01">
</div>

<div class="input-group mb-3">
  <span class="input-group-text" id="inputGroupSelect01">인증 방법</span>
  <select class="form-select" id="inputGroupSelect01">
    <option selected>일주일에 인증할 회수를 선택해 주세요</option>
    <option value="1">1일</option>
    <option value="2">2일</option>
    <option value="3">3일</option>
    <option value="4">4일</option>
    <option value="5">5일</option>
    <option value="6">6일</option>
    <option value="7">매일</option>
  </select>
</div>

<div class="input-group mb-3">
  <span class="input-group-text" id="inputGroup-sizing-default">공개 여부</span>
  <%-- 구독회원 여부에 따라 공개설정 표시 달라짐<c:if test=""></c:if> --%>
<div class="form-check">
  <input class="form-check-input" type="radio" name="accessibility" id="public" checked disabled>
  <label class="form-check-label" for="publicCheckedDisabled">
    공개
  </label>
</div>
<div class="form-check">
  <input class="form-check-input" type="radio" name="accessibility" id="private"  disabled>
  <label class="form-check-label" for="privateDisabled">
    비공개
  </label>
</div>
  <span class="input-group-text" id="inputGroup-sizing-default">비밀번호</span>
    <label for="inputPassword4" class="form-label">Password</label>
    <input type="password" class="form-control" id="inputPassword4">
</div>

<div class="input-group mb-3">
  <input type="text" class="form-control" placeholder="Username" aria-label="Username">
  <span class="input-group-text">@</span>
  <input type="text" class="form-control" placeholder="Server" aria-label="Server">
</div>

<div class="input-group mb-3">
  <span class="input-group-text" id="inputGroup-sizing-default">챌린지 소개</span>
  <input type="text" class="form-control" placeholder="예)하루 만보 걷기 챌린지 : 건강을 위해 우리 다함께 매일 만보씩 걸어요" >
  <span class="input-group-text" id="inputGroup-sizing-default">썸네일</span>
  <input type="file" class="form-control" id="inputGroupFile01">
</div>



</form>
</body>
</html>