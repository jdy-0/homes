<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/hostMainLayout.css">
<style>
#contentWrapper ul{
	width:200px;
	height: 100px;
}


</style>
</head>
<body>
<%@ include file="/header.jsp" %>
<%@ include file="hostheader.jsp" %>

<section>
    <div id="contentWrapper">
        <article id="booking">
            <h2>강원도 오션뷰 숙소</h2><!--db숙소 제목 -->
            <ul>
                <li>인원 : 3인</li>
                <li>요청 사항 :
                    <label>오후 4시쯤 도착할 것 같아요.
                        바베큐 준비 해주세요~~
                       	
                    </label>
                </li>
            </ul>
        </article>
		 
        <article id="calendarart">
         <input type="date">
         필요 sql<br>
         예약 번호, host 번호, 방 번호로 매칭
        </article>
         <article id="buttonart">
         	<ul>
           		<li><input type="button" value="수락"></li>
           		<li><input type="button" value="거절"></li>
           </ul>
        </article>
	</div>
	
    <div id="hr">
        <!-- hr 요소를 추가하려면 아래에 넣으세요 -->
    </div>
    <hr>
    <h2>----------db연동 후 for문으로 쏴줘야 할듯----------------------------------</h2>
</section>
</body>
</html>
