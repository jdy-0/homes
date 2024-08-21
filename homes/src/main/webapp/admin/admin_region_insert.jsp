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
<link rel="stylesheet" type="text/css" href="css/regionInsert.css">
</head>
<body>
<fieldset>
   <legend>지역추가</legend>
   <form name="rginsert" action="admin_region_insert_ok.jsp">
   <div id="rginsert_frame">
   <div>
      <label>지역이름</label>
      <input type="text" name="regionName" id="regionName" required="required">      
   </div>
   <div>
      <label>상위지역</label>
      <select name="select_parent" class="select_things">
      			<option value="0">-</option>
				<%	
				ArrayList<RegionDTO> region=new ArrayList<>();
				region=rdao.getRegion();
				for(int i=0;i<region.size();i++){
				%>
					<option value="<%=region.get(i).getRegion_idx()%>"><%=region.get(i).getRegion_name()%></option> 
		    	<%
	    		} 
	    	%>
		</select>   
   </div>
      <input type="submit" id="button" value="추가">
   </div>
   </form>
</fieldset>
</body>
<script>

</script>
</html>
