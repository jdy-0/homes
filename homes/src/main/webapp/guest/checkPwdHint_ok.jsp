<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
String id = request.getParameter("id");
String pwd_hint_q = request.getParameter("pwd_hint_q");
String pwd_hint_a = request.getParameter("pwd_hint_a");

boolean result = gdao.findPwd(id, pwd_hint_q, pwd_hint_a);

if(result){
	%>
	<script>
	location.href='findAccount.jsp?divId=resetPWD&id=<%=id%>';
	</script>
	<%
}else{
	%>
	<script>
	window.alert('힌트와 정답이 일치하지 않습니다.');
	location.href='findAccount.jsp?divId=checkPwdHint&id=<%=id%>';
	</script>
	<%
}
%>