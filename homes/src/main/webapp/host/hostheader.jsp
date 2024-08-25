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
		<li><a href="/homes/host/host_roomSchedule.jsp">휴무 관리</a></li>
		<li><a href="/homes/host/hostmanage.jsp">숙소 스케줄</a></li>
		<li><a href="/homes/host/hostinsert.jsp">숙소 등록 요청</a></li>
				
		<li><a href="/homes/host/hostschedule_veiw_test.jsp">매출 관리</a></li>
	</ul>
</nav>
