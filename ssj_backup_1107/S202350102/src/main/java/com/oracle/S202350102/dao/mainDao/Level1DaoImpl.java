package com.oracle.S202350102.dao.mainDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Level1;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class Level1DaoImpl implements Level1Dao {
	private final SqlSession session;

	@Override
	public List<Level1> level1List(Level1 level1) {
		List<Level1> levelList = null;
		try {
			levelList = session.selectList("level1List",level1);
			System.out.println("levelList size->"+levelList.size());
		} catch (Exception e) {
			System.out.println("level1List sql exception->"+e.getMessage());
		}
		return levelList;
	}


}
