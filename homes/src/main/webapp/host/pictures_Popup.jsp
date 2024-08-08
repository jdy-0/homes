<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
</head>
<body>
	<form name="fileUpload" method="post" enctype="multipart/form-data"
		action="fileUpload_ok.jsp">
		<fieldset>
			<legend>파일올리기</legend>
			<label>파일선택</label> 
			<input type="file" name="upload"> 
			<input type="submit" value="파일올리기">
		</fieldset>
	</form>
</body>
</html>