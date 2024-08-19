<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
String id = request.getParameter("id");

boolean result = gdao.IdCheck(id);

if(result){
	%>
	<script>
	location.href='findAccount.jsp?divId=checkPwdHint&id=<%=id%>';
	</script>
	<%
}else{
	%>
	<script>
	window.alert('존재하지 않는 ID입니다.');
	location.href='findAccount.jsp?divId=findPWD';
	</script>
	<%
}
%>