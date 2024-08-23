<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/myPageLayout.css">
<style>
#resetPwdTable{
	margin:100px auto;
	width:60%;
}
#resetPwdTable td{
	padding:5px;
	font-size:25px;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<%@include file="/guest/myPageNav.jsp" %>
<article id="updatePwd_ar" class="myPageContent_ar">
	<form name="updatePwd" onsubmit="return checkUpdatePwdForm();" action="resetPwd_ok.jsp">
	<table id="resetPwdTable">
		<tr>
			<td colspan="2" align="center">
			<h3>비밀번호 재설정</h3>
			</td>
		</tr>
		<tr>
			<td>비밀번호 입력</td>
			<td>
				<input type="password" id="pwd" name="pwd" class="textfield" onblur="validatePwd();">
				<div id="error-message-pwd" style="color: black; margin-top: 5px; font-size:15px;">영어, 숫자, 특수문자(!, @, ^, *)를 포함한 8~12글자</div>
			</td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td>
				<input type="password" id="pwdck" name="pwdck" class="textfield" oninput="revalidatePwd();">
				<div id="error-message-pwdCheck" style="color: red; margin-top: 5px; font-size:15px;"></div>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<input type="submit" value="변경하기" class="button">
			</td>
		</tr>
	</table>
	</form>
</article>
</section>
<%@include file="/footer.jsp" %>
<script>
//비밀번호 설정 기준 확인
function validatePwd(){
    var insertPwd = document.updatePwd.pwd.value;
    var errorMessage = document.getElementById("error-message-pwd");
    
    var validPattern = /^(?=.*[a-zA-Z])(?=.*[!@^*])(?=.*\d)[a-zA-Z\d!@^*]{8,15}$/;

    if (!validPattern.test(insertPwd)) {
    	errorMessage.style.color = "red";
        errorMessage.textContent = "비밀번호는 영어와 숫자, 특수문자(!,@,^,*)를 포함한 8~12글자여야 합니다.";
        document.getElementById("pwd").style.border='3px solid red';
        return false;
    } else {
        errorMessage.textContent = "";
        document.getElementById("pwd").style.border='3px solid black';
        return true;
    }
}
//비밀번호 입력필드 일치 여부 확인
function revalidatePwd(){
	var pwd = document.updatePwd.pwd.value;
	var pwdck = document.updatePwd.pwdck.value;

	if(pwd !== pwdck){
		document.getElementById("error-message-pwdCheck").textContent = "비밀번호가 일치하지 않습니다.";
		document.getElementById("pwdck").style.border='3px solid red';
		return false;
	}else{
		document.getElementById("error-message-pwdCheck").textContent = "";
		document.getElementById("pwdck").style.border='3px solid black';
		return true;
	}
}
function checkUpdatePwdForm(){
	var valid = true;
	if(!validatePwd()) valid = false;
	if(!revalidatePwd()) valid = false;
	
	return valid;
}
</script>
</body>
</html>