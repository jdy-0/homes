<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.region.RegionDTO" %>
<jsp:useBean id="rdto" class="com.homes.region.RegionDTO"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.region.RegionDAO"></jsp:useBean>   
<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO"></jsp:useBean>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	String region_idx_s=request.getParameter("param");
	int region_idx=Integer.parseInt(region_idx_s);
%>
<link rel="stylesheet" type="text/css" href="/homes/admin/css/regionUpdate.css">
</head>
<body>
<fieldset>
   <legend>지역수정</legend>
   <form name="rgupdate" action="admin_region_update_ok.jsp">
   <div id="rgupdate_frame">
   <%
		RegionDTO rg=new RegionDTO();
 		rg=adao.getRegion(region_idx);
	%>
   <div>
      <label>지역이름</label>
      <input type="text" name="regionName" id="regionName" value="<%=rg.getRegion_name()%>" required="required">      
   </div>
   <div>
      <label>상위지역</label>
      <select name="select_parent" class="select_things">
      		<%
      		if(rg.getParent_idx()==0){
      			%><option value="0">-</option><%
      		} else {
      		%>
				<%	
				ArrayList<RegionDTO> region=new ArrayList<>();
				region=rdao.getRegion();
				for(int i=0;i<region.size();i++){
				%>
					<option value="<%=region.get(i).getRegion_idx()%>"><%=region.get(i).getRegion_name()%></option> 
		    	<%
	    		} 
			}
	    	%>
		</select>   
   </div>
   <div style="text-align:center; margin:20px;">
   		<input type="hidden" name="regionIdx" value="<%=rg.getRegion_idx() %>">
      	<input type="submit" id="button" value="수정">
   </div>
   </div>
   </form>
</fieldset>
</body>
<script>

</script>
</html>
