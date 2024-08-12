<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.guest.*" %>
<jsp:useBean id="mdto" class="com.homes.guest.MsgDTO" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>
<%
if(session.getAttribute("userid")==null || session.getAttribute("userid")==""){
%>
<script>
window.alert('로그인 후 사용 가능한 서비스입니다.');
window.location.href='/homes';
</script>
<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
#msgList_fieldset{
	margin:30px auto;
}
#msgList_fieldset div{
	width:1200px;
	margin:20px auto;
}
#msgList_table{
	margin:30px auto;
	border-spacing:0px;
	width:1200px;
	border:4px solid black;
}
#msgList_table th{
	background-color: #dec022;
	border-bottom: 4px solid black;
	font-family: 'SBAggroB';
	padding:12px;
}
#msgList_sender_th{
	width:200px;
}
#msgList_title_th{
}
#msgList_sendtime_th{
	width:200px;
}
#msgList_readstate{
	width:100px;
}
#msgList_table td{		
	color:black;
	font-family: 'Ownglyph_meetme-Rg';
	padding: 10px;
	font-size:23px;
}

#msgList_table td a{
	color:black;
	text-decoration:none;
}
#msgList_table td a:hover{
	text-decoration:underline;
}
#msgList_table tbody tr:hover{
	background-color:antiquewhite;
}
.btstyle{
	background-color:#dec022;
	font-family: 'SBAggroB';
	font-size:20px;
	padding:8px;
	border:3px solid black;
}
.btstyle:hover{
	background-color: #e2dccc;
    transition: 0.5s;
}
#msgPageNav{
	text-align:center;
	font-family: 'SBAggroB';
}

#msgPageNav span{
	color:black;
}
#msgPageNav a{
	color: darkgray;
}
</style>
</head>
<%
/* String userid = request.getParameter("userid"); */
%>
<body>
<%@include file="/header.jsp" %>
<section>
	<article>
	<fieldset id="msgList_fieldset">
		<div align="right">
			<input type="button" class="btstyle" value="쪽지쓰기" onclick="location.href='writeMsg.jsp'">
		</div>
		<table id="msgList_table">
		<%
		int crpage = 1;
		int msgSize = 10;
		int pageSize = 5;
		
		if(request.getParameter("crpage")!=null){
			crpage=Integer.parseInt(request.getParameter("crpage"));
		}
		ArrayList<MsgDTO> arr = gdao.getMsgList(userid, crpage, msgSize);
		
		if(arr == null || arr.size()==0){
			%>
			<tr>
				<td colspan="3" align="center">메세지 없음</td>
			</tr>
			<%
		}else{
			%>
			<thead>
			<tr>
				<th id="msgList_sender_th">보낸사람</th>
				<th id="msgList_title_th">제목</th>
				<th id="msgList_sendtime_th">전송시간</th>
				<th id="msgList_readstate">읽음</th>
			</tr>
			</thead>
			<tbody>
			<%
			for(int i=0;i<arr.size();i++){
				%>
				<tr>
					<td align="center"><%=arr.get(i).getSender_id() %></td>
					<td><a href="msgContent.jsp?msgidx=<%=arr.get(i).getIdx()%>"><%=arr.get(i).getTitle() %></a></td>
					<td><%=arr.get(i).getSend_time() %></td>
					<%
					int read_state = arr.get(i).getRead_state();
					String state = (read_state == 0) ? "안읽음":"읽음";
					%>
					<td><%=state %></td>
				</tr>
				<%
			}
			%>
			</tbody>
			<%
		}
		%>			
		</table>
	</fieldset>
	</article>
	<article>
	<!-- 페이지 네비게이션 -->
	<div id="msgPageNav">
	<%
	int totalMsg = gdao.getTotalMsgCount(userid);
	int totalPageNum = ((totalMsg-1)/msgSize)+1;
	
	int startPageNum = ((crpage-1)/pageSize)*pageSize  +1;
	int endPageNum = Math.min(startPageNum + pageSize -1, totalPageNum);
	
	if(startPageNum > 1){
		%>
		<a href="/homes/guest/msg.jsp?crpage=<%=startPageNum-1%>">&lt;&lt; 이전</a>
		<%
	}
	
	for(int i = startPageNum; i<=endPageNum; i++){
		if(i == crpage){
			%>
			<span><%=i %></span>
			<%
		} else{
			%>
			<a href="/homes/guest/msg.jsp?crpage=<%=i %>"><%=i %></a>
			<%
		}
	}
	
	if(endPageNum<totalPageNum){
		%>
		<a href="/homes/guest/msg.jsp?crpage=<%=endPageNum + 1 %>">다음&gt;&gt;</a>
		<%
	}
	%>
	</div>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>