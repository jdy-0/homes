<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
if(session.getAttribute("userid")==null || session.getAttribute("userid")==""){
%>
<script>
window.location.href='/homes';
</script>
<%
} else{
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>

section{
	display:flex;
}
#myPageMain{
	width:1150px;
	border-left:5px solid black;
}
#myPageNav{
	width:300px;
}
.label_fs{
	background-color:#dec022;
	color:black;
	border-bottom:5px solid black;
	margin:0px;
	font-family: 'SBAggroB';
	text-align:start;
}
#myPageMain_fs{
	margin:80px auto;
	width:800px;
	text-align:center;
	border:0;
}
#myPageMain_fs img{ 
	width:250px;
	height:250px;
	padding: 20px;
}
#img_div{
	width: 320px;
    height: 320px;
    border: 4px solid black;
    border-radius: 500px;
    margin:30px auto;
}
input[type="file"] {display: none;}
#myPageMain_fs div{
	font-family: 'SBAggroB';
}
#ul_menu{
	display: flex;
    flex-direction: column;
    justify-content: space-evenly;
	list-style:none;
}
#ul_menu li{
	margin:50px 10px 50px 10px;
}
#ul_menu a{
	color:black;
	font-family: 'SBAggroB';
	font-size:25px;
	text-decoration:none;
}
.ul_submenu{
	margin-top:15px 0px 15px 0px;
	list-style:none;
	display:none;
}
.ul_submenu a{
	color:black;
	font-family: 'SBAggroB';
	font-size:10px;
	text-decoration:none;
}
</style>
<script>

// 이미지 클릭 시 파일 선택 창 열기
document.getElementById("profileImg").addEventListener("click", function() {
    document.getElementById("fileInput").click();
});

// 파일 선택 시 자동으로 폼 전송
document.getElementById("fileInput").addEventListener("change", function() {
    document.getElementById("uploadForm").submit();
});
</script>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<article id="myPageNav">
	<fieldset class="label_fs">
		<h3>MENU</h3>
	</fieldset>
	<nav>
		<ul id="ul_menu">
			<li><a href="javascript:openNewArticle('myPageMain');">My Page</a></li>
			<li><a href="javascript:showSubMenu('ul_account');">&#127960;계정관리</a>
   				<ul id="ul_account" class="ul_submenu" style="display: none;">
        			<li><a href="javascript:openNewArticle('myProfile');">나의 정보</a></li>
        			<li><a href="#">비밀번호 변경</a></li>
    			</ul>
			</li>
			<li><a href="javascript:showSubMenu('ul_myreserve');">&#127960;나의 예약</a>
    			<ul id="ul_myreserve" class="ul_submenu" style="display: none;">
        			<li><a href="javascript:openNewArticle('myReserve');">예약 내역 보기</a></li>
    			</ul>
			</li>
			<li><a href="javascript:showSubMenu('ul_myLike');">&#127960;LIKE</a>
    			<ul id="ul_myLike" class="ul_submenu" style="display: none;">
        			<li><a href="javascript:openNewArticle('myLike');">내가 찜한 목록</a></li>
    			</ul>
			</li>
			<li><a href="javascript:showSubMenu('ul_myActivity');">&#127960;나의 활동</a>
    			<ul id="ul_myActivity" class="ul_submenu" style="display: none;">
        			<li><a href="javascript:openNewArticle('myReview');">내가 쓴 리뷰</a></li>
        			<li><a href="javascript:openNewArticle('myReviewToMe');">내가 받은 리뷰</a></li>
        			<li><a href="/homes/guest/msgMain.jsp">쪽지</a></li>
    			</ul>
			</li>
			<li><a href="/homes/host/hostmain.jsp">&#127960;HOSTING</a></li>
		</ul>
	</nav>
</article>
<article id="myPageMain">
	<fieldset class="label_fs">
		<h3><%=session.getAttribute("usernickname") %>님의 페이지</h3>
	</fieldset>
	<div id="myPage_main_div">
		<fieldset id="myPageMain_fs">
		<%
		
		int useridx=(Integer)session.getAttribute("useridx");
		String img = gdao.getImgSrc(useridx);
		%>
			<div id="img_div">
			<img src="<%=img %>" alt="profile_img" id="profileImg">
			</div>
			<form action="profileUpload.jsp" method="post" enctype="multipart/form-data" id="uploadForm">
            	<input type="file" name="profileImg" id="fileInput" accept="image/*">
        	</form>
			<div>
			<%
			int number[] = gdao.getCountandPeriod(useridx);
			int usecount = 0;
			int period = 0;
			if(number!=null && number.length!=0){
				usecount = number[0];
				period = number[1];
			}
			%>
				<h2>나의 이용 횟수:&nbsp;<%=usecount %></h2>
				<h2>HOMES와 함께한 시간:&nbsp;<%=period %>일</h2>
			</div>
		</fieldset>
	</div>
</article>
<%@include file="/guest/myProfile.jsp" %>
<%@include file="/guest/reserveHistory.jsp" %>

</section>
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
</script>
<script>
function showSubMenu(submenuId){
	    var submenu = document.getElementById(submenuId);
	    if (submenu.style.display === "none" || submenu.style.display === "") {
	        submenu.style.display = "block";
	    } else {
	        submenu.style.display = "none";
	    }
}

</script>
<%@include file="/footer.jsp" %>
</body>
</html>
<%} %>
