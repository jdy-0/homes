<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
String nickname=request.getParameter("nickname");
String email=request.getParameter("email");
String tel=request.getParameter("tel");

int useridx = (Integer)session.getAttribute("useridx");

int result = gdao.updateProfile(useridx, nickname, email, tel);

String msg = (result > 0) ? "수정이 완료되었습니다." : "수정된 내용을 저장하는 데 실패했습니다.";
%>
<script>
window.alert('<%=msg%>');
window.location.href='/homes/guest/myPage.jsp';
</script>