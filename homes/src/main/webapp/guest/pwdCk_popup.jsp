<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@font-face {	/*제목용 굵은 폰트*/
    font-family: 'SBAggroB';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroB.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
body{background-color:cornsilk;}
fieldset{
	width:480px;
	font-family: 'SBAggroB';
	margin:100px auto;
	border:0;
}
legend{
	text-align:center;
	font-size:30px;
}
#idcheck_frame{
	margin:20px auto;
	display:flex;
	justify-content: space-between;
	font-family: 'SBAggroB';
	font-size:25px;
	align-items: center;
}
#userId{
	width:300px;
	outline:none;
	border:3px solid black;
	font-family: 'SBAggroB';
	font-size:23px;
	padding:5px;
}
#button{
	border:0;
	background-color:#cd280e;
	font-family: 'SBAggroB';
	font-size:23px;
	padding:10px;
	color:cornsilk;
}
#button:hover{
	opacity:0.5;
	transition:0.3s;
}
</style>
</head>
<body>
<fieldset>
	<h2>비밀번호를 입력해주세요</h2>
	<form name="pwdCk" action="pwdCk_ok.jsp" method="post">
	<div id="pwdCk_frame">
		<label>비밀번호</label>
		<input type="password" name="pwd" id="userId" oninput="validateId()" style="outline:none;">		
		<input type="submit" id="button" value="확인">
	</div>
	</form>
</fieldset>
</body>
</html>