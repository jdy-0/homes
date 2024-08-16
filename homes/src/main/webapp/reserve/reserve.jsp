<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="resdao" class="com.homes.guest.ReservationDAO"></jsp:useBean>
<jsp:useBean id="resdto" class="com.homes.guest.ReservationDTO"></jsp:useBean>
<%-- <jsp:setProperty property="*" name="resdto"/>
 --%>
 <jsp:useBean id="resddto" class="com.homes.guest.Reservation_detailDTO"></jsp:useBean>
<%-- <jsp:setProperty property="*" name="resddto"/>
 --%>

<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

int useridx =Integer.parseInt(session.getAttribute("useridx").toString());
resdto.setMember_idx(useridx);
resdto.setRoom_idx(Integer.parseInt(request.getParameter("room_idx")));
resdto.setState("예약대기중");
resdto.setPrice(Integer.parseInt(request.getParameter("totalPrice")));
resdto.setCount(Integer.parseInt(request.getParameter("guest_num")));

java.sql.Date check_in = java.sql.Date.valueOf(request.getParameter("check_in"));
java.sql.Date check_out = java.sql.Date.valueOf(request.getParameter("check_out"));


resdto.setCheck_in(check_in);
resdto.setCheck_out(check_out);
resdto.setRequest(request.getParameter("request"));

resdao.insertReservation(resdto);


%>
<script>
	alert('성공');
</script>