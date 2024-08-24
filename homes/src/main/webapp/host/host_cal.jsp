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
	margin-top:60px;
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
	background-color: tomato;
	brder:1px solid #cd280e;
	border-radius:30px;
	color:white;
}

.hol_selected {
	background-color: lightcoral;
	border-radius:30px;
	
}

.choosen{
	background-color: lime;
}

.holi_line {
	background-color: tomato;
	color:white;
	opacity: 0.8;
	border-radius:30px;
}
</style>
<%
String s_room = request.getParameter("room");

int room=0;
if(s_room!=null && !s_room.equals("")){
	room = Integer.parseInt(s_room);
}

String seq = request.getParameter("seq");
ArrayList<ScheduleDTO> cal_arr = sdao.showAllSchdule(room);
String uuid = UUID.randomUUID().toString(); // 고유 ID 생성
%>

<div class="date-picker">

	<div class="calendar" id="calendar_<%=uuid %>" style="display: block;">
		<%



	if(cal_arr!=null || cal_arr.size()!=0){
		
	
		for(int j=0; j<cal_arr.size(); j++){
		%>
		<input type="hidden" class="<%=cal_arr.get(j).getReason() %>"
			data-type="start" value="<%=cal_arr.get(j).getStart_day()%>" readonly>
		<input type="hidden" class="<%=cal_arr.get(j).getReason() %>"
			data-type="end" value="<%=cal_arr.get(j).getEnd_day()%>" readonly>
		<%
		}
	}
		%>
		<div class="month">
			<button class="prev-month">‹</button>
			<span class="month-year">초기화</span> <span class="submit">휴무 등록</span>
			<button class="next-month">›</button>
		</div>
		<div class="side_cal">
			<!-- 날짜가 여기에 동적으로 추가됩니다 -->
		</div>

		<form action="host_roomSchedule_ok.jsp" name="host_roomSchedule">
			<input type="hidden" name="room" value="<%=room%>">
		</form>
	</div>
</div>


