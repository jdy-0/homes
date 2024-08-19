<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO"></jsp:useBean> 
<%
String name=request.getParameter("regionName");
String pidx_s=request.getParameter("select_parent");
int pidx=Integer.parseInt(pidx_s);

boolean check=true;
if(pidx==0){	
	check=adao.nameCheck(name);
} else {	
	check=adao.nameCheck(pidx, name);
}

if(!check){
	int result=0;
	if(pidx==0){	
		result=adao.regionInsertSubmit(name);
	} else {	
		result=adao.regionInsertSubmit(name, pidx);
	}
	
	String msg=(result==1) ? "지역 추가 완료" : "지역 추가 실패";
	%>
	<script>
	window.alert('<%=msg %>');
	opener.window.location.reload();
	window.self.close();
	
	</script>
<%} else {
	%>
	<script>
	window.alert('이미 존재하는 지역명입니다');
	history.back();
	</script>
	<%
}%>