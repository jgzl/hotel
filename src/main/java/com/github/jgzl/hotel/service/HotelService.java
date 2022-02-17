package com.github.jgzl.hotel.service;

import com.github.jgzl.hotel.entity.Hotel;

import java.util.List;

public interface HotelService {

    int insert(Hotel hotel);
    int delete(int hotelId);
    int update(Hotel hotel);
    Hotel selectByName(String hotelName);
    Hotel selectById(int hotelId);
    List<Hotel> selectAll();

}