<script>
document.addEventListener("DOMContentLoaded", function() {
    const uuid = '<%=uuid%>';

    const calendar = document.getElementById('calendar_' + uuid);
    const prevMonthBtn = calendar.querySelector('.prev-month');
    const nextMonthBtn = calendar.querySelector('.next-month');
    const side_cal = calendar.querySelector('.side_cal');
    
    const reset = calendar.querySelector('.month-year');
    const submit = calendar.querySelector('.submit');

    var index =1;
	var cals = [];
	var date_from_to = [];
    let currentDate = new Date();
    let nextDate = new Date();
    var loc = 0;
    
    reset.addEventListener('click', () => {
        
    	side_cal.querySelectorAll('.hol_selected').forEach(span => span.classList.replace('hol_selected','none'));
/*     	side_cal.querySelectorAll('.choosen').forEach(span => span.classList.remove	('choosen'));
 */    	
        /* holiday */
    });
    
    
    function getAllhol_selected(){
    	
    	var hol_sel = calendar.querySelectorAll('.hol_selected');
    	
    	const hol_sel_date = [];
    	
    	hol_sel.forEach(hol=>{
    		hol_sel_date.push(new Date(makeIdToDate(hol.id)));
    		
    	});
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
    
    function makeHidden(range_date){
    	var form = calendar.querySelector('form[name="host_roomSchedule"]');
    	
    	range_date.forEach((r,index)=>{
    		const input = document.createElement('input');
        	input.value=r;
        	input.type='hidden';
        	input.name = 'range_'+index;
        	
        	form.appendChild(input);
    	});
    	form.submit();
    	
    	
    }
    
    submit.addEventListener('click', () => {
        
    	const range_date = getAllhol_selected();
    	makeHidden(range_date);
    	
    });
    
    atStart();
    
    
    function atStart(){
    	renderCalendar(currentDate);
        dateCheck();
        renderCalendar(nextDate);
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
        
/*         all_sch.forEach((one_sch) =>{
        	alert(one_sch[0]);
        	alert(one_sch[1]);
        });  
         */
        return all_sch;
    }
    
    function attachTag(one_month_cal){
    	
    	one_month_cal.querySelectorAll('.selected').forEach(sel => {
            const smallStart = document.createElement('em');
        	smallStart.className = 'small_start';
            smallStart.textContent = index++;
            sel.appendChild(smallStart);

        });
    	
    	one_month_cal.querySelectorAll('.holi').forEach(sel => {
            const smallStart = document.createElement('em');
        	smallStart.className = 'small_start';
            smallStart.textContent = '휴무';
            sel.appendChild(smallStart);

        });
    	

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
    
    

    prevMonthBtn.addEventListener('click', () => {
    	if(loc==0) return;
		nextDate.setMonth(nextDate.getMonth()- 1);

		
		for(var i=0; i<cals.length; i++){
			cals[i].style.display='none';
		}
 		cals[loc+1].style.display='none';
		cals[loc].style.display='block';
		cals[loc-1].style.display='block';

    	loc--;


    });

    nextMonthBtn.addEventListener('click', () => {
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

        
/* 		alert((loc+9)%12);
 */		

    });
    
	function dateCheck(){
		var checkDate = nextDate.getDate();
		nextDate.setDate(1);
    	nextDate.setMonth(nextDate.getMonth()+1);

    	var temp = new Date(nextDate.getFullYear(), nextDate.getMonth() + 1, 0).getDate();
    	nextDate.setDate(Math.min(checkDate, temp));

	}
	
	function chooseWeeks(tag) {
	    const Element = tag.parentElement;
	    const parentElement = Element.parentElement;
	    const className = tag.textContent;
	    const selector = ':not(.disabled):not(.selected):not(.line):not(.holi):not(.choosen):not(.holi_line)';

	    function isSpans_holSelected(spans) {
	    	let check = true;
	        spans.forEach(span => {
	            if (!span.classList.contains('hol_selected')) {
	            	check =  false;
	            }
	        });
	        return check;
	    }

	    // Select spans based on the className
	    let spans;
	    switch (className) {
	        case '일':
	            spans = parentElement.querySelectorAll('.sun' + selector);
	            break;
	        case '월':
	            spans = parentElement.querySelectorAll('.mon' + selector);
	            break;
	        case '화':
	            spans = parentElement.querySelectorAll('.tue' + selector);
	            break;
	        case '수':
	            spans = parentElement.querySelectorAll('.wed' + selector);
	            break;
	        case '목':
	            spans = parentElement.querySelectorAll('.thur' + selector);
	            break;
	        case '금':
	            spans = parentElement.querySelectorAll('.fri' + selector);
	            break;
	        case '토':
	            spans = parentElement.querySelectorAll('.sat' + selector);
	            break;
	        default:
	            alert('잘못된 접근');
	            return;
	    }
		
	    if (isSpans_holSelected(spans)) {
	        spans.forEach(span => span.classList.replace('hol_selected', 'none'));
	    } else {
	        spans.forEach(span => span.classList.replace('none', 'hol_selected'));
	    }
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
 

            dayElement.addEventListener('click', () => {   	
				chooseDate(year, month, day, dayElement);
            });
            monthContainer.appendChild(dayElement);
            
            if(cals.length==1 && day<currentDate.getDate()){
                dayElement.classList.add('disabled');
                const clone = dayElement.cloneNode(true);
                dayElement.parentNode.replaceChild(clone, dayElement);
            }
        }
        one_month_cal.appendChild(monthContainer);
        setAllSchedule();

        attachTag(one_month_cal);
    }
    
    const ClickedDates = [];
    
    function chooseDate(year, month, day, dayElement) {
    	
		// span태그 + none클래스 : => remove selected
		const selector = ':not(.disabled):not(.selected):not(.line):not(.holi):not(.holi_line)';

			  if (dayElement.matches('.disabled') ||dayElement.matches('.selected') || dayElement.matches('.line') || dayElement.matches('.holi') 
					|| dayElement.matches('.holi_line')) {
			  if (!dayElement.matches('.selected') && !dayElement.matches('.disabled') && !dayElement.matches('.line')) {
				const longDate = new Date(makeIdToDate(dayElement.id)).getTime();
				const checkDel = confirm(makeIdToDate(dayElement.id)+"이 포함된 일정을 삭제하시겠습니까?");
				if(checkDel){
					location.href='host_roomSchedule_Delete_ok.jsp?room=<%=room%>&date='+longDate; 
				}
			  }
			        return;  // 일치하면 함수 종료
		}	
		// line none 클릭마다 변환
    	/* if (dayElement.classList.contains('choosen')) {
            dayElement.classList.replace('choosen', 'hol_selected');
            
        } else */ if (dayElement.classList.contains('none')){
            dayElement.classList.replace('none', 'hol_selected');
        } else {
            dayElement.classList.replace('hol_selected', 'none');

        }
     }
        
		
    function rangeChoosen(dayElement){
    	var count = true;
        count=!count;
        if(count){
        	ClickedDates[1] = new Date(makeIdToDate(dayElement.id));
        } else {
        	ClickedDates[0] = new Date(makeIdToDate(dayElement.id));
            const allDays = side_cal.querySelectorAll('span');
            allDays.forEach(dayElement => {
                const dayId = dayElement.id;
                if(dayId!=null && dayId!="")

                if (dayId) {
                    const currentDate = new Date(makeIdToDate(dayId))

                    if (currentDate >= ClickedDates[0] && currentDate <=  ClickedDates[1]) {
                        dayElement.classList.add('choosen');
                    }
                }
            });
        	
        }
    }
    
        
		function makeIdToDate(id){
			
			var date_id = id.slice(1);
			
			return date_id.slice(0, 4)+'-'+date_id.slice(4, 6)+'-'+date_id.slice(6, 8);
		}
    

})
</script>