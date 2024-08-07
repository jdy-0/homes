<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Custom Date Picker</title>
<style>
#date-input {
    width: 300px;
    padding: 8px;
    font-size: 16px;
    cursor: pointer;
}

.calendar {
    position: absolute;
    top: 100%;
    left: 0;
    width: 300px;
    z-index: 10;
    border: 1px solid #ccc;
    background-color: white;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.month {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    background-color: #f2f2f2;
}

.weekdays, .days {
    display: flex;
    flex-wrap: wrap;
}

.weekdays span, .days span {
    width: 14.28%;
    text-align: center;
    padding: 10px 0;
}

.days span {
    cursor: pointer;
}

.days span:hover {
    background-color: #f2f2f2;
}

.days .selected {
    background-color: #007bff;
    color: white;
}  
.line {
    background-color: blue;
}

.side_cal {
    display: flex;
}

.one_month_cal {
    display: inline;
    float: left;
    border: 1px solid gray;
    width: 300px;
}

.month-year {
    text-align: center;
}

.disabled {
    text-decoration: line-through;
    background-color: lightgray;
}

.sunday {
    color: red;
}

.month-year {
    font-size: 25px;
    background-color: lightgray;
}
</style>
</head>
<body>

        <div class="calendar" id="calendar">
            <div class="month">
                <button class="prev-month">‹</button>
                <span class="month-year"></span>
                <button class="next-month">›</button>
            </div>
            <div class="side_cal">
                <!-- 날짜가 여기에 동적으로 추가됩니다 -->
            </div>
        </div>
    </div>

    <script>
        const dateInput = document.getElementById('date-input');
        const from = document.getElementById('from');
        const to = document.getElementById('to');
        const calendar = document.getElementById('calendar');
        const monthYear = calendar.querySelector('.month-year');
        const prevMonthBtn = calendar.querySelector('.prev-month');
        const nextMonthBtn = calendar.querySelector('.next-month');
        const side_cal = calendar.querySelector('.side_cal');
        var cals = [];
        let currentDate = new Date();
        let nextDate = new Date();

        function openCalendar() {
            if (cals.length === 0) {
                renderCalendar(currentDate);
            }
        }
        
        // 초기 달력 렌더링
        openCalendar();

        prevMonthBtn.addEventListener('click', () => {
            nextDate.setMonth(nextDate.getMonth() - 1);
            side_cal.innerHTML = '';
            renderCalendar(nextDate);
        });

        nextMonthBtn.addEventListener('click', () => {
            nextDate.setMonth(nextDate.getMonth() + 1);
            side_cal.innerHTML = '';
            renderCalendar(nextDate);
        });
        
        function addWeekdays(){
            const weekdays = document.createElement('div');
            weekdays.classList.add('weekdays');

            for(let i = 0; i < 7; i++ ){
                const dow_span = document.createElement('span');
                weekdays.appendChild(dow_span);
            }
            
            one_month_cal.appendChild(weekdays);
            side_cal.appendChild(one_month_cal);

            for(let i = 0; i < document.querySelectorAll(".weekdays>span").length; i++){
                switch (i % 7) {
                    case 0:
                        document.querySelectorAll(".weekdays>span")[i].textContent = '일';
                        document.querySelectorAll(".weekdays>span")[i].setAttribute('class', 'sunday');
                        break;
                    case 1:
                        document.querySelectorAll(".weekdays>span")[i].textContent = '월';
                        break;
                    case 2:
                        document.querySelectorAll(".weekdays>span")[i].textContent = '화';
                        break;
                    case 3:
                        document.querySelectorAll(".weekdays>span")[i].textContent = '수';
                        break;
                    case 4:
                        document.querySelectorAll(".weekdays>span")[i].textContent = '목';
                        break;
                    case 5:
                        document.querySelectorAll(".weekdays>span")[i].textContent = '금';
                        break;
                    case 6:
                        document.querySelectorAll(".weekdays>span")[i].textContent = '토';
                        break;
                    default:
                        break;
                }
            }

            return one_month_cal;
        }
        
        function setYMD(){
            const one_month_cal  = document.createElement('div');
            one_month_cal.classList.add('one_month_cal');
            
            const month_year  = document.createElement('div');
            month_year.setAttribute('class', 'month-year');
            one_month_cal.appendChild(month_year);
            
            const year = nextDate.getFullYear();
            const month = nextDate.getMonth();
            month_year.textContent = year + '년' + (month + 1) + '월';
            
            return one_month_cal;
        }
        
        function renderCalendar(date) {
            one_month_cal = setYMD();
            addWeekdays();

            const monthContainer = document.createElement('div');
            monthContainer.innerHTML = '';
            monthContainer.classList.add('days');
            
            const year = date.getFullYear();
            const month = date.getMonth();
            
            const firstDay = new Date(year, month, 1).getDay();
            const lastDate = new Date(year, month + 1, 0).getDate();

            for (let i = 0; i < firstDay; i++) {
                const emptyCell = document.createElement('span');
                monthContainer.appendChild(emptyCell);
            }

            for (let day = 1; day <= lastDate; day++) {
                const dayElement = document.createElement('span');
                dayElement.setAttribute('class', 'none');
                dayElement.textContent = day;
                dayElement.id = 'd' + year + (month + 1).toString().padStart(2, '0') + (day.toString().padStart(2, '0'));

                dayElement.addEventListener('click', () => {   
                    chooseDate(year, month, day, dayElement);
                });
                monthContainer.appendChild(dayElement);
            }
            one_month_cal.appendChild(monthContainer);
            side_cal.appendChild(one_month_cal);
        }
        
        function chooseDate(year, month, day, dayElement) {
            document.querySelectorAll('.none').forEach(span => span.classList.remove('selected'));
            dayElement.classList.add('selected');

            if (dayElement.getAttribute('class').indexOf('line') != -1) {
                dayElement.classList.replace('line', 'none');
            } else {
                dayElement.classList.replace('none', 'line');
            }

            const selectedDates = document.querySelectorAll('.selected');

            if (selectedDates.length === 2) {
                const firstDateId = selectedDates[0].id.replaceAll('d', '');
                const lastDateId = selectedDates[1].id.replaceAll('d', '');

                const firstDate = new Date(
                    firstDateId.substring(0, 4),
                    parseInt(firstDateId.substring(4, 6)) - 1,
                    firstDateId.substring(6, 8)
                );
                const lastDate = new Date(
                    lastDateId.substring(0, 4),
                    parseInt(lastDateId.substring(4, 6)) - 1,
                    lastDateId.substring(6, 8)
                );
                
                const allDays = side_cal.querySelectorAll('span');
                
                allDays.forEach(dayElement => {
                    const dayId = dayElement.id;
                    if(dayId != null && dayId != "")

                    if (dayId) {
                        const currentDate = new Date(
                            dayId.substring(1, 5),
                            parseInt(dayId.substring(5, 7)) - 1,
                            dayId.substring(7, 9),
                        );

                        if (currentDate >= firstDate && currentDate <= lastDate) {
                            dayElement.classList.add('line');
                        }
                    }
                });
                to.value = '' + year + '-' + (month + 1).toString().padStart(2, '0') + '-' + day.toString().padStart(2, '0');
            } else {
                from.value = '' + year + '-' + (month + 1).toString().padStart(2, '0') + '-' + day.toString().padStart(2, '0');
            }
        }
    </script>
</body>
</html>
