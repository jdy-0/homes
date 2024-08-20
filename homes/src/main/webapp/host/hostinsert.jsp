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
  	<link rel="stylesheet" type="text/css" href="/homes/css/hostInsertLayout.css">

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
        
        
        document.addEventListener('DOMContentLoaded', function() {
        	
            const regionDetails = {
            		
            		'1': [ // 강원도
            	        { id: '11', name: '속초시' },{ id: '12', name: '강릉시' }
            	    ],
            	    '2': [ // 경기도
            	        { id: '13', name: '수원시' },{ id: '14', name: '가평군' }
            	    ],
            	    '3': [ // 인천광역시
            	        { id: '15', name: '중구' }
            	    ],
            	    '4': [ // 충청도
            	        { id: '16', name: '단양군' },{ id: '17', name: '서산시' }
            	    ],
            	    '5': [ // 경상도
            	        { id: '18', name: '경주시' },{ id: '19', name: '울릉군' }
            	    ],
            	    '6': [ // 전라도
            	        { id: '20', name: '전주시' },{ id: '21', name: '담양군' }
            	    ],
            	    '7': [ // 제주특별자치도
            	        { id: '22', name: '서귀포시' },{ id: '23', name: '제주시' }
            	    ],
            	    '8': [ // 서울특별시
            	        { id: '24', name: '종로구' },{ id: '25', name: '용산구' }
            	    ],
            	    '9': [ // 부산광역시
            	        { id: '26', name: '해운대구' }
            	    ]
            	};

            function updateLocationDetails() {
                const locationSelect = document.getElementById('select_location');//첫번째 선택값
                const locationDetailSelect = document.getElementById('select_location_detail');
                //두번쨰 선택값
                const selectedRegionId = locationSelect.value;
                
                locationDetailSelect.innerHTML = '<option value="">상세 지역을 선택하세요</option>';

                if (regionDetails[selectedRegionId]) {
                    regionDetails[selectedRegionId].forEach(detail => {
                        const option = document.createElement('option');
                        option.value = detail.id;
                        option.textContent = detail.name;
                        locationDetailSelect.appendChild(option);
                    });
                }
            }

            document.getElementById('select_location').addEventListener('change', updateLocationDetails);
        });
    
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
					<select name="select_location"  id="select_location" class="select_things" onchange="aaa();"><!-- DB에서 지역 가져와서 셀렉트박스로 선택 -->
					<%						
						ArrayList<RegionDTO> region=new ArrayList<>();
						region=rdao.getRegion();
						for(int i=0;i<region.size();i++){%>
	      				<option value="<%=region.get(i).getRegion_idx()%>"><%=region.get(i).getRegion_name()%></option>
	      					 
	   					<%
	   					}
	   					%>
	   					
					</select>
					
					<select id="select_location_detail" name="select_location_detail" class="select_things">
						
						<option>상세 지역</option>
						
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
			<!-- <tr>
				<th>지도</th>
				<td><input type="text" name="map_url" class="text" required placeholder="map_url"></td>지도 이미지 경로를 입력하라는 의미? 
			</tr> -->
		</table>
		</fieldset>
		<input type="hidden" name="host_idx" value="<%=Host_idx%>">

	<div style="display: flex; align-items: flex-end;">
		<input type="hidden" name="Folder"  value="<%=name%>"> 
		<input type="submit" value="등록" class="button">
	</div>
</form>
</article>
</section>
</body>

</html>
		