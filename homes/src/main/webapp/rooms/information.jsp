<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.room.RoomDAO, com.homes.room.RoomDTO" %>
<%@ page import="com.homes.review.ReviewDAO, com.homes.review.ReviewDTO" %>
<%@ page import="com.homes.report.ReportDAO, com.homes.report.ReportDTO" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.util.concurrent.TimeUnit" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.List" %>
<%
try {
	 request.setCharacterEncoding("UTF-8");
    // 처리할 작업을 결정하는 파라미터
    String action = request.getParameter("action");

    if ("submitReview".equals(action)) {
        // 리뷰 작성 처리
        String memberId = request.getParameter("member_id");
        String reviewContent = request.getParameter("review");
        String rateParam = request.getParameter("rate");
        String roomIdxParam = request.getParameter("room_idx");

        if (memberId != null && !memberId.isEmpty() &&
            reviewContent != null && !reviewContent.isEmpty() &&
            rateParam != null && !rateParam.isEmpty() &&
            roomIdxParam != null && !roomIdxParam.isEmpty()) {

            int roomIdx = Integer.parseInt(roomIdxParam);
            int rate = Integer.parseInt(rateParam);

            ReviewDTO review = new ReviewDTO();
            review.setMemberId(memberId);
            review.setContent(reviewContent);
            review.setRoomIdx(roomIdx);
            review.setRate(rate);

            ReviewDAO reviewDAO = new ReviewDAO();
            reviewDAO.insertReview(review);

            response.sendRedirect("Review_ok.jsp?room_idx=" + roomIdx);
            return;
        } else {
            response.sendRedirect("errorPage.jsp?message=모든 필드를 입력해 주세요.");
            return;
        }
    } else if ("submitReport".equals(action)) {
        // 신고 처리
        String commentIdParam = request.getParameter("comment_id");
        String reportReason = request.getParameter("report_reason");
        String roomIdxParam = request.getParameter("room_idx");

        if (commentIdParam != null && !commentIdParam.isEmpty() &&
            reportReason != null && !reportReason.isEmpty() &&
            roomIdxParam != null && !roomIdxParam.isEmpty()) {

            int commentId = Integer.parseInt(commentIdParam);
            int roomIdx = Integer.parseInt(roomIdxParam);

            ReportDTO report = new ReportDTO();
            report.setCommentId(commentId);
            report.setRoomIdx(roomIdx);
            report.setReportReason(reportReason);

            ReportDAO reportDAO = new ReportDAO();
            reportDAO.insertReport(report);

            response.sendRedirect("Report_ok.jsp?room_idx=" + roomIdx);
            return;
        } else {
            response.sendRedirect("errorPage.jsp?message=모든 필드를 입력해 주세요.");
            return;
        }
    }

    // 기본 정보 로드 및 페이지 렌더링

    // 세션에서 로그인 여부를 확인
    String f = (String) session.getAttribute("userid");



    String roomIdxParam = request.getParameter("room_idx");
    RoomDTO room = null;
    double averageRate = 0.0;

    if (roomIdxParam != null && !roomIdxParam.isEmpty()) {
        try {
            int roomIdx = Integer.parseInt(roomIdxParam);
            RoomDAO roomDAO = new RoomDAO();
            room = roomDAO.getRoomById(roomIdx);

            if (room != null) {
                // 평균 평점 계산
                ReviewDAO reviewDAO = new ReviewDAO();
                averageRate = reviewDAO.getAverageRateByRoomIdx(roomIdx);
            } else {
                // 숙소를 찾지 못한 경우
                response.sendRedirect("errorPage.jsp?message=해당 숙소 정보를 찾을 수 없습니다.");
                return;
            }
        } catch (NumberFormatException e) {
            // 잘못된 room_idx가 입력된 경우
            response.sendRedirect("errorPage.jsp?message=유효하지 않은 숙소 ID입니다.");
            return;
        }
    } else {
        // room_idx가 없는 경우
        response.sendRedirect("errorPage.jsp?message=숙소 ID가 제공되지 않았습니다.");
        return;
    }

    String checkInParam = request.getParameter("check_in");
    String checkOutParam = request.getParameter("check_out");

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    long numberOfNights = 1; // 기본값 1박

    try {
        if (checkInParam != null && checkOutParam != null) {
            Date checkInDate = dateFormat.parse(checkInParam);
            Date checkOutDate = dateFormat.parse(checkOutParam);

            long diffInMillies = checkOutDate.getTime() - checkInDate.getTime();
            numberOfNights = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);

            if (numberOfNights < 1) {
                numberOfNights = 1; // 체크아웃이 체크인보다 빠르다면 기본값 1박
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("errorPage.jsp?message=날짜 형식이 올바르지 않습니다.");
        return;
    }

    // 총 숙박 비용 계산
    long totalCost = room != null ? room.getPrice() * numberOfNights : 0;

    // 리뷰 페이징 처리
    int pageNum = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
    int pageSize = 5;  // 페이지당 5개의 리뷰

    ReviewDAO reviewDAO = new ReviewDAO();
    List<ReviewDTO> reviews = null;
    int totalPageCount = 0;
    if (room != null) {
        try {
            reviews = reviewDAO.getReviewsByRoomIdxWithPaging(room.getRoom_idx(), pageNum, pageSize);
            int totalReviewCount = reviewDAO.getReviewCountByRoomIdx(room.getRoom_idx());
            totalPageCount = (int) Math.ceil(totalReviewCount / (double) pageSize);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp?message=리뷰를 불러오는 중 오류가 발생했습니다.");
            return;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 정보</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/infoLayout.css">
</head>
<body>
<%@ include file="/header.jsp"%>

<% 
    // 신고 성공 메시지 표시
    String reportSuccess = request.getParameter("reportSuccess");
    if (reportSuccess != null && reportSuccess.equals("true")) {
%>
    <div style="color: green; font-weight: bold; margin-bottom: 20px;">
        신고가 성공적으로 접수되었습니다.
    </div>
<%
    }
%>

<% 
    // 신고 오류 메시지 표시 (필요에 따라 추가 가능)
    String reportError = request.getParameter("reportError");
    if (reportError != null && reportError.equals("true")) {
%>
    <div style="color: red; font-weight: bold; margin-bottom: 20px;">
        신고 처리 중 오류가 발생했습니다.
    </div>
<%
    }
%>
<main class="container">
    <% if (room != null) { %>
        <div class="top">
            <h1>숙소 정보</h1>
            <div class="room-details">
                <h2><%= room.getRoom_name() %></h2>
                <p><%= room.getGoodthing() %></p>
                <p><%= room.getAddr_detail() %></p>
                <div class="room-images">
                    <img src="<%= room.getImage() %>" alt="메인 숙소 이미지">
                    <img src="<%= room.getImage() %>" alt="서브 숙소 이미지 1">
                    <img src="<%= room.getImage() %>" alt="서브 숙소 이미지 2">
                    <img src="<%= room.getImage() %>" alt="서브 숙소 이미지 3">
                </div>
            </div>
        </div>
        <div class="left">
            <div class="reviews">
                <div style="display: flex; align-items: center; background-color: #dec022; padding: 10px; border-radius: 5px; border: 2px solid black;">
                    <span style="font-size: 18px; font-family: 'SBAggroB', Arial, sans-serif; margin-right: auto;">
                        (후기) ★ <%= new DecimalFormat("#.0").format(averageRate) %> / 5.0
                    </span>
                    <a href="javascript:void(0);" onclick="showReviewModal()">후기 쓰기</a>
                </div>
            </div>
 <div id="reviews-section">
    <h3>후기 목록</h3>
    <div class="review-list">
        <% if (reviews != null && !reviews.isEmpty()) { %>
            <% for (ReviewDTO review : reviews) { %>
<div class="review-item">
    <p><strong>아이디:</strong> <%= review.getMemberId() != null ? review.getMemberId() : "Unknown" %></p>
    <p><strong>별점:</strong> <span id="review-rate-<%= review.getIdx() %>"><%= review.getRate() %></span>점</p>
    <p id="review-content-<%= review.getIdx() %>"><%= review.getContent() %></p>
    <% if (userid != null &&  review.getMemberId().equals(userid)) { %>
        <span class="edit-btn" onclick="editReview(<%= review.getIdx() %>, <%= review.getRoomIdx() %>)">수정</span>
        <span class="delete-btn" onclick="deleteReview(<%= review.getIdx() %>, <%= review.getRoomIdx() %>)">삭제</span>
    <% } %>
    <span class="report-btn" onclick="showReportModal(<%= review.getIdx() %>)">신고</span>
</div>



            <% } %>
        <% } else { %>
            <p>아직 후기가 없습니다.</p>
        <% } %>
    </div>
</div>
 
                <div class="pagination">
                    <% for (int i = 1; i <= totalPageCount; i++) { %>
                        <a href="information.jsp?room_idx=<%= room.getRoom_idx() %>&page=<%= i %>" class="<%= i == pageNum ? "active" : "" %>">
                            <%= i %>
                        </a>
                    <% } %>
                </div>
            </div>
        </div>
        <div class="right">
            <p class="price">₩<%= room.getPrice() %> / 박</p>
            <div>
				<input type="text" name="check_in" value="<%= (request.getParameter("check_in") != null) ? request.getParameter("check_in") : "" %>" readonly="readonly">
				<input type="text" name="check_out" value="<%= (request.getParameter("check_out") != null) ? request.getParameter("check_out") : "" %>" readonly="readonly">
            	<jsp:include page="information_cal.jsp">
            		<jsp:param value="<%=roomIdxParam %>" name="room"/>
            		<jsp:param value="<%=room.getPrice() %>" name="price"/>
            	</jsp:include>
            	
            </div>

			<label for="checkin">인원수</label> <input type="number" name="guest_num" id="select_guest" min="2" value="<%=(request.getParameter("guest_num")!=null) ?request.getParameter("guest_num"):2 %>" required>


            <div class="reservation-box">
                <div class="details">

                    <p>총 합계: ₩<span id="room_total_price"><%= room.getPrice() %></span></p>
                </div>
                <form id="reservationForm" action="reservationConfirmation.jsp" method="get">
                	
                    <input type="hidden" name="room_idx" value="<%= room.getRoom_idx() %>" id="hid_room_idx">
                    <input type="hidden" name="price" value="<%= room.getPrice() %>" id="hid_room_price">
                    <input type="hidden" name="total_price" value="0" id="hid_room_total_price">
                    <input type="hidden" name="check_in" value="<%= request.getParameter("check_in") %>" id="hid_check_in">
                    <input type="hidden" name="check_out" value="<%= request.getParameter("check_out") %>" id="hid_check_out">
                    <input type="hidden" name="guest_num" value="<%= request.getParameter("guest_num") %>" id="hid_guest_num">
                    <button type="submit" class="button" onclick="setInputValuesTohidden();">예약하기</button>

                </form>
            </div>

        </div>

    <% } else { %>
        <p>해당 숙소 정보를 찾을 수 없습니다.</p>
    <% } %>
</main>

<!-- 후기 쓰기 모달 -->
<div id="review-modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeReviewModal()">&times; 닫기</span>
        <h2 style="margin-bottom: 20px;">후기 작성</h2>
        <form method="post" action="information.jsp?action=submitReview" accept-charset="UTF-8" onsubmit="return submitReview();">
            <div class="review-inputs">
                <input type="text" name="member_id" value="<%=userid%>" readonly>
                <textarea name="review" placeholder="후기를 작성하세요..." required></textarea>
            </div>
            <div class="star-rating">
                <input type="radio" id="star5" name="rate" value="5"><label for="star5">★</label>
                <input type="radio" id="star4" name="rate" value="4"><label for="star4">★</label>
                <input type="radio" id="star3" name="rate" value="3"><label for="star3">★</label>
                <input type="radio" id="star2" name="rate" value="2"><label for="star2">★</label>
                <input type="radio" id="star1" name="rate" value="1"><label for="star1">★</label>
                <input type="hidden" name="room_idx" value="<%=request.getParameter("room_idx")%>">

            </div>
            <button type="submit">후기 제출</button>
        </form>
    </div>
</div>
<!-- 신고 모달 HTML -->
<div id="report-modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeReportModal()">&times; 닫기</span>
        <h2 style="margin-bottom: 20px;">신고하기</h2>
        <form method="post" action="information.jsp?action=submitReport" accept-charset="UTF-8" onsubmit="return submitReport();">
            <input type="hidden" id="comment-id" name="comment_id" value="">
            <div class="reason-list">
                <label><input type="radio" name="report_reason" value="스팸홍보/도배"> 스팸홍보/도배입니다.</label>               
                <label><input type="radio" name="report_reason" value="불법정보"> 불법정보를 포함하고 있습니다.</label>
                <label><input type="radio" name="report_reason" value="청소년유해"> 청소년에게 유해한 내용입니다.</label>
                <label><input type="radio" name="report_reason" value="욕설/혐오"> 욕설/생명경시/혐오/차별적 표현입니다.</label>
                <label><input type="radio" name="report_reason" value="개인정보노출"> 개인정보가 노출되었습니다.</label>
                <label><input type="radio" name="report_reason" value="불쾌한표현"> 불쾌한 표현이 있습니다.</label>
                <label><input type="radio" name="report_reason" value="저작권/명예훼손"> 저작권/명예훼손 등 권리 침해입니다.</label>
                <label><input type="radio" name="report_reason" value="사기/거짓정보"> 사기/거짓 정보입니다.</label>
                <label><input type="radio" name="report_reason" value="기타"> 기타</label>
                <input type="hidden" name="room_idx" value="<%=request.getParameter("room_idx")%>">
                
            </div>
            <button type="submit">신고하기</button>
        </form>
    </div>
</div>
<!-- 리뷰 수정 모달 -->
<div id="edit-review-modal" style="display:none; position:fixed; z-index:1000; left:50%; top:50%; transform:translate(-50%, -50%); background-color:white; padding:30px; border:2px solid black; width:600px; height:auto;">
    <div class="modal-content">
        <span class="close-btn" onclick="closeEditReviewModal()">&times; 닫기</span>
        <h2>리뷰 수정</h2>
        <form id="edit-review-form" method="post" action="editReview_ok.jsp" accept-charset="UTF-8">
            <input type="hidden" id="edit-review-id" name="review_id" value="">
            <input type="hidden" id="edit-room-idx" name="room_idx" value="">
            <textarea id="edit-review-text" name="review_content" placeholder="수정할 내용을 입력하세요..." required></textarea>
            
            <!-- 별점 선택 -->
            <div class="star-rating">
                <input type="radio" id="edit-star5" name="rate" value="5"><label for="edit-star5">★</label>
                <input type="radio" id="edit-star4" name="rate" value="4"><label for="edit-star4">★</label>
                <input type="radio" id="edit-star3" name="rate" value="3"><label for="edit-star3">★</label>
                <input type="radio" id="edit-star2" name="rate" value="2"><label for="edit-star2">★</label>
                <input type="radio" id="edit-star1" name="rate" value="1"><label for="edit-star1">★</label>
            </div>
            
            <button type="submit">수정 완료</button>
        </form>
    </div>
</div>
<%@ include file="/footer.jsp"%>
<%
} finally {
    // 여기에 리소스 해제 코드 또는 로그 등을 추가할 수 있습니다.
}
%> 
<script>
function showReviewModal() {
    <% 
    // 세션에서 로그인 여부를 확인
    String userid = (String) session.getAttribute("userid");
    if (userid == null || userid.isEmpty()) {
    %>
        alert("로그인이 필요한 서비스입니다.");
        window.open("http://localhost:9090/homes/guest/login_popup.jsp", "loginPopup", "width=400,height=500,scrollbars=no,toolbar=no,menubar=no,resizable=no");
    <% } else { %>
        document.getElementById('review-modal').style.display = 'block';
    <% } %>
}



function closeReviewModal() {
    document.getElementById('review-modal').style.display = 'none';
}

function showReportModal(commentId) {
    document.getElementById('report-modal').style.display = 'block';
    document.getElementById('comment-id').value = commentId;
}

function closeReportModal() {
    document.getElementById('report-modal').style.display = 'none';
}

function submitReview() {
    alert("후기 제출 완료!!");
    return true;
}

function submitReport() {
    const reason = document.querySelector('input[name="report_reason"]:checked');
    if (!reason) {
        alert('신고 사유를 선택해주세요.');
        return false;
    }
    alert('신고가 성공적으로 접수되었습니다.');
    return true;
}

function editReview(reviewId, roomIdx) {
    // 리뷰 수정 모달을 띄웁니다.
    const reviewContent = document.getElementById('review-content-' + reviewId).innerText;
    const reviewRate = document.getElementById('review-rate-' + reviewId).innerText; // 기존 별점 가져오기
    
    document.getElementById('edit-review-modal').style.display = 'block';
    document.getElementById('edit-review-id').value = reviewId;
    document.getElementById('edit-room-idx').value = roomIdx;
    document.getElementById('edit-review-text').value = reviewContent;
    
    // 기존 별점 설정
    document.querySelector(`input[name="rate"][value="${reviewRate}"]`).checked = true;
}

// 모달을 닫는 함수
function closeEditReviewModal() {
    document.getElementById('edit-review-modal').style.display = 'none';
}

// 리뷰 수정 폼을 제출하는 함수
function submitEditReview() {
    document.getElementById('edit-review-form').submit();
}

function deleteReview(reviewId, roomIdx) {
    if (confirm("정말로 이 후기를 삭제하시겠습니까?")) {
        window.location.href = "deleteReview_ok.jsp?review_id=" + reviewId + "&room_idx=" + roomIdx;
    }
}
function setInputValuesTohidden(){
	var ch_in = document.querySelector('input[name="check_in"]');
	var ch_out = document.querySelector('input[name="check_out"]');
	var gst_n = document.querySelector('input[name="guest_num"]');
	var room_total_price = document.querySelector('#room_total_price');
		
	document.querySelector('#hid_check_in').value = ch_in.value;
	document.querySelector('#hid_check_out').value = ch_out.value;
	document.querySelector('#hid_guest_num').value = gst_n.value;
	document.querySelector('#hid_room_total_price').value = room_total_price.innerText;
}
</script>
</body>
<script>
</script>
</html>
