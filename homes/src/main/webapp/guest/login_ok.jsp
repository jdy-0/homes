<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
%>
<%@ page import="java.util.*" %>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.room.RoomDAO" scope="session"></jsp:useBean>
<%@ page import="com.homes.room.RoomDTO" %>

<%
String id=request.getParameter("id");
String pwd=request.getParameter("pwd");
String saveID=request.getParameter("saveID");
int result = gdao.loginCheck(id, pwd);

int useridx = 0;

if(result == gdao.No_Id || result == gdao.No_Pwd){
	%>
	<script>
	window.alert('아이디 또는 비밀번호를 확인해주세요.');
	window.location.href='login.jsp';
	</script>
	<%
} else if(result == gdao.Login_ok){
	
	ArrayList<Object> user_info = gdao.getUserInfo(id);
	useridx=(Integer)user_info.get(0);
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
	
	
	
	if(useridx!=0){
		
		ArrayList<RoomDTO> room_arr=rdao.RoomInfo(useridx);
		session.setAttribute("room_arr", room_arr);
	}
	%>
	<script>
	window.alert('<%=usernickname%>님 로그인되었습니다.');
	//window.alert('room_arr세션저장');
	window.location.href='/homes';
	
	</script>
	<%
	//room더미데이터 생성 로직
	if(usernickname.equals("admin")){
	int CreateRoomTable= rdao.CreateRoomTable();//룸 테이블 생성
	//int CreateRoomTable=1;
	if(CreateRoomTable>=1){
		int CreateRoom_ImgTable = rdao.CreateRoom_ImgTable();//룸 이미지 테이블 생성
		if(CreateRoom_ImgTable>=1){
			int CreatSeq= rdao.CreateSeq();//룸 시퀀스, 룸 이미지시퀀스 생성
			if(CreatSeq>=1){
				int count = rdao.CreateAllRoom(usernickname); // 룸 insert
				if(count>=1){
					int count2 = rdao.CreateRoomDetailImg(); // 룸 이미지 insert
					if(count2>=1){
						System.out.println("생성완료");
					}else{
						System.out.println("룸 insert 오류");
					}
				}else{
					
				}
			}else{
				System.out.println("시퀀스 생성 오류");
			}
		}else{
			System.out.println("room_img테이블 생성 오류");
		}
	}else{
		System.out.println("room테이블 생성 오류");
	}
	}
	
	/*  int count = rdao.CreateAllRoom(usernickname);
	System.out.println(count);   */
	/* 
	int count2 = rdao.RoomDetailImg();
	System.out.println(count2); */
}
else
{
	%>
	<script>
	window.alert('고객센터 연락 바람');
	window.location.href='/homes';
	</script>
	<%
}
%>

<%
if(useridx!=0){
	
	ArrayList<RoomDTO> room_arr=rdao.RoomInfo(useridx);
	session.setAttribute("room_arr", room_arr);
	%>
	<script>
		window.alert('room_arr세션저장');
	
	</script>
	
<%
}else{
	%>
	<script>
		window.alert('아이디 또는 비밀번호를 확인해주세요.');
		window.location.href='login.jsp';
	</script>
	<%
}
%>





