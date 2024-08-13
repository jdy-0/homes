<%@page import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
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
<title>숙소 검색 결과</title>
<link rel="stylesheet" type="text/css" href="css/mainLayout.css">
<%
	String region_idx=request.getParameter("select_location");
	int p_region_idx=Integer.parseInt(region_idx);
	String check_in=request.getParameter("check_in");
	String check_out=request.getParameter("check_out");
	String num=request.getParameter("guest_num");
	if(num==null||num.equals("")){
		num="0";
	}
	int guest_num=Integer.parseInt(num);
%>
<%
	//1.총게시물수
	int totalCnt=0;
	if(!(num.equals("0"))){
		totalCnt=rmdao.getRoomCount(p_region_idx, guest_num, check_in, check_out);
	} else{
		totalCnt=rmdao.getRoomCount(p_region_idx);
	}
	//2.보여줄 리스트수
	int listSize=6;
	//3.페이지수
	int pageSize=5;
	//4.사용자 현재위치
	String cp_s=request.getParameter("cp");
	if(cp_s==null||cp_s.equals("")){
		cp_s="1";
	}
	int cp=Integer.parseInt(cp_s);
	
	int totalPage=(totalCnt/listSize)+1;
	if(totalCnt%listSize==0) totalPage--;
	
	//사용자 현재 위치의 그룹번호
	int userGroup=cp/pageSize;
	if(cp%pageSize==0)userGroup--;
%>
</head>
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
.index_label_fs{
    background-color:#dec022;
    color:black;
    border-bottom:5px solid black;
    margin:0px;
    font-family: 'SBAggroB';
}
#search_box_fs{
    height: 150px;
    padding-top: 50px;
    border-bottom:5px solid black;
    border-right:0px;
    border-left:0px;
    border-top:0px;
    margin:0px;
}
.select_box {
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'SBAggroB';
    font-size:25px;
}
.select_things{
    border: 3px solid black;
    width: 200px;
    padding: 10px;
    font-size: 20px;
    font-family: 'SBAggroB';
}

</style>
<style>
.date{
    width: 200px;
    border: 3px solid black;
    padding: 10px;
    font-size: 20px;
    font-family: 'SBAggroB';
}
.date-picker {
    position: relative;
    display: flex;
    align-items: center;
}
.date-picker>div{
     float:left;
}
.date-picker>div>div{
     float:left;
}
#date-input {
    width: 417px;
    padding: 8px;
    font-size: 16px;
    cursor: pointer;
    display:flex;
    font-family: 'SBAggroB';
    font-size:25px;
}
.calendar {
    position: absolute;
    top: 90%;
    left: -30px;
    width: 615px;
    z-index: 10;
    border:0px;
    background-color: #e2dccc;
}
.prev-month{
    font-size: 30px;
    width: 40px;
    border: 3px solid black;
    background-color: #dec022;
    font-weight: bold;
}
.next-month{
    font-size: 30px;
    width: 40px;
    border: 3px solid black;
    background-color: #dec022;
    font-weight: bold;
}
.month {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    background-color: #e2dccc;
    width: -webkit-fill-available;
    border:3px solid black;
}
.weekdays, .days {
    display: flex;
    flex-wrap: wrap;
}
.weekdays span, .days span {
    width: 14.28%;
    text-align: center;
    padding: 10px 0;
}
.days span {
    cursor: pointer;
}
.days span:hover {
    background-color: #f2f2f2;
}
.days .selected {
    background-color: #007bff;
    color: white;
}
.line {
    background-color: blue;
}

.side_cal {
    display: flex;
}

.one_month_cal {
    display: inline;
    float: left;
    border: 4px solid black;
    width: 300px;
}

.month-year {
    text-align: center;
}

.disabled {
    text-decoration: line-through;
    background-color: lightgray;
}

.sunday {
    color: red;
}

.month-year {
    font-size: 25px;
    background-color:#dec022;
    border-bottom:3px solid black;
}
#select_guest_div{
    margin-left:115px;
    display: flex;
    flex-direction: column;
    padding: 10px;
}
#select_guest_div label{
    padding-bottom:5px;
}
#select_guest{
    border: 3px solid black;
    width: 200px;
    font-size: 20px;
    padding: 10px;
    font-family: 'SBAggroB';
}
.button{
    width:80px;
    background-color:#dec022;
    border:3px solid black;
    font-family: 'SBAggroB';
    padding:10px;
    font-size:20px;
}
#recommend_region{
    border-bottom:5px solid black;
    height:380px;
}
#recommend_region_table{
    margin:50px auto;
    width:1600px;
    border-spacing:0px;
}
#recommend_region_table td{
    text-align:center;
    width:260px;
}

