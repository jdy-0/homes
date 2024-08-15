<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.guest.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
section{display:flex;}
.label_fs{
	background-color:#dec022;
	color:black;
	border-bottom:5px solid black;
	margin:0px;
	font-family: 'SBAggroB';
	text-align:start;
}
#msgNav{
	width:300px;
	border-right:5px solid black;
	margin:0;
}
.msgContentArticle{
	width: 1150px;
	margin:0;
}
/*전체 메세지 리스트*/
.msgListTable{
	margin:30px auto;
	width:1000px;
	font-family: 'SBAggroB';
	border-spacing:0;
}
.msgListTable th{
	border-top:4px solid black;
	border-bottom:4px solid black;
	background-color:#dec022;
	font-size:25px;
	padding:10px;
}
.msgListTable td{
	font-size:22px;
	padding:10px;
}
.msgListTable td a{color:black; text-decoration:none;}
.msgListTable td a:hover{text-decoration:underline; font-size:23px; padding:0px;}
.msgListTable tbody tr:hover{background-color:white; opacity:0.5;}
/*메세지 보내기*/
#sendMsg{width:100%;}
#writeMsg_table{
	width:1000px;
	border:4px solid black;
	margin:30px auto;
	border-spacing:0px;
	font-family: 'SBAggroB';
}
#writeMsg_table th{
	width:150px;
	background-color:#dec022;
	border-right:3px solid black;
	border-bottom:3px solid black;
	font-size:20px;
	color:black;
	padding:5px;
}
#writeMsg_table td{
	border-bottom:3px solid black;
	font-size:20px;
	padding:5px;
}
.textfield{
	border:2px solid black;
	outline:none;
	padding:4px;
	font-family: 'SBAggroB';
	font-size:20px;
	width:800px;
}
textarea{
	border:2px solid black; 
	/* border:0; */
	/* background-color:#e2dccc; */
	font-family: 'SBAggroB';
	font-size:20px;
	outline:none;
	width:970px;
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
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%
String articleId = "msgList";
if(request.getParameter("articleId")!=null){
	articleId = request.getParameter("articleId");
}
%>
<section>
<article id="msgNav">
	<fieldset class="label_fs">
		<h3>Message</h3>
	</fieldset>
	<nav>
		<ul id="ul_msgMenu">
			<li><a href="/homes/guest/msgMain.jsp?articleId=sendMsg">Send Message</a></li>
			<li><a href="javascript:showSubMenu('ul_gotMsgMenu');">Message Box</a>
				<ul id="ul_gotMsgMenu" style="display:none;">
					<li><a href="/homes/guest/msgMain.jsp?articleId=msgList">전체 보기</a></li> 
					<li><a href="/homes/guest/msgMain.jsp?articleId=unreadMsgList">안읽은 메세지</a></li>
					<li><a href="/homes/guest/msgMain.jsp?articleId=sendMsgList">보낸 메세지</a></li>
				</ul>
			</li>
		</ul>
	</nav>
</article>
<article id="msgList" class="msgContentArticle">
	<fieldset class="label_fs">
		<h3>받은 메세지</h3>
	</fieldset>
	<table class="msgListTable">
	<%
	int crpage = 1;
	int msgSize = 10;
	int pageSize = 5;
	
	if(request.getParameter("crpage")!=null){
		crpage = Integer.parseInt(request.getParameter("crpage"));
	}
	ArrayList<MsgDTO> msgList = gdao.getMsgList(userid, crpage, msgSize, "receiver", "no");
	
	if(msgList == null || msgList.size()==0){
		%>
		<tr>
			<td colspan="4" align="center">받은 메세지가 없습니다</td>
		</tr>
		<%
	}else{
		%>
		<thead>
		<tr>
			<th id="msgList_sender_th" style="width:200px;">보낸사람</th>
			<th id="msgList_title_th">제목</th>
			<th id="msgList_sendtime_th" style="width:200px;">전송시간</th>
			<th id="msgList_readstate_th" style="width:100px;">읽음</th>
		</tr>
		</thead>
		<tbody>
		<%
		for(int i=0; i<msgList.size(); i++){
		%>
		<tr>
			<td align="center"><%=msgList.get(i).getSender_id() %></td>
			<td><a href="msgContent.jsp?msgidx=<%=msgList.get(i).getIdx() %>"><%=msgList.get(i).getTitle() %></a></td>
			<td><%=msgList.get(i).getSend_time() %></td>
			<%
			int read_state = msgList.get(i).getRead_state();
			String state = (read_state == 0) ? "안읽음" : "읽음" ;
			%>
			<td align="center"><%=state %></td>
		</tr>
		<%
		}
		%>
		</tbody>
		<%
	}
	%>
	</table>
	<div id="msgPageNav">
	<%
	int totalMsg = gdao.getTotalMsgCount(userid, "receiver");
	int totalPageNum = ((totalMsg-1)/msgSize)+1;
	int startPageNum = ((crpage-1)/pageSize)*pageSize+1;
	int endPageNum = Math.min(startPageNum+pageSize-1, totalPageNum);
	
	if(startPageNum > 1){
		%>
		<a href="/homes/guest/msgMain.jsp?articleId=msgList&crpage=<%=startPageNum-1 %>">&lt;&lt; 이전</a>
		<%
	}
	
	for(int i=startPageNum; i<=endPageNum; i++){
		if(i==crpage){
			%><span><%=i%></span><%
		} else{
			%><a href="/homes/guest/msgMain.jsp?articleId=msgList&crpage=<%=i%>"><%=i%></a><%
		}
	}
	
	if(endPageNum<totalPageNum){
		%>
		<a href="/homes/guest/msgMain.jsp?articleId=msgList&crpage=<%=endPageNum+1 %>">다음&gt;&gt;</a>
		<%
	}
	%>
	</div>
</article>
<article id="sendMsg" style="display:none;">
<fieldset class="label_fs">
		<h3>메세지 보내기</h3>
</fieldset>
<form name="writeMsg" action="writeMsg_ok.jsp">
	<input type="hidden" name="sender_id" value="<%=userid%>">
	<table id="writeMsg_table"> 
	<tr>
		<th>받는 사람 ID</th>
		<%
		String receiver_id = request.getParameter("receiver_id");
		if(receiver_id==null){
			receiver_id="";
		}
		%>
		<td><input type="text" name="receiver_id" value="<%=receiver_id%>" class="textfield" required="required"></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" class="textfield" required="required"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<textarea rows="20" cols="30" name="content" required="required"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<input type="reset" value="다시 작성" class="btstyle">
		<input type="submit" value="전송" class="btstyle">
		</td>
	</tr>
	</table>
</form>
</article>
<article id="unreadMsgList" style="display:none;">
<h2>안읽은메세지</h2>
<table class="msgListTable">
<%
/* 	int crpage = 1;
	int msgSize = 10;
	int pageSize = 5; */
	crpage = 1;
	
	if(request.getParameter("crpage")!=null){
		crpage = Integer.parseInt(request.getParameter("crpage"));
	}
	ArrayList<MsgDTO> unreadMsgList = gdao.getMsgList(userid, crpage, msgSize, "receiver", "yes");
	
	if(unreadMsgList == null || unreadMsgList.size()==0){
		%>
		<tr>
			<td colspan="4" align="center">받은 메세지가 없습니다</td>
		</tr>
		<%
	}else{
		%>
		<thead>
		<tr>
			<th id="msgList_sender_th" style="width:200px;">보낸사람</th>
			<th id="msgList_title_th">제목</th>
			<th id="msgList_sendtime_th" style="width:200px;">전송시간</th>
			<th id="msgList_readstate_th" style="width:100px;">읽음</th>
		</tr>
		</thead>
		<tbody>
		<%
		for(int i=0; i<unreadMsgList.size(); i++){
		%>
		<tr>
			<td align="center"><%=unreadMsgList.get(i).getSender_id() %></td>
			<td><a href="msgContent.jsp?msgidx=<%=unreadMsgList.get(i).getIdx() %>"><%=unreadMsgList.get(i).getTitle() %></a></td>
			<td><%=unreadMsgList.get(i).getSend_time() %></td>
			<%
			int read_state = unreadMsgList.get(i).getRead_state();
			String state = (read_state == 0) ? "안읽음" : "읽음" ;
			%>
			<td align="center"><%=state %></td>
		</tr>
		<%
		}
		%>
		</tbody>
		<%
	}
	%>
	</table>
	<div id="msgPageNav">
	<%
	int totalUnreadMsg = gdao.countUnreadMsg(userid);
	totalPageNum = ((totalUnreadMsg-1)/msgSize)+1;
	startPageNum = ((crpage-1)/pageSize)*pageSize+1;
	endPageNum = Math.min(startPageNum+pageSize-1, totalPageNum);
	
	if(startPageNum > 1){
		%>
		<a href="/homes/guest/msgMain.jsp?articleId=unreadMsgList&crpage=<%=startPageNum-1 %>">&lt;&lt; 이전</a>
		<%
	}
	
	for(int i=startPageNum; i<=endPageNum; i++){
		if(i==crpage){
			%><span><%=i%></span><%
		} else{
			%><a href="/homes/guest/msgMain.jsp?articleId=unreadMsgList&crpage=<%=i%>"><%=i%></a><%
		}
	}
	
	if(endPageNum<totalPageNum){
		%>
		<a href="/homes/guest/msgMain.jsp?articleId=unreadMsgList&crpage=<%=endPageNum+1 %>">다음&gt;&gt;</a>
		<%
	}
	%>
</article>
<article id="sendMsgList" style="display:none; width:100%;">
<fieldset class="label_fs">
		<h3>보낸 메세지</h3>
</fieldset>
	<table class="msgListTable">
<%
/* 	int crpage = 1;
	int msgSize = 10;
	int pageSize = 5; */
	crpage = 1;
	
	if(request.getParameter("crpage")!=null){
		crpage = Integer.parseInt(request.getParameter("crpage"));
	}
	ArrayList<MsgDTO> sendMsgList = gdao.getMsgList(userid, crpage, msgSize, "sender", "no");
	
	if(sendMsgList == null || sendMsgList.size()==0){
		%>
		<tr>
			<td colspan="4" align="center">받은 메세지가 없습니다</td>
		</tr>
		<%
	}else{
		%>
		<thead>
		<tr>
			<th id="msgList_sender_th" style="width:200px;">받는사람</th>
			<th id="msgList_title_th">제목</th>
			<th id="msgList_sendtime_th" style="width:200px;">전송시간</th>
			<th id="msgList_readstate_th" style="width:100px;">읽음</th>
		</tr>
		</thead>
		<tbody>
		<%
		for(int i=0; i<sendMsgList.size(); i++){
		%>
		<tr>
			<td align="center"><%=sendMsgList.get(i).getSender_id() %></td>
			<td><a href="msgContent.jsp?msgidx=<%=sendMsgList.get(i).getIdx() %>"><%=sendMsgList.get(i).getTitle() %></a></td>
			<td><%=sendMsgList.get(i).getSend_time() %></td>
			<%
			int read_state = sendMsgList.get(i).getRead_state();
			String state = (read_state == 0) ? "안읽음" : "읽음" ;
			%>
			<td align="center"><%=state %></td>
		</tr>
		<%
		}
		%>
		</tbody>
		<%
	}
	%>
	</table>
	<div id="msgPageNav">
	<%
	int totalSendMsg = gdao.getTotalMsgCount(userid, "sender");
	totalPageNum = ((totalSendMsg-1)/msgSize)+1;
	startPageNum = ((crpage-1)/pageSize)*pageSize+1;
	endPageNum = Math.min(startPageNum+pageSize-1, totalPageNum);
	
	if(startPageNum > 1){
		%>
		<a href="/homes/guest/msgMain.jsp?articleId=sendMsgList&crpage=<%=startPageNum-1 %>">&lt;&lt; 이전</a>
		<%
	}
	
	for(int i=startPageNum; i<=endPageNum; i++){
		if(i==crpage){
			%><span><%=i%></span><%
		} else{
			%><a href="/homes/guest/msgMain.jsp?articleId=sendMsgList&crpage=<%=i%>"><%=i%></a><%
		}
	}
	
	if(endPageNum<totalPageNum){
		%>
		<a href="/homes/guest/msgMain.jsp?articleId=sendMsgList&crpage=<%=endPageNum+1 %>">다음&gt;&gt;</a>
		<%
	}
	%>
	</div>
</article>
</section>
<script>
function showSubMenu(submenuId){
    var submenu = document.getElementById(submenuId);
    if (submenu.style.display === "none" || submenu.style.display === "") {
        submenu.style.display = "block";
    } else {
        submenu.style.display = "none";
    }
}
function openNewArticle(){
	var articles = ['sendMsg', 'msgList', 'unreadMsgList', 'sendMsgList'];
	
	for(var i=0; i<articles.length; i++){
		var article = document.getElementById(articles[i]);
		if(article){
			if(articles[i] == '<%=articleId%>'){
				article.style.display="block";
			}else{
				article.style.display="none";
			}
		}
	}	
}
window.onload = openNewArticle;
</script>
<%@include file="/footer.jsp" %>
</body>
</html>