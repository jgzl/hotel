package com.github.jgzl.hotel.service.impl;

import com.github.jgzl.hotel.entity.CheckIn;
import com.github.jgzl.hotel.entity.Order;
import com.github.jgzl.hotel.entity.Room;
import com.github.jgzl.hotel.entity.RoomType;
import com.github.jgzl.hotel.enums.OrderStatus;
import com.github.jgzl.hotel.enums.RoomStatus;
import com.github.jgzl.hotel.mapper.CheckInMapper;
import com.github.jgzl.hotel.service.CheckInService;
import com.github.jgzl.hotel.service.OrderService;
import com.github.jgzl.hotel.service.RoomService;
import com.github.jgzl.hotel.service.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CheckInServiceImpl implements CheckInService {
    @Autowired
    private CheckInMapper checkInMapper;
    @Autowired
    private OrderService orderService;
    @Autowired
    private RoomTypeService roomTypeService;
    @Autowired
    private RoomService roomService;

    @Override
    public int insert(CheckIn checkIn) {
        return checkInMapper.insert(checkIn);
    }

    /**
     * 入住登记
     * @param checkIn
     * 1.获取订单
     * 2.获取房间类型
     * 3.获取房间
     * @return
     */
    @Override
    @Transactional
    public Room checkIn(CheckIn checkIn) {
        Order order = orderService.selectById(checkIn.getOrderId());
        RoomType rt = roomTypeService.selectById(order.getRoomTypeId());
        Room r = roomService.selectById(roomService.inRoom(order.getRoomTypeId()));
        checkIn.setRoomId(r.getRoomId());
        checkIn.setRoomNumber(r.getRoomNumber());
        roomTypeService.updateRest(rt.getTypeId(),-1);
        order.setOrderStatus(OrderStatus.CHECK_IN.getCode());
        orderService.update(order);
        checkInMapper.insert(checkIn);
        return r;
    }

    /**
     * 退房登记
     * 1.获取房间
     * 2.获取房型
     * 3.获取checkIn
     * @param roomNumber
     * @return
     */
    @Override
    public int checkOut(String  roomNumber){
        Room r = roomService.selectByNumber(roomNumber);
        RoomType ty = roomTypeService.selectById(r.getTypeId());
        CheckIn checkIn = checkInMapper.selectLatestByRoomNumber(roomNumber);
        r.setRoomStatus(RoomStatus.AVAILABLE.getCode());
        if(roomService.update(r) <=0 )return -3;
        if (roomTypeService.updateRest(ty.getTypeId(),1)<=0)return -2;
        return checkInMapper.checkOut(checkIn.getCheckInId());
    }

    @Override
    public int delete(int checkInId) {
        return checkInMapper.deleteByPrimaryKey(checkInId);
    }

    @Override
    public int update(CheckIn checkIn) {
        return checkInMapper.updateByPrimaryKeySelective(checkIn);
    }



    @Override
    public int updateByRoomNumber(String roomNumber) {
        return checkInMapper.updateByRoomNumber(roomNumber);
    }

    @Override
    public CheckIn selectById(int checkInId) {
        return checkInMapper.selectByPrimaryKey(checkInId);
    }

    @Override
    public List<CheckIn> selectAll() {
        return checkInMapper.selectAll();
    }
}
