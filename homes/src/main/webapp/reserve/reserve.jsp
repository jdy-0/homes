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
int useridx =Integer.parseInt(session.getAttribute("useridx").toString());
resdto.setMember_idx(useridx);
resdto.setRoom_idx(1 );
resdto.setState("예약대기중");
resdto.setPrice(130000);

Date start = new Date(124,8,22);
Date end = new Date(124,8,25);
resdto.setCheck_in(start);
resdto.setCheck_out(end);
resdao.insertReservation(resdto);
%>
<script>
	alert('성공');
</script>