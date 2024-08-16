<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.homes.guest.ReservationDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="resdao" class="com.homes.guest.ReservationDAO"></jsp:useBean>

<%

String s_reserve_idx = request.getParameter("reserve_idx");
int reserve_idx = Integer.parseInt(s_reserve_idx);

String state = request.getParameter("state");

String s_room_idx = request.getParameter("room_idx");
int room_idx = Integer.parseInt(s_room_idx);

String s_start = request.getParameter("check_in");
String s_end = request.getParameter("check_out");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
java.util.Date utilDate = null;
utilDate = sdf.parse(s_start);

// java.util.Date를 java.sql.Date로 변환
Date check_in = new Date(utilDate.getTime());
utilDate = sdf.parse(s_end);
Date check_out = new Date(utilDate.getTime());

String s_price = request.getParameter("price");
int price = Integer.parseInt(s_price);

ReservationDTO dto = new ReservationDTO();

dto.setReserve_idx(reserve_idx);
dto.setState(state);
dto.setRoom_idx(room_idx);
dto.setCheck_in(check_in);
dto.setCheck_out(check_out);
dto.setPrice(price);
int count = resdao.updateSetResState(dto);

if(count>0){
%>
<script>
	alert("성공");
	location.href="hostbooking.jsp";
</script>
<%
} else {
%>
	<script>
	alert("실패");
	location.href="hostbooking.jsp";
	</script>
<%
}

%>