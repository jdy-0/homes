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
    private int viewCount;       // 조회수 (새 필드 추가)
    private int likeCount;       // 좋아요 수 (새 필드 추가)

    // Getters and Setters

    /**
     * 후기 번호를 반환합니다.
     * @return 후기 번호 (Primary Key)
     */
    public int getIdx() {
        return idx;
    }

    /**
     * 후기 번호를 설정합니다.
     * @param idx 후기 번호 (Primary Key)
     */
    public void setIdx(int idx) {
        this.idx = idx;
    }

    /**
     * 숙소 번호를 반환합니다.
     * @return 숙소 번호 (Foreign Key)
     */
    public int getRoomIdx() {
        return roomIdx;
    }

    /**
     * 숙소 번호를 설정합니다.
     * @param roomIdx 숙소 번호 (Foreign Key)
     */
    public void setRoomIdx(int roomIdx) {
        this.roomIdx = roomIdx;
    }

    /**
     * 별점을 반환합니다.
     * @return 별점
     */
    public int getRate() {
        return rate;
    }

    /**
     * 별점을 설정합니다.
     * @param rate 별점
     */
    public void setRate(int rate) {
        this.rate = rate;
    }

    /**
     * 리뷰 내용을 반환합니다.
     * @return 리뷰 내용
     */
    public String getContent() {
        return content;
    }

    /**
     * 리뷰 내용을 설정합니다.
     * @param content 리뷰 내용
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * 조회수를 반환합니다.
     * @return 조회수
     */
    public int getViewCount() {
        return viewCount;
    }

    /**
     * 조회수를 설정합니다.
     * @param viewCount 조회수
     */
    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    /**
     * 좋아요 수를 반환합니다.
     * @return 좋아요 수
     */
    public int getLikeCount() {
        return likeCount;
    }

    /**
     * 좋아요 수를 설정합니다.
     * @param likeCount 좋아요 수
     */
    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }
}
