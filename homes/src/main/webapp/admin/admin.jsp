<%@page import="com.homes.room.RoomDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO"></jsp:useBean>
<%
if(session.getAttribute("aid")==null || !(session.getAttribute("aid").equals("admin"))){
	%>
	<script>
	window.alert('로그인 후 이용 가능합니다.');
	//location.href='/homes/admin/admin_login.jsp;
	window.open('/homes/admin/admin_login.jsp','adminlogin','width=550,height=350');
	</script>
	<%
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="../css/adminLayout.css">
</head>
<body>
<%@ include file="adminheader.jsp"%>
<section>
<article>
<fieldset class="title">
<h2>관리자페이지</h2>
</fieldset>
</article>
<article class="adminContent">
<%@include file="adminSideBar.jsp" %>
<fieldset class="fs_adminContent">
	<div >
	    <h1>대시보드</h1>
	    <%
	    int guestcnt=adao.guestCount();
	    int guestcntok=adao.guestCountOk();
	    %>	    
	    <div class="card">
	        <h2>회원 통계</h2>
	        <p>총 회원 수: <%=guestcnt %>명</p>
	        <p>활성 회원 수: <%=guestcntok %>명</p>
	    </div>
	    
	    <div class="card">
	        <h2>호스트 통계</h2>
	        <p>총 호스트 수: ?명</p>
	        <p>활성 호스트 수: ?명</p>
	    </div>
	    <%
	    int regioncnt=adao.regionCount();
	    int regiondtcnt=adao.regionDetailCount();
	    %>
	    <div class="card">
	        <h2>지역 통계</h2>
	        <p>총 지역 수: <%=regioncnt %>개</p>
	        <p>지역 대분류 수: <%=regiondtcnt %>개</p>
	    </div>
	    <%
	    int reviewcnt=adao.reviewCount();
	    int reviewrmcnt=adao.reviewroomCount();
	    %>
	    <div class="card">
	        <h2>후기 통계</h2>
	        <p>총 후기 수: <%=reviewcnt %>개</p>
	        <p>후기가 등록된 숙소 수: <%=reviewrmcnt %>개</p>
	    </div>
	    <%
	    int roomcnt=adao.roomCount();
	    int roomcntok=adao.roomCountOk();
	    %>
	    <div class="card">
	        <h2>숙소 통계</h2>
	        <p>총 숙소 수: <%=roomcnt %>개</p>
	        <p>승인된 숙소 수: <%=roomcntok %>개</p>
	    </div>
	    <%
	    int reservecnt=adao.reserveCount();
	    int reservecntyet=adao.reserveCountYet();
	    int reservecntfin=adao.reserveCountFinish();
	    %>
	    <div class="card">
	        <h2>예약 현황</h2>
	        <p>총 예약: <%=reservecnt %>건</p>
	        <p>예약대기중인 예약: <%=reservecntyet %>건</p>
	        <p>예약완료된 예약: <%=reservecntfin %>건</p>
	        <!--
	        <p>오늘의 예약: ?건</p>
	        <p>이번 주 예약: ?건</p>
	        <p>이번 달 예약: ?건</p>
	        -->
	    </div>
	    
	    <div class="card">
	        <h2>QNA 통계</h2>
	        <p>총 QNA 수: ?개</p>
	        <p>활성 QNA 수: ?개</p>
	    </div>
	</div>
</fieldset>
</article>
</section>
<%@ include file="../footer.jsp"%>
</body>
</html>