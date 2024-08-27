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
<link rel="stylesheet" type="text/css" href="css/indexLayout.css">
</head>
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
    
    var checkIn = document.getElementById('check_in');
    var checkOut = document.getElementById('check_out');
	
   
    if (!checkIn || !checkOut || checkin==''||checkout=='' ) {
        alert("체크인, 체크아웃을 입력해주세요.");
        return false; // 폼 제출을 막습니다.
    }
    
    return true; // 폼 제출을 허용
}

</script>
<%
//1.총게시물수
int totalCnt=rddao.regionDetailCount();
//2.보여줄 리스트수
int listSize=5;
//3.페이지수
int pageSize=1;
//4.사용자 현재위치
String cp_s=request.getParameter("cp");
if(cp_s==null||cp_s.equals("")){
	cp_s="1";
}
int cp=Integer.parseInt(cp_s);

int totalPage=(totalCnt/pageSize)+1;
if(totalCnt%pageSize==0) totalPage--;

//사용자 현재 위치의 그룹번호
int userGroup=cp/listSize;
if(cp%listSize==0)userGroup--;
%>
<body>
<%@ include file="header.jsp"%>
<section>
<article id="search_box">
<!-- 검색 바 -->
<fieldset class="search_box_fs">
<form name="search" action="searchlist.jsp" onsubmit="return validateForm()">
<div class="select_box">
	<div class="search_item">
		<label for="destination">여행지</label>
		<select name="select_location" class="select_things">
		<%
		ArrayList<RegionDTO> region=new ArrayList<>();
		region=rdao.getRegion();
				
		for(int i=0;i<region.size();i++){%>
	      		<option value="<%=region.get(i).getRegion_idx()%>"><%=region.get(i).getRegion_name()%></option> 
	    <%} %>
		</select>
	</div> 

	<div class="date-picker">
		<div id="date-input">
			<div class="search_item">
				<label for="checkin">체크인</label> <input type="text" id="check_in" name="check_in" class="date" readonly="readonly">
			</div>
			<div class="search_item">
				<label for="checkout">체크아웃</label> <input type="text" id="check_out" name="check_out" class="date" readonly="readonly">
			</div>
		</div>

		<%@ include file="cal.jsp"%>
		<div id="select_guest_div">
			<label for="checkin">인원수</label> <input type="number" name="guest_num" id="select_guest" min="2" required>
		</div>
		<div class="search_button">
			<input type="submit" value="검색" class="button">
		</div>
	</div>
</div>
</form>
</fieldset>
</article>

<article id="recommend_region">
	<fieldset class="index_label_fs">
		<h2>HOMES의 인기 여행지</h2>
	</fieldset>
	<table id="recommend_region_table">
	<tr>
		<td class="td_arrow">
		<%
		if(userGroup!=0){
			%><a href="index.jsp?cp=<%=(userGroup-1)*listSize+listSize %>" id="arrow">&laquo;</a><%
		}
		%>
		</td>
		<%
		ArrayList<RegionDTO> rcname=new ArrayList<>();
		rcname=rdao.getRegionClick();
		ArrayList<String> img=new ArrayList<>();
		img=rddao.getRegionImg();
		for(int i=userGroup*listSize+1;i<=userGroup*listSize+listSize;i++){%>
	      		<td>
	      			<a href="searchlist.jsp?&select_location=<%=rcname.get(i-1).getRegion_idx() %>"><img src="<%=img.get(i-1) %>" onerror="this.src='/homes/img/no_image.jpg'" width=200, height="200"></a>
	      			<p><%= rcname.get(i-1).getRegion_name()%></p>
	      		</td>
	      		<%
				if(i==totalPage){
					break;
				}
	      		%>
	    <%} %>
	   <td class="td_arrow">
	   <%
	   //if(userGroup!=(totalPage/listSize-(totalPage%listSize==0?1:0))){
		if(userGroup!=(totalPage/listSize-(totalPage%listSize==0?1:0))){
		%>
	   <a href="index.jsp?cp=<%=(userGroup+1)*listSize+1 %>" id="arrow">&raquo;</a><%
		}
		%>
	   </td>
   </tr>
	</table>
</article>

<article id="recommend_room">
<fieldset class="index_label_fs">
<h2>HOMES의 랜덤 추천</h2>
</fieldset>
<table id="recommend_room_table">
	<%
	int user_idx=0;
	if(!(session.getAttribute("useridx")==null || session.getAttribute("useridx")=="")){ 
		user_idx=(Integer)session.getAttribute("useridx");
	}
	
	String redheart = "&hearts;";
	String blankheart = "&#9825;";
	if(rmdao.roomCount()>=6){
		RoomDTO[] room=rmdao.roomRandom();
		for(int i=0;i<6;i++){ %>
			<%if(i%3==0) {%>
		   		<tr>
		   	<%} %>
	      		<td>
	      			<div id="room_card">
	      				<a href="/homes/rooms/information.jsp?room_idx=<%=room[i].getRoom_idx()%>">
	      				<img src="<%=room[i].getImage() %>" onerror="this.src='/homes/img/no_image.jpg'" width=200, height=200></a>
	      				<%
	      				int like_idx = gdao.like(user_idx, room[i].getRoom_idx());
	      				if(like_idx!=0){ 	      				
	      				%>
		      				<div id="room_heart">
	           					 <a id="room_heartlink" href="/homes/deletelike_ok.jsp?likeidx=<%=like_idx %>"><%= redheart %></a>
	       					</div>
       					<%
       					} else if (user_idx!=0){
       					%>
		      				<div id="room_heart">
	           					 <a id="room_heartlink" href="/homes/insertlike_ok.jsp?roomidx=<%=room[i].getRoom_idx() %>"><%= blankheart %></a>
	       					</div>
       					<%	
       					}
       					%>
	      			</div>
	      			<p><%=room[i].getRoom_name() %></p>
	      		</td>
	   		<%if(i%3==2) {%>
		   		</tr>
		   	<%} %>
		<%} 
	} else {
		//등록된 숙소가 충분하지 않음
	}%>
</table>
</article>
</section>
<%@ include file="footer.jsp"%>
</body>
</html>