<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="gdto" class="com.homes.guest.GuestDTO"></jsp:useBean>
<jsp:setProperty property="*" name="gdto"/>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
String email = request.getParameter("email");
boolean sameEmail = gdao.checkSameGuest(email);
if(sameEmail){
	%>
	<script>
	window.alert('이미 등록된 이메일입니다.');
	window.location.href='/homes/guest/homesJoin.jsp';
	</script>
	<%
	return;
}

int result=gdao.homesJoin(gdto);

String msg=result>0?"회원가입을 환영합니다.":"가입실패!";
if(result>0){
	%>
	<script>
	window.alert('회원가입을 환영합니다.');
	window.location.href='/homes';
	</script>
	<%
}else if(result==0){
	%>
	<script>
	window.alert('이미 등록된 이메일입니다.');
	window.location.href='/homes/guest/homesJoin.jsp';
	</script>
	<%
}else{
	%>
	<script>
	window.alert('가입실패!')
	window.location.href='/homes/guest/homesJoin.jsp';
	</script>
	<%
}
%>
