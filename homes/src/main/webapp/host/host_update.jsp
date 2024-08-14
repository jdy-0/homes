<%@page import="java.util.ArrayList"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.room.RoomDAO, com.homes.room.RoomDTO" %>

<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.room.RoomDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdto" class="com.homes.room.RoomDTO" scope="session"></jsp:useBean>
<%
    String roomIdxParam = request.getParameter("room_idx");
	session.setAttribute("room_idx", roomIdxParam);
	String id= (String)session.getAttribute("userid");
	
	String path=request.getRealPath("/");
	wf.setHomePath(path);
	
	int idx= Integer.parseInt(roomIdxParam);
    RoomDTO room = null;
	
    // room_idx가 null이거나 빈 문자열인 경우 기본값 또는 에러 처리
    if (roomIdxParam != null && !roomIdxParam.isEmpty()) {
        try {
            int roomIdx = Integer.parseInt(roomIdxParam);
            RoomDAO roomDAO = new RoomDAO();
            room = roomDAO.getRoomById(roomIdx);
            if (room == null) {
                out.println("해당 숙소 정보를 찾을 수 없습니다.");
            }
        } catch (NumberFormatException e) {
            // room_idx 파라미터가 유효하지 않은 경우 처리
            out.println("유효하지 않은 숙소 ID입니다.");
        }
    } else {
        // room_idx 파라미터가 유효하지 않은 경우 처리
        out.println("유효하지 않은 숙소 ID입니다.");
    }
    
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 정보</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/rating.css"> <!-- 추가된 rating.css 링크 -->
<script>
// 로그인 여부를 확인하는 함수
function checkLogin() {
    var isLoggedIn = '<%= session.getAttribute("userid") != null %>'; // 세션에 userid가 있는지 확인
    if (!isLoggedIn) {
        alert("로그인이 필요한 서비스입니다.");
        openLoginPopup(); // 로그인 팝업을 띄우는 함수 호출
    } else {
        document.getElementById('reservationForm').submit(); // 로그인 상태이면 예약 진행
    }
}

// 로그인 팝업을 여는 함수
function openLoginPopup(){
    var option = 'width=600, height=300, resizable=no, top=200, left=470';
    window.open('/homes/guest/login_popup.jsp?redirect=information.jsp?room_idx=<%=request.getParameter("room_idx")%>&checkin=<%=request.getParameter("checkin")%>&checkout=<%=request.getParameter("checkout")%>&guests=<%=request.getParameter("guests")%>', 'login', option);
}

//선택한 사진으로 변환
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
           // localStorage.setItem('selectedImageUrl', imageUrl);
            
            // 이미지 미리보기 업데이트
            document.getElementById('selectedImage').src = imageUrl;
        };
        // 파일을 데이터 URL로 읽기
        reader.readAsDataURL(file);
    }
}

/* function deleteFile(fileName) {
 
        window.location.href = "host_delete_file.jsp?fileName="+fileName;
    } */

</script>

</head>
<link rel="stylesheet" href="/homes/css/updateLayout.css" type="text/css"/>
<body>

