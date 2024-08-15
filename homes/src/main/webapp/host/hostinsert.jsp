<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.region.RegionDAO"></jsp:useBean>
<%@page import="com.homes.region.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>숙소 등록</title>
    <link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
    <!-- <link rel="stylesheet" type="text/css" href="/homes/css/hostMainLayout.css"> -->
    <!-- <style>
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
        #roominsert {
            text-align: left;
        }
        #roominsert h2{
        	text-align: center;
        }
        input[type="number"] {
            font-size: 14px; /* 폰트 크기 설정 */
            padding: 2px; /* 입력 필드 내 여백 설정 */
            width: 50px; /* 적절한 너비 설정 */
            box-sizing: border-box; /* 패딩과 테두리를 포함한 너비 설정 */
        }
        
    </style> -->
<style>
section{
	font-family: 'SBAggroB';
	display:flex;
}
.label_fs{
	background-color:#dec022;
	color:black;
	border-bottom:5px solid black;
	margin:0px;
	font-family: 'SBAggroB';
	text-align:start;
}
#selectedImage{
	width:400px;
	height:300px;
	display:block;
	margin-bottom:10px;
}
#article_insert_room{
	width: 100%;	
}
#insert_mainImg_fs{
	border:0; 
	border-right:3px dashed black; 
	padding:20px;
	width:450px;
}
#insert_mainImg_fs div{
	display: flex;
    align-items: baseline;
    justify-content: space-between;
    border:0;
}
#insert_mainImg_fs img{
	margin:10px auto;
}
#insert_room_fs{
	border:0; 
	padding:20px;
}
#insert_room_fs table{
	margin:15px auto;
	width:500px;
	font-size:20px;
}
#insert_room_fs table th{width:100px;}
#insert_room_fs table select{
	border:3px solid black;
	font-family: 'SBAggroB';
	padding:5px;
	font-size:18px;
}
.text{
	border:3px solid black;
	padding:5px;
	font-family: 'SBAggroB';
	font-size:18px;
}
.button{
	font-family: 'SBAggroB';
	font-size:20px;
	padding:5px;
	background-color:#dec022;
	border:4px solid black;
	margin:15px;
}
.button:hover{background-color:#e2dccc; transition:0.5s;}
#file-upload-button{
	font-family: 'SBAggroB';
	font-size:20px;
	padding:5px;
	background-color:#dec022;
	border:4px solid black;
}
</style>
       <script>
        function FileSelect(event) {
        	  const fileInput = event.target;
              const file = fileInput.files[0];

              if (file) {
                  const reader = new FileReader();

                  // 새로고침 
                  
                  reader.onload = function (e) {
                	  //파일 선택을 누른 타겟의 url
                      const imageUrl = e.target.result;
                     
                      // 이미지 URL을 로컬 저장소에 저장
                      //localStorage.setItem('selectedImageUrl', imageUrl);
                      
                      // 이미지 미리보기 업데이트
                      document.getElementById('selectedImage').src = imageUrl;
                  };
                  // 파일을 데이터 URL로 읽기
                  reader.readAsDataURL(file);
              }
        }
        
        //새로고침 함수
   /*      window.onload = function () {
            
            const savedImageUrl = localStorage.getItem('selectedImageUrl');
            if (savedImageUrl) {
                document.getElementById('selectedImage').src = savedImageUrl;
            }
        }; */
        
    </script>
    
</head>
<body>
	<%@include file="/header.jsp"%>
	<%
	String name = (String)session.getAttribute("userid");
	
	Integer useridx = (Integer)session.getAttribute("useridx");
	String Host_idx = useridx != null ? useridx.toString() : "";
	
	if (name == null || name.isEmpty()) {
	%><script>
			window.open('/homes/guest/login_popup.jsp', 'popup',
					'width=400,height=300,top=100,left=100');
		</script>
	<%
	return;
	}
	%>
<%
String path = request.getRealPath("/");
wf.setHomePath(path);
wf.setUserid(name);
String crpath = name;
wf.setCrpath(crpath);
%>
<section>
<%@include file="hostheader.jsp"%>
<article id="article_insert_room" class="container">
<fieldset class="label_fs">
		<h3>숙소 등록</h3>
</fieldset>	

