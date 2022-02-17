package com.github.jgzl.hotel.controller.worker;

import com.github.jgzl.hotel.entity.OrderType;
import com.github.jgzl.hotel.response.AjaxResult;
import com.github.jgzl.hotel.response.ResponseTool;
import com.github.jgzl.hotel.service.OrderTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/op/order-type")
public class OpOrderTypeController {
    @Autowired
    private OrderTypeService orderTypeService;

    @RequestMapping(value = "/add")
    public AjaxResult addOrderType(String type,String remark){
        OrderType orderType = new OrderType(type,remark);
        int re = orderTypeService.insertOrderType(orderType);
        if(re!=1) return ResponseTool.failed();
        return ResponseTool.success();
    }

    @RequestMapping(value = "/delete/{typeId}")
    public AjaxResult deleteOrderType(@PathVariable Integer typeId){
        int re= orderTypeService.deleteOrderType(typeId);
        if(re!=1) return ResponseTool.failed();
        return ResponseTool.success();
    }

    @RequestMapping(value = "/update")
    public AjaxResult updateOrderType(Integer typeId,String type,String remark){
        OrderType orderType = new OrderType(type,remark);
        orderType.setTypeId(typeId);
        int re = orderTypeService.updateOrderType(orderType);
        if(re!=1) return ResponseTool.failed();
        return ResponseTool.success();
    }

    @RequestMapping(value = "/{typeId}")
    public AjaxResult getById(@PathVariable Integer typeId){
        return ResponseTool.success(orderTypeService.selectById(typeId));
    }

    @RequestMapping(value = "")
    public AjaxResult getAllType(){
        return ResponseTool.success(orderTypeService.selectAll());
    }

}
