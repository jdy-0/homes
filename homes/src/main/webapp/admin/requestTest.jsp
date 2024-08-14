<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>requestTest.jsp</h1>
<h3>사용자의 IP: <%=request.getRemoteAddr() %></h3>
<h3>사용자의 접속port: <%=request.getRemotePort() %></h3>
<h3>사용자의 접속방식: <%=request.getMethod() %></h3>
<h3>서버 ip: <%=request.getServerName() %></h3>
<h3>서버 서비스 port: <%=request.getServerPort() %></h3>
<h3>접속 페이지: <%=request.getRequestURL() %></h3>
<h3>현재 프로젝트 이름: <%= request.getRealPath("/") + "img/no_image.jpg" %></h3>
<h3>현재 프로젝트 절대경로정보: path</h3>
</body>
</html>