<%@ include file="/header.jsp"%> <!-- 헤더에서 유저 정보를 가져올 수 있습니다. -->
    <main class="container">
    	
        <div class="top">
            <h1>숙소 정보 수정</h1>
            <div class="room-details">
                <% if (room != null) { %>
                
                 <div class="room-images">
                	<div class="room-main">
                    	<img id="selectedImage" src="<%= room.getImage() %>" alt="메인 숙소 이미지">
                    
                    	<input type="file" id="fileUpdate" accept="image/*" onchange="FileSelect(event)">
                    </div>
                    
                    
               		<div class="small-image">
                    	<img src="<%= room.getImage() %>" alt="서브 숙소 이미지 1">
                    </div>
                    <div class="small-image">
                    	<img src="<%= room.getImage() %>" alt="서브 숙소 이미지 1">
                    </div>
                    <div class="small-image">
                    	<img src="<%= room.getImage() %>" alt="서브 숙소 이미지 1">
                    </div>
                    	
                    	
                    </div>
                <div>
                	<h2>상세 사진 관리</h2>
                	<div>
                		<%
                		String userpath= id;
                		File f= new File(wf.getHomePath()+wf.getEverypath()+id+"/"+room.getRoom_name());
                		File files[]=f.listFiles();
                		if(files==null||files.length==0){
                			System.out.println(f.getPath());
                			%>
                			<script>
                			window.alert('<%=f.getPath()%>');
                			</script>
                			
                			<label>사진이 없습니다.</label>
                			<form name="host_update_imgfm" action="host_update_image_ok.jsp">
                				<input type="submit" value="사진 추가">
                				<input type="hidden" name="room_idx" value="<%= roomIdxParam %>">
                			</form>
                			<%
                		}else{
                			for(int i=0;i<files.length;i++){
                				%>
                				<form name="host_delete_imgfm" action="host_delete_file.jsp">
                					<a>
                				
                					<label><%=files[i].getName()%>
                						<input type="submit" value="삭제">
										<input type="hidden" value="<%= files[i].getName() %>" name="img_name">
										<input type="hidden" value="<%=id %>" name= "user_name">
										<input type="hidden" value="<%= room.getRoom_name() %>" name= "room_name">
									</label>
                 					</a>
                 				</form>
                				<%
                			}
                		}
                		%>
                	</div>
                	
                	
                </div>

				<div class="room-input">

					<!-- 숙소 이름 -->
					<h2>숙소 이름: <input type="text"
						id="room_name" name="room_name" value="<%=room.getRoom_name()%>"
						placeholder="숙소 이름을 입력하세요" title="숙소의 이름을 입력하세요" required>
					</h2>
					
					<!-- 숙소 편의시설 -->
					<label for="goodthing"> 숙소 편의시설: <input type="text"
						id="goodthing" name="goodthing" value="<%=room.getGoodthing()%>"
						placeholder="편의시설을 입력하세요" title="숙소의 편의시설을 입력하세요">
					</label>

					<!-- 숙소 지역 -->
					<label for="addr_detail"> 숙소 지역: <input type="text"
						id="addr_detail" name="addr_detail"
						value="<%=room.getAddr_detail()%>" placeholder="숙소 지역을 입력하세요"
						title="숙소의 상세 지역을 입력하세요">
					</label>

					<!-- 숙소 가격 -->
					<label for="price"> 숙소 가격: <input type="text" id="price"
						name="price" value="<%=room.getPrice()%>"
						placeholder="숙소 가격을 입력하세요" title="숙소 1박당 가격을 입력하세요"> / 박
					</label>

					<!-- 인원수 -->
					<label for="room_min"> 인원수: <input type="number"
						id="room_min" name="room_min" min="2"
						value="<%=room.getRoom_min()%>" placeholder="최소 인원수"
						title="최소 인원수를 입력하세요" required> ~ <input type="number"
						id="room_max" name="room_max" min="2"
						value="<%=room.getRoom_max()%>" placeholder="최대 인원수"
						title="최대 인원수를 입력하세요" required> 명
					</label>
				</div>


				<h2>후기 관리</h2>
                <%
                ArrayList<RoomDTO> arr= rdao.Review_select(idx);
                if(arr==null||arr.size()==0){
                	%><label>등록된 후기가 없습니다.</label><%
                }else{
                	for(int i=0;i<arr.size();i++){
					%>
					
					<div>
						<div class="reviews">
							<p>작성자 :<label><%=arr.get(i).getMember_id() %></label></p>
							<p>별점 :<%=arr.get(i).getRate() %></p>
							<p>내용 :<label><%=arr.get(i).getContent() %></label></p>
							
					</div>
						<!-- 
						<form name="deletefm" action="reviews_delete.jsp">
						<div class="button_delete">
							<input type="button" name="delete" value="삭제">
						</div>
						</form>
					</div> -->
						<%
						}
                }
                %>
                
            </div>
        </div>
        <div>
          	<div>	
                   
                    <input type="hidden" name="checkin" value="<%= request.getParameter("checkin") %>">
                    <input type="hidden" name="checkout" value="<%= request.getParameter("checkout") %>">
                    <input type="hidden" name="guests" value="<%=request.getParameter("guests") %>">
                    
                    
                    
                    <button type="submit" class="button">수정하기</button>
               		<%
               		} 
               		%>
            </div>
            
        </div>
    </main>
    <%@ include file="/footer.jsp"%>
</body>
</html>
