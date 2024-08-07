<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@font-face {	/*제목용 굵은 폰트*/
    font-family: 'SBAggroB';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroB.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
@font-face {	/*손글씨 느낌*/
    font-family: 'Ownglyph_jooreeletter-Rg';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2405-2@1.0/Ownglyph_jooreeletter-Rg.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
@font-face {	/*손글씨 버전 2*/
    font-family: 'Ownglyph_meetme-Rg';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_1@1.0/Ownglyph_meetme-Rg.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
body{
	background: #e2dccc;
	width:1600px;
	margin:30px auto;;
	border:5px solid black;
}
#header_top{
	width:1600px;
	height:auto;
	display: flex;
    justify-content: space-between;
}
#header_top table{
	width:500px;
	border-spacing:0;
	border-bottom:5px solid black;
	text-align:center;
}
.logo_black{
	witdh:70px;
	height:100px;
	background-color: black;
    color: #dec022;
    font-family: 'SBAggroB';
    font-size: 65px;
}
.logo_icon{
	witdh:70px;
	height:100px;
	background-color: black;
    color: white;
    font-family: 'SBAggroB';
    font-size: 65px;
}
.logo_yellow{
	width:70px;
	height:100px;
	background-color: #dec022;
    color: black;
    /* color: blue; */
    font-family: 'SBAggroB';
    font-size: 65px;
}
#header_top_center{
	background:#6f7bd0;
	width: -webkit-fill-available;
	color: #e2dccc;
	padding-left:50px;
	font-family: 'Ownglyph_meetme-Rg';
	vertical-align:middle;
	border-bottom:5px solid black;
}
#header_top_center h1{
	/* margin:80px; */
	font-family: 'Ownglyph_meetme-Rg';
	font-size:80px;
}
#header_top_right{
	background-color: black;
	width:600px;
	color:#e2dccc;
	padding-left:50px;
	font-family: 'Ownglyph_meetme-Rg';
	display: flex;
    flex-direction: column;
    justify-content: space-between;
}
#header_top_right_login{
	height:120px;
	margin-top:30px;
	display: flex;
    flex-direction: column;
    justify-content: space-evenly;
}
#header_top_right_login a{
	text-decoration:none;
	color:#e2dccc;
	font-family: 'Ownglyph_meetme-Rg';
	font-size:30px;
	padding:10px;
}
#header_top_right_login a:hover{
	font-size:33px;
}
#header_top_right_p{
	text-align:right;
	font-size:30px;
}
#header_top_right_p p{
	margin-botton:5px;
	margin-right:5px;
}
#header_bottom{
	display: flex;
    justify-content: space-between;
    border-bottom:5px solid black;
}
#table_barcode{
	height:50px;
	width:685px;
	border-spacing:0;
}
#table_barcode td{
	background:black;
}
#table_fullname{
	/* width:1100px; */
	height:50px;
	border-spacing:0;
	border-left:5px solid black;
}
#table_fullname th{
	padding:10px;
}
#table_fullname td{
	padding-left:25px;
	padding-right:25px;
}
#th_h{
	background:#00acc1;	
	border-right:5px solid black;
	font-family: 'SBAggroB';
	font-size:25px;
	color:white;
	width:35px;
}
#td_h{
	color:#00acc1;
	border-right:5px solid black;
	font-family: 'Ownglyph_meetme-Rg';
	font-size:25px;
	/* padding-left:5px;
	padding-right:5px; */
}
#th_o{
	background:#931a47;
	border-right:5px solid black;
	font-family: 'SBAggroB';
	font-size:25px;
	color:white;
	width:35px;
}
#td_o{
	color:#931a47;
	border-right:5px solid black;
	font-family: 'Ownglyph_meetme-Rg';
	font-size:25px;
	/* padding-left:5px;
	padding-right:5px; */
}
#th_m{
	background: #e88c30;
	border-right:5px solid black;
	font-family: 'SBAggroB';
	font-size:25px;
	color:white;
	width:35px;
}
#td_m{
	color:#e88c30;
	border-right:5px solid black;
	font-family: 'Ownglyph_meetme-Rg';
	font-size:25px;
	/* padding-left:5px;
	padding-right:5px; */
}
#th_e{
background: #009688;
border-right:5px solid black;
font-family: 'SBAggroB';
font-size:25px;
	color:white;
	width:35px;
}
#td_e{
color:#009688;
border-right:5px solid black;
font-family: 'Ownglyph_meetme-Rg';
font-size:25px;
/* padding-left:5px;
padding-right:5px; */
}
#th_s{
background: #ca3101;
border-right:5px solid black;
font-family: 'SBAggroB';
font-size:25px;
	color:white;
	width:35px;
}
#td_s{
color:#ca3101;
font-family: 'Ownglyph_meetme-Rg';
font-size:25px;
/* padding-left:5px;
padding-right:5px; */
}
footer{
	text-align:center;
	font-family: 'Ownglyph_meetme-Rg';
	font-size:20px;
}
footer hr{
	border:2px solid black;
}
footer div{
	margin:30px auto;
}
footer table{
	margin:20px auto;
	font-size:20px;
	width:1000px;
	height:30px;
}
footer table td{
	width:250px;
}
footer table a{
	color:black;
	text-decoration:underline;
}
footer table a:hover{
	font-size:22px;
	transition:0.4s;
}
</style>
</head>
<body>
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
			<td class="logo_icon">&#127960;</td>
			<td class="logo_yellow">S</td>
		</tr>
	</table>
	<div id="header_top_center">
		<h1>To the Endless Spaces</h1>
	</div>
	<div id="header_top_right">
		<div id="header_top_right_login">
			<a href="/homes/guest/login_popup.jsp">LOGIN</a>
			<a href="/homes/guest/homesjoin.jsp">JOIN US</a>
		</div>
		<div id="header_top_right_p">
			<p>since 2024</p>
		</div>
	</div>
</div>
<div id="header_bottom">
	<div>
	<table id="table_barcode">
		<tr>
			<%
			for(int i=1;i<=35;i++){
			%>
			<th> </th>
			<td> </td>
			<%
			}
			%>
		</tr>
	</table>
	</div>
	<div>
	<table id="table_fullname">
		<tr>
			<th id="th_h">H</th>
			<td id="td_h">Homes</td>
			<th id="th_o">O</th>
			<td id="td_o">Opened</td>
			<th id="th_m">M</th>
			<td id="td_m">Mesmerizing</td>
			<th id="th_e">E</th>
			<td id="td_e">Endless</td>
			<th id="th_s">S</th>
			<td id="td_s">Spaces</td>
		</tr>
	</table>
	</div>
</div>
</header>
<section>

</section>
<footer>
<hr>
<div>Copyright &copy;Homes.All Rights Reserved </div>
<table>
	<tr>
		<td><a href="#">개인정보 처리 방침</a></td>
		<td><a href="#">이용약관</a></td>
		<td><a href="#">환불 규정</a></td>
		<td><a href="#">회사 세부 정보</a></td>
	</tr>
</table>
</footer>
</body>
</html>