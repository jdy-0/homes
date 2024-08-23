<%@page import="com.homes.guest.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.homes.host.ScheduleDTO"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="sdao" class="com.homes.host.ScheduleDAO"></jsp:useBean>
<style>
.date {
	width: 200px;
	border: 3px solid black;
	padding: 10px;
	font-size: 20px;
	font-family: 'SBAggroB';
}

.date-picker {
	position: relative;
	display: flex;
	align-items: center;
}

.date-picker>div {
	float: left;
}

.date-picker>div>div {
	float: left;
}

#date-input {
	width: 417px;
	padding: 8px;
	font-size: 16px;
	cursor: pointer;
	display: flex;
	font-family: 'SBAggroB';
	font-size: 25px;
}

.calendar {
	position: static;
	top: 90%;
	left: -30px;
	width: 615px;
	z-index: 10;
	/* border: 1px solid black; */
	border: 0px;
	background-color: floralwhite;
	/* box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); */
}

.prev-month {
	font-size: 30px;
	width: 40px;
	 border:0;
	background-color: floralwhite;
	font-weight: bold;
	border-radius:20px;
	
}
.prev-month:hover{
	background-color:palegoldenrod;
	color:dimgray;
	transition:0.3s;
}
.next-month {
	font-size: 30px;
	width: 40px;
	 border:0;
	background-color: floralwhite;
	font-weight: bold;
	border-radius:20px;
}
.next-month:hover{
	/* background-color:beige; */
	background-color:palegoldenrod;
	color:dimgray;
	transition:0.3s;
}

.month {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px;
    background-color: floralwhite;
	width: -webkit-fill-available;
    border: 1px solid gray;
}

.weekdays, .days {
	display: flex;
	flex-wrap: wrap;
	background-color: floralwhite;
	border-top: 1px solid gray;
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
	background-color: palegoldenrod;
    border-radius: 30px;
}

.days .selected {
    background-color: palegoldenrod;
    color: black;
    border-radius:30px;
}

.line {
	background-color: cornsilk;
	color:dimgray;
	border-radius:30px;
}

.side_cal {
	display: flex;
}

.one_month_cal {
    display: inline;
    float: left;
    border: 1px solid gray;
    width: 300px;
    background-color: floralwhite;
    margin: 0px 9px 0px 0px;
}

.month-year {
	text-align: center;
	font-size:25px;
	background-color: floralwhite;
}

.disabled {
    text-decoration: line-through;
    /* background-color: lightgray; */
    opacity: 0.5;
    color: gray;
}

.sunday {
	color: red;
}

/* .month-year {
	font-size: 25px;
	 background-color: lightgray; 
	background-color: #dec022;
	border-bottom: 3px solid black;
} */

#select_guest_div {
	margin-left: 115px;
	display: flex;
	flex-direction: column;
	padding: 10px;
}

#select_guest_div label {
	padding-bottom: 5px;
}

#select_guest {
	border: 3px solid black;
	width: 200px;
	font-size: 20px;
	padding: 10px;
	font-family: 'SBAggroB';
}

.button {
	width: 80px;
	background-color: #dec022;
	border: 3px solid black;
	font-family: 'SBAggroB';
	padding: 10px;
	font-size: 20px;
}

/* ----------------test---------------------- */
.small_start {
	position: relative; /* 절대 위치 지정 */
	top: -20px; /* 상단에 위치 */
	left: 0; /* 왼쪽에 위치 */
	font-size: 0.25em; /* 작은 글자 크기 조정 */
	color: gray; /* 작은 글자의 색상 설정 */
	background: white; /* 배경색을 설정하여 가독성 향상 */
	padding: 2px; /* 약간의 여백 추가 */
}

.holi {
	background-color: #cd280e;
}

.hol_selected {
	background-color: lightpink;
}

.choosen{
	background-color: lime;
}

.holi_line {
	background-color: #cd280e;
	opacity: 0.8;
}
</style>
<%
ReservationDTO resdto = (ReservationDTO) request.getAttribute("resdto");
int room=resdto.getRoom_idx();

ArrayList<ScheduleDTO> cal_arr = sdao.showAllSchdule(room);
String uuid = UUID.randomUUID().toString(); // 고유 ID 생성


%>

