package com.hz.ssm.utils;

import java.util.List;


/**
 * 分页工具类
 * @author Administrator
 *
 */
public class PageUtils<T> {
	
	private Integer biginRows;  //起始行
	private Integer pageSize;  // 每页大小
	private Integer indexPage; //当前页码
	private Integer totalPage; //总页数
	
	private Long countRows; //总记录数  SELECT COUNT(1) FROM orders o;
	
	private List<T> beanList; //保存每页数据的属性
	

	

	public List<T> getBeanList() {
		return beanList;
	}

	public void setBeanList(List<T> beanList) {
		this.beanList = beanList;
	}

	public PageUtils() {
		// TODO Auto-generated constructor stub
	}
	
	public Integer getTotalPage() {

		totalPage = (int) (countRows%pageSize==0?countRows/pageSize : countRows/pageSize+1);
		
		return totalPage;
	}

	public Long getCountRows() {
		return countRows;
	}
	public void setCountRows(Long countRows) {
		this.countRows = countRows;
	}


	public Integer getBiginRows() {
		
		biginRows =	(indexPage -1) * pageSize;
		
		return biginRows;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getIndexPage() {
		return indexPage;
	}

	public void setIndexPage(Integer indexPage) {
		this.indexPage = indexPage;
	}
	

}
