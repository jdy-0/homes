<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="sidebar">
	    <h2>관리자 메뉴</h2>
	    <nav>
	      	<ul id="ul_menu">
			    <li><a href="/homes/admin/admin.jsp">대시보드</a></li>
			    <li>
					회원 관리
			    	<ul>
			    		<li><a href="/homes/admin/admin_member_report.jsp">신고 회원 목록</a></li>
			    		<li><a href="/homes/admin/admin_member_block.jsp">차단 회원 목록</a></li>
			    	</ul>
			    </li>
			    <li>
			    	지역 관리
			    	<ul>
			    		<li><a href="/homes/admin/admin_region.jsp">지역 목록</a></li>
			    		<li><a href="/homes/admin/admin_regiondetail_list.jsp">지역 이미지 목록</a></li>
			    	</ul>
			    </li>		
			    <li>
			    	후기 관리
			    	<ul>
			    		<li><a href="/homes/admin/admin_reportlist.jsp">신고 후기 목록</a></li>
			    	</ul>
			    </li>		
			    <li>
			    	숙소 관리
			    	<ul>
			    		<li><a href="/homes/admin/admin_host_accept.jsp">숙소 승인</a></li>
			    	</ul>
			    </li>	    
			    <li>
			    	예약 관리
			    	<ul>
			    		<li><a href="/homes/admin/admin_refund_accept.jsp">환불 승인</a></li>
			    	</ul>
			    </li>
		    </ul>
	    </nav>
	    
	</div>