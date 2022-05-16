package com.hz.ssm.controller;

import com.github.pagehelper.PageInfo;
import com.hz.ssm.pojo.Customer;
import com.hz.ssm.service.CustomerService;
import com.hz.ssm.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/api/cust")//窄化请求映射路径
public class CustomerController {
    @Autowired
    private CustomerService customerService;
    /**
     * 根据主键Id的查询方法
     * @param custId
     * @return
     */
    @ResponseBody
    @RequestMapping("/findCustinfoById/{custId}")
    public Customer findCustinfoById(@PathVariable("custId") Long custId){
        Customer customer = customerService.findCustinfoById(custId);
        return customer;
    }

    /**
     * 后台分页查询数据的功能
     * @param indexPage
     * @return
     */
    @ResponseBody
    @RequestMapping("/findCustInfoByPage")
    public PageUtils<Customer> findCustInfoByPage(Integer indexPage,String name){

        PageUtils<Customer> pageBean =  customerService.findCustInfoByPage(indexPage,name);

        System.out.println("=====");
        return pageBean;
    }
    /**
     * 后台分页查询数据的功能
     * @param indexPage
     * @return
     */
    @ResponseBody
    @RequestMapping("/findCustInfoByPage2")
    public PageInfo<Customer> findCustInfoByPage2(Integer indexPage,String name){

        PageInfo<Customer> pageInfo =  customerService.findCustInfoByPage2(indexPage,name);

        return pageInfo;
    }



}
