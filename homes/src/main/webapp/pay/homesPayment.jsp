<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 정보 입력</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
    body {
        font-family: 'Ownglyph_meetme-Rg', Arial, sans-serif;
        margin: 20px;
        background-color: #f8f9fa;
    }
    .container {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        background-color: #e2dccc;
        border: 4px solid black;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        text-align: center;
    }
    .header {
        font-size: 24px;
        margin-bottom: 20px;
        text-align: left;
        background-color: #dec022;
        padding: 10px;
        border: 2px solid black;
        border-radius: 5px;
    }
    .form-group {
        margin-bottom: 15px;
        text-align: left;
    }
    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-family: 'SBAggroB', Arial, sans-serif;
        font-size: 18px;
    }
    .form-group input {
        width: 100%;
        padding: 10px;
        border: 2px solid black;
        border-radius: 5px;
        font-size: 16px;
        font-family: 'Ownglyph_meetme-Rg', Arial, sans-serif;
    }
    .payment-button {
        display: block;
        width: 100%;
        padding: 15px;
        background-color: #dec022;
        color: black;
        border: 2px solid black;
        cursor: pointer;
        text-align: center;
        border-radius: 5px;
        font-family: 'SBAggroB', Arial, sans-serif;
        font-size: 20px;
        margin-top: 20px;
    }
    .payment-button:hover {
        background-color: #e2dccc;
        transition: 0.5s;
    }
    .back-link {
        text-align: left;
        margin-bottom: 20px;
    }
    .back-link a {
        color: black;
        text-decoration: none;
        background-color: #dec022;
        border: 2px solid black;
        border-radius: 5px;
        padding: 5px 10px;
        font-family: 'SBAggroB', Arial, sans-serif;
        font-size: 18px;
    }
    .back-link a:hover {
        background-color: #e2dccc;
        transition: 0.5s;
    }
</style>
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
        <form action="processPayment.jsp" method="POST" onsubmit="return validatePaymentForm();">
            <div class="form-group">
                <label for="cardNumber">카드 번호:</label>
                <input type="text" id="cardNumber" name="cardNumber" required>
            </div>
            <div class="form-group">
                <label for="expiryDate">유효 기간:</label>
                <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
            </div>
            <div class="form-group">
                <input type="hidden" name="checkin" value="<%= request.getParameter("checkin") %>">
                <input type="hidden" name="checkout" value="<%= request.getParameter("checkout") %>">
                <input type="hidden" name="guests" value="<%= request.getParameter("guests") %>">
                <input type="hidden" name="totalPrice" value="<%= request.getParameter("totalPrice") %>">
            </div>
            <button type="submit" class="payment-button">결제하기</button>
        </form>
    </main>
    <%@ include file="/footer.jsp"%>
</body>
</html>
