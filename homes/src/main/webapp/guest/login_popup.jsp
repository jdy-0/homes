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
<body id="login_body">
<section>
<form name="login" action="login_pop_ok.jsp" method="post">
<fieldset>
	<table>
		<tr>
			<th>아이디</th>
			<td><input type="text" name="id" value="<%=saveID%>" class="login_text"></td>
			<td rowspan="2" align="center"><input type="submit" value="Login" class="login_button"></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="pwd" class="login_text"></td>
		</tr>
<%-- 		<tr>
			<td colspan="3" align="center">
			<input type="checkbox" name="saveID" value="on" <%=saveID.equals("")?"":"checked" %> style="width:50px; height:30px;"> ID 기억하기
			</td>
		</tr> --%>
	</table>
	<div>	
		<div style="align-items: center;">
			<input type="checkbox" name="saveID" value="on" <%=saveID.equals("")?"":"checked" %> style="width:50px; height:30px;"> 
			<p>ID 기억하기</p>
		</div>
		<a href="javascript:goTo('findAccount');">ID/비밀번호 찾기</a>
		<a href="/homes/guest/homesJoin.jsp">회원가입</a>
	</div>
</fieldset>
<!-- <div>
	<label>아직 회원이 아니신가요?</label>
	<a href="/homes/guest/homesJoin.jsp">[회원가입]</a>
</div> -->
</form>
</section>
<script>
function goTo(href){
	opener.location.href = '/homes/guest/'+href+'.jsp';
	self.close();
}
</script>
</body>
</html>