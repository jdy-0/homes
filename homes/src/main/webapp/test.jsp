<%@page import="com.homes.db.HomesDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Connection conn = com.homes.db.HomesDB.getConn();
String sql = " select * from tabs ";
PreparedStatement ps = conn.prepareStatement(sql);
ResultSet rs = ps.executeQuery();
if(rs.next()){
%>
	<%=rs.getString(1) %>
<%
}

rs.close();
ps.close();
conn.close();
%>

</body>
</html>