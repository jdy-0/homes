<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <h1><a href="hostmain.jsp">호스트 메인페이지</a></h1> -->
<style>
#host_nav{
	background-color: #cd280e;
    font-family: 'SBAggroB';
    font-size: 25px;
    width:100%;
    margin:30px auto;
    border-radius:10px;
}
#host_nav ul{
	list-style:none;
	display: flex;
	justify-content:space-around;
	padding:30px;
}

#host_nav ul a{
	color:cornsilk;
	text-decoration:none;
	padding:10px;
}
#host_nav ul a:hover{
	background-color:white;
	border-radius:5px;
	opacity:0.5;
	color:#cd280e;
}
</style>
<nav id="host_nav">
	<ul>
		
		<li><a href="/homes/host/hostmain.jsp">숙소 정보 관리</a></li>
		<li><a href="/homes/host/hostbooking.jsp">숙소 예약 승인</a></li>
		<li><a href="/homes/host/host_roomSchedule.jsp">휴무 및 예약 관리</a></li>
		<li><a href="/homes/host/hostmanage.jsp">숙소 스케줄</a></li>
		<li><a href="/homes/host/hostinsert.jsp">숙소 등록 요청</a></li>
	</ul>
</nav>
<%
Integer h_user_idx=0 ;
h_user_idx = session.getAttribute("useridx")==null || session.getAttribute("useridx").equals("")?0:(Integer)session.getAttribute("useridx");
if (h_user_idx == null || h_user_idx == 0) {

%>
    <script>
    alert('로그인 후 이용가능합니다.');
    window.location.href = '/homes/index.jsp';
    </script>
<%
return;
}
%>