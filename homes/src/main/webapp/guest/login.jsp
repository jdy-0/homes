<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
section{margin: 250px 0px 300px 0px;}
h2{
	text-align:center;
	margin-top:50px;
	font-family: 'SBAggroB';
}
#login_table{
	margin: 0px auto;
	font-family: 'SBAggroB';
	border-spacing:0;
	font-size:25px;
}
#login_table th{width:80px; padding:10px;}
#login_table td{padding:10px;}
#login_table td a{color:black; text-decoration:none;}
#login_table td a:hover{text-decoration:underline;}
.textfield{
	border:3px solid black;
	outline:none;
	padding:5px;
	font-family: 'Ownglyph_meetme-Rg';
	font-size:25px;
	width:250px;
}
.btstyle{
	background-color:#dec022;
	font-family: 'SBAggroB';
	font-size:20px;
	padding:8px;
	border:4px solid black;
	height: 107px;
    width: 120px;
    margin-left:10px;
}
.btstyle:hover{
	background-color: #e2dccc;
    transition: 0.5s;
}
.btstyle_small{
	background-color:#dec022;
	font-family: 'SBAggroB';
	font-size:20px;
	padding:8px;
	border:4px solid black;
    width: 100px;
    margin-left:25px;
}
.btstyle_small:hover{background-color: #e2dccc; transition: 0.5s;}
#loginBottom_div{
	text-align:center;
	margin:0px auto;
	font-family: 'Ownglyph_meetme-Rg';
	font-size:25px;
	diplay:flex;
	flex-direction: column;
	width:500px;
}
#findAccount_div{text-align:left;}
#findAccount_div a{color:black;}
#joinMsg_div{
	text-align:left;
	margin:10px auto;
	font-family: 'Ownglyph_meetme-Rg';
}
</style>
</head>
<%
String saveID="";
Cookie cks[]=request.getCookies();
if(cks!=null){
	for(int i=0;i<cks.length;i++){
		if(cks[i].getName().equals("saveID")){
			saveID=cks[i].getValue();
		}
	}
}
%>
<body>
<%@include file="/header.jsp" %>
<section>
<h2>Login</h2>
<form name="login" action="login_ok.jsp" method="post">
	<table id="login_table">
		<tbody>
		<tr>
			<th>ID</th>
			<td><input type="text" name="id" value="<%=saveID%>" class="textfield"></td>
			<td rowspan="2"><input type="submit" value="Login" class="btstyle"></td>
		</tr>
		<tr>
			<th>PWD</th>
			<td><input type="password" name="pwd" class="textfield"></td>
		</tr>
		<tr>
			<td colspan="3" align="center">
				<input type="checkbox" name="saveID" value="on" <%=saveID.equals("")?"":"checked" %>>&nbsp;&nbsp;ID 기억하기
				<input type="button" value="돌아가기" class="btstyle_small" onclick="location.href='/homes'">
			</td>
		</tr>
		</tbody>
	</table>
	<div id="loginBottom_div">
		<div id="findAccount_div">
			<a href="/homes/guest/findAccount.jsp">ID 또는 비밀번호 찾기</a>
		</div>
		<div id="joinMsg_div">
			<label>아직 HOMES의 가족이 아니신가요?</label>
			<a href="/homes/guest/homesJoin.jsp">회원가입</a>
		</div>
	</div>
</form>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>