<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <h1><a href="hostmain.jsp">호스트 메인페이지</a></h1> -->
<style>
#host_nav{
	background-color: #dec022;
    padding: 8px;
    font-family: 'SBAggroB';
    font-size: 25px;
    border-right: 5px solid black;
    width:300px;
}
#host_nav ul{
	list-style:none;
	display: flex;
    flex-direction: column;
    padding: 30px;
}
#host_nav ul li{
	padding-bottom:30px;
}
#host_nav ul a{
	color:black;
	text-decoration:none;
	
}
#host_nav ul a:hover{
	text-decoration:underline;
}
</style>
<nav id="host_nav">
	<ul>
		
		<li><a href="/homes/host/hostmain.jsp">숙소 관리</a></li>
		<li><a href="/homes/host/hostbooking.jsp">예약 관리</a></li>
		<li><a href="/homes/host/host_roomSchedule.jsp">휴무 관리</a></li>
		<li><a href="/homes/host/hostmanage.jsp">숙소 이용 현황</a></li>
		<li><a href="/homes/host/hostinsert.jsp">숙소 등록 요청</a></li>		
		<li><a href="#">매출 관리</a></li>
	</ul>
</nav>
