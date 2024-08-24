<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/myPageLayout.css">
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<%@include file="/guest/myPageNav.jsp" %>
<article id="myReview" class="myPageContent_ar">
	<div>
		<%
		ArrayList<HashMap<String, Object>> myReview = gdao.getMyReview(userid);
		if(myReview == null || myReview.size()==0){
			%>
			<h2>작성한 리뷰가 없습니다.</h2>
			<%
		}else{
			%>
			<table>
				<tr>
				<%
				for(int i=0; i<myReview.size(); i++){
					String content = (String)myReview.get(i).get("content");
					int rate = (Integer)myReview.get(i).get("rate");
					int room_idx = (Integer)myReview.get(i).get("room_idx");
					%>
					<td>
					<div style="display:flex;">
						<img src="<%=myReview.get(i).get("room_img")%>">
						<div>
							<div style="display:flex;">							
							<p><a href="/homes/rooms/information.jsp?room_idx=<%=room_idx%>"><%=myReview.get(i).get("room_name") %></a></p>
							<p style="color:yellow;"><%for(int j=1; j<=rate; j++){%>&#9733;<%} %></p>
							</div>
							<p><%=content.length()>15?content.substring(0, 15)+"...":content %><a href="javascript:openFullReview('full_<%=i%>');">[전체보기]</a></p>
							<div style="display:none;" id="full_<%=i%>">
								<p><%=content%></p>
							</div>
						</div>
					</div>
					
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
			<%
		}
		%>
	</div>
</article>
</section>
<%@include file="/footer.jsp" %>
<script>
function selectedMenu(){
	document.getElementById("manageActivity").style.backgroundColor = 'white';
	document.getElementById("manageActivity").style.borderRadius = '5px';
}
window.onload=selectedMenu;
function openFullReview(divId){
	
	var div = document.getElementById(divId);
	//var show = div.style.display;
	
	if(div.style.display == "none"){
		div.style.display = "block";
	}else{
		div.style.display = "none";
	}
}
</script>
</body>
</html>