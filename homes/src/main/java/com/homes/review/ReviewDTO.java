package com.homes.review;

/**
 * ReviewDTO 클래스는 리뷰 데이터를 저장하고 전달하는 역할을 합니다.
 * 이 클래스는 데이터베이스의 Reviews 테이블 구조와 일치하도록 설계되었습니다.
 */
public class ReviewDTO {
    private int idx;             // 후기 번호 (Primary Key)
    private int roomIdx;         // 숙소 번호 (Foreign Key)
    private int rate;            // 별점
    private String content;      // 리뷰 내용
    private String memberId; // 추가된 필드
    // Getters and Setters

    public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public int getRoomIdx() {
        return roomIdx;
    }

    public void setRoomIdx(int roomIdx) {
        this.roomIdx = roomIdx;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
