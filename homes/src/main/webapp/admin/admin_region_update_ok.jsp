<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO"></jsp:useBean> 
<%
//int result=adao.regionUpdateSubmit(dto);
String idx_s=request.getParameter("regionIdx");
int idx=Integer.parseInt(idx_s);
String name=request.getParameter("regionName");
String parent_name=request.getParameter("select_parent");
int pidx=0;
if(!parent_name.equals("-")){
	pidx=Integer.parseInt(parent_name);
	System.out.println(pidx);
}
//String pidx_s=request.getParameter("select_parent");
//int pidx=Integer.parseInt(pidx_s);

int result=0;


if(parent_name.equals("-")){	
	result=adao.regionUpdateSubmit(idx, name);
} else {	
	result=adao.regionUpdateSubmit(idx, name, pidx);
}

String msg=result>0 ? "지역 수정 완료" : "지역 수정 실패";
%>
<script>
window.alert('<%=msg %>');
opener.window.location.reload();
window.self.close();

</script>