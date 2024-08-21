<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO" scope="session"></jsp:useBean>
<%
	String member_idx_s=request.getParameter("param");
	int member_idx=Integer.parseInt(member_idx_s);
%>

<%
	int result=adao.memberStateBlock(member_idx);
	String msg=result>0 ? "회원 차단 완료" : "회원 차단 실패";
%>
<script>
window.alert('<%= msg %>');
window.location.href='admin_member_report.jsp';
</script>
