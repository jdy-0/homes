<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
String userid=request.getParameter("userid");
String userpwd=request.getParameter("userpwd");

if(userid.equals("admin") && userpwd.equals("0000")){		

	//session.setAttribute("aid", userid);
	//session.setAttribute("apwd", userpwd);
	Cookie loginCk=new Cookie("login","login");
	loginCk.setMaxAge(60*60);	
	response.addCookie(loginCk);
	%>
	<script>
	window.alert('<%=userid %>님 환영합니다');
	opener.window.location.reload();
	window.self.close();
	</script>
	<%
}else{
	%>
	<script>
	window.alert('아이디 또는 비밀번호가 잘못되었습니다');
	location.href='admin_login.jsp';
	</script>
<%
}
%>