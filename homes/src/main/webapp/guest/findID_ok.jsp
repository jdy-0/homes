<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
String name = request.getParameter("name");
String email = request.getParameter("email");

String id = gdao.findId(name, email);
if(id==null){
	%>
	<script>
	window.alert('회원정보가 존재하지 않습니다.');
	location.href='/homes/guest/findAccount.jsp?divId=findID';
	</script>
	<%
}else{
	%>
	<script>
	location.href='/homes/guest/findAccount.jsp?divId=showID&id=<%=id%>';
	<%-- document.getElementById("showID").textContent='ID는 <%=id%>입니다.'; --%>
	</script>
	<%
}
%>