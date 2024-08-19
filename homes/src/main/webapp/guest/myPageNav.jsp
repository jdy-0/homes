<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<article id="myPageNav">
	<fieldset class="label_fs">
		<h3>MENU</h3>
	</fieldset>
	<nav>
		<ul id="ul_menu">
			<li><a href="mypage.jsp">My Page</a></li>
			<li><a href="javascript:showSubMenu('ul_account');">&#127960;계정관리</a>
   				<ul id="ul_account" class="ul_submenu" style="display: none;">
        			<li><a href="/homes/guest/myProfile.jsp">나의 정보</a></li>
        			<li><a href="javascript:openPwdCheck();">비밀번호 변경</a></li>
    			</ul>
			</li>
			<li><a href="javascript:showSubMenu('ul_myreserve');">&#127960;나의 예약</a>
    			<ul id="ul_myreserve" class="ul_submenu" style="display: none;">
        			<li><a href="/homes/guest/myReservation.jsp">예약 내역 보기</a></li>
    			</ul>
			</li>
			<li><a href="javascript:showSubMenu('ul_myLike');">&#127960;LIKE</a>
    			<ul id="ul_myLike" class="ul_submenu" style="display: none;">
        			<li><a href="/homes/guest/myLike.jsp">내가 찜한 목록</a></li>
    			</ul>
			</li>
			<li><a href="javascript:showSubMenu('ul_myActivity');">&#127960;나의 활동</a>
    			<ul id="ul_myActivity" class="ul_submenu" style="display: none;">
        			<li><a href="/homes/guest/myReview.jsp">내가 쓴 리뷰</a></li>
        			<li><a href="/homes/guest/reviewToMe.jsp">내가 받은 리뷰</a></li>
        			<li><a href="/homes/guest/msg.jsp">쪽지</a></li>
    			</ul>
			</li>
			<li><a href="/homes/host/hostmain.jsp">&#127960;HOSTING</a></li>
		</ul>
	</nav>
</article>
<script>
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