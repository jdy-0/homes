<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<%@ page import="java.util.*" %>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
String id=request.getParameter("id");
String pwd=request.getParameter("pwd");
String saveID=request.getParameter("saveID");
int result = gdao.loginCheck(id, pwd);

if(result == gdao.No_Id || result == gdao.No_Pwd){
	%>
	<script>
	window.alert('아이디 또는 비밀번호를 확인해주세요.');
	window.location.href='login_popup.jsp';
	</script>
	<%
} else if(result == gdao.Login_ok){
	
	ArrayList<Object> user_info = gdao.getUserInfo(id);
	int useridx=(Integer)user_info.get(0);
	String userid=(String)user_info.get(1);
	String username=(String)user_info.get(2);
	String usernickname=(String)user_info.get(3);
	
	session.setAttribute("useridx", useridx);
	session.setAttribute("userid", userid);
	session.setAttribute("username", username);
	session.setAttribute("usernickname", usernickname);
	
	if(saveID==null){
		Cookie ck=new Cookie("saveID", id);
		ck.setMaxAge(0);
		response.addCookie(ck);
	}else{
		Cookie ck=new Cookie("saveID", id);
		ck.setMaxAge(60*60*24*30);
		response.addCookie(ck);
	}
	
	%>
	<script>
	window.alert('<%=usernickname%>님 로그인되었습니다.');
	opener.window.location.reload();
	window.self.close();
	</script>
	<%
} else{
	%>
	<script>
	window.alert('고객센터 연락 바람');
	window.self.close();
	</script>
	<%
}
%>