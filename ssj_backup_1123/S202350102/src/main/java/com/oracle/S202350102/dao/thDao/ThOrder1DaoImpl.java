package com.oracle.S202350102.dao.thDao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Order1;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ThOrder1DaoImpl implements ThOrder1Dao {
	// Mybatis DB 연동
	private final SqlSession session;

	@Override
	public int insertOrder(Order1 order1) {
		System.out.println("ThOrder1DaoImpl insertOrder start...");
		int insertResult = 0;
		try {
			insertResult = session.insert("thOrderInsert", order1);
		}catch (Exception e) {
			System.out.println("ThOrder1DaoImpl thOrderInsert Exception --> " + e.getMessage());
		}
		return insertResult;
	}

	@Override
	public Order1 selectOrder(Order1 order1) {
		System.out.println("ThOrder1DaoImpl selectOrder start...");
		Order1 orderResult = null;
		try {
			orderResult = session.selectOne("thOrderSelect", order1);
		}catch (Exception e) {
			System.out.println("ThOrder1DaoImpl orderResult  Exception --> " + e.getMessage());
		}
		return orderResult;
	}
	
	
}
