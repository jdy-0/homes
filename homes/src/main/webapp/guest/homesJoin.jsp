<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="texxt/css" href="/homes/css/mainLayout.css">
<style>
#fs_join{
	margin: 30px auto;
	width:800px;
	border:0px;
}
#fs_join legend{
	text-align: center;
	font-family: 'SBAggroB';
	font-size:30px;
}
#fs_join table{
	margin: 30px auto;
	border-spacing:0px;
	border:5px solid black;
	border-bottom:0px;
	width:800px;
}
#fs_join table th{
	width:100px;
	background-color:#dec022;
	border-right:5px solid black;
	border-bottom:5px solid black;
	font-family: 'SBAggroB';
	font-size:25px;
	color:black;
	padding:10px;
}
#fs_join table td{
	border-bottom:5px solid black;
	font-family: 'SBAggroB';
	font-size:25px;
	padding:10px;
}
#fs_join table select{
	width: 120px;
    font-size: 25px;
    font-family: 'SBAggroB';
    outline: none;
    border: 3px solid black;
    padding: 5px;
}
#fs_join table td div{
	display: flex;
    justify-content: space-between;
    margin:0;
}
#fs_join div{
	margin:30px auto;
}
.btstyle{
	background-color:#dec022;
	font-family: 'SBAggroB';
	font-size:20px;
	padding:8px;
	border:4px solid black;
}
.btstyle:hover{
	background-color: #e2dccc;
    transition: 0.5s;
}
.textfield_solo{
	border:3px solid black;
	outline:none;
	padding:5px;
	font-family: 'Ownglyph_meetme-Rg';
	font-size:25px;
	width:400px;
}
.textfield_with{
	border:3px solid black;
	outline:none;
	padding:5px 10px;
	font-family: 'Ownglyph_meetme-Rg';
	font-size:25px;
	width:120px;
}
</style>
</head>
<script>

</script>
<body>
<%@include file="/header.jsp" %>
<section>
	<fieldset id="fs_join">
	<legend>회원가입</legend>
	<form name="homesJoin" onsubmit="return checkForm();" action="homesJoin_ok.jsp" method="post">
	<table>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" id="name" class="textfield_solo" required="required" maxlength="8"/></td>
			<div id="error-message-name" style="color:red; margin-top:5px; font-size:15px;"></div>
		</tr>
		<tr>
			<th>ID</th>
			<td>
				<div>
				<input type="text" name="id" id="id" class="textfield_solo" readonly/>
				<input type="button" value="ID 중복 확인" onclick="openIdCheck();" class="btstyle">
				</div>
				<div id="error-message-id" style="color:red; margin-top:5px; font-size:15px;"></div>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<input type="password" name="pwd" id="pwd" class="textfield_solo" required="required" onblur="validatePwd();">
				<div id="error-message-pwd" style="color: black; margin-top: 5px; font-size:15px;">영어, 숫자, 특수문자(!, @, ^, *)를 포함한 8~12글자</div>
			</td>
		</tr>
		<tr>
			<th>비밀번호 힌트</th>
			<td>
				<select name="pwd_hint_q" id="pwd_hint_q" style="width:420px;">
					<option value="1">가장 감명깊게 본 영화는?</option>
					<option value="2">가장 좋아하는 음식은?</option>
					<option value="3">가장 싫어하는 음식은?</option>
					<option value="4">응원하는 스포츠 팀의 이름은?</option>
					<option value="5">나의 반려동물 이름은?</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>정답</th>
			<td><input type="text" name="pwd_hint_a" id="pwd_hint_a" class="textfield_solo" required="required" maxlength="500"/></td>
			<div id="error-message-hint" style="color:black; margin-top:5px; font-size:15px;"></div>
		</tr>
		<tr>
			<th>닉네임</th>
			<td><input type="text" name="nickname" id="nickname" class="textfield_solo" required="required" maxlength="15"></td>
			<div id="error-message-nickname" style="color:red; margin-top:5px; font-size:15px"></div>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>
				<select name="byear">
				<%
				Calendar now=Calendar.getInstance();
				int y=now.get(Calendar.YEAR);
					for(int i=y;i>=1990;i--){
						%>
						<option value="<%=i%>"><%=i%></option>
						<%
					}
				%>
				</select>&nbsp;년&nbsp;&nbsp;
				<select name="bmonth">
				<%
					for(int j=1;j<=12;j++){
						%>
						<option value="<%=j%>"><%=j%></option>
						<%
					}
				%>
				</select>&nbsp;월&nbsp;&nbsp;
				<input type="number" name="bdate" id="bdate" class="textfield_with" required="required" oninput="validateBdate()">&nbsp;일
				<div id="error-message-bdate" style="color: black; margin-top: 5px; font-size:15px;"></div>
				<input type="hidden" name="bday" value="">
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="email" class="textfield_solo" required="required"></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
			<input type="text" value="010" name="tel" id="tel" class="textfield_solo" required="required" onblur="validateTel()">
			<div id="error-message-tel" style="color: black; margin-top: 5px; font-size:15px;">'-'없이 숫자만 입력해주세요.</div>
			</td>
		</tr>
		
	</table>
	<div align="center">
		<input type="reset" value="다시작성" class="btstyle">
		<input type="submit" value="가입" class="btstyle" onclick="setBday();">
	</div>
	</form>
	</fieldset>
