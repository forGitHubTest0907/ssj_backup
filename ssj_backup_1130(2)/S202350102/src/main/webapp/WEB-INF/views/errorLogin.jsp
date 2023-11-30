<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>로그인 에러</title>
    <script>
    function loginAlert(){
        alert("로그인이 필요합니다.");
        self.location = "/loginForm";
    }
    </script>
</head>
<body onload="loginAlert()">

</body>
</html>