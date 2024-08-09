<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="scDAO" class="com.homes.host.ScheduleDAO"></jsp:useBean>
<%
Enumeration<String> range_req = request.getParameterNames();
ArrayList<String> range_arr = new ArrayList();
String s_room = "";
if(range_req!=null){
	while(range_req.hasMoreElements()){
		String pname = range_req.nextElement();
        String[] pnames = request.getParameterValues(pname);
		
		if(pname.startsWith("range_")){
			range_arr.add(request.getParameter(pname));
		} else {
			s_room = request.getParameter(pname);

		}
	
	}
	int room = s_room==null||s_room.equals("")?0:Integer.parseInt(s_room);
	int result[] = scDAO.insertRoomSchedule(range_arr,room);
	
	for(int i : result){
		System.out.println(i);
	}
	
}
%>
<script>
window.location.href='host_roomSchedule.jsp';
</script>
