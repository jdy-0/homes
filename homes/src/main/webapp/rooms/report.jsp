<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<style>
    /* 모달 창 스타일 */
    #report-modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        background-color: white;
        padding: 30px;
        border: 2px solid black;
        width: 400px;
        height: auto;
    }

    /* 닫기 버튼 스타일 */
    #report-modal .close-btn {
        cursor: pointer;
        font-size: 20px;
        font-weight: bold;
        float: right;
    }

    /* 신고 사유 리스트 스타일 */
    .reason-list label {
        display: block;
        margin-bottom: 10px;
    }

    /* 신고하기 버튼 스타일 */
    #report-modal button[type="submit"] {
        width: 100%;
        padding: 10px 0;
        font-size: 16px;
        background-color: #dec022;
        border: 2px solid black;
        cursor: pointer;
        border-radius: 5px;
    }

    #report-modal button[type="submit"]:hover {
        background-color: #e2dccc;
        transition: 0.5s;
    }
</style>
</head>
<body>

<!-- 신고 모달 HTML -->
<div id="report-modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeReportModal()">&times; 닫기</span>
        <h2 style="margin-bottom: 20px;">신고하기</h2>
        <form method="post" action="submitReport.jsp" onsubmit="return submitReport();">
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
			<label><input type="radio" name="report_reason"value="기타"> 기타</label>
			<input type="hidden" name="room_idx" value="">
            </div>
            <button type="submit">신고하기</button>
        </form>
    </div>
</div>

<script>
    // 모달 창을 열기 위한 함수
    function showReportModal(commentId) {
        document.getElementById('report-modal').style.display = 'block';
        document.getElementById('comment-id').value = commentId; // 댓글 ID를 숨겨진 필드에 저장
    }

    // 모달 창을 닫기 위한 함수
    function closeReportModal() {
        document.getElementById('report-modal').style.display = 'none';
    }

    // 신고 폼 제출 전 확인
    function submitReport() {
        const reason = document.querySelector('input[name="report_reason"]:checked');
        if (!reason) {
            alert('신고 사유를 선택해주세요.');
            return false;
        }

        // 팝업 메시지 표시
        alert('신고가 성공적으로 접수되었습니다.');

        return true;
    }
</script>

</body>
</html>
