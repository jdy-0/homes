<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO" scope="session"></jsp:useBean>
<%
	String room_idx_s=request.getParameter("param");
	int room_idx=Integer.parseInt(room_idx_s);
%>

<%
if(room_idx!=0){
	int result=adao.roomStateUpdate(room_idx);
	String msg=result>0 ? "숙소 승인 완료" : "숙소 승인 실패";
	%>
	<script>
	window.alert('<%= msg %>');
	window.location.href='admin_host_accept.jsp';
	</script>
<%
} else {
	int result=adao.roomStateUpdate();
	String msg=result>0 ? "숙소 일괄승인 완료" : "숙소 일괄승인 실패";
	%>
	<script>
	window.alert('<%= msg %>');
	window.location.href='admin_host_accept.jsp';
	</script>
<%
}
%>