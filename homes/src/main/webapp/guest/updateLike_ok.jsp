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

Map<String, Object> data = mapper.readValue(json, new TypeReference<Map<String, Object>>() {});
String action = (String)data.get("action");
String useridx_s = (String)data.get("useridx");

String roomidx_s = (String)data.get("roomidx");

String likeidx_s = (String)data.get("likeidx");


if("like".equals(action)){
	if(useridx_s != null && roomidx_s !=null){
		int useridx = Integer.parseInt(useridx_s);
		int roomidx = Integer.parseInt(roomidx_s);
		gdao.addLike(useridx, roomidx);
	}
}else if("unlike".equals(action)){
	if(likeidx_s!=null){
		int likeidx = Integer.parseInt(likeidx_s);
		gdao.dltLike(likeidx);
	}
}
%>