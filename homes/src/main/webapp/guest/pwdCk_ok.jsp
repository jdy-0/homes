<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
String pwd = request.getParameter("pwd");
String id = (String)session.getAttribute("userid");
boolean result = gdao.pwdCheck(id, pwd);
String msg = result ? "확인되었습니다." : "비밀번호가 일치하지 않습니다.";
String href = result ? "/homes/guest/updatePwd.jsp" : "/homes/guest/mypage.jsp";
%>
<script>
window.alert('<%=msg%>');
opener.window.location.href='<%=href%>';
self.close();
</script>