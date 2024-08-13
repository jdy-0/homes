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
body{background-color:#e2dccc;}
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
	border:3px solid black;
	background-color:#dec022;
	font-family: 'SBAggroB';
	font-size:23px;
	padding:10px;
}
#button:hover{
	background-color:#e2dccc;
	transition:0.5s;
}
</style>
</head>
<body>
<fieldset>
	<legend>ID 중복 확인</legend>
	<form name="idCheck" onsubmit="return checkId()" action="IdCheck_ok.jsp">
	<div id="idcheck_frame">
		<label>아이디</label>
		<input type="text" name="id" id="userId" oninput="validateId()" style="outline:none;">		
		<input type="submit" id="button" value="확인">
	</div>
	<div id="error-message" style="color: red; margin-top: 5px;"></div>
	</form>
</fieldset>
</body>
<script>
//ID에 영어와 허용되지 않은 특수문자가 포함되었는지 확인하는 함수
function validateId(){
    var insertId = document.idCheck.id.value;
    var errorMessage = document.getElementById("error-message");
    
    //영어 소문자와 숫자, 특수문자 _ 만 입력 가능하도록 설정
    var validPattern = /^[a-z0-9_]{6,15}$/;

    if (!validPattern.test(insertId)) {
    	
        errorMessage.textContent = "아이디는 영어 소문자와 특수문자 '_'만 사용할 수 있습니다.";
        document.getElementById("userId").style.border='3px solid red';
    } else {
    	document.getElementById("userId").style.border="3px solid black";
        errorMessage.textContent = "";
    }
}
//ID가 기준에 맞지 않으면 submit을 막는 함수
function checkId(){
    //ID 유효성 검사
    validateId();
    
    var errorMessage = document.getElementById("error-message").textContent;
    
    //오류 메시지가 있으면 submit 안됨
    if (errorMessage !== "") {
        return false;
    }
    return true;
}
</script>
</html>
