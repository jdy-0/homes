<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 정보 입력</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #f8f9fa;
    }
    .container {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        border: 1px solid #ccc;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        text-align: center;
    }
    .header {
        font-size: 24px;
        margin-bottom: 20px;
        text-align: left;
    }
    .form-group {
        margin-bottom: 15px;
        text-align: left;
    }
    .form-group label {
        display: block;
        margin-bottom: 5px;
    }
    .form-group input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .payment-button {
        display: block;
        width: 100%;
        padding: 15px;
        background-color: #ff4d4d;
        color: white;
        border: 2px solid #ff4d4d;
        cursor: pointer;
        text-align: center;
        border-radius: 5px;
        font-size: 18px;
        margin-top: 20px;
    }
    .payment-button:hover {
        background-color: #ff3333;
    }
    .back-link {
        text-align: left;
        margin-bottom: 20px;
    }
    .back-link a {
        color: #007BFF;
        text-decoration: none;
    }
    .back-link a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
<%@ include file="/header.jsp"%>
    <main class="container">
        <div class="back-link">
            <a href="../rooms/reservationConfirmation.jsp">← 돌아가기</a>
        </div>
        <div class="header">결제 정보 입력</div>
        <form action="processPayment.jsp" method="POST">
            <div class="form-group">
                <label for="cardNumber">카드 번호:</label>
                <input type="text" id="cardNumber" name="cardNumber" required>
            </div>
            <div class="form-group">
                <label for="expiryDate">유효 기간:</label>
                <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
            </div>
            <div class="form-group">
                <label for="cvv">CVV:</label>
                <input type="text" id="cvv" name="cvv" required>
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
