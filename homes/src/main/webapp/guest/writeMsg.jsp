<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/msgLayout.css">
</head>
<style>

</style>
<body>
<%@include file="/header.jsp" %>
<section>
<%@include file="/guest/msgNav.jsp" %>
<article class="msgContentArticle">
<!-- <fieldset class="label_fs">
	<h3>메세지 보내기</h3>
</fieldset> -->
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
</section>
<%@include file="/footer.jsp" %>
<script>
function selectedMenu(){
	document.getElementById("writeMsg_a").style.backgroundColor='cornsilk';
	document.getElementById("writeMsg_a").style.color='#cd280e';
	document.getElementById("writeMsg_a").style.borderRadius='200px'; 
	document.getElementById("writeMsg_a").style.opacity='1';
}
window.onload=selectedMenu;
</script>
</body>
</html>