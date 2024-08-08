<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 확인 및 결제</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
    /* 기본 스타일 설정 */
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
    .info-section, .price-section, .terms-section, .payment-section {
        text-align: left;
        margin-bottom: 20px;
    }
    .info-section p, .price-section p {
        margin: 5px 0;
        border-bottom: 2px solid black;
        padding-bottom: 5px;
    }
    .price-section {
        border: 2px solid black;
        padding: 10px;
        border-radius: 10px;
        background-color: #fff;
    }
    .price-section p span {
        float: right;
    }
    .terms-section {
        margin-bottom: 20px;
    }
    .terms-section input {
        margin-right: 10px;
    }
    .payment-section select {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 5px;
        border: 2px solid black;
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
    .note {
        color: red;
        margin-top: 20px;
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
    /* 모달 창 스타일 */
    .modal {
        display: none; /* 처음에는 표시하지 않음 */
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.5); /* 배경을 어둡게 처리 */
    }
    .modal-content {
        background-color: #e2dccc;
        margin: 15% auto;
        padding: 20px;
        border: 4px solid black;
        width: 80%;
        max-width: 500px; /* 최대 너비를 설정하여 중앙에 고정 */
        border-radius: 10px;
    }
    .close-button {
        color: black;
        float: right;
        font-size: 28px;
        font-weight: bold;
        border: none;
        background: none;
        cursor: pointer;
    }
    .close-button:hover,
    .close-button:focus {
        color: #aaa;
        text-decoration: none;
        cursor: pointer;
    }
    .modal-header {
        font-size: 20px;
        margin-bottom: 15px;
        font-family: 'SBAggroB', Arial, sans-serif;
    }
    .modal-footer {
        text-align: right;
    }
    .modal-footer button {
        padding: 10px 20px;
        background-color: #dec022;
        color: black;
        border: 2px solid black;
        cursor: pointer;
        border-radius: 5px;
        font-family: 'SBAggroB', Arial, sans-serif;
    }
    .modal-footer button:hover {
        background-color: #e2dccc;
        transition: 0.5s;
    }
</style>
</head>
<body>
<%@ include file="/header.jsp"%>
    <main class="container">
        <div class="back-link">
            <a href="information.jsp">← 뒤로 가기</a>
        </div>
        <div class="header">
            확인 및 결제
        </div>
        <div class="info-section">
            <h3>예약 정보</h3>
            <%
                String checkin = request.getParameter("checkin");
                String checkout = request.getParameter("checkout");
                String guests = request.getParameter("guests");
                String priceStr = request.getParameter("price"); // 가격 정보를 받아옴
                int price = Integer.parseInt(priceStr != null ? priceStr : "0"); // price 정보가 null일 경우 0으로 처리
                int serviceFee = (int)(price * 0.1); // 서비스 수수료 10%
                int totalPrice = price + serviceFee; // 총 합계
            %>
            <p>날짜: <%= checkin %> ~ <%= checkout %></p>
            <p>체크인 시간: ~</p>
            <p>게스트: <%= guests %></p>
        </div>
        <div class="price-section">
            <h3>요금 세부정보</h3>
            <p>₩<%= price %> / 박<span></span></p>
            <p>서비스 수수료 <span>₩<%= serviceFee %></span></p>
            <p><strong>총 합계</strong> <span><strong>₩<%= totalPrice %></strong></span></p>
        </div>
        <div class="terms-section">
            <label>
                <input type="checkbox" id="terms-checkbox" name="termsAccepted">
                <a href="javascript:void(0);" onclick="showModal()">이용약관</a>에 동의합니다.
            </label>
        </div>
        <!-- 결제하기 버튼이 새로운 JSP 페이지로 POST 요청을 보냄 -->
        <form id="payment-form" action="/homes/pay/homesPayment.jsp" method="POST">
            <input type="hidden" name="checkin" value="<%= checkin %>">
            <input type="hidden" name="checkout" value="<%= checkout %>">
            <input type="hidden" name="guests" value="<%= guests %>">
            <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
            <button type="submit" class="payment-button" id="final-payment">결제하기</button>
        </form>
        <div class="note">
            실제 결제는 호스트의 예약 승인이 후에 이루어집니다.
        </div>
    </main>

    <!-- 모달 창 구조 -->
    <div id="termsModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <span class="close-button" onclick="closeModal()">&times;</span>
                이용약관
            </div>
            <div class="modal-body">
                <!-- 이용약관 내용을 여기에 추가할 수 있습니다. -->
                <p>여기에 이용약관 내용을 입력하세요.</p>
            </div>
            <div class="modal-footer">
                <button onclick="closeModal()">확인</button>
            </div>
        </div>
    </div>

    <script>
        // 모달 창을 보여주는 함수
        function showModal() {
            document.getElementById('termsModal').style.display = "block";
        }

        // 모달 창을 닫는 함수
        function closeModal() {
            document.getElementById('termsModal').style.display = "none";
        }

        // 결제하기 버튼 클릭 시 이용약관 체크 여부 확인
        document.getElementById('payment-form').addEventListener('submit', function(event) {
            const termsCheckbox = document.getElementById('terms-checkbox');
            if (!termsCheckbox.checked) {
                event.preventDefault(); // 폼 제출 중단
                alert('이용약관에 동의해야 결제를 진행할 수 있습니다.');
            }
        });
    </script>
    <%@ include file="/footer.jsp"%>
</body>
</html>
