<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<script>
function openLoginPopup(){
	/* var width=screen.width ;
	var height = screen.height;	
	var option='width=600, height=300, resizable=no, top=200, left=470'; */
	var option = 'width=600, height=300, resizable:no, top=200, left=470, toolbar:0, location:0, menubar:0, overflow-y:none, scrollbars=yes';
	window.open('/homes/guest/login_popup.jsp','login',option);
}
</script>
<header>
<div id="header_top">
	<table>
		<tr>
			<td class="logo_black">H</td>
			<td class="logo_yellow">O</td>
			<td class="logo_black">M</td>
		</tr>
		<tr>
			<td class="logo_yellow">E</td>
			<td class="logo_icon"><a href="/homes">&#127960;</a></td>
			<td class="logo_yellow">S</td>
		</tr>
	</table>
	<div id="header_top_center">
		<h1>To the Endless Spaces</h1>
	</div>
	<div id="header_top_right">
		<%
		String usernickname = (String)session.getAttribute("usernickname");
		String userid = (String)session.getAttribute("userid");
		
		if(usernickname == null || usernickname == ""){
			%>
			<div id="header_top_right_login">
				<!-- <a href="/homes/guest/login.jsp">LOGIN</a> -->
				<a href="javascript:openLoginPopup()">LOGIN</a>
				<a href="/homes/guest/homesJoin.jsp">JOIN US</a>
			</div>
			<%
		}else{
			%>
			<div id="header_top_right_profile">
				<%
				int totalUnreadMsg = gdao.countUnreadMsg(userid);
				boolean unread = gdao.checkNonReadMsg(userid);
				String msgColor = unread ? "powderblue" : "cornsilk";
				String msgicon = unread ? "&#128486;":"";
				%>
				<table style="width:100%;">
				<tr>
					<td style="width:60%; text-align:start;"><a href="/homes/guest/mypage.jsp"><%=usernickname %>님<br>My Page</a></td>
					<td style="width:30%; display:flex; justify-content:space-evenly; align-items: baseline; text-align:start;">
						<a href="/homes/guest/msg.jsp" style="color:<%=msgColor%>; font-size:80px;">&#128490;</a>
						<p style="color:">(<%=totalUnreadMsg %>)</p>
					</td>
				</tr>
				</table>
				<%-- <a href="/homes/guest/mypage.jsp"><%=usernickname %>님<br>My Page</a>
				
				<a href="/homes/guest/msg.jsp"><%=msgicon %></a>	 --%>						
			</div><!-- 
			<div id="header_top_right_logout">
				<a href="/homes/guest/logout.jsp">LOGOUT</a>
			</div> -->
			<%
		}
		%>
		
		<div id="header_top_right_p">
		<%
		if(userid!=null && userid!=""){
			%>
			<a href="/homes/guest/logout.jsp">LOGOUT</a>
			<%
		}
		%>
			<p>since 2024</p>
		</div>
	</div>
</div>
</header>