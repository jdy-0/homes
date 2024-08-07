<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.homes.guest.*" %>
<jsp:useBean id="mdto" class="com.homes.guest.MsgDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
String userid = (String)session.getAttribute("userid");
int result = gdao.sendMsg(mdto);

String msg = result>0 ? "전송완료":"전송실패";
%>
<script>
window.alert('<%=msg%>');
window.location.href='msg.jsp?userid=<%=userid%>';
</script>