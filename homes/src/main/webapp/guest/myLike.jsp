<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.guest.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/myPageLayout.css">
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<%@include file="/guest/myPageNav.jsp" %>
<article id="myReserveHistory" class="myPageContent_ar">
	<fieldset class="label_fs">
		<h3><%=session.getAttribute("usernickname") %>님이 찜한 HOMES</h3>
	</fieldset>
	<%
	ArrayList<LikeDTO> mylikes = gdao.getMyLike(userid);
	if(mylikes == null || mylikes.size()==0){
		%>
		<div id="noList">
		<h2>아직 찜한 숙소가 없습니다.</h2>
		</div>
		<%
	}else{
		%>
		<div id="list">
			<ul>
			<%
			for(int i=0; i<mylikes.size(); i++){
				%>
				<li>
				<fieldset>
					
				</fieldset>
				</li>
				<%
			}
			%>
			</ul>
		</div>
		<%
	}
	%>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>