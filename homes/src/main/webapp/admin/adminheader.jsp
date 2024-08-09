<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<script>
function openLoginPopup(){
	var option='width=600, height=300, resizable=no, top=200, left=470';
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
			for(int i=1;i<=30;i++){
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