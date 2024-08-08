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
function openIdCheck(){
	var option='width=500, height=300, resizable=no, top=200, left=470';
	window.open('/homes/guest/IdCheck.jsp','IdCheck',option);
}
function idchk(){
	if(document.homesJoin.id.value==''){
		window.alert('아이디를 입력하세요.');
		return false;
	}else {
		return true;
	}
}
function setBday(){
	var byear = document.homesJoin.byear.value;
	var bmonth01 = document.homesJoin.bmonth.value;
	var bmonth=bmonth01.padStart(2, '0');
	var bdate01 = document.homesJoin.bdate.value;
	var bdate = bdate01.padStart(2, '0');
	
	var bday = byear+'-'+bmonth+'-'+bdate;
	
	document.homesJoin.bday.value=bday;
}
function setTel(){
	var first_tel = document.homesJoin.first_tel.value;
	var middle_tel = document.homesJoin.middle_tel.value;
	var last_tel = document.homesJoin.last_tel.value;
	var tel = first_tel+'-'+middle_tel+'-'+last_tel;

	document.homesJoin.tel.value=tel;
}
</script>
<body>
<%@include file="/header.jsp" %>
<section>
	<fieldset id="fs_join">
	<legend>회원가입</legend>
	<form name="homesJoin" onsubmit="idchk();" action="homesJoin_ok.jsp" method="post">
	<table>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" class="textfield_solo" required="required"></td>
		</tr>
		<tr>
			<th>ID</th>
			<td>
				<div>
				<input type="text" name="id" class="textfield_solo" readonly/>
				<input type="button" value="ID 중복 확인" onclick="openIdCheck();" class="btstyle">
				</div>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="pwd" class="textfield_solo" required="required"></td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td><input type="text" name="nickname" class="textfield_solo" required="required" size="10"></td>
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
				<input type="number" name="bdate" min="1" max="31" class="textfield_with" required="required">&nbsp;일
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
			<input type="text" value="010" name="first_tel" class="textfield_with" required="required">&nbsp;-&nbsp;
			<input type="text" name="middle_tel" class="textfield_with" required="required">&nbsp;-&nbsp;
			<input type="text" name="last_tel" class="textfield_with" required="required">
			<input type="hidden" name="tel">
			</td>
		</tr>
		
	</table>
	<div align="center">
		<input type="reset" value="다시작성" class="btstyle">
		<input type="submit" value="가입" class="btstyle" onclick="setBday(); setTel();">
	</div>
	</form>
	</fieldset>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>