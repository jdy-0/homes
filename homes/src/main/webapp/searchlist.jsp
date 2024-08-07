<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.region.RegionDTO" %>
<jsp:useBean id="rdto" class="com.homes.region.RegionDTO"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.region.RegionDAO"></jsp:useBean>    
<%@ page import="com.homes.region.Region_DetailDTO" %>
<jsp:useBean id="rddto" class="com.homes.region.Region_DetailDTO"></jsp:useBean>
<jsp:useBean id="rddao" class="com.homes.region.Region_DetailDAO"></jsp:useBean>    
<%@ page import="com.homes.room.RoomDTO" %>
<jsp:useBean id="rmdto" class="com.homes.room.RoomDTO"></jsp:useBean>
<jsp:useBean id="rmdao" class="com.homes.room.RoomDAO"></jsp:useBean>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/mainLayout.css">
</head>
<%
	String region_idx=request.getParameter("select_location");
	int p_region_idx=Integer.parseInt(region_idx);
	System.out.println(region_idx);
%>
<style>
.search_item {
    padding: 10px 20px;
}
.search_button {
    padding: 10px 20px 0px 50px;
}
.search_item label {
    display: block;
    padding-bottom: 5px;
}
.select_box {
   	display: flex;
}

#arrow{
	text-decoration: none;
}
</style>
<script>
function validateForm() {
    var checkin = document.getElementById('check_in').value;
    var checkout = document.getElementById('check_out').value;
    var checkinDate = new Date(checkin);
    var checkoutDate = new Date(checkout);
    var now = new Date();
    
    if (checkinDate <= now) {
        alert('체크인 날짜는 현재 날짜와 시간 이후여야 합니다.');
        return false; // 폼 제출을 막음
    }
    
    if (checkoutDate <= now) {
        alert('체크아웃 날짜는 현재 날짜와 시간 이후여야 합니다.');
        return false; // 폼 제출을 막음
    }
    
    if (checkoutDate <= checkinDate) {
        alert('체크아웃 날짜는 체크인 날짜 이후여야 합니다.');
        return false; // 폼 제출을 막음
    }
    return true; // 폼 제출을 허용
}
</script>
<body>
<%@ include file="header.jsp"%>
<section>
<article id="search_box">
<fieldset>
<form name="search2" action="searchlist.jsp" onsubmit="return validateForm()">
<div class="select_box">
	<div class="search_item">
		<label for="destination">여행지</label>
		<select name="select_location">
			<%
			ArrayList<String> rname=new ArrayList<>();
			rname=rdao.getRegionNames();
					
			for(int i=0;i<rname.size();i++){%>
		      		<option value="<%=i+1%>"><%=rname.get(i)%></option> 
		    <%} %>
			<!--
			   <option value="Seoul">서울</option> 
			   <option value="Busan">부산</option> 
			   <option value="Sokcho">속초</option> 
			   <option value="Gangneung">강릉</option> 
			   <option value="Jeonju">전주</option> 
			   <option value="Daegu">대구</option> 
			   <option value="Gyeongju">경주</option> 
			-->
		</select>
	</div> 

   <div class="search_item">
	   <label for="checkin">체크인</label>
	   <input type="date" id="check_in" class="date" required> 
   </div>
   <div class="search_item">
	   <label for="checkin">체크아웃</label>   
	   <input type="date" id="check_out" class="date" required>
	</div>
	<div class="search_item">
	   <label for="checkin">인원수</label>
	   <input type="number" name="인원수" id="select_guest" min="1" required>
   </div>
   <div class="search_button">
   	<input type="submit" value="검색" class="button"> 
	</div>
</div>
</form>
</fieldset>
</article>
<hr>
<article id="article_recommend">
<table>
	<tr>
		<td><a href="#" id="arrow">←</a></td>
		<%
		ArrayList<String> img=new ArrayList<>();
		img=rddao.getRegionImg();
		for(int i=0;i<rname.size();i++){%>
	      		<td>
	      			<a href="searchlist.jsp?select_location=<%=i+1 %>"><img src="<%=img.get(i) %>" onerror="this.src='/homes/img/no_image.jpg'" width=200, height="200"></a>
	      			<p>추천여행지:<%= rname.get(i)%></p>
	      		</td>
	    <%} %>
	   <td><a href="#" id="arrow">→</a></td>
   </tr>
</table>
<table>
	<%
	ArrayList<RoomDTO> room=new ArrayList<>();
	room=rmdao.getRoom(p_region_idx);
	if(room==null||room.size()==0){
		%>
		<tr>
			<td colspan="3" align="center">
				<%rddao.countUpdate(p_region_idx); %>
				검색된 숙소가 없습니다
			</td>
		</tr>
		<%
	} else {
		for(int i=0;i<room.size();i++){ %>
			<%if(i%3==0) {%>
		   		<tr>
		   	<%} System.out.println(room.get(i).getRoom_name());%>
	      		<td><a href="#"><img src="<%=room.get(i).getImage() %>" onerror="this.src='/homes/img/no_image.jpg'" width=200, height="200"></a><p><%=room.get(i).getRoom_name() %></p></td>
	   		<%if(i%3==2 || i==room.size()-1) {%>
		   		</tr>
		   	<%} %>
		<%}
	}%>
</table>
</article>
</section>
<%@ include file="footer.jsp"%>
</body>
</html>