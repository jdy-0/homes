<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "com.homes.guest.*" %>
<style>
#myProfile{
	font-family: 'SBAggroB';
	width:1000px;
	border-right:5px solid black;
}
#myProfile table{
	margin: 100px 140px 20px;
    /* width: 800px; */
}
#myProfile table th{
	width:200px;
	font-size:25px;
	padding:15px;
}
#myProfile table td{
	font-size:23px;
	padding:15px;
}
.textfield{
	width:280px;
	padding:15px;
	font-size:20px;
	font-family: 'SBAggroB';
	outline:none;
	border:4px solid black;
}
.button{
	width:100px;
	padding:10px;
	font-size:20px;
	background-color:#dec022;
	color:black;
	font-family: 'SBAggroB';
	border:4px solid black;
	margin:10px;
}
.button:hover{
	background-color:#dec022;
}
</style>
<%
String id = (String)session.getAttribute("userid");
GuestDAO dao = new GuestDAO();
GuestDTO dto = dao.getUserProfile(id);
%>
<article id="myProfile" style="display:none;">
	<fieldset class="label_fs">
		<h3><%=session.getAttribute("usernickname") %>님 계정 정보</h3>
	</fieldset>
	<form name="updateProfile" action="updateProfile.jsp" method="post">
	<table>
	<tr>
		<th>이름</th>
		<td><%=dto.getName() %></td>
	</tr>
	<tr>
		<th>ID</th>
		<td><%=dto.getId() %></td>
	</tr>
	<tr>
		<th>닉네임</th>
		<td>
			<input type="text" name="nickname" value="<%=dto.getNickname() %>" class="textfield" readonly/>
			<input type="button" value="변경하기" class="button">
		</td>
	</tr>
	<tr>
		<th>생년월일</th>
		<td><%=dto.getBday() %></td>
	</tr>
	<tr>
		<th>E-Mail</th>
		<td>
			<input type="text" name="email" value="<%=dto.getEmail() %>" class="textfield" readonly/>
			<input type="button" value="변경하기" class="button">
		</td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td>
			<input type="text" name="tel" value="<%=dto.getTel() %>" class="textfield" readonly/>
			<input type="button" value="변경하기" class="button">
		</td>
	</tr>
	<tr>
		<th>가입날짜</th>
		<td><%=dto.getJoindate() %></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" value="돌아가기" class="button">
			<input type="submit" value="저장하기" class="button">
		</td>
	</tr>
	</table>
</form>
</article>