<div class="date-picker">

	<div class="calendar" id="calendar_<%=uuid %>" style="display: block;">
		
		<input type="hidden" 
			data-type="start" value="<%=resdto.getCheck_in()%>">
		<input type="hidden" 
			data-type="end" value="<%=resdto.getCheck_out()%>">
			
		<form action="hostbooking_ok.jsp" name="hostbooking" >
			<input type="hidden" name="reserve_idx" value="<%=resdto.getReserve_idx()%>">
			<input type="hidden" name="state" value="">
			<input type="hidden" name="room_idx" value="<%=resdto.getRoom_idx()%>">
			<input type="hidden" name = "check_in"
				data-type="start" value="<%=resdto.getCheck_in()%>">
			<input type="hidden" 
				data-type="end" name = "check_out" value="<%=resdto.getCheck_out()%>">
			<input type="hidden" name="price" value="<%=resdto.getPrice()%>">
		</form>
		
		
		<div class="month">
			<button class="prev-month">‹</button>
			<span class="month-year accept">수락</span> <span class="month-year decline">거절</span>
			<button class="next-month">›</button>
		</div>
		<div class="side_cal">
			<!-- 날짜가 여기에 동적으로 추가됩니다 -->
		</div>


	</div>
</div>


<script>
document.addEventListener("DOMContentLoaded", function() {
    const uuid = '<%=uuid%>';

    const calendar = document.getElementById('calendar_' + uuid);
    const prevMonthBtn = calendar.querySelector('.prev-month');
    const nextMonthBtn = calendar.querySelector('.next-month');
    const side_cal = calendar.querySelector('.side_cal');
    
    const accept = calendar.querySelector('.accept');
    const decline = calendar.querySelector('.decline');
    
    const form = calendar.querySelector('form[name="hostbooking"]');
    const state = form.querySelector('input[name="state"]');

    var index =1;
	var cals = [];
	var date_from_to = [];
    let currentDate = new Date();
    let nextDate = new Date();
    var loc = 0;
    
    accept.addEventListener('click', () => {
    	const check = confirm('예약을 승인하시겠습니까?');
    	if(check){
    		state.value="예약완료";
        	form.submit();
    	}
    });
    
    decline.addEventListener('click', () => {
    	const check = confirm('예약을 거절하시겠습니까?');
    	if(check){
    		state.value="승인거절";
        	form.submit();
    	}    
    });

		function moveToCheckInDate(){
	    	dateCheck();
	
			for(var i=0; i<cals.length; i++){
				
				cals[i].style.display='none';
			}
	        if(loc+2==cals.length){
	        	renderCalendar(nextDate);
	
	            cals[loc+1].style.display='block';
	
	        } else {
	            cals[loc+1].style.display='block';
	            cals[loc+2].style.display='block';
	        }
	   
	    	loc++;
		}
    
    function getAllhol_selected(){
    	
    	var hol_sel = calendar.querySelectorAll('.hol_selected');
    	
    	const hol_sel_date = [];
    	
    	hol_sel.forEach(hol=>{
    		hol_sel_date.push(new Date(makeIdToDate(hol.id)));
    		
    	});
		alert('길이'+hol_sel_date.length);
    	var s_date = hol_sel_date[0];
    	var e_date = hol_sel_date[0];
    	
    	
    	var range_date= [];
    	for(var i = 1; i<hol_sel_date.length; i++){
    		
    		const c_s_date = hol_sel_date[i-1];
    		const next_date = new Date(c_s_date);
     		next_date.setDate(c_s_date.getDate()+1);
    		const sideDate = hol_sel_date[i];

    		if(next_date.getTime()==sideDate.getTime()){
    			e_date = sideDate;
    			
    		} else {
					
    			range_date.push([s_date.getTime(),e_date.getTime()]);
				s_date=hol_sel_date[i];	
				e_date=hol_sel_date[i];	
    		}
    	}
    	
		range_date.push([s_date.getTime(),e_date.getTime()]);
		return range_date;
    }
    

    
    atStart();
    
    
    function getMonBetMon(start){
    	
    	const today = new Date();

    	const year = start.getFullYear();
    	const today_year = today.getFullYear();
    	
    	const month = start.getMonth();
    	const today_month = today.getMonth();
    	
    	return (year-today_year)*12 + (month-today_month);
    	
    }
    
    
    function atStart(){
    	renderCalendar(currentDate);
        dateCheck();
        renderCalendar(nextDate);
        
    	const startVal = calendar.querySelectorAll('input[data-type="start"]')[0];
    	const start = new Date(startVal.value);
    	
		for(var i =0; i< getMonBetMon(start); i++){
	        moveToCheckInDate();

		}
    }
    

	
    function getAllScheduleToId(){
    	
    	const startInputs = calendar.querySelectorAll('input[data-type="start"]');
        const endInputs = calendar.querySelectorAll('input[data-type="end"]');
        
        
        let all_sch = [];
        startInputs.forEach((input, index) => {
            const startDate = input.value;
            const endDate = endInputs[index].value;
            const reason = input.className;
			let one_sch = [];
			one_sch[0] = startDate.replaceAll('-','');
			one_sch[1] = endDate.replaceAll('-','');
			one_sch[2] = reason;
			all_sch.push(one_sch);
        });

        return all_sch;
    }
    
    
    function checkHoliday(dayElement,reason){
    	
    	if (reason === "예약됨") {
            dayElement.classList.add('selected');
 
        } else {
            dayElement.classList.add('holi');
            
        }
    	
    }
    
	function setAllSchedule(){
    	
    	let all_sch = getAllScheduleToId();
    	
    	
    	for(let i=0; i<all_sch.length; i++){

	    	 const firstDate = all_sch[i][0];
	         const lastDate  = all_sch[i][1];
	 		 const reason = all_sch[i][2];	
	             const allDays = side_cal.querySelectorAll('span');
	             
	             allDays.forEach(dayElement => {
	                 const dayId = dayElement.id;
	                 if(dayId!=null && dayId!=""){
							
	                	 currentDate = dayId.replaceAll('d','');
	                	 if (currentDate == firstDate){
	                		 checkHoliday(dayElement,reason);
	                		
	                	 }else if (currentDate == lastDate){
	                		 checkHoliday(dayElement,reason);
	                		 
	                	 }else if (currentDate > firstDate && currentDate < lastDate) {
	                		
	                		 if(reason=='예약됨'){
	 	                		dayElement.classList.add('line');
	                		 } else {
		 	                		dayElement.classList.add('holi_line');
	                		 }
	                		
	                		
	                		
	                	 }
	                     
	                 }
	             });

    	}
		
    } 
    
    
	function dateCheck(){
		var checkDate = nextDate.getDate();
		nextDate.setDate(1);
    	nextDate.setMonth(nextDate.getMonth()+1);

    	var temp = new Date(nextDate.getFullYear(), nextDate.getMonth() + 1, 0).getDate();
    	nextDate.setDate(Math.min(checkDate, temp));

	}
	
	
    function addWeekdays(one_month_cal){

    	const weekdays  = document.createElement('div');
		weekdays.classList.add('weekdays');
       const weekOfDays = ['일', '월', '화', '수', '목', '금', '토'];

		for(let i=0; i<weekOfDays.length; i++){
        	const dow_span = document.createElement('span');
        	weekdays.appendChild(dow_span);
        	dow_span.textContent = weekOfDays[i];
        	if(weekOfDays[i]=='일'){
    			dow_span.setAttribute('class','sunday');
        	}
        	
        	
        	
        	dow_span.addEventListener('click', () => {   	
				chooseWeeks(dow_span,one_month_cal);
            });

		}
		one_month_cal.appendChild(weekdays);
        side_cal.appendChild(one_month_cal);
        return one_month_cal;
    }
    
    function setYMD(){
		
		const one_month_cal  = document.createElement('div');
		cals.push(one_month_cal);
		one_month_cal.classList.add('one_month_cal');
		const month_year  = document.createElement('div');
		month_year.setAttribute('class','month-year');
		one_month_cal.appendChild(month_year);
		
    	const year = nextDate.getFullYear();
        const month = nextDate.getMonth();
        const tot = '';
        month_year.textContent = year+'년'+(month+1)+'월';
        
        return one_month_cal;
        
        
    }
    
    function renderCalendar(date) {
    	one_month_cal = setYMD();
    	addWeekdays(one_month_cal);
     
      	const monthContainer  = document.createElement('div');
      	monthContainer.innerHTML = '';
      	monthContainer.classList.add('days');
      	

      	const year = nextDate.getFullYear();
        const month = nextDate.getMonth();
        
        const weekClass = ['sun','mon','tue','wed','thur','fri','sat'];
      	
        const firstDay = new Date(year, month, 1).getDay();
        const lastDate = new Date(year, month + 1, 0).getDate();

        for (let i = 0; i < firstDay; i++) {
            const emptyCell = document.createElement('span');
            monthContainer.appendChild(emptyCell);
        }
		
        
        for (let day = 1; day <= lastDate; day++) {
            const dayElement = document.createElement('span');

            dayElement.setAttribute('class','none');
			dayElement.classList.add(weekClass[(firstDay+day-1)%7]);
            dayElement.textContent = day;
            dayElement.id = 'd' + year + (month + 1).toString().padStart(2, '0') + (day.toString().padStart(2, '0'));
 
            monthContainer.appendChild(dayElement);
            
            if(cals.length==1 && day<currentDate.getDate()){
                dayElement.classList.add('disabled');
                const clone = dayElement.cloneNode(true);
                dayElement.parentNode.replaceChild(clone, dayElement);
            }
        }
        one_month_cal.appendChild(monthContainer);
        setAllSchedule();

    }
    
    
        
		function makeIdToDate(id){
			
			var date_id = id.slice(1);
			
			return date_id.slice(0, 4)+'-'+date_id.slice(4, 6)+'-'+date_id.slice(6, 8);
		}
    

})
</script>