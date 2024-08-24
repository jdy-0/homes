<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@font-face {
    font-family: 'goorm-sans-bold';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2408@1.0/goorm-sans-bold.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}
body{background-color:floralwhite;font-family: 'goorm-sans-bold';}
fieldset{
	width: 80%;
    margin: 100px auto;
    border: 2px solid;
    border-radius: 10px;
    font-size:30px;
}
legend{
	font-size: 30px;
    text-align: center;
}
ul{
	margin: 10px auto;
}
li{
	list-style-type: none;
}
li label{
    width: 30%;
    float: left;
}
div{
	text-align: right;
}
input{
	width: 50%;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid;}
div{text-align:center}
input[type="submit"]{
	background-color:#cd280e;
	border:0;
	color:lemonchiffon;
	font-size:25px;
	font-family: 'goorm-sans-bold';
}
</style>
</head>
<body>
<form name="adminlogin" action="admin_login_ok.jsp">
<fieldset>
	<legend>Login</legend>
	<ul>
		<li><label>ID</label><input type="text" name="userid"></li>
		<li><label>Password</label><input type="password" name="userpwd"></li>
	</ul>
	<div>
		<input type="submit" value="Login">
	</div>
</fieldset>
</form>
</body>
</html>