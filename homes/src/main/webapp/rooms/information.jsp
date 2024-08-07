<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 정보</title>
<style>
    /* 기본 스타일 설정 */
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #f8f9fa;
    }
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        min-height: 800px; /* 흰색 테두리 아래 공간 확보 */
    }
    .header {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        margin-bottom: 20px;
    }
    .header h1 {
        font-size: 32px;
        margin: 0;
        display: inline;
    }
    .header p {
        font-size: 18px;
        color: #666;
        margin: 0;
        display: inline;
        margin-left: 10px;
    }
    .main-content {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap; /* Flexbox 아이템이 줄 바꿈이 가능하도록 설정 */
    }
    .main-top {
        width: 100%;
        margin-bottom: 20px;
    }
    .main-left {
        width: 65%;
        margin-right: 20px;
    }
    .main-right {
        width: 30%;
        background-color: #f1f1f1;
        padding: 20px;
        border-radius: 10px;
    }
    .이미지 img {
        width: 100%;
        height: auto;
        border-radius: 10px;
    }
    .사진들 {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        margin-top: 20px;
    }
    .사진들 img {
        width: 48%;
        height: auto;
        border-radius: 10px;
        margin-bottom: 10px;
    }
    .모든사진보기 {
        text-align: right;
        margin-top: 10px;
    }
    .모든사진보기 a {
        color: #007BFF;
        text-decoration: none;
    }
    .모든사진보기 a:hover {
        text-decoration: underline;
    }
    button {
        display: block;
        width: 100%;
        margin-top: 10px;
        padding: 10px;
        background-color: #007BFF;
        color: white;
        border: none;
        cursor: pointer;
        text-align: center;
        border-radius: 5px;
        font-size: 16px;
    }
    button:hover {
        background-color: #0056b3;
    }
    .후기, .숙소 시설, .가격, .날짜 선택, .인원 선택, .총 비용 {
        margin-bottom: 10px;
    }
    .후기 span, .가격 p, .총 비용 p {
        font-weight: bold;
    }
    .날짜 선택, .인원 선택 {
        margin-bottom: 10px;
    }
    .날짜 선택 label, .인원 선택 label {
        display: block;
        margin-bottom: 5px;
    }
    .후기 {
        display: flex;
        align-items: center;
        margin-top: 10px;
    }
    .후기 img {
        margin-right: 10px;
        vertical-align: middle;
    }
    .후기 span a { /* 추가된 부분: 후기 링크 스타일 */
        color: #007BFF;
        text-decoration: none;
    }
    .후기 span a:hover {
        text-decoration: underline;
    }
    .예약-summary {
        border: 1px solid #ccc;
        padding: 10px;
        box-sizing: border-box;
        border-radius: 10px;
        background-color: #fff;
        margin-top: 20px;
    }
    .예약-summary p {
        margin: 5px 0;
    }
    .총 비용 {
        font-size: 18px;
        color: #000;
    }

    /* 로그인 팝업 스타일 */
    #로그인팝업, #경고팝업 {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 300px;
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        z-index: 1000;
        text-align: center;
    }
    #로그인팝업 .close, #경고팝업 .close {
        position: absolute;
        top: 10px;
        right: 10px;
        cursor: pointer;
    }
    #로그인팝업 form, #경고팝업 form {
        display: flex;
        flex-direction: column;
    }
    #로그인팝업 form input, #경고팝업 form input {
        margin-bottom: 10px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    #로그인팝업 form button, #경고팝업 button {
        padding: 10px;
        background-color: #007BFF;
        color: white;
        border: none;
        cursor: pointer;
        border-radius: 5px;
    }
    #로그인팝업 form button:hover, #경고팝업 button:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
    <main class="container">
        <!-- 메인 이미지와 상세 사진들 -->
        <div class="main-top">
            <div class="header">
                <!-- 숙소 이름과 설명 -->
                <div>
                    <h1>부산 아파트</h1>
                    <span>|</span>
                    <p>서해안로 도로 10호, 오션뷰, 전망 좋은 아파트, 무료주차 가능</p>
                </div>
            </div>
            <!-- 메인 이미지 -->
            <section id="숙소 정보">
                <div class="이미지">
                    <img src="path_to_image.jpg" alt="숙소 이미지">
                </div>
            </section>
            <!-- 상세 사진들 -->
            <section class="사진들">
                <img src="path_to_image1.jpg" alt="사진1">
                <img src="path_to_image2.jpg" alt="사진2">
                <img src="path_to_image3.jpg" alt="사진3">
                <img src="path_to_image4.jpg" alt="사진4">
            </section>
            <!-- 모든 사진 보기 링크 -->
            <div class="모든사진보기">
                <a href="#">모든 사진 보기</a>
            </div>
        </div>

        <div class="main-content">
            <!-- 별점, 후기, 숙소 시설, 호스트 정보 -->
            <div class="main-left">
                <!-- 별점 및 후기 -->
                <div class="후기">
                    <img src="star_icon.png" alt="별점">
                    <!-- 후기 링크 추가 -->
                    <span><a href="review.jsp">4.79 후기 34개</a></span>
                </div>
                <!-- 숙소 시설 목록 -->
                <section id="숙소 시설">
                    <ul>
                        <li>TV</li>
                        <li>NETFLIX</li>
                        <li>에어컨</li>
                        <li>와이파이</li>
                        <li>무료 주차</li>
                    </ul>
                </section>
                <!-- 호스트 정보 -->
                <p>호스트: HY 님</p>
            </div>

            <!-- 예약 섹션과 다른 옵션 추가 -->
            <div class="main-right">
                <!-- 예약 섹션 -->
                <section id="예약">
                    <div class="가격">
                        <p>₩152,000/박</p>
                    </div>
                    <div class="날짜 선택">
                        <label for="체크인">체크인</label>
                        <input type="date" id="체크인" name="체크인">
                        <label for="체크아웃">체크아웃</label>
                        <input type="date" id="체크아웃" name="체크아웃">
                    </div>
                    <div class="인원 선택">
                        <label for="인원">인원</label>
                        <select id="인원" name="인원">
                            <option>게스트 2명 / 유아 1명</option>
                            <!-- 다른 옵션 추가 -->
                        </select>
                    </div>
                    <button id="예약하기">예약 하기</button>
                    <div class="예약-summary">
                        <p>₩152,000 x 1박</p>
                        <p>서비스 수수료: ₩15,200</p>
                        <p class="총 비용">총 합계: ₩167,200</p>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <!-- 로그인 팝업 -->
    <div id="로그인팝업">
        <span class="close" onclick="document.getElementById('로그인팝업').style.display='none'">&times;</span>
        <p>로그인이 필요한 서비스입니다</p>
        <form id="로그인폼" method="post">
            <label for="아이디">아이디</label>
            <input type="text" id="아이디" name="아이디" required>
            <label for="비밀번호">비밀번호</label>
            <input type="password" id="비밀번호" name="비밀번호" required>
            <button type="submit">로그인</button>
        </form>
    </div>

    <!-- 경고 팝업 -->
    <div id="경고팝업">
        <span class="close" onclick="document.getElementById('경고팝업').style.display='none'">&times;</span>
        <p>잘못된 입력입니다. 다시 시도해주세요.</p>
        <button onclick="document.getElementById('경고팝업').style.display='none'">확인</button>
    </div>

    <script>
        // 페이지 로드 시 체크인 날짜를 당일 날짜로 설정하는 함수
        window.onload = function() {
            var today = new Date(); // 오늘 날짜를 가져옴
            var year = today.getFullYear(); // 연도
            var month = ('0' + (today.getMonth() + 1)).slice(-2); // 월 (0부터 시작하므로 +1 필요)
            var day = ('0' + today.getDate()).slice(-2); // 일
            var todayFormatted = year + '-' + month + '-' + day; // YYYY-MM-DD 형식으로 변환
            
            document.getElementById('체크인').value = todayFormatted; // 체크인 필드에 오늘 날짜 설정
        };

        // 모든 사진 보기 버튼 클릭 이벤트
        document.querySelector('.모든사진보기 a').addEventListener('click', function() {
            window.location.href = '/photos'; // 사진 페이지로 이동
        });

     // 예약 버튼 클릭 이벤트
        document.getElementById('예약하기').addEventListener('click', function() {
            // 로그인 여부 확인
            var isLoggedIn = false; // 실제 로그인 여부 확인 로직 필요
            if (!isLoggedIn) {
                document.getElementById('로그인팝업').style.display = 'block';
            } else {
                goToConfirmation();
            }
        });

        // 로그인 폼 제출 이벤트
        document.getElementById('로그인폼').addEventListener('submit', function(event) {
            event.preventDefault();
            var id = document.getElementById('아이디').value;
            var password = document.getElementById('비밀번호').value;
            
            // 실제로는 서버와 통신하여 로그인 여부를 확인해야 함
            if (id === 'testuser' && password === 'password') {
                document.getElementById('로그인팝업').style.display = 'none';
                goToConfirmation();
            } else {
                document.getElementById('경고팝업').style.display = 'block';
            }
        });

        function goToConfirmation() {
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = 'reservationConfirmation.jsp';

            // 체크인 날짜
            var checkin = document.createElement('input');
            checkin.type = 'hidden';
            checkin.name = 'checkin';
            checkin.value = document.getElementById('체크인').value;
            form.appendChild(checkin);

            // 체크아웃 날짜
            var checkout = document.createElement('input');
            checkout.type = 'hidden';
            checkout.name = 'checkout';
            checkout.value = document.getElementById('체크아웃').value;
            form.appendChild(checkout);

            // 인원 수
            var guests = document.createElement('input');
            guests.type = 'hidden';
            guests.name = 'guests';
            guests.value = document.getElementById('인원').value;
            form.appendChild(guests);

            document.body.appendChild(form);
            form.submit();
        }

        // 팝업 닫기 이벤트
        document.querySelectorAll('.close').forEach(function(element) {
            element.addEventListener('click', function() {
                element.parentElement.style.display = 'none';
            });
        });
    </script>
</body>
</html>
