<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>

<%
    request.setCharacterEncoding("utf-8");

    int idx = (Integer) session.getAttribute("useridx");
    String id = (String) session.getAttribute("userid");
    
    // 파일 저장 경로
    String savePath = request.getRealPath("/")+"guest/profileimg";
    MultipartRequest mr = new MultipartRequest(request, savePath, 5*1024*1024, "utf-8");
	
    String nickname = mr.getParameter("nickname");
    String email = mr.getParameter("email");
    String tel = mr.getParameter("tel");
    
    //프로필이미지 파일 가져오기
    File profileImgFile = mr.getFile("profileImgFile");
    
    //파일 이름을 사용자 id로 저장하기
    if(profileImgFile!=null){
    	String fileEx = "";//확장자명 초기화
    	String fileName = profileImgFile.getName();
    	int dotIdx = fileName.lastIndexOf('.');
    	
    	if(dotIdx > 0){	//확장자명 가져오기
    		fileEx = fileName.substring(dotIdx);
    	}
    	
    	String newFileName = id+fileEx;
    	File newFile = new File(savePath, newFileName);
    	
    	//기존 파일 있으면 삭제
    	if(newFile.exists()){
    		newFile.delete();
    	}
    	//새로운 이름으로 파일 저장
    	profileImgFile.renameTo(newFile);
    	
    	//프로필 정보 업데이트
    	String imagePath = savePath+"/"+newFileName;
    	int uploadResult = gdao.updateProfileImagePath(idx, newFileName);
    	
    	if(uploadResult<0){
    		%>
    		<script>
    		alert('업로드 실패');
    		location.href='/homes/guest/myProfile.jsp';
    		</script>
    		<%
    	}    	
    }
    
    int result = gdao.updateProfile(idx, nickname, email, tel);
	String msg = result>0? "수정완료":"수정실패";
%>
<script>
alert('<%=msg%>');
location.href='/homes/guest/myProfile.jsp';
</script>