<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
#mypage_profile{
	width:800px;
	height:70px;
	margin:20px auto;  
}
#mypage_profile fieldset{
	
	display: flex;
	border-radius:100px;
	border:3px solid black;
}
#mypage_profile img{
	width:80px;
	margin-left:20px;
}
#mypage_profile div{
	margin-left:20px;
}
#mypage_list{
	margin:30px auto;
	text-align:center;
}
#mypage_list li{
	list-style-type:none;
	margin-bottom:15px;
}
#mypage_list fieldset{
	border: 1px solid black;
	width:800px;
	height:50px;
	border-radius:100px;
	
}
#mypage_list a{
	margin:10px;
	color:black;
	text-decoration:none;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
	<article id="mypage_profile">
		<fieldset>
			<img src="/homes/img/default_profile.png" alt="profile_image">
			<div>
				<p><%=session.getAttribute("usernickname") %>님</p>
				<a href="msg.jsp">&#128233;</a>
			</div>
		</fieldset>
	</article>
	<article id="mypage_list">
	<ul>
		<li>
		<fieldset>
			<a href="showProfile.jsp?userid=<%=session.getAttribute("userid")%>">계정관리</a>
		</fieldset>
		</li>
		<li>
		<fieldset>
			<a href="#">예약 확인</a>
		</fieldset>
		</li>
		
		<li>
		<fieldset>
			<a href="#">즐겨찾기 목록</a>
		</fieldset>
		</li>
		<li>
		<fieldset>
			<a href="/homes/host/hostmain.jsp">호스팅 관리</a>
		</fieldset>
		</li>
		<li>
		<fieldset>
			<a href="#">고객 지원</a>
		</fieldset>
		</li>
		
	</ul>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>