<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
li{
	list-style-type: none;
}
li label{
	width: 80px;
	float: left;
}
div{
	text-align: right;
}
</style>
</head>
<body>
<form name="adminlogin" action="admin_login_ok.jsp">
<fieldset style="width: 500px;">
	<legend>Login</legend>
	<ul>
		<li><label>ID</label><input type="text" name="userid"></li>
		<li><label>Password</label><input type="password" name="userpwd"></li>
	</ul>
	<div>
		<input type="submit" value="login">
	</div>
</fieldset>
</form>
</body>
</html>