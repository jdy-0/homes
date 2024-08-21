<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.homes.review.ReviewDAO, com.homes.review.ReviewDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 보기 및 작성</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/reviewLayout.css">
<script>
    // 자바스크립트를 이용한 폼 유효성 검사
    function validateReviewForm() {
        const reviewText = document.querySelector('textarea[name="review"]').value.trim();
        const rateValue = document.querySelector('input[name="rate"]:checked');
        if (reviewText === "") {
            alert("후기를 작성해주세요.");
            return false;
        }
        if (!rateValue) {
            alert("별점을 선택해주세요.");
            return false;
        }
        return true;
    }

    // 신고 모달 창 열기
    function showReportModal(reviewId) {
        document.getElementById('reportModal').style.display = 'block';
        document.getElementById('report_review_id').value = reviewId;
    }

    // 신고 모달 창 닫기
    function closeReportModal() {
        document.getElementById('reportModal').style.display = 'none';
    }
</script>
</head>
<body>
<%@ include file="/header.jsp"%>
<main class="container">
    <div class="back-link">
        <a href="information.jsp?room_idx=<%= request.getParameter("room_idx") %>">← 돌아가기</a>
    </div>
    <div class="header">
        후기 보기 및 작성
    </div>

    <%
        // room_idx 값 확인 및 초기화
        String roomIdxParam = request.getParameter("room_idx");
        int roomIdx = 0;
        boolean validRoom = true;
        int pageNum = 1;
        int totalPageCount = 0;

        if (roomIdxParam == null || roomIdxParam.isEmpty()) {
            out.println("<p>유효하지 않은 숙소 ID입니다.</p>");
            validRoom = false;
        } else {
            try {
                roomIdx = Integer.parseInt(roomIdxParam);
            } catch (NumberFormatException e) {
                out.println("<p>유효하지 않은 숙소 ID입니다.</p>");
                validRoom = false;
                e.printStackTrace();
            }
        }

        if (validRoom) {
            // 후기 리스트를 가져오는 로직
            pageNum = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
            int pageSize = 10;

            ReviewDAO reviewDAO = new ReviewDAO();

            // 페이징된 리뷰 가져오기
            List<ReviewDTO> reviews = null;
            try {
                reviews = reviewDAO.getReviewsByRoomIdxWithPaging(roomIdx, pageNum, pageSize);
                int totalReviewCount = reviewDAO.getReviewCountByRoomIdx(roomIdx);
                totalPageCount = (int) Math.ceil(totalReviewCount / (double) pageSize);
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>리뷰를 불러오는 중 오류가 발생했습니다.</p>");
            }

            // 리뷰 출력
            if (reviews != null && !reviews.isEmpty()) {
                for (ReviewDTO review : reviews) {
                    // 아이디 마스킹 처리
                    String memberId = review.getMemberId();
                    String displayedMemberId = "Unknown";  // 기본값 설정

                    if (memberId != null) {  // Null 체크 추가
                        if (memberId.length() <= 4) {
                            displayedMemberId = memberId; // 아이디가 4자리 이하라면 마스킹 없이 그대로 반환
                        } else {
                            String visiblePart = memberId.substring(0, 4); // 처음 4자리
                            String maskedPart = memberId.substring(4).replaceAll(".", "*"); // 나머지 부분을 *로 대체
                            displayedMemberId = visiblePart + maskedPart;
                        }
                    }
    %>
                    <div class="review-item">
                        <p><strong>아이디:</strong> <%= displayedMemberId %></p>
                        <p><strong>별점:</strong> <%= review.getRate() %>점</p>
                        <p><%= review.getContent() %></p>
                        <button onclick="showReportModal(<%= review.getIdx() %>)">신고</button>
                    </div>
    <%
                }
            } else {
    %>
                <p>아직 후기가 없습니다.</p>
    <%
            }
        }
    %>

    <!-- 페이지 네비게이션 -->
    <div class="pagination">
        <% if (validRoom) { for (int i = 1; i <= totalPageCount; i++) { %>
            <a href="review.jsp?room_idx=<%= roomIdx %>&page=<%= i %>" class="<%= i == pageNum ? "active" : "" %>">
                <%= i %>
            </a>
        <% } } %>
    </div>

    <!-- 후기 작성 폼 -->
    <div class="review-form">
        <% if (validRoom) { %>
        <form method="post" action="submitReview.jsp" onsubmit="return validateReviewForm();" accept-charset="UTF-8">
            <div class="review-header">
                <h3>후기 작성</h3>
                <div class="star-rating">
                    <input type="radio" id="star5" name="rate" value="5"><label for="star5">★</label>
                    <input type="radio" id="star4" name="rate" value="4"><label for="star4">★</label>
                    <input type="radio" id="star3" name="rate" value="3"><label for="star3">★</label>
                    <input type="radio" id="star2" name="rate" value="2"><label for="star2">★</label>
                    <input type="radio" id="star1" name="rate" value="1"><label for="star1">★</label>
                </div>
            </div>
            <div class="review-inputs">
                <textarea name="review" placeholder="후기를 작성하세요..."></textarea>
            </div>
            <input type="hidden" name="room_idx" value="<%= roomIdx %>">
            <button type="submit">후기 제출</button>
        </form>
        <% } %>
    </div>
