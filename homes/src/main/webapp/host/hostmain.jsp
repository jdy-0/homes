<%@page import="com.homes.room.RoomDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.homes.db.HomesDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<jsp:useBean id="homedto" class="com.homes.room.RoomDTO"></jsp:useBean>
<jsp:useBean id="homedao" class="com.homes.room.RoomDAO"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.region.RegionDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/hostMainLayout.css">
<!--     <style>
        img {
            width: 400px;
            height: 300px;
            display: block;
            margin-bottom: 10px;
        }
        div {
            border: 1px solid black;
            text-align: center;
            padding: 10px;  /* 패딩 추가 */
        }
        .container {
            display: flex;
            gap: 10px;  /* 열 사이의 간격을 조정합니다 (선택적) */
        }
        .column {
            flex: 1; /* 열의 비율을 설정합니다 */
            padding: 20px;
            background-color: lightgray;
            border: 1px solid #ccc;
        }
        .column:nth-child(1) {
            background-color: lightcoral;
        }
        .column:nth-child(2) {
            background-color: lightseagreen;
        }
        .column:nth-child(3) {
            background-color: lightsteelblue;
            
        }
        #roomselect {
            text-align: left;
        }
        #roomselect h2{
        	text-align: center;
        }
        input[type="number"] {
            font-size: 14px; /* 폰트 크기 설정 */
            padding: 2px; /* 입력 필드 내 여백 설정 */
            width: 50px; /* 적절한 너비 설정 */
            box-sizing: border-box; /* 패딩과 테두리를 포함한 너비 설정 */
        }
        
    </style> -->

</head>
<body>
<%@ include file="/header.jsp"%>
<%	

//Integer useridx = (Integer)session.getAttribute("useridx");

Integer useridx=0 ;
useridx = session.getAttribute("useridx")==null || session.getAttribute("useridx").equals("")?0:(Integer)session.getAttribute("useridx");
if (useridx == null || useridx == 0) {
	System.out.println(useridx);

%>
    <script>
    window.location.href = '/homes/guest/login.jsp';
    </script>
<%
}

ArrayList<RoomDTO> arr= homedao.HomesList(useridx);

%>



<section>
<%@include file="hostheader.jsp" %>
<article id="host_main_article">
		<%
		if(arr==null||arr.size()==0){
			%>
				<div id="no_room_div">
				<h3>등록된 숙소가 없습니다. 등록하시겠습니까?</h3>
				<form name="insertfm" action="hostinsert.jsp"> 
				<input type="submit" value="숙소 등록하기" class="button">				
				</form>
				</div>
			<%
		}else{
			int a = arr.size();
			for(int i=0;i<arr.size();i++){
				
				%>
				
			<form name="updatefm" action="host_update_image_ok.jsp?room_idx<%=arr.get(i).getRoom_idx()%>"> 
			<div class="container">
				<div>
					<img id="selectedImage" src ="<%=arr.get(i).getImage()%>" alt="Selected Image"  onerror="this.src='/homes/img/no_image.jpg'" />
				</div>
				<div id="roomselect">
					<h2><%=arr.get(i).getRoom_name() %></h2>
					<ul>
						<li><label>지역:</label> 
						
						<label><%=arr.get(i).getSelectedRegionName()+" "+arr.get(i).getParentRegionName()%></label>
						<li>
							<label for="room_goodthing">편의 시설 : </label> 
							<label><%=arr.get(i).getGoodthing()%></label>
						</li>
						<li>
							<label for="room_addr">상세 주소:</label> 
							<label><%=arr.get(i).getAddr_detail()%></label>
						</li>
						<li>
							<label for="price">가격:</label> 
							<label><%=arr.get(i).getPrice()%> / 박</label>
						</li>
						
						
						<!-- <li>
							<label for="map_url">맵 url :</label> 
							<label>맵 쓰기</label>
						</li> -->
						<li>
							<input type="hidden" value=<%=arr.get(i).getRoom_idx() %> name="room_idx">
						<li>
						
					</ul>
				</div>
				<!-- <div>
					<h2>사진 등록</h2>
					<hr>
					<input type="file" multiple="multiple" accept="image/*" name='subpicture'>
				</div> -->
				<div>
					<input type="submit" value="수정">
				</div>
			</div>
			</form>
			<br>
			<hr>
			<%
			}
		}
		%>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>