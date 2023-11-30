<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>로그인 에러</title>
    <script>
    function adminAlert(){
        alert("접근 권한이 없습니다");
        self.location = "/";
    }
    </script>
</head>
<body onload="adminAlert()">
</body>
</html>