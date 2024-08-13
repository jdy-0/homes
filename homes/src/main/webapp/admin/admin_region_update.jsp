<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.region.RegionDTO" %>
<jsp:useBean id="rdto" class="com.homes.region.RegionDTO"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.region.RegionDAO"></jsp:useBean>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@font-face {   /*제목용 굵은 폰트*/
    font-family: 'SBAggroB';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroB.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
body{background-color:#e2dccc;}
fieldset{
   width:480px;
   font-family: 'SBAggroB';
   margin:100px auto;
   border:0;
}
legend{
   font-size:30px;
}
#rgupdate_frame{
   margin:20px auto;
   display:block;
   justify-content: space-between;
   font-family: 'SBAggroB';
   font-size:25px;
   align-items: center;
}
#regionName{
   width:300px;
   outline:none;
   border:3px solid black;
   font-family: 'SBAggroB';
   font-size:23px;
   padding:5px;
}
#button{
   border:3px solid black;
   background-color:#dec022;
   font-family: 'SBAggroB';
   font-size:23px;
   padding:10px;
}
#button:hover{
   background-color:#e2dccc;
   transition:0.5s;
}
.select_things{
	border: 3px solid black;
    width: 300px;
    padding: 10px;
    font-size: 20px;
    font-family: 'SBAggroB';
}

</style>
</head>
<body>
<fieldset>
   <legend>지역수정</legend>
   <form name="rgupdate" onsubmit="return checkId()" action="admin_region_update_ok.jsp">
   <div id="rgupdate_frame">
   <div>
      <label>지역이름</label>
      <input type="text" name="name" id="regionName">      
   </div>
   <div>
      <label>상위지역</label>
      <select name="select_parent" class="select_things">
	      <%
			ArrayList<RegionDTO> region=new ArrayList<>();
			region=rdao.getRegion();
					
			for(int i=0;i<region.size();i++){%>
		      		<option value="<%=region.get(i).getRegion_idx()%>"><%=region.get(i).getRegion_name()%></option> 
	    <%} %>
		</select>   
   </div>
      <input type="submit" id="button" value="확인">
   </div>
   <div id="error-message" style="color: red; margin-top: 5px;"></div>
   </form>
</fieldset>
</body>
<script>

</script>
</html>
