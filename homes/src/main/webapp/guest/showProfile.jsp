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
</head>

<body>
<%@include file="/header.jsp" %>
<%
	String id = (String)session.getAttribute("userid");
	GuestDTO dto = gdao.getUserProfile(id);
%>
<section>
<fieldset>
	<table>
		<tr>
			<th>이름</th>
			<td><%=dto.getName() %></td>
		</tr>
		<tr>
			<th>아이디</th>
			<td><%=dto.getId() %></td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td><%=dto.getNickname() %></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><%=dto.getPwd() %></td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td><%=dto.getBday() %></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><%=dto.getEmail() %></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><%=dto.getTel() %></td>
		</tr>
	</table>
</fieldset>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>