</section>
<%@include file="/footer.jsp" %>
</body>
<script>
//Id중복검사 팝업창 띄우는 함수
function openIdCheck(){
	var option='width=500, height=300, resizable=no, top=200, left=470';
	window.open('/homes/guest/IdCheck.jsp','IdCheck',option);
}
//따로 입력받은 연월일을 하나의 문자열로 합치는 함수
function setBday(){
	var byear = document.homesJoin.byear.value;
	var bmonth01 = document.homesJoin.bmonth.value;
	var bmonth=bmonth01.padStart(2, '0');
	var bdate01 = document.homesJoin.bdate.value;
	var bdate = bdate01.padStart(2, '0');
	
	var bday = byear+'-'+bmonth+'-'+bdate;
	
	document.homesJoin.bday.value=bday;
}

//비밀번호 설정 기준에 맞는지 확인하는 함수 (영어, 숫자, 특수문자(!, @, ^, *)를 포함한 8~15글자)
function validatePwd(){
    var insertPwd = document.homesJoin.pwd.value;
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
//생일에 1~31까지의 숫자만 입력할 수 있도록 하는 함수
function validateBdate(){
	var insertBdate = document.homesJoin.bdate.value;
	var errorMessage = document.getElementById("error-message-bdate");
	
	var validPattern = /^(0?[1-9]|[12][0-9]|3[01])$/;
	
	if(!validPattern.test(insertBdate)){
		errorMessage.style.color = "red";
		errorMessage.textContent = "1~31의 숫자만 입력할 수 있습니다.";
		document.getElementById("bdate").style.border='3px solid red';
		return false;
	}else{
		errorMessage.textContent = "";
		document.getElementById("bdate").style.border='3px solid black';
		return true;
	}
}
//전화번호에 10~11글자의 숫자만 입력할 수 있도록 하는 함수
function validateTel(){
	var insertTel = document.homesJoin.tel.value;
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
//이름 글자수 제한하는 함수
function validateName() {
    var nameField = document.getElementById("name");
    var nameValue = nameField.value.trim();
    var errorMsgName = document.getElementById("error-message-name");
    var maxLength = 8;

    if (nameValue === "") {
        errorMsgName.textContent = "필수 입력 사항입니다.";
        nameField.style.border = '3px solid red';
        return false;
    } else if (nameValue.length > maxLength) {
        errorMsgName.textContent = `이름은 최대 ${maxLength}자까지 입력할 수 있습니다.`;
        nameField.style.border = '3px solid red';
        return false;
    } else {
        errorMsgName.textContent = "";
        nameField.style.border = '3px solid black';
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
//비밀번호 힌트 정답 글자수 제한하는 함수
function validateHint() {
    var hintField = document.getElementById("pwd_hint_a");
    var hintValue = hintField.value.trim();
    var errorMsgHint = document.getElementById("error-message-hint");
    var maxLength = 500;

    if (hintValue === "") {
        errorMsgHint.textContent = "필수 입력 사항입니다.";
        hintField.style.border = '3px solid red';
        return false;
    } else if (hintValue.length > maxLength) {
        errorMsgHint.textContent = `힌트는 최대 ${maxLength}자까지 입력할 수 있습니다.`;
        hintField.style.border = '3px solid red';
        return false;
    } else {
        errorMsgHint.textContent = "";
        hintField.style.border = '3px solid black';
        return true;
    }
}

//ID 입력 필드 변경 시 에러 메시지 제거..인데 작동을 안하네
document.getElementById("id").addEventListener("input", function() {
	
    var errorMessageId = document.getElementById("error-message-id");

    if (this.value !== "") {
        errorMessageId.textContent = "";
        this.style.border = '3px solid black';
    }
});
//submit 전에 최종적으로 form 유효성 검사
function checkForm() {
	var checkValid = true;
	
	//ID유효성 검사
	var insertId = document.homesJoin.id.value;
	var errorMsgId = document.getElementById("error-message-id");
	
	if(insertId ==="" || insertId ===null){
		errorMsgId.style.color = "red";
		errorMsgId.textContent = "아이디를 입력해주세요";
		document.getElementById("id").style.border="3px solid red";
		checkValid = false;
	}else{
		errorMsgId.textContent = "";
		document.getElementById("id").style.border="3px solid black";
	}
	
	if(!validateName()) checkValid = false;
	if(!validateHint()) checkValid = false;
	if(!validateNickname()) checkValid = false;
	if(!validatePwd()) checkValid = false;
	if(!validateBdate()) checkValid = false;
	if(!validateTel()) checkValid = false;
	
	return checkValid;
}
</script>
</html>