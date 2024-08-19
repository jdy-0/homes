<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO" scope="session"></jsp:useBean>
<%
	String savepath = request.getRealPath("/")+"img/";
	MultipartRequest mr = new MultipartRequest(request, savepath, 1024*1024*10, "utf-8");
    
	// 업로드된 파일 이름 가져오기
    String fileName = mr.getFilesystemName("selectFile");
    String imgpath="/homes/img/"+fileName;
    
    String ridx_s=mr.getParameter("ridx");
    int ridx=Integer.parseInt(ridx_s);
    
    System.out.println(imgpath);
    System.out.println(ridx);
%>
<script>
<%--window.alert('파일올리기 성공: <%= fileName %>');--%>
<%
int result=adao.regionImageUpdate(imgpath, ridx);
String msg=result>0 ? "지역 이미지 수정 완료" : "지역 이미지 수정 실패";
%>
window.alert('<%= msg %>');
window.location.href='admin_regiondetail_list.jsp';
</script>