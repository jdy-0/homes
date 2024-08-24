<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("useridx")==null || session.getAttribute("useridx")==""){
	%>
	<script>
	window.alert('로그인 후 이용 가능합니다.');
	location.href='/homes';
	</script>
	<%
	return;
}
%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.guest.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/msgLayout.css">
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<%@include file="/guest/msgNav.jsp" %>
<article id="msgList" class="msgContentArticle">
<!-- 	<fieldset class="label_fs">
		<h3>받은 메세지</h3>
	</fieldset>	 -->
	<%
	int crpage = 1;
	int msgSize = 10;
	int pageSize = 5; 
	
	if(request.getParameter("crpage")!=null){
		crpage = Integer.parseInt(request.getParameter("crpage"));
	}
	
	ArrayList<MsgDTO> msgList = gdao.getMsgList(userid, crpage, msgSize, "receiver", "no");
	
	if(msgList==null || msgList.size()==0){
		%>
		<h2>메세지가 없습니다.</h2>
		<%
	}else{
		%>
		<div class="msgFnBar">
			<input type="button" value="읽음" class="btstyle" onclick="setReadState();">
			<input type="button" value="삭제" class="btstyle" onclick="dltMsg();">
		</div>
		<form name="msgList_fm">
		<table class="msgListTable">
		<thead>
		<tr>
			<th><input type="checkbox" class="checkbox" id="checkAll" onclick="checkAllMsg();"></th>
			<th>보낸사람</th>
			<th>제목</th>
			<th>전송시간</th>
			<th>읽음</th>
		</tr>
		</thead>
		<tbody>
		<%
		for(int i=0; i<msgList.size(); i++){
			String readState = (msgList.get(i).getRead_state() == 0) ? "안읽음" : "읽음" ;
			%>
			<tr>
				<td><input type="checkbox" class="checkbox" name="msgCheck" id="ck_<%=i+1%>" data-idx="<%=msgList.get(i).getIdx() %>"></td>
				<td><%=msgList.get(i).getSender_id() %></td>
				<td><a href="msgContent.jsp?msgidx=<%=msgList.get(i).getIdx()%>&crarticle=msgList&crpage=<%=crpage%>"><%=msgList.get(i).getTitle() %></a></td>
				<%
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
			    String formattedDate = sdf.format(msgList.get(i).getSend_time());
				%>
				<td><%=formattedDate.substring(0, 16) %></td>
				<td><%=readState %></td>
			</tr>
			<%
		}
		%>
		</tbody>
		<%
	}
	%>	
	</table>
	</form>
<div class="msgPageNav">
<%
	int totalMsg = gdao.getTotalMsgCount(userid, "receiver");
	int totalPageNum = ((totalMsg-1)/msgSize)+1;
	int startPageNum = ((crpage-1)/pageSize)*pageSize+1;
	int endPageNum = Math.min(startPageNum+pageSize-1, totalPageNum);
	
	if(startPageNum > 1){
		%>
		<a href="/homes/guest/msg.jsp?crpage=<%=startPageNum-1 %>">&lt;&lt; 이전</a>
		<%
	}
	
	for(int i=startPageNum; i<=endPageNum; i++){
		if(i==crpage){
			%><span><%=i%></span><%
		} else{
			%><a href="/homes/guest/msg.jsp?crpage=<%=i%>"><%=i%></a><%
		}
	}
	
	if(endPageNum<totalPageNum){
		%>
		<a href="/homes/guest/msg.jsp?crpage=<%=endPageNum+1 %>">다음&gt;&gt;</a>
		<%
	}
	%>
</div>
</article>
</section>
<%@include file="/footer.jsp" %>
<script>
function selectedMenu(){
	document.getElementById("msgList_a").style.backgroundColor='cornsilk';
	document.getElementById("msgList_a").style.color='#cd280e';
	document.getElementById("msgList_a").style.borderRadius='200px'; 
	document.getElementById("msgList_a").style.opacity='1';
}
window.onload=selectedMenu;
function checkAllMsg(){
	if(document.getElementById("checkAll").checked == true){
		for(var i=0; i<document.msgList_fm.msgCheck.length; i++){
			document.msgList_fm.msgCheck[i].checked=true;
		}
	}else{
		for(var i=0; i<document.msgList_fm.msgCheck.length; i++){
			document.msgList_fm.msgCheck[i].checked=false;
		}
	}
}
function dltMsg(){
	var checkedValues = [];
	for(var i = 1; i<=document.msgList_fm.msgCheck.length; i++){
		var ck = document.getElementById("ck_"+i);
		if(ck && ck.checked){
			var idx = ck.getAttribute("data-idx");
			checkedValues.push(idx);
		}
	}
	
	if(checkedValues.length==0){
		window.alert('체크된 항목 없음');
		return;
	}
	
	//체크됐을때
	var xhr = new XMLHttpRequest();
	xhr.open("POST", "msgDlt_ok.jsp", true);
	xhr.setRequestHeader("Content-Type", "application/json");
	xhr.onload = function (){
		if(xhr.status === 200){	//서버가 200을 띄워주면 처리 성공
			alert('삭제 성공!');
			location.reload();
		} else{
			alert('오류발생.');
		}
	};
	xhr.send(JSON.stringify({dltmsgidx: checkedValues})); //선택된 체크박스 아이디를 제이슨 객체로 전송	
}

function setReadState(){
	var checkedValues = [];
	for(var i=1; i<=document.msgList_fm.msgCheck.length; i++){
		var ck = document.getElementById("ck_"+i);
		if(ck && ck.checked){
			var idx = ck.getAttribute("data-idx");
			checkedValues.push(idx);
		}
	}
	
	//체크된 항목이 없을 때 유효성 검사
	if(checkedValues.length==0){
		window.alert('체크된 항목 없음');
		return;
	}
	
	var xhr = new XMLHttpRequest();
	xhr.open("POST", "setMsgRead_ok.jsp", true);
	xhr.setRequestHeader("Content-Type", "application/json");
	xhr.onload = function(){
		if(xhr.status === 200){
			alert('읽음상태 변경');
			location.reload();
		}else{
			alert('오류발생');
		}
	};
	xhr.send(JSON.stringify({setReadidx: checkedValues}));
}
</script>
</body>
</html>