<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<%@page import="java.io.*"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>숙소 등록</title>
    <link rel="stylesheet" type="text/css" href="/homes/css/hostMainLayout.css">
    <style>
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
        
    </style>
</head>
	<%@include file="../header.jsp"%>
	<%
	String name = (String) session.getAttribute("userid");

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
<body>

	<%@include file="hostheader.jsp"%>
	<section>
		<form name="fminsertroom" action="hostinsert_ok.jsp">
			<div class="container">
				<div>
					<fieldset>
						<legend>이미지 등록하기 </legend>
						<img src="/homes/img/no_image.jpg" alt="이미지 없음"> <input
							type="file" name="image" accept="image/*" multiple>
					</fieldset>
				</div>
				<div id="roominsert">
					<h2>숙소 등록 하기</h2>
					<ul>
						<li><label>숙소 이름:</label> <input type="text" name="room_name"
							name="room_img" required></li>
						<li><label for="room_min">인원수:</label> <input type="number"
							id="room_min" name="room_min" min="2" required
							placeholder="최소 인원수"> ~ <input type="number"
							id="room_max" name="room_max" min="2" required
							placeholder="최대 인원수"></li>
						<li><label for="details">세부사항:</label> <input type="text"
							name="goothing" required placeholder="세부사항 입력"></li>
						<li><label for="addr_detail">주소:</label> <input type="text"
							name="addr_detail" required placeholder="주소 입력"></li>
						<li><label for="price">가격:</label> <input type="text"
							name="price" required placeholder="가격 입력"></li>
					</ul>
				</div>
				<div>
					<input type="hidden" name="Folder" value="<%=name%>"> <input
						type="submit" value="등록">
				</div>
			</div>
		</form>
	</section>
</body>
</html>
