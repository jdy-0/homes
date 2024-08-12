<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.homes.guest.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%

GuestDAO dao_rh = new GuestDAO();
int member_idx = (Integer)session.getAttribute("useridx");
ArrayList<ReservationDTO> arr=dao_rh.getReserveHistory(member_idx);

Calendar now=Calendar.getInstance();
int y = now.get(Calendar.YEAR);
int m = now.get(Calendar.MONTH)+1;
int d = now.get(Calendar.DATE);
%>
<style>
#myReserve{
	font-family: 'SBAggroB';
	width:1000px;
	border-right:5px solid black;
}
.res_history_fs{
	border:4px solid black;
	padding:5px;
	margin:10px auto;
	width:800px;
}
.res_history_fs td{
	padding:10px;
	
}
</style>
<article id="myReserve" style="display:none;">
	<fieldset class="label_fs">
		<h3><%=session.getAttribute("usernickname") %>님 예약 내역 보기</h3>
	</fieldset>
	<form>
	<div align="center">
		<select name="reserve_state">
			<option value="예약대기중">예약대기중</option>
			<option value="예약완료">예약완료</option>
			<option value="이용완료">이용완료</option>
		</select>
		<input type="date" name="start_date">
		<input type="date" name="end_date">
	</div>
	</form>
		<%
		if(arr==null || arr.size()==0){
			%>
			<h2>예약 내역이 없습니다.</h2>
			<%
		}else{
			for(int i=0;i<arr.size();i++){
				%>
				<fieldset class="res_history_fs">
					<table>
						<tr>
							<td rowspan="3"><img src="<%=arr.get(i).getImage() %>" style="width:150px;"></td>
							<td><%=arr.get(i).getRoom_name() %></td>
						</tr>
						<tr>
							<td><%=arr.get(i).getCheck_in() %> - <%=arr.get(i).getCheck_out() %></td>
						</tr>
						<tr>
							<td><%=arr.get(i).getState() %></td>
						</tr>
					</table>
				</fieldset>
					
				<%
			}	
		}
		
		
		%>
	</table>
</article>