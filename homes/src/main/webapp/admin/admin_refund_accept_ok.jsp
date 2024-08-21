<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO" scope="session"></jsp:useBean>
<%
	String reserve_idx_s=request.getParameter("param");
	int reserve_idx=Integer.parseInt(reserve_idx_s);
%>

<%
if(reserve_idx!=0){
	int rfresult=adao.refundStatusUpdate(reserve_idx);
	int pmresult=adao.paymentStatusUpdate(reserve_idx);
	String msg=(rfresult>0 && pmresult>0) ? "환불 승인 완료" : "환불 승인 실패";
	%>
	<script>
	window.alert('<%= msg %>');
	window.location.href='admin_refund_accept.jsp';
	</script>
<%
} else {
	%>
	<script>
	window.alert('환불 일괄 승인 예정(아마)');
	window.location.href='admin_refund_accept.jsp';
	</script>
	<%
}
%>