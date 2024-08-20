<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="refdao" class="com.homes.refund.refundDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/myPageLayout.css">
</head>
<body>
<%@include file="/header.jsp" %>
<%
int reserve_idx =Integer.parseInt(request.getParameter("reserve_idx"));

HashMap<String, Object> hm = gdao.getReserveInfo(reserve_idx);
%>
<section>
<%@include file="/guest/myPageNav.jsp" %>
<article id="myReserve" class="myPageContent_ar">
	<fieldset class="label_fs">
		<h3>예약 상세 내역</h3>
	</fieldset>
	<div style="width:60%; margin:30px auto; border:5px solid black;">
		<div style="background-color:#dec022; padding:1px 10px; border-bottom:5px solid black;">
			<h2><%=hm.get("host_nickname") %>님의 숙소</h2>
		</div>
		<div style="text-align:center; padding:20px 0px;">
			<img src="<%=hm.get("room_img") %>" style="width:80%;">
		</div>
		<div style="display:flex; justify-content: space-between;">
			<div>
				<p>체크인</p>
				<p><%=hm.get("check_in") %></p>
			</div>
			<hr>
			<div>
				<p>체크아웃</p>
				<p><%=hm.get("check_out") %></p>
			</div>
		</div>
		<hr>
		<div style="display:flex;">
			<div style="font-size:30px;">&#128172;</div>
			<div>
				<a href="writeMsg.jsp?receiver_id=<%=hm.get("host_id")%>">호스트에게 메세지 보내기</a>
				<p><%=hm.get("host_nickname") %></p>
			</div>		
		</div>
		<hr>
		<div style="display:flex;">
			<div style="font-size:30px;">&#127968;</div>
			<div>
				<a href="/homes/rooms/information.jsp?room_idx=<%=hm.get("room_idx")%>">숙소 보기</a>
				<p><%=hm.get("room_name") %></p>
			</div>
		</div>	
		<hr>
		<div style="display:flex; align-items: center;">
			<div>
				<p>예약상태</p>
				<p><%=hm.get("state") %></p>
			</div>
			<%
			String state = (String)hm.get("state");
			if(!state.contains("이용") && !state.contains("취소")){
				%>
				<div>
				<input type="button" value = "예약취소" onclick="location.href='res_detail_ok.jsp?reserve_idx=<%=reserve_idx %>&res_state=<%=state %>'">
				</div>
				<%
			}
			%>
		</div>
	</div>
	<div style="width:60%; margin:30px auto; border:5px solid black;">
		<div style="background-color:#dec022; padding:1px 10px; border-bottom:5px solid black;"><h2>예약 세부정보</h2></div>
		<div>
			<p>게스트</p>
			<p> 명</p>
		</div>
		<hr>
		<div>
			<p>예약번호</p>
			<p><%=hm.get("reserve_idx") %></p>
		</div>
		<hr>
		<div>
			<p>호스트</p>
			<p><%=hm.get("host_nickname") %>님</p>
		</div>
		<hr>
		<div>
			<p>금액</p>
			<p><%=hm.get("price") %>원 /박</p>
		</div>
	</div>	
	<div style="width:60%; margin:30px auto; border:5px solid black;">
		<div style="background-color:#dec022; padding:1px 10px; border-bottom:5px solid black;"><h2>결제정보</h2></div>
		<div>
			<p>결제한 금액</p>
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