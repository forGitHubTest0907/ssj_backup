package com.oracle.S202350102.service.thService;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.thDao.ThOrder1Dao;
import com.oracle.S202350102.dto.Order1;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ThOrder1ServiceImpl implements ThOrder1Service {

	private final ThOrder1Dao od1;
	
	@Override
	public int insertOrder(Order1 order1) {
		System.out.println("ThOrder1ServiceImpl insertOrder Start...");
		int insertResult = od1.insertOrder(order1);
		return insertResult;
	}

	@Override
	public Order1 selectOrder(Order1 order1) {
		System.out.println("ThOrder1ServiceImpl selectOrder Start...");
		Order1 orderResult = od1.selectOrder(order1);
		return orderResult;
	}

}
