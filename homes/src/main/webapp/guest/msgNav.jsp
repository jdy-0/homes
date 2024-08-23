<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("useridx")==null){
	%>
	<script>
	window.alert('로그인 후 이용 가능합니다');
	location.href='/homes';
	</script>
	<%
	return;
}
%>
<%@ page import="com.homes.guest.*" %>
<article id="msgNav">
<!-- 	<fieldset class="label_fs" style="text-align:center;">
		<h3>Message</h3>
	</fieldset> -->
	<nav>
		<ul id="ul_msgMenu">
			<li ><a href="/homes/guest/writeMsg.jsp" id="writeMsg_a">메세지 보내기</a></li>
			<li><a href="/homes/guest/msg.jsp" id="msgList_a">메세지 전체</a></li> 
			<%
			String userid_msg = (String)session.getAttribute("userid");
			GuestDAO dao = new GuestDAO();
			
			int totalUnreadMsg = dao.countUnreadMsg(userid_msg);
			%>
			<li><a href="/homes/guest/unreadMsgList.jsp" id="unreadMsg_a">안 읽은 메세지 (<%=totalUnreadMsg %>)</a></li>
			<li><a href="/homes/guest/sendMsgList.jsp" id="sendMstList_a">보낸 메세지</a></li>
		</ul>		
	</nav>
</article>