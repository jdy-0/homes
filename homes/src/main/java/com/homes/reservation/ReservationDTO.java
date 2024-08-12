package com.homes.reservation;

import java.util.Date;

public class ReservationDTO {
    private int reserve_idx;
    private int member_idx;
    private int room_idx;
    private String state;
    private Date reserve_date;
    private int price;

    // Getters and Setters
    public int getReserve_idx() {
        return reserve_idx;
    }

    public void setReserve_idx(int reserve_idx) {
        this.reserve_idx = reserve_idx;
    }

    public int getMember_idx() {
        return member_idx;
    }

    public void setMember_idx(int member_idx) {
        this.member_idx = member_idx;
    }

    public int getRoom_idx() {
        return room_idx;
    }

    public void setRoom_idx(int room_idx) {
        this.room_idx = room_idx;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Date getReserve_date() {
        return reserve_date;
    }

    public void setReserve_date(Date reserve_date) {
        this.reserve_date = reserve_date;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
}
