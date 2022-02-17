package com.github.jgzl.hotel.controller.common;

import com.github.jgzl.hotel.response.AjaxResult;
import com.github.jgzl.hotel.response.ResponseTool;
import com.github.jgzl.hotel.service.HotelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/hotel")
public class HotelController {
    @Autowired
    private HotelService hotelService;

    @RequestMapping(value = "")
    public AjaxResult getAllHotel(){
        return ResponseTool.success(hotelService.selectAll());
    }
}
