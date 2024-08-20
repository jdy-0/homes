<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="javax.servlet.http.Part" %>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
int idx = (Integer)session.getAttribute("useridx");
String nickname = request.getParameter("nickname");
String email = request.getParameter("email");
String tel = request.getParameter("tel");

int result = gdao.updateProfile(idx, nickname, email, tel);
String msg = result>0 ? "수정 완료" : "수정 실패";

// 파일 업로드
Part filePart = request.getPart("profileImgFile");
if (filePart != null && filePart.getSize() > 0) {
    String uploadDir = application.getRealPath("/") + "homes/guest/profileImg";
    boolean uploadResult = gdao.uploadProfileImage(idx, filePart, uploadDir);

    if (!uploadResult) {
        msg = "이미지 업로드 실패";
    }
}
%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>

<%
    request.setCharacterEncoding("utf-8");

    // 세션에서 사용자 ID 가져오기
    int idx = (Integer) session.getAttribute("useridx");

    // 모든 파트 가져오기
    Collection<Part> parts = request.getParts();
    String nickname = null;
    String email = null;
    String tel = null;
    Part filePart = null;

    // 파트에서 파라미터와 파일 분리하기
    for (Part part : parts) {
        String contentDisposition = part.getHeader("Content-Disposition");
        if (contentDisposition != null && contentDisposition.contains("filename=")) {
            filePart = part; // 파일 파트
        } else {
            String partName = part.getName();
            if ("nickname".equals(partName)) {
                nickname = request.getParameter("nickname");
            } else if ("email".equals(partName)) {
                email = request.getParameter("email");
            } else if ("tel".equals(partName)) {
                tel = request.getParameter("tel");
            }
        }
    }

    // 디버깅: 파라미터 값 확인
    System.out.println("nickname=" + nickname);
    System.out.println("email=" + email);
    System.out.println("tel=" + tel);

    // 프로필 정보 업데이트
    int result = gdao.updateProfile(idx, nickname, email, tel);
    String msg = result > 0 ? "수정 완료" : "수정 실패";

    // 파일 업로드 처리
    if (filePart != null && filePart.getSize() > 0) {
        String uploadDir = application.getRealPath("/") + "homes/guest/profileImg";
        boolean uploadResult = gdao.uploadProfileImage(idx, filePart, uploadDir);

        if (!uploadResult) {
            msg = "이미지 업로드 실패";
        }
    }
%>
<script>
alert('nickname=<%=nickname%>, email=<%=email%>, tel=<%=tel%>');
alert('<%=msg%>');
location.href='/homes/guest/myProfile.jsp';
</script>