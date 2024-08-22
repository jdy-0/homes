<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
String crpage="/homes";
if(request.getParameter("crpage")!=null && request.getParameter("crpage")!=""){
	crpage = request.getParameter("crpage");
}
%>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
</head>
<script>
function goToJoin(){
	opener.location.href='<%=crpage%>';
	self.close();
}
</script>
<%
String saveID="";
Cookie cks[]=request.getCookies();
if(cks!=null){
	for(int i=0;i<cks.length;i++){
		if(cks[i].getName().equals("saveID")){
			saveID=cks[i].getValue();
		}
	}
}
%>
<body>
<section>
<form name="login" action="login_pop_ok.jsp" method="post">
<fieldset>
	<legend>로그인</legend>
	<table>
		<tr>
			<th>아이디</th>
			<td><input type="text" name="id" value="<%=saveID%>"></td>
			<td rowspan="2" align="center"><input type="submit" value="Login" class="button"></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="pwd"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<input type="checkbox" name="saveID" value="on" <%=saveID.equals("")?"":"checked" %>> ID 기억하기
			<input type="button" value="닫기" onclick="window.close();">
			</td>
		</tr>
	</table>
</fieldset>
</form>
<div>
	<label>아직 회원이 아니신가요?</label>
	<a href="/homes/guest/homesJoin.jsp">[회원가입]</a>
</div>
</section>
</body>
</html>