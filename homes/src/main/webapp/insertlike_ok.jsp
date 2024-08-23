<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO"></jsp:useBean> 
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO"></jsp:useBean>
<%
	int useridx=(Integer)session.getAttribute("useridx");
	String roomidx_s=request.getParameter("roomidx");
	int roomidx=Integer.parseInt(roomidx_s);

	int result=gdao.addLike(useridx, roomidx);
	
	//String msg=(result>0) ? "like 추가 완료" : "like 추가 실패";
%>
<script>
<%--window.alert('<%=msg %>');--%>
window.location.href='index.jsp'

</script>