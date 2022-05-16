package com.hz.ssm.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hz.ssm.dao.CustomerMapper;
import com.hz.ssm.pojo.Customer;
import com.hz.ssm.pojo.CustomerExample;
import com.hz.ssm.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService{

    @Autowired
    private CustomerMapper customerMapper;
    @Override
    public Customer findCustinfoById(Long custId) {
        return customerMapper.selectByPrimaryKey(custId);
    }


    @Override
    public PageUtils<Customer> findCustInfoByPage(Integer indexPage,String name) {
        //默认首页
        if(indexPage == null){
            indexPage = 1;
        }
        //模糊匹配的查询拼接%%作为条件
        if(name == null){
            name = "";
        }

        name = "%"+name + "%";

        //分页插件pageHelper初始化
        PageHelper.startPage(indexPage,5);

        CustomerExample example = new CustomerExample();
        CustomerExample.Criteria criteria = example.createCriteria();
        //拼接查询条件
        criteria.andCustNameLike(name);

        //查询当前页数据
        List<Customer> customerList = customerMapper.selectByExample(example);

        //插件pageInfo对象，并完成分页参数的封装（包含了全面的分页属性信息）
        PageInfo<Customer> pageInfo = new PageInfo<Customer>(customerList);
        //把数据封装到PageUtils对象中
        PageUtils<Customer> pageBean = new PageUtils<Customer>();
      //设置当前页码
        pageBean.setIndexPage(indexPage);
        //设置每页大小
        pageBean.setPageSize(pageInfo.getPageSize());
        //设置总记录数
        pageBean.setCountRows(pageInfo.getTotal());
        //把当前页数据设置到PageUtils
        pageBean.setBeanList(customerList);


        return pageBean;
    }

    @Override
    public PageInfo<Customer> findCustInfoByPage2(Integer indexPage,String name) {

        //默认首页
        if(indexPage == null){
            indexPage = 1;
        }
        //模糊匹配的查询拼接%%作为条件
        if(name == null){
            name = "";
        }

        name = "%"+name + "%";

        //分页插件pageHelper初始化
        PageHelper.startPage(indexPage,5);

        CustomerExample example = new CustomerExample();
        CustomerExample.Criteria criteria = example.createCriteria();
        //拼接查询条件
        criteria.andCustNameLike(name);
        //查询当前页数据
        List<Customer> customerList = customerMapper.selectByExample(example);


        //插件pageInfo对象
        PageInfo<Customer> pageInfo = new PageInfo<Customer>(customerList);

        System.out.println("总记录数："+pageInfo.getTotal());

        return pageInfo;
    }
}
