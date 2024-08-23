<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.guest.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/myPageLayout.css">
<style>
#list table{
	margin:20px auto;
	width:90%;
	border-spacing:10px;
}
#list table td{
	width:50%;
	text-align:center;
	vertical-align: top;
	border:5px solid black;
}
#list table td a{
	text-decoration:none;
	color:black;
	font-size:20px;
}
#list table td fieldset{
	margin:10px auto;
	border:0;
    width: 90%;   
}
#list table td img{
	width:90%;
}
.div_text{
	display: flex;
    justify-content: space-around;
    width: 90%;
    height:90%;
    margin: 5px auto;
}
.div_text div{
	text-align: left;
    margin-left: 20px;
}
#pushHeart a{
	font-size:100px;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<%@include file="/guest/myPageNav.jsp" %>
<article id="myReserveHistory" class="myPageContent_ar">
	<%
	ArrayList<LikeDTO> mylikes = gdao.getMyLike(userid);
	if(mylikes == null || mylikes.size()==0){
		%>
		<div id="noList">
		<h2>아직 찜한 숙소가 없습니다.</h2>
		</div>
		<%
	}else{
		%>
		<div id="list">
			<table>
			<tr>
			<%
			for(int i=0; i<mylikes.size(); i++){
				%>				
				<td>
				<a href="/homes/rooms/information.jsp?room_idx=<%=mylikes.get(i).getRoom_idx()%>">
				<fieldset>
					<div>
					<img src="<%=mylikes.get(i).getRoom_image() %>" alt="room_img" style="width:300px;">
					</div>
					<div class="div_text">
						<div>
							<p><%=mylikes.get(i).getRoom_name() %></p>
							<p><%=mylikes.get(i).getPrice() %> 원 /박</p>
							<p>호스트: <%=mylikes.get(i).getHost_nickname() %>님</p>
							<p><%=mylikes.get(i).getRegion_name() %></p>
						</div>
						<div id="pushHeart">
							<a href="javascript:dltLike('<%=mylikes.get(i).getIdx()%>');">&#10084;</a>
						</div>
					</div>
				</fieldset>
				</a>
				</td>
				<%
				if(i%2==1){
					%>
					</tr>
					<tr>
					<%
				}
			}
			%>
			</tr>
			</table>
		</div>
		<%
	}
	%>
</article>
</section>
<%@include file="/footer.jsp" %>
<script>
function dltLike(like_idx){
	var idx = like_idx;
	
	var xhr = new XMLHttpRequest();
	xhr.open("POST", "dltLike_ok.jsp", true);
	xhr.setRequestHeader("Content-Type", "application/json");
	xhr.onload = function(){
		if(xhr.status === 200){
			alert(idx+'찜 목록 해제');
			location.reload();
		}else{
			alert('찜 해제 실패');
		}
	};
	xhr.send(JSON.stringify({dltlikeidx: idx}));
}
</script>
</body>
</html>