<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
if(session.getAttribute("userid")==null || session.getAttribute("userid")==""){
%>
<script>
window.location.href='/homes';
</script>
<%
}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
/* #mypage_profile{
	width:800px;
	height:70px;
	margin:20px auto;  
}
#mypage_profile fieldset{
	background-color:#dec022;
	display: flex;
	border:5px solid black;
	font-family: 'SBAggroB';
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
}
#mypage_list a{
	margin:10px;
	color:black;
	text-decoration:none;
} */
section{
	display:flex;
}
#myPageMain{
	width:1000px;
	border-right:5px solid black;
}
#myPageNav{
	width:400px;
}
.label_fs{
	background-color:#dec022;
	color:black;
	border-bottom:5px solid black;
	margin:0px;
	font-family: 'SBAggroB';
}
#myPageMain_fs{
	margin:50px auto;
	width:800px;
	text-align:center;
}
#myPageMain_fs img{ 
	width:150px;
	border:4px solid black;
	border-radius:500px;
	margin:30px;
}
input[type="file"] {display: none;}
</style>
<script>
// 이미지 클릭 시 파일 선택 창 열기
document.getElementById("profileImg").addEventListener("click", function() {
    document.getElementById("fileInput").click();
});

// 파일 선택 시 자동으로 폼 전송
document.getElementById("fileInput").addEventListener("change", function() {
    document.getElementById("uploadForm").submit();
});
</script>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<article id="myPageMain">
	<fieldset class="label_fs">
		<h3><%=session.getAttribute("usernickname") %>님의 페이지</h3>
	</fieldset>
	<div id="myPage_main_div">
		<fieldset id="myPageMain_fs">
		<%
		int useridx=(Integer)session.getAttribute("useridx");
		String img = gdao.getImgSrc(useridx);
		%>
			<img src="<%=img %>" alt="profile_img" id="profileImg">
			<form action="profileUpload.jsp" method="post" enctype="multipart/form-data" id="uploadForm">
            	<input type="file" name="profileImg" id="fileInput" accept="image/*">
        	</form>
			<div>
			
			</div>
		</fieldset>
	</div>
</article>
<article id="myPageNav">
	<fieldset class="label_fs">
		<h3>MENU</h3>
	</fieldset>
</article>
</section>
<%-- <section>
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
			<a href="/homes/guest/reserveHistory.jsp">예약 목록 보기</a>
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
</section> --%>
<%@include file="/footer.jsp" %>
</body>
</html>