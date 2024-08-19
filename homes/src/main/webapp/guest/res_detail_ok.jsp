<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="rfdao" class="com.homes.refund.refundDAO"></jsp:useBean>
<%
String s_ridx = request.getParameter("reserve_idx");
String res_state = request.getParameter("res_state");

int reserve_idx = Integer.parseInt(s_ridx);
int count = 0;
if(res_state.equals("예약대기중")){

 
	count = rfdao.updateResStateToCanceled(reserve_idx);

} else if(res_state.equals("예약완료")){

	count = rfdao.commitedResToCancle(reserve_idx); 
}

	String msg = count>0?"예약이 취소되었습니다.":"예약 취소가 실패하셨습니다";

%>

<script>

alert('<%=msg%>');
window.location.href = 'mypage.jsp';

</script>