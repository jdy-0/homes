<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="resdao" class="com.homes.guest.ReservationDAO"></jsp:useBean>
<jsp:useBean id="resdto" class="com.homes.guest.ReservationDTO"></jsp:useBean>
<jsp:useBean id="msgdto" class="com.homes.guest.MsgDTO"></jsp:useBean>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO"></jsp:useBean>
<%-- <jsp:setProperty property="*" name="resdto"/>
 --%>
 <jsp:useBean id="resddto" class="com.homes.guest.Reservation_detailDTO"></jsp:useBean>
<%-- <jsp:setProperty property="*" name="resddto"/>
 --%>

<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

String id = (String)session.getAttribute("userid");

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

msgdto.setContent("예약이 대기중입니다.");

msgdto.setReceiver_id("호수트");
msgdto.setSender_id(id);

int count = resdao.insertReservation(resdto);
String msg = count>0?"예약에 성공하셨습니다.":"시스템 문제로 예약에 실패하셨습니다.";

%>
<script>
	alert('<%=msg%>');
	window.location.href='../index.jsp';
</script>