#recommend_region_table td img{
    width:232px;
    height:232px;
    margin:28px;
}
#recommend_region_table td a img:hover{
    width:260px;
    height:260px;
    margin:14px;
}
.td_arrow{
    text-align:center;
    width:80px;
}
#arrow{
    text-decoration: none;
    color:black;
    font-size:80px;
    font-weight:bold;
}
#search_room_table{
    margin:50px auto;
    width:1550px;
    height:1020px;
}
#search_room_table td{
    text-align:center;
    height:510px;
}
#search_room_table td img{
    width:480px;
    height:480px;
    margin:15px;
}
#search_room_table td img:hover{
    width:495px;
    height:495px;
    margin:0px;
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
<fieldset class="index_label_fs">
<h2>Find Home >></h2>
</fieldset>
<fieldset id="search_box_fs">
<form name="search" action="searchlist.jsp" onsubmit="return validateForm()">
<div class="select_box">
    <div class="search_item">
        <label for="destination">여행지</label>
        <select name="select_location" class="select_things">
        <%
        ArrayList<RegionDTO> region = new ArrayList<>();
        region = rdao.getRegion();
                
        for (int i = 0; i < region.size(); i++){%>
                  <option value="<%=region.get(i).getRegion_idx()%>"><%=region.get(i).getRegion_name()%></option> 
        <%} %>
        </select>
    </div> 


   <div class="date-picker">

            <div id="date-input">
                <div class="search_item">
                    <label for="checkin">체크인</label> <input type="text" id="check_in" class="date" required readonly="readonly" id="from">
                </div>
                <div class="search_item">
                    <label for="checkin">체크아웃</label> <input type="text" id="check_out" class="date" required readonly="readonly" id="to">
                </div>
            </div>

            <%@ include file="cal.jsp"%>
            <div id="select_guest_div">
                <label for="checkin">인원수</label> <input type="number" name="인원수" id="select_guest" min="1" required>
            </div>
            <div class="search_button">
                <input type="submit" value="검색" class="button">
            </div>
        </div>

    </div>
</form>
    </fieldset>
</article>

<fieldset class="index_label_fs">
<h2>HOMES 숙소 검색 결과</h2>
</fieldset>
<article id="search_room">
<table id="search_room_table">
<tbody>
	<%
	ArrayList<RoomDTO> room=new ArrayList<>();
	//room=rmdao.getRoom(p_region_idx,cp,listSize);
	if(!(num.equals("0"))){
		room=rmdao.getRoom(p_region_idx,cp,listSize,guest_num,check_in,check_out);
	} else {
		room=rmdao.getRoom(p_region_idx,cp,listSize);
	}
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
			<%if(i%2==0) {%>
		   		<tr>
		   	<%} %>
	      		<td><a href="rooms/information.jsp?room_idx=<%= room.get(i).getRoom_idx() %>"><img src="<%=room.get(i).getImage() %>" onerror="this.src='/homes/img/no_image.jpg'" width=200, height="200"></a><p><%=room.get(i).getRoom_name() %></p></td>
	   		<%if(i%2==1 || i==room.size()-1) {%>
		   		</tr>
		   	<%} %>
		<%}
	}%>
</tbody>
<tfoot>
	<tr>
		<td colspan="3" align="center">
			<%
			if(userGroup!=0){
				%><a href="searchlist.jsp?cp=<%=(userGroup-1)*pageSize+pageSize %>&select_location=<%=p_region_idx %>
				<%
				if(!(num.equals("0"))){
					%>&check_in=<%=check_in %>&check_out=<%=check_out %>&guest_num=<%=guest_num %><%
				}
				%>
				">&lt;&lt;</a><%
			}
			%>
			
			<%
			for(int i=userGroup*pageSize+1;i<=userGroup*pageSize+pageSize;i++){
				%>
				&nbsp;&nbsp;<a href="searchlist.jsp?cp=<%=i %>&select_location=<%=p_region_idx %>
				<%
				if(!(num.equals("0"))){
					%>&check_in=<%=check_in %>&check_out=<%=check_out %>&guest_num=<%=guest_num %><%
				}
				%>
				"><%=i %></a>&nbsp;&nbsp;
				<%
				if(i==totalPage){
					break;
				}
			}
			%>
			
			<%
			if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
				%><a href="searchlist.jsp?cp=<%=(userGroup+1)*pageSize+1 %>&select_location=<%=p_region_idx %>
				<%
				if(!(num.equals("0"))){
					%>&check_in=<%=check_in %>&check_out=<%=check_out %>&guest_num=<%=guest_num %><%
				}
				%>
				">&gt;&gt;</a><%
			}
			%>
		</td>
	</tr>
</tfoot>
</table>
</article>
</section>
<%@ include file="footer.jsp"%>
</body>
</html>