<form name="fminsertroom" style="display: flex;" action="hostinsert_ok.jsp" method="post" enctype="multipart/form-data">
	<fieldset id="insert_mainImg_fs">
		<div>
			<h2>대표 이미지</h2>
			<input type="file" id="fileInput" name="mainPiceture" accept="image/*" onchange="FileSelect(event)" />
		</div>		
		<img id="selectedImage" src="default-image.jpg" alt="Selected Image"  onerror="this.src='/homes/img/no_image.jpg'" />		
	</fieldset>
	<fieldset id="insert_room_fs" style="border:0;">
		<h2>숙소 정보</h2>
		<table>
			<tr>
				<th>숙소이름</th>
				<td><input type="text" name="room_name" class="text" required></td>
			</tr>
			<tr>
				<th>인원수</th>
				<td>
					<input type="number" id="room_min" name="room_min" min="2" class="text" required="required" placeholder="최소 인원수"> ~ 
					<input type="number" id="room_max" name="room_max" min="2" class="text" required="required" placeholder="최대 인원수">
				</td>
			</tr>
			<tr>
				<th>지역</th>
				<td>
					<select name="select_location" class="select_things"><!-- DB에서 지역 가져와서 셀렉트박스로 선택 -->
					<%						
						ArrayList<RegionDTO> region=new ArrayList<>();
						region=rdao.getRegion();
				
						for(int i=0;i<region.size();i++){%>
	      				<option value="<%=region.get(i).getRegion_idx()%>"><%=region.get(i).getRegion_name()%></option> 
	   					<%} %>
					</select>
				</td>
			</tr>
			<tr>
				<th>상세주소</th>
				<td><input type="text" name="addr_detail" class="text" required placeholder="주소 입력"></td>
			</tr>
			<tr>
				<th>편의시설</th>
				<td>
					<input type="text" name="goodthing" class="text" required placeholder="세부사항 입력">
					<!-- 여기 편의시설 테이블 만들어지면 DB에서 가져와서 체크박스로 목록 만들어서 선택하게 하는 게 좋을 것 같음 -->
				</td>
			</tr>
			<tr>
				<th>가격</th>
				<td><input type="text" name="price" class="text" required placeholder="가격 입력"></td>
			</tr>
			<tr>
				<th>지도</th>
				<td><input type="text" name="map_url" class="text" required placeholder="map_url"></td><!-- 지도 이미지 경로를 입력하라는 의미?  -->
			</tr>
		</table>
		</fieldset>
		<input type="hidden" name="host_idx" value="<%=Host_idx%>">
<%-- 		
		<ul>
			<li><label>숙소 이름:</label> 
				<input type="text" name="room_name" required></li>
			<li>
				<label for="room_min">인원수:</label> 
				<input type="number" id="room_min" name="room_min" min="2" required="required" placeholder="최소 인원수"> ~ 
				<input type="number" id="room_max" name="room_max" min="2" required="required" placeholder="최대 인원수">
			</li>
			<li>
				<label for="details">지역 번호:</label> 
				<input type="text" name="region_idx" required placeholder="지역 번호 입력">
			</li>
			<li>
				<label for="details">세부사항:</label> 
				<input type="text" name="goodthing" required placeholder="세부사항 입력">
			</li>
			<li>
				<label for="addr_detail">주소:</label> 
				<input type="text" name="addr_detail" required placeholder="주소 입력">
			</li>
			<li>
				<label for="price">가격:</label> 
				<input type="text" name="price" required placeholder="가격 입력">
			</li>
			<li>
				<label for="map_url">맵 url :</label> 
				<input type="text" name="map_url" required placeholder="map_url">
			</li>
			<li>
				<input type="hidden" name="host_idx" value="<%=Host_idx%>">
			</li>
		</ul>
	</div>
	</fieldset> --%>
				<!-- <div>
					<h2>사진 등록</h2>
					<hr>
					<input type="file" multiple="multiple" accept="image/*" name='subpicture'>
				</div> -->
	<div style="display: flex; align-items: flex-end;">
		<input type="hidden" name="Folder"  value="<%=name%>"> 
		<input type="submit" value="등록" class="button">
	</div>
</form>
</article>
</section>
</body>
</html>
		