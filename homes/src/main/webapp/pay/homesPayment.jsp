<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 정보 입력</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/payLayout.css">
<script>
// 결제 정보 유효성 검사 함수
function validatePaymentForm() {
    const cardNumber = document.getElementById('cardNumber').value.trim();
    const expiryDate = document.getElementById('expiryDate').value.trim();
    
    // 카드 번호 유효성 검사 (예: 16자리 숫자)
    if (!/^\d{16}$/.test(cardNumber)) {
        alert("유효한 카드 번호를 입력하세요 (16자리 숫자).");
        return false;
    }
    
    // 유효 기간 검사 (예: MM/YY 형식)
    if (!/^(0[1-9]|1[0-2])\/?([0-9]{2})$/.test(expiryDate)) {
        alert("유효한 유효 기간을 입력하세요 (MM/YY 형식).");
        return false;
    }
    
    // 모든 검사가 통과되면 폼 제출
    return true;
}
</script>
</head>
<body>
<%@ include file="/header.jsp"%>
    <main class="container">
        <div class="back-link">
            <a href="../rooms/reservationConfirmation.jsp">← 돌아가기</a>
        </div>
        <div class="header">결제 정보 입력</div>
        <form action="/homes/reserve/reserve.jsp" method="POST" accept-charset="UTF-8" onsubmit="return validatePaymentForm();">
            <div class="form-group">
                <label for="cardNumber">카드 번호:</label>
                <input type="text" id="cardNumber" name="cardNumber" required>
            </div>
            <div class="form-group">
                <label for="expiryDate">유효 기간:</label>
                <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
            </div>
            <div class="form-group">
	            <input type="hidden" name="room_idx" value="<%= request.getParameter("room_idx") %>">
                <input type="hidden" name="check_in" value="<%= request.getParameter("check_in") %>">
                <input type="hidden" name="check_out" value="<%= request.getParameter("check_out") %>">
                <input type="hidden" name="guest_num" value="<%= request.getParameter("guest_num") %>">
                <input type="hidden" name="totalPrice" value="<%= request.getParameter("totalPrice") %>">
                <input type="hidden" name="request" value="<%= request.getParameter("request") %>">
            </div>
            <button type="submit" class="payment-button">결제하기</button>
        </form>
    </main>
    <%@ include file="/footer.jsp"%>
</body>
</html>
