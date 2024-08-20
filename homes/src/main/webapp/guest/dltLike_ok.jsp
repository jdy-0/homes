<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper, com.fasterxml.jackson.core.type.TypeReference" %>
<%@ page import="java.util.*"%>
<%@ page import="java.util.stream.*"%>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");
String json = request.getReader().lines().collect(Collectors.joining());
ObjectMapper mapper = new ObjectMapper();

Map<String, Integer> data = mapper.readValue(json, new TypeReference<Map<String, Integer>>() {});
Integer idx = data.get("dltlikeidx");

if(idx != null){
	gdao.dltLike(idx);
}
%>