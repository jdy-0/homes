<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "com.homes.guest.*" %>
<jsp:useBean id="mdto" class="com.homes.guest.MsgDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#table_msgcontent{
	border:4px solid black;
	border-spacing:0px;
	width:1000px;
	margin:30px auto;
	font-family: 'Ownglyph_meetme-Rg';
}
#table_msgcontent th{
	background-color:#dec022;
	border-right:3px solid black;
	border-bottom:3px solid black;
	width:100px;
	padding:10px;
	font-size:20px;
	color:black;
}
#table_msgcontent td{
	border-bottom:3px solid black;
	padding:10px;
	font-size:20px;
}
.td_nonbottom{
	border-bottom:0px;
	padding:10px;
	font-size:20px;
}
textarea{
	width:950px;
	border:0px;
	background-color:#e2dccc;
	outline:none;
	font-size:20px;
	color:black;
	font-family: 'Ownglyph_meetme-Rg';
}
.button{
	width:80px;
	background-color:#dec022;
	color:black;
	border:3px solid black;
	outline:none;
	padding:5px;
	font-family: 'Ownglyph_meetme-Rg';
	font-size:20px;
}
</style>
</head>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<body>
<%@include file="/header.jsp" %>
<%
String msgidx_s = request.getParameter("msgidx");
if(msgidx_s == null || msgidx_s== ""){
	msgidx_s = "0";
}
int msgidx = Integer.parseInt(msgidx_s);
MsgDTO msgdto = gdao.getMsgContent(msgidx);
%>
<section>
<article>	
	<table id="table_msgcontent">
		<tr>
			<th>보낸사람</th>
			<td><%=msgdto.getSender_id() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=msgdto.getTitle() %></td>
		</tr>
		<tr>
			<td colspan="2" align="center" class="td_nonbottom">
			<textarea rows="20" cols="20" readonly><%=msgdto.getContent() %></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center" class="td_nonbottom">
			<input type="button" value="목록보기" onclick="location.href='msg.jsp?userid=<%=userid%>'" class="button">
			<input type="button" value="답장하기" onclick="location.href='writeMsg.jsp?receiver_id=<%=msgdto.getSender_id()%>'" class="button">
			</td>
		</tr>
	</table>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>