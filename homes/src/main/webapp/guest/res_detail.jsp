<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
if(session.getAttribute("useridx")==null || session.getAttribute("useridx")==""){
	%>
	<script>
	window.alert('로그인 후 이용 가능한 서비스입니다.');
	locatin.href='/homes';
	</script>
	<%
	return;
}
%>
<jsp:useBean id="refdao" class="com.homes.refund.refundDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/myPageLayout.css">
<style>
.container{
    width: 60%;
    margin: 30px auto;
    border: 3px solid #cd280e;
    border-radius: 10px;
    background-color: floralwhite;
}
.cancelBt{
	background-color:#cd280e;
	border:0;
	font-size:20px;
	padding:10px;
	color:cornsilk;
	border-radius:10px;
	font-family: 'SBAggroB';
	width:150px;
}
.cancelBt:hover{opacity:0.7; transition:0.3s;}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%
int reserve_idx =Integer.parseInt(request.getParameter("reserve_idx"));

HashMap<String, Object> hm = gdao.getReserveInfo(reserve_idx);
%>
<section>
<%@include file="/guest/myPageNav.jsp" %>
<article id="myReserveDetail" class="myPageContent_ar">
	<div class="container">
		<div style="padding:5px 50px;">
			<h2 style="text-align:start;"><%=hm.get("host_nickname") %>님의 숙소</h2>
		</div>
		<div>
			<img src="<%=hm.get("room_img") %>" style="width:90%;">
		</div>
		<div style="display:flex;justify-content: space-between; padding:0 50px;">
			<div style="text-align:start;">
				<p>체크인</p>
				<p><%=hm.get("check_in") %></p>
			</div>
			<hr>
			<div style="text-align:end;">
				<p>체크아웃</p>
				<p><%=hm.get("check_out") %></p>
			</div>
		</div>
		<hr>
		<div style="display:flex; padding:5px 50px;">
			<div style="font-size:30px;">&#128172;</div>
			<div style="text-align:start;">
				<a href="writeMsg.jsp?receiver_id=<%=hm.get("host_id")%>">호스트에게 메세지 보내기</a>
				<p><%=hm.get("host_nickname") %></p>
			</div>		
		</div>
		<hr>
		<div style="display:flex; padding:5px 50px;">
			<div style="font-size:30px;">&#127968;</div>
			<div style="text-align:start;">
				<a href="/homes/rooms/information.jsp?room_idx=<%=hm.get("room_idx")%>">숙소 보기</a>
				<p><%=hm.get("room_name") %></p>
			</div>
		</div>	
		<hr>
		<div style="display:flex; align-items: center; padding:5px 80px; justify-content: space-between;">
			<div style="display:flex;">
				<p>예약상태</p>
				<p>:&nbsp;<%=hm.get("state") %></p>
			</div>
			<%
			String state = (String)hm.get("state");
			if(!state.contains("이용") && !state.contains("취소")){
				%>
				<div>
				<input type="button" value = "예약취소" class="cancelBt" onclick="location.href='res_detail_ok.jsp?reserve_idx=<%=reserve_idx %>&res_state=<%=state %>'">
				</div>
				<%
			}
			%>
		</div>
	</div>
	<div class="container">
		<div style="padding:5px 50px; "><h2 align=left>예약 세부정보</h2></div>
		<hr>
		<div style="display:flex; justify-content:flex-start; padding:5px 50px;">
			<p style="padding-right:50px; font-size:20px;">예약번호</p>
			<p><%=hm.get("reserve_idx") %></p>
		</div>
		<hr>
		<div style="display:flex; padding:5px 50px;">
			<p style="padding-right:50px; font-size:20px;">호스트</p>
			<p><%=hm.get("host_nickname") %>님</p>
		</div>
		<hr>
		<div style="text-align:start; padding:5px 50px;">
			<p style="padding-right:50px; font-size:20px;">금액</p>
			<p><%=hm.get("price") %>원 /박</p>
		</div>
	</div>	
	<div class=container>
		<div style="padding:5px 50px;"><h2 style="text-align:start;">결제정보</h2></div>
		<hr>
		<div style="text-align:start; padding:5px 50px;">
			<p style="padding-right:50px; font-size:20px;">결제한 금액</p>
			<p><%=hm.get("totalprice")%> 원</p>
		</div>
	</div>
		<%-- <%
		String res_state = refdao.checkCanRefund(reserve_idx);
		if(!res_state.contains("이용") && !res_state.contains("취소")){
			%>
			<input type="button" value = "예약취소" onclick="location.href='res_detail_ok.jsp?reserve_idx=<%=reserve_idx %>&res_state=<%=res_state %>'">
			<%
		}
		%> --%>
</article>
</section>

<%@include file="/footer.jsp" %>
</body>
</html>