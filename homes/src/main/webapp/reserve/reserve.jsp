<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="rdao" class="com.homes.guest.ReservationDAO"></jsp:useBean>
<jsp:useBean id="rdto" class="com.homes.guest.ReservationDTO"></jsp:useBean>
<jsp:setProperty property="*" name="rdto"/>
<jsp:useBean id="rddto" class="com.homes.guest.Reservation_detailDTO"></jsp:useBean>
<jsp:setProperty property="*" name="rddto"/>


<%
int useridx =Integer.parseInt(session.getAttribute("useridx").toString());
rdto.setMember_idx(useridx);
rdto.setRoom_idx(1);
rdto.setState("예약대기중");
rdto.setPrice(130000);

rdao.insertReservation(rdto);
 
 Date start = new Date(124,8,17);
 Date end = new Date(124,8,20);
%>