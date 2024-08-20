<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "com.homes.guest.*" %>
<!DOCTYPE html>
<%
if(session.getAttribute("useridx")==null || session.getAttribute("useridx")==""){
	%>
	<script>
	window.alert('로그인 후 이용 가능합니다.');
	location.href='/homes';
	</script>
	<%
	return;
}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/myPageLayout.css">
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<%@include file="/guest/myPageNav.jsp" %>
<%
GuestDTO dto = gdao.getUserProfile(userid);
%>
<article id="myProfile" class="myPageContent_ar">
	<fieldset class="label_fs">
		<h3><%=session.getAttribute("usernickname") %>님 계정 정보</h3>
	</fieldset>
	<form name="updateProfile" onsubmit="return checkForm();" action="updateProfile_ok.jsp" method="post" enctype="multipart/form-data">
	<input type="hidden" name="idx" value="<%=dto.getIdx() %>">
		<div id="img_div">
			<a href="javascript:changeImg();"><img src="<%=dto.getImg() %>" alt="profile_img" id="profileImg"></a>
			<input type="file" name="profileImgFile" id="profileImgFile" style="display:none;" onchange="previewImage(event);">
		</div>
	<table>
	<tr>
		<th>이름</th>
		<td><%=dto.getName() %></td>
	</tr>
	<tr>
		<th>ID</th>
		<td><%=dto.getId() %></td>
	</tr>
	<tr>
		<th>닉네임</th>
		<td>
			<input type="text" name="nickname" id="nickname" value="<%=dto.getNickname() %>" class="textfield" maxlength="15" required>
			<div id="error-message-nickname" style="color:red; margin-top:5px; font-size:15px"></div>
		</td>
	</tr>
	<tr>
		<th>생년월일</th>
		<td><%=dto.getBday() %></td>
	</tr>
	<tr>
		<th>E-Mail</th>
		<td>
			<input type="text" name="email" value="<%=dto.getEmail() %>" class="textfield" required>
		</td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td>
			<input type="text" name="tel" value="<%=dto.getTel() %>" class="textfield" onblur="validateTel()" required>
			<div id="error-message-tel" style="color: black; margin-top: 5px; font-size:15px;"></div>
		</td>
	</tr>
	<tr>
		<th>가입날짜</th>
		<td><%=dto.getJoindate() %></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="변경사항 저장" class="button">
		</td>
	</tr>
	</table>
	</form>
</article>
</section>
<%@include file="/footer.jsp" %>
<script>
function changeImg(){
	document.getElementById('profileImgFile').click();
}
//선택한 이미지 미리보기
function previewImage(event) {
    var reader = new FileReader();
    reader.onload = function(){
        var output = document.getElementById('profileImg');
        output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
}
//전화번호에 10~11글자의 숫자만 입력할 수 있도록 하는 함수
function validateTel(){
	var insertTel = document.updateProfile.tel.value;
	var errorMessage = document.getElementById("error-message-tel");
	
	var validPattern = /^\d{10,11}$/;
	
	if(!validPattern.test(insertTel)){
		errorMessage.style.color = "red";
		errorMessage.textContent = "전화번호는 최대 11자의 숫자로만 입력해주세요.";
		document.getElementById("tel").style.border='3px solid red';
		return false;
	}else{
		errorMessage.textContent = "";
		document.getElementById("tel").style.border='3px solid black';
		return true;
	}
}
//닉네임 글자수 제한하는 함수
function validateNickname() {
    var nicknameField = document.getElementById("nickname");
    var nicknameValue = nicknameField.value.trim();
    var errorMsgNickname = document.getElementById("error-message-nickname");
    var maxLength = 15;

    if (nicknameValue === "") {
        errorMsgNickname.textContent = "필수 입력 사항입니다.";
        nicknameField.style.border = '3px solid red';
        return false;
    } else if (nicknameValue.length > maxLength) {
        errorMsgNickname.textContent = `닉네임은 최대 ${maxLength}자까지 입력할 수 있습니다.`;
        nicknameField.style.border = '3px solid red';
        return false;
    } else {
        errorMsgNickname.textContent = "";
        nicknameField.style.border = '3px solid black';
        return true;
    }
}
//fome의 최종 유효성 검사
function checkForm(){
	var valid = true;
	
	if(!validateTel()) valid = false;
	if(!validateNickname()) valid = false;
	
	return valid;
}
</script>
</body>
</html>