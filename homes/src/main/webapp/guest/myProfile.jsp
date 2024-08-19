<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "com.homes.guest.*" %>
<!DOCTYPE html>
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
<%
GuestDTO dto = gdao.getUserProfile(userid);
%>
<article id="myProfile" class="myPageContent_ar">
	<fieldset class="label_fs">
		<h3><%=session.getAttribute("usernickname") %>님 계정 정보</h3>
	</fieldset>
	<form name="updateProfile" action="updateProfile.jsp" method="post">
	<table>
	<tr>
		<th>이름</th>
		<td><%=dto.getName() %></td>
	</tr>
	<tr>
		<th>ID</th>
		<td><%=dto.getId() %></td>
	</tr>
	<tr>
		<th>닉네임</th>
		<td>
			<input type="text" name="nickname" value="<%=dto.getNickname() %>" class="textfield" readonly/>
			<input type="button" value="변경하기" class="button">
		</td>
	</tr>
	<tr>
		<th>생년월일</th>
		<td><%=dto.getBday() %></td>
	</tr>
	<tr>
		<th>E-Mail</th>
		<td>
			<input type="text" name="email" value="<%=dto.getEmail() %>" class="textfield" readonly/>
			<input type="button" value="변경하기" class="button">
		</td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td>
			<input type="text" name="tel" value="<%=dto.getTel() %>" class="textfield" readonly/>
			<input type="button" value="변경하기" class="button">
		</td>
	</tr>
	<tr>
		<th>가입날짜</th>
		<td><%=dto.getJoindate() %></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="저장하기" class="button">
		</td>
	</tr>
	</table>
	</form>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>