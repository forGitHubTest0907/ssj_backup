package com.oracle.S202350102.service.main;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.mainDao.Level1Dao;
import com.oracle.S202350102.dto.Level1;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class Level1ServiceImpl implements Level1Service {
	private final Level1Dao ld;

	@Override
	public List<Level1> level1List(Level1 level1) {
		List<Level1> levelList = ld.level1List(level1);
		return levelList;
	}


}
