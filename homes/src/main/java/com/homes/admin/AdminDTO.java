package com.homes.admin;

/**
 * AdminDTO 클래스는 admin 테이블의 행(row)을 객체로 표현합니다.
 * 이 클래스는 관리자의 정보를 저장하고 전송하는 데 사용됩니다.
 */
public class AdminDTO {
    // 관리자의 고유 인덱스 번호 (Primary Key)
    private int idx;

    // 관리자의 로그인 아이디
    private String id;

    // 관리자의 비밀번호 (해싱된 형태로 저장되는 것이 권장됨)
    private String pwd;

    // 관리자의 이름
    private String name;

    // 관리자의 부서 (선택 사항)
    private String dept;

    // 관리자의 이메일 주소
    private String email;

    /**
     * 기본 생성자
     * 필요한 경우 객체를 초기화할 수 있음.
     */
    public AdminDTO() {}

    /**
     * 모든 필드를 사용하는 생성자
     * 객체 생성 시 모든 필드를 초기화할 수 있음.
     * 
     * @param idx 관리자의 고유 인덱스 번호
     * @param id 관리자의 로그인 아이디
     * @param pwd 관리자의 비밀번호
     * @param name 관리자의 이름
     * @param dept 관리자의 부서
     * @param email 관리자의 이메일 주소
     */
    public AdminDTO(int idx, String id, String pwd, String name, String dept, String email) {
        this.idx = idx;
        this.id = id;
        this.pwd = pwd;
        this.name = name;
        this.dept = dept;
        this.email = email;
    }

    // Getter 및 Setter 메서드
    // 각 필드에 접근하거나 값을 설정하기 위한 메서드들

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
