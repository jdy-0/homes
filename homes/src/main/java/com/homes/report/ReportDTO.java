package com.homes.report;

public class ReportDTO {
    private int id;
    private int commentId;
    private int roomIdx;
    private String reportReason;
    private String reportDate;

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getCommentId() {
        return commentId;
    }
    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }
    public int getRoomIdx() {
        return roomIdx;
    }
    public void setRoomIdx(int roomIdx) {
        this.roomIdx = roomIdx;
    }
    public String getReportReason() {
        return reportReason;
    }
    public void setReportReason(String reportReason) {
        this.reportReason = reportReason;
    }
    public String getReportDate() {
        return reportDate;
    }
    public void setReportDate(String reportDate) {
        this.reportDate = reportDate;
    }
}
