<%@page import="com.homes.room.RoomDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO"></jsp:useBean>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/mainLayout.css">
<style>
.admin{
	display: flex;
    align-items: stretch;
    padding: 0;
    margin: 0;
    border-bottom: 5px solid black;
    width: 100%;
    height: auto;
    font-family: 'SBAggroB';
}
.title{
	background-color:#dec022;
	color:black;
	border-bottom:5px solid black;
	margin:0px;
	font-family: 'SBAggroB';
}
.sidebar {
    width: 200px;
    background-color: #333;
    color: white;
    padding: 20px;
}
.sidebar a {
    color: white;
    text-decoration: none;
    display: block;
    margin: 10px 0;
}
.content {
    flex-grow: 1;
    padding: 20px;
}
.card {
    background-color: #f4f4f4;
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 5px;
}
</style>
<style>

.buttons>button {
	font-weight: bold; 
	margin-top: 10px;
	margin-right: 8px; 
	margin-bottom: 8px; 
	height: 45px;
	width : 90px;
}

.card_cover {
	display: flex;
	margin-top: 20px;
}

.card_cover .rg_img {
	cursor: pointer;
	border: 1px solid #ccc;
	width: 300px;
	height: 200px;
	position: relative;
	background-image: url('<%= request.getContextPath() %>/img/no_image.jpg');
	background-size: contain;  
    background-repeat: no-repeat;  
    background-position: center;
}

img {
	max-width: 100%;
 	max-height: 100%;
}

.card_cover .rg_value {
	padding : 10px;
}
</style>
<script>
function loadImage(reader) {
    var output = document.querySelector('.rg_img');
    output.style.backgroundImage = 'url(' + reader.result + ')';
}
function selectImage(event) {
    var reader = new FileReader();
    
    reader.onload = function() {
        loadImage(reader);
    };    
    reader.readAsDataURL(event.target.files[0]);
}
</script>

</head>
<body>
<%@ include file="adminheader.jsp"%>
<section>
<article>
<fieldset class="title">
<h2>관리자페이지</h2>
</fieldset>
</article>
<article>
<fieldset class="admin">
	<div class="sidebar">
	    <h2>관리자 메뉴</h2>
	    <nav>
	      	<ul id="ul_menu">
			    <li><a href="#">대시보드</a></li>
			    <li><a href="#">회원 관리</a></li>
			    <li><a href="#">호스트 관리</a></li>
			    <li><a href="/homes/admin/admin_region.jsp">지역 관리</a></li>
			    <li><a href="#">후기 관리</a></li>
			    <li><a href="#">숙소 관리</a></li>	    
			    <li><a href="#">예약 관리</a></li>
			    <li><a href="#">QNA</a></li>
			    <li><a href="#">설정</a></li>
		    </ul>
	    </nav>
	    
	</div>
	
	<form name="fileUpload" method="post" enctype="multipart/form-data" action="admin_region_profile_ok.jsp">
	<div class="content">
		<div>
			<label for="region_sum" class="label">
	       		<span>지역이름: </span>
	       		<span>서울특별시</span>
				<input type="hidden" name="ridx" value="1">
	       </label>		

		</div>
    	<label for="region_sum" class="label">
       	<span>지역사진</span>
       </label>
        <div class="card_cover">
        	<div class="rg_img">       		
        	</div>
        	<div class="rg_value">
        		<label for="thumb_nail" class="label">	
					<span style="font-size: 15px;">지역을 대표하는 이미지</span>
					<br>
					<small style="color: #A6A6A6;">확장자: jpg, jpeg, png, 이미지에 한글을 포함할 수 없습니다</small>
				</label>
			
				<input type="file" name="selectFile" class="form-control" accept="image/*" style="width: 500px; margin-top: 15px;" onchange="selectImage(event)">
        		
	        	<div style="float : right; margin-top: 50px; margin-right: 10px;">
	        		<input type="submit" value="확인">
				</div>
        	</div>
       </div>			
	</div>
	</form>		
</fieldset>
</article>
</section>
<%@ include file="../footer.jsp"%>
</body>
</html>