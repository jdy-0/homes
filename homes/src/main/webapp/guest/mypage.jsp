<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/myPageLayout.css">
<!-- <script>

// 이미지 클릭 시 파일 선택 창 열기
document.getElementById("profileImg").addEventListener("click", function() {
    document.getElementById("fileInput").click();
});

// 파일 선택 시 자동으로 폼 전송
document.getElementById("fileInput").addEventListener("change", function() {
    document.getElementById("uploadForm").submit();
});
</script> -->
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<%@include file="myPageNav.jsp" %>
<article id="myPageMain" class="myPageContent_ar">
	<fieldset class="label_fs">
		<h3><%=session.getAttribute("usernickname") %>님의 페이지</h3>
	</fieldset>
	<div id="myPage_main_div">
		<fieldset id="myPageMain_fs">
		<%	
		int useridx=(Integer)session.getAttribute("useridx");
		String img = gdao.getImgSrc(useridx);
		%>
			<div id="img_div">
			<img src="<%=img %>" alt="profile_img" id="profileImg">
			</div>
			<form action="profileUpload.jsp" method="post" enctype="multipart/form-data" id="uploadForm">
            	<input type="file" name="profileImg" id="fileInput" accept="image/*">
        	</form>
			<div>
			<%
			int number[] = gdao.getCountandPeriod(useridx);
			int usecount = 0;
			int period = 0;
			if(number!=null && number.length!=0){
				usecount = number[0];
				period = number[1];
			}
			%>
				<h2>나의 이용 횟수:&nbsp;<%=usecount %></h2>
				<h2>HOMES와 함께한 시간:&nbsp;<%=period %>일</h2>
			</div>
		</fieldset>
	</div>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>

