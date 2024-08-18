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
			<input type="reset" value="다시작성" class="btstyle">
			<input type="submit" value="찾기" class="btstyle">
		</td>
	</tr>	
	</table>
	</div>
	</form>
	<form name="findPWD" action="findPWD_ok.jsp" method="post">
	<div id="findPWD" class="div_content" style="display:none;">
	<table>
	<tr>
		<td>아이디</td>
		<td><input type="text" name="id" class="text"></td>
	</tr>
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
			<input type="reset" value="다시작성" class="btstyle">
			<input type="submit" value="찾기" class="btstyle">
		</td>
	</tr>
	</table>	
	</div>
	</form>
</article>
</section>
<%@include file="/footer.jsp" %>
<script>
function openDiv(divId){
	var divIds = ['findID', 'findPWD'];
	
	for(var i=0; i<divIds.length; i++){
		var div = document.getElementById(divIds[i]);
		var fsname = "fs_"+divIds[i];
		
		var fs = document.getElementById(fsname);
		
		if(div){
			if(divIds[i] == divId){
				div.style.display="flex";
				fs.style.borderBottom = "0px"
				fs.style.backgroundColor="#e2dccc";
			}else{
				div.style.display="none";
				fs.style.borderBottom = "5px solid black";
				fs.style.backgroundColor="lightgray";
			}
		}
	}
}
</script>
</body>
</html>