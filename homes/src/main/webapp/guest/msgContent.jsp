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
header{
	display:none;
}
footer{
	display:none;
}
textarea{
	width:95%;
	border:0px;
	background-color:white;
	outline:none;
	font-size:20px;
	color:black;
	font-family: 'SBAggroB';
	border-radius:0;	
}
#msgContent{
	border: 3px solid palegoldenrod;
	background-color:floralwhite;
	margin:100px auto;
	border-radius:10px;
	padding:20px;
}
#msgContent h2{
    text-align: start;
    font-size: 30px;
    width: 95%;
    margin: 10px auto;
}
#msgInfo{
	display:flex;
	font-size:20px;
	width: 95%;
    margin: 10px auto;
}
.userid_div{
	display:flex;
	width:50%;
}
.btstyle{
	width:48%;
}
</style>
</head>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/msgLayout.css">
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
<%-- <%@include file="/guest/msgNav.jsp" %> --%>
<article id="msgContent" class="msgContentArticle">
	<h2>Title : <%=msgdto.getTitle() %></h2>
	<div id="msgInfo">
		<div class="userid_div">
			<p>보낸사람 : </p>
			<p><%=msgdto.getSender_id() %></p>
		</div>
		<div class="userid_div">
			<p>받는사람 : </p>
			<p><%=msgdto.getReceiver_id() %></p>
		</div>
	</div>
	<div style="text-align:center;">
		<textarea rows="20" cols="20" readonly><%=msgdto.getContent() %></textarea>
	</div>
	<div style="width:95%; margin:10px auto; text-align:center;">
		<%
			String crarticle=request.getParameter("crarticle");
			String href = "";
			if("msgList".equals(crarticle)){
				href="msg.jsp";
			}else if("sendMsgList".equals(crarticle)){
				href="sendMsgList.jsp";
			}else if("unreadMsgList".equals(crarticle)){
				href="unreadMsgList.jsp";
			}else{
				href="msg.jsp";
			}
			int crpage=1;
			if(request.getParameter("crpage")!=null ){
				crpage = Integer.parseInt(request.getParameter("crpage"));
			}
			%>
		<input type="button" value="목록보기" onclick="location.href='<%=href %>?userid=<%=userid%>&crpage=<%=crpage %>'" class="btstyle">
		<input type="button" value="답장하기" onclick="location.href='writeMsg.jsp?receiver_id=<%=msgdto.getSender_id()%>'" class="btstyle">
	</div>
	<%-- <table id="table_msgcontent">
		<tr>
			<th>보낸사람</th>
			<td><p><%=msgdto.getSender_id() %></p></td>
			<th>받는사람</th>
			<td><p><%=msgdto.getReceiver_id() %></p></td>
		</tr>
		<tr>
			<td colspan="4" align="center" class="td_nonbottom">
			<textarea rows="20" cols="20" readonly><%=msgdto.getContent() %></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center" class="td_nonbottom">
			<%
			String crarticle=request.getParameter("crarticle");
			String href = "";
			if("msgList".equals(crarticle)){
				href="msg.jsp";
			}else if("sendMsgList".equals(crarticle)){
				href="sendMsgList.jsp";
			}else if("unreadMsgList".equals(crarticle)){
				href="unreadMsgList.jsp";
			}else{
				href="msg.jsp";
			}
			int crpage=1;
			if(request.getParameter("crpage")!=null ){
				crpage = Integer.parseInt(request.getParameter("crpage"));
			}
			%>
			<input type="button" value="목록보기" onclick="location.href='<%=href %>?userid=<%=userid%>&crpage=<%=crpage %>'" class="btstyle">
			<input type="button" value="답장하기" onclick="location.href='writeMsg.jsp?receiver_id=<%=msgdto.getSender_id()%>'" class="btstyle">
			</td>
		</tr>
	</table> --%>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>