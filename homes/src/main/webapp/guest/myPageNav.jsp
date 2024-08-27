<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("useridx")==null || session.getAttribute("useridx")==""){
	%>
	<script>
	window.alert('로그인 후 이용 가능한 서비스입니다.');
	location.href='/homes';
	</script>
	<%
	return;
}
%>
<article id="myPageNav">
	<nav>
		<ul id="ul_menu">
			<!-- <li><a href="mypage.jsp">My Page</a></li> -->
			<li id="manageAccount"><a href="" id="board" class="fa fa-caret-down" aria-hidden="true">계정관리</a>
   				<ul id="ul_account s-d"  class="ul_submenu dropdown" >
        			<li><a href="/homes/guest/myProfile.jsp">나의 정보</a></li>
        			<li><a href="javascript:openPwdCheck();">비밀번호 변경</a></li>
    			</ul>
			</li>
			<li id="manageReservation"><a href="" id="board">나의 예약</a>
    			<ul id="ul_myreserve s-d" class="ul_submenu dropdown">
        			<li><a href="/homes/guest/myReservation.jsp">예약 내역 보기</a></li>
        			<li><a href="/homes/guest/myResereHistory.jsp">지난 여행</a></li>
        			<li><a href="/homes/guest/myCancel.jsp">취소 내역 보기</a></li>
    			</ul>
			</li>
			<li id="manageActivity"><a href="" id="board">나의 활동</a>
    			<ul id="ul_myActivity s-d" class="ul_submenu dropdown">
        			<li><a href="/homes/guest/myReview.jsp">내가 쓴 리뷰</a></li>
        			<li><a href="/homes/guest/myLike.jsp">내가 찜한 목록</a></li>
    			</ul>
			</li>
			<li><a href="/homes/host/hostmain.jsp">HOSTING</a></li>
		</ul>
	</nav>
</article>
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js'></script>
<script>
//메뉴 호버 함수
$(" #board ").click(function () {
   $(" #s-d ").toggleClass('show');
})
function openNewArticle(articleId){
	
	var articles = ['myPageMain', 'myProfile', 'myReserve', 'myLike', 'myReview', 'myReviewToMe'];
	
	for(var i=0;i<articles.length;i++){
		var article = document.getElementById(articles[i]);
		if(article){
			if(articles[i] == articleId){
				article.style.display="block";
			}else{
				article.style.display="none";
			}
		}
	}
}
function showSubMenu(submenuId){
	    var submenu = document.getElementById(submenuId);
	    if (submenu.style.display === "none" || submenu.style.display === "") {
	        submenu.style.display = "block";
	    } else {
	        submenu.style.display = "none";
	    }
}
function openPwdCheck(){
	var option='width=500, height=300, resizable=no, top=200, left=470';
	window.open('/homes/guest/pwdCk_popup.jsp','PwdCheck',option);
}
</script>