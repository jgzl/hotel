package com.github.jgzl.hotel.service;

import com.github.jgzl.hotel.entity.CheckIn;
import com.github.jgzl.hotel.entity.Room;

import java.util.List;

public interface CheckInService {

    int insert(CheckIn checkIn);

    Room checkIn(CheckIn checkIn);

    int delete(int checkInId);

    int update(CheckIn checkIn);

    int checkOut(String roomNumber);

    int updateByRoomNumber(String roomNumber);

    CheckIn selectById(int checkInId);

    List<CheckIn> selectAll();

}
