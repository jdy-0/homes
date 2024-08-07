<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
String userid=request.getParameter("id");
boolean result=gdao.IdCheck(userid);
if(result==true){	//아이디가 이미 존재하는 경우
	%>
	<script>
	window.alert('이미 사용중인 아이디입니다.');
	window.location.href='IdCheck.jsp';
	</script>
	<%
}else{	//해당 아이디 사용 가능
	%>
	<script>
	opener.document.homesJoin.id.value='<%=userid%>';
	window.alert('사용 가능한 아이디입니다.');
	window.self.close();	
	</script>
	<%
}
%>