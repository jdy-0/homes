<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO"></jsp:useBean> 
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO"></jsp:useBean>
<%
	String likeidx_s=request.getParameter("likeidx");
	int likeidx=Integer.parseInt(likeidx_s);
	
	int result=gdao.dltLike(likeidx);
	
	//String msg=(result>0) ? "like 삭제 완료" : "like 삭제 실패";
%>
<script>
<%--window.alert('<%=msg %>');--%>
window.location.href='index.jsp'

</script>