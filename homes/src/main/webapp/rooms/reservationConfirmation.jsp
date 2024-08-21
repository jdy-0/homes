<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 확인 및 결제</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/resConfirm.css">
</head>
<body>
<%@ include file="/header.jsp"%>
    <main class="container">
        <div class="back-link">
            <a href="information.jsp?room_idx=<%=request.getParameter("room_idx")%>">← 뒤로 가기</a>
        </div>
        <div class="header">
            확인 및 결제
        </div>
        <div class="info-section">
            <h3>예약 정보</h3>
            <%	String room_idx = request.getParameter("room_idx");
                String check_in = request.getParameter("check_in");
                String check_out = request.getParameter("check_out");
                String guest_num = request.getParameter("guest_num");
                String priceStr = request.getParameter("price"); // 가격 정보를 받아옴
                int price = Integer.parseInt(priceStr != null ? priceStr : "0"); // price 정보가 null일 경우 0으로 처리
/*                 int serviceFee = (int)(price * 0.1); // 서비스 수수료 10%
 */             int totalPrice = Integer.parseInt(request.getParameter("total_price")); // 총 합계
            %>
            <p>날짜: <%= check_in %> ~ <%= check_out %></p>
            <p>체크인 시간: ~</p>
            <p>인원수: <%= guest_num %></p>
        </div>
        <div class="price-section">
            <h3>요금 세부정보</h3>
            <p>₩<%= price %> / 박<span></span></p>
<%--             <p>서비스 수수료 <span>₩<%= serviceFee %></span></p>
 --%>            <p><strong>총 합계</strong> <span><strong>₩<%= totalPrice %></strong></span></p>
        </div>
        <div class="terms-section">
            <label>
                <input type="checkbox" id="terms-checkbox" name="termsAccepted">
                <a href="javascript:void(0);" onclick="showModal()">이용약관</a>에 동의합니다.
            </label>
        </div>
        <div class="request-section">
            <h3>요청사항</h3>
            <textarea id="request"></textarea>
        </div>
        <!-- 결제하기 버튼이 새로운 JSP 페이지로 POST 요청을 보냄 -->
        <form id="payment-form" action="/homes/pay/homesPayment.jsp" method="POST" accept-charset="UTF-8" onsubmit="setRequestTohidden();">
            <input type="hidden" name="room_idx" value="<%= room_idx %>">
            <input type="hidden" name="check_in" value="<%= check_in %>">
            <input type="hidden" name="check_out" value="<%= check_out %>">
            <input type="hidden" name="guest_num" value="<%= guest_num %>">
            <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
            <input type="hidden" name="request" value="" id="hid_request">
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
            <div class="modal-body" id="termsContent">
                <!-- 이용약관 내용이 로드될 부분 -->
            </div>
            <div class="modal-footer">
                <button onclick="closeModal()">확인</button>
            </div>
        </div>
    </div>

    <script>
        // 모달 창을 보여주는 함수
        function showModal() {
            // termsOfService.html 파일에서 이용약관 내용 불러오기
            var xhr = new XMLHttpRequest();
            xhr.open('GET','/homes/termsOfService.html', true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById('termsContent').innerHTML = xhr.responseText;
                    document.getElementById('termsModal').style.display = "block";
                }
            };
            xhr.send();
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
    <script type="text/javascript">
    	function setRequestTohidden(){
    		document.querySelector("#hid_request").value = document.querySelector('#request').value;
    	}
    </script>
    <%@ include file="/footer.jsp"%>
</body>
</html>
