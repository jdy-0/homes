<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
String id = (String)session.getAttribute("userid");
String pwd = request.getParameter("pwd");

int result = gdao.updatePwd(id, pwd);

if(result > 0){
	%>
	<script>
	window.alert('비밀번호가 변경되었습니다.\r로그인 페이지로 이동합니다.');
	location.href='/homes/guest/login.jsp';
	</script>
	<%
}else{
	%>
	<script>
	window.alert('비밀번호 변경 실패');
	location.href='/homes/guest/login.jsp?divId=resetPWD&id=<%=id%>';
	</script>
	<%
}
%>