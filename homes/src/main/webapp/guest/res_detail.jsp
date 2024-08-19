<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="refdao" class="com.homes.refund.refundDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int reserve_idx =Integer.parseInt(request.getParameter("reserve_idx"));
String res_state = refdao.checkCanRefund(reserve_idx);
if(!res_state.contains("이용") && !res_state.contains("취소")){
	
%>
<section>
	<article>
		<input type="button" value = "예약취소" onclick="location.href='res_detail_ok.jsp?reserve_idx=<%=reserve_idx %>&res_state=<%=res_state %>'">
	</article>
</section>
<%
}
%>
</body>
</html>