<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
section{margin: 250px 0px 300px 0px; font-family: 'SBAggroB';}
#findAcc{
	margin:0px auto;
	width:500px;
	border:5px solid black;
/* 	border-radius:50px;
 */}
.fs{
	width:50%;
	text-align:center;
	margin:0px;
	border:0px;
}
.fs a{
	color:black;
	text-decoration:none;
}
#findAcc table{
	margin:20px auto;
	font-size:20px;
}
#findAcc table td{
	padding:5px;
}
.div_content{
	height:500px;
	display: flex;
    align-items: center;    
    justify-content: center;
	font-size:25px;
}
.text{
	border:4px solid black;
	font-family: 'SBAggroB';
	font-size:20px;
	padding:5px;
	width:200px;
}
.btstyle{
	border:4px solid black;
	background-color:#dec022;
	font-family: 'SBAggroB';
	font-size:20px;
	padding:5px;
}
#pwd_hint_q{
	width:250px;
	font-family: 'SBAggroB';
	font-size:18px;
	padding:5px;
	border:4px solid black;
}
</style>
<%
String divId="findID";
if(request.getParameter("divId")!=null){
	divId = request.getParameter("divId");
}
%>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<article id="findAcc">
	<div style="display:flex;">
	<fieldset class="fs" id="fs_findID" style="border-right:5px solid black;">
	<h2><a href="javascript:openDiv('findID');">아이디찾기</a></h2>
	</fieldset>
	<fieldset class="fs" id="fs_findPWD" style="background-color:lightgray; border-bottom:5px solid black;">
	<h2><a href="javascript:openDiv('findPWD');">비밀번호찾기</a></h2>
	</fieldset>
	</div>
	<form name="findID" action="findID_ok.jsp" method="post">
	<div id="findID" class="div_content">
	<table>
	<tr>
		<td>이름</td>
		<td><input type="text" name="name" class="text"></td>
	</tr>
	<tr>
		<td>메일</td>
		<td><input type="text" name="email" class="text"></td>
	</tr>	
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="찾기" class="btstyle">
		</td>
	</tr>	
	</table>
	</div>
	</form>
	<div id="showID" class="div_content" style="display:none;"></div>
	<form name="checkID" action="checkID_ok.jsp" method="post">
	<div id="findPWD" class="div_content" style="display:none;">
	<table>
	<tr>
		<td>아이디</td>
		<td><input type="text" name="id" class="text"></td>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="확인" class="btstyle">
		</td>
	</tr>
	</table>	
	</div>
	</form>
	<div id="showID" class="div_content" style="display:none;"></div>
	<div id="checkPwdHint" class="div_content" style="display:none;">
	<form name="checkPwdHint" action="checkPwdHint_ok.jsp" method="post">
	<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
	<table>
		<tr>
			<td style="width:140px;">비밀번호 힌트</td>
			<td>
			<select name="pwd_hint_q" id="pwd_hint_q">
					<option value="1">가장 감명깊게 본 영화는?</option>
					<option value="2">가장 좋아하는 음식은?</option>
					<option value="3">가장 싫어하는 음식은?</option>
					<option value="4">응원하는 스포츠 팀의 이름은?</option>
					<option value="5">나의 반려동물 이름은?</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>정답</td>
			<td><input type="text" name="pwd_hint_a" class="text"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<input type="submit" value="확인" class="btstyle">
			</td>
		</tr>
	</table>
	</form>
	</div>
	<div id="resetPWD" class="div_content" style="display:none;">
	<form name="resetPwd" onsubmit="return checkResetPwdForm();" action="resetPwd_ok.jsp" method="post">
	<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
	<table>
		<tr>
			<td colspan="2" align="center">
			<h3>비밀번호 재설정</h3>
			</td>
		</tr>
		<tr>
			<td>비밀번호 입력</td>
			<td>
				<input type="password" id="pwd" name="pwd" class="text" onblur="validatePwd();">
				<div id="error-message-pwd" style="color: black; margin-top: 5px; font-size:15px;">영어, 숫자, 특수문자(!, @, ^, *)를 포함한 8~12글자</div>
			</td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td>
				<input type="password" id="pwdck" name="pwdck" class="text" oninput="revalidatePwd();">
				<div id="error-message-pwdCheck" style="color: red; margin-top: 5px; font-size:15px;"></div>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<input type="submit" value="변경하기" class="btstyle">
			</td>
		</tr>
	</table>
	</form>
	</div>
</article>
</section>
<%@include file="/footer.jsp" %>
<script>
function openDiv(divId){
	var divIds = ['findID', 'findPWD', 'showID', 'resetPWD', 'checkPwdHint'];
	
	for(var i=0; i<divIds.length; i++){
		var div = document.getElementById(divIds[i]);
		//var idOrPwd = divIds[i].contains("ID") ? "ID" : "PWD";
			
		//var fsname = "fs_find"+idOrPwd;
		
		//var fs = document.getElementById(fsname);
		
		if(div){
			if(divIds[i] == divId){
				div.style.display="flex";
				//fs.style.borderBottom = "0px"
				//fs.style.backgroundColor="#e2dccc";
			}else{
				div.style.display="none";
				//fs.style.borderBottom = "5px solid black";
				//fs.style.backgroundColor="lightgray";
			}
		}
	}
}
window.onload=function(){
	
	var divId = "<%=divId%>";
	var id = "<%=request.getParameter("id")%>";
	if(!divId){
		
		divId='findID';
	}
	
	openDiv(divId);
	
	if(divId == 'showID' && id){
		
		document.getElementById("showID").textContent = 'ID는 "'+id+'"입니다.';
	}
};
//비밀번호 설정 기준 확인
function validatePwd(){
    var insertPwd = document.resetPwd.pwd.value;
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
	var pwd = document.resetPwd.pwd.value;
	var pwdck = document.resetPwd.pwdck.value;
	
	console.log("pwd: " + pwd + ", pwdck: " + pwdck);
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
function checkResetPwdForm(){
	var valid = true;
	if(!validatePWd()) valid = false;
	if(!revalidatePwd()) valid = false;
	
	return valid;
}
</script>
</body>
</html>