</main>

<!-- 신고 모달 창 -->
<div id="report-modal" style="display:none; position:fixed; top:20%; left:50%; transform:translate(-50%, 0); padding:20px; background-color:#fff; border:1px solid #ccc; z-index:1000;">
    <h3>신고하기</h3>
   <form method="post" action="submitReport.jsp" onsubmit="return submitReport();" accept-charset="UTF-8">
        <input type="hidden" id="comment-id" name="comment_id">
        <input type="hidden" id="room-idx" name="room_idx" value="<%= request.getParameter("room_idx") %>">
        <div class="reason-list" style="margin-bottom: 20px; font-size: 1.2rem;">
            <label style="display: block; margin-bottom: 15px;"><input type="radio" name="report_reason" value="스팸홍보/도배"> 스팸홍보/도배입니다.</label>
            <label style="display: block; margin-bottom: 15px;"><input type="radio" name="report_reason" value="불법정보"> 불법정보를 포함하고 있습니다.</label>
            <label style="display: block; margin-bottom: 15px;"><input type="radio" name="report_reason" value="청소년유해"> 청소년에게 유해한 내용입니다.</label>
            <label style="display: block; margin-bottom: 15px;"><input type="radio" name="report_reason" value="욕설/혐오"> 욕설/생명경시/혐오/차별적 표현입니다.</label>
            <label style="display: block; margin-bottom: 15px;"><input type="radio" name="report_reason" value="개인정보노출"> 개인정보가 노출되었습니다.</label>
            <label style="display: block; margin-bottom: 15px;"><input type="radio" name="report_reason" value="불쾌한표현"> 불쾌한 표현이 있습니다.</label>
            <label style="display: block; margin-bottom: 15px;"><input type="radio" name="report_reason" value="저작권/명예훼손"> 저작권/명예훼손 등 권리 침해입니다.</label>
            <label style="display: block; margin-bottom: 15px;"><input type="radio" name="report_reason" value="사기/거짓정보"> 사기/거짓 정보입니다.</label>
            <label style="display: block; margin-bottom: 15px;"><input type="radio" name="report_reason" value="기타"> 기타</label>
        </div>
        <button type="submit" style="width: 100%; padding: 10px 0; font-size: 16px;">신고하기</button>
        <button type="button" onclick="closeReportModal()" style="width: 100%; padding: 10px 0; margin-top: 10px;">닫기</button>
    </form>
</div>

<script>
    function showReportModal(commentId) {
        document.getElementById('report-modal').style.display = 'block';
        document.getElementById('comment-id').value = commentId; // 댓글 ID를 숨겨진 필드에 저장
    }

    function closeReportModal() {
        document.getElementById('report-modal').style.display = 'none';
    }

    function submitReport() {
        const reason = document.querySelector('input[name="report_reason"]:checked');
        if (!reason) {
            alert('신고 사유를 선택해주세요.');
            return false;
        }

        // 팝업 메시지 표시
        alert('신고가 성공적으로 접수되었습니다.');

        return true; // 폼 제출을 계속 진행합니다.
    }
</script>

<%@ include file="/footer.jsp"%>
</body>
</html>