<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
</head>
<style>
#writeMsg_table{
	width:1000px;
	border:4px solid black;
	margin:30px auto;
	border-spacing:0px;
	font-family: 'Ownglyph_meetme-Rg';
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
	font-family: 'Ownglyph_meetme-Rg';
	font-size:20px;
	width:800px;
}
textarea{
	border:2px solid black; 
	/* border:0; */
	/* background-color:#e2dccc; */
	font-family: 'Ownglyph_meetme-Rg';
	font-size:20px;
	outline:none;
	width:970px;
}
.btstyle{
	background-color:#dec022;
	font-family: 'SBAggroB';
	font-size:20px;
	padding:8px;
	border:0;
}
.btstyle:hover{
	background-color: #e2dccc;
    transition: 0.5s;
}
</style>
<body>
<%@include file="/header.jsp" %>
<section>
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
</section>
<%@include file="/footer.jsp" %>
</body>
</html>