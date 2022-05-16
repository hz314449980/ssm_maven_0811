package com.hz.ssm.service;

import com.github.pagehelper.PageInfo;
import com.hz.ssm.pojo.Customer;
import com.hz.ssm.utils.PageUtils;

public interface CustomerService {
    /**
     * 根据主键Id的查询方法
     * @param custId
     * @return
     */
    Customer findCustinfoById(Long custId);

    /**
     * 分页查询
     * @param indexPage
     * @return
     */
    PageUtils<Customer> findCustInfoByPage(Integer indexPage,String name);

    /**
     * 分页查询2
     * @param indexPage
     * @return
     */
    PageInfo<Customer> findCustInfoByPage2(Integer indexPage,String name);
}
