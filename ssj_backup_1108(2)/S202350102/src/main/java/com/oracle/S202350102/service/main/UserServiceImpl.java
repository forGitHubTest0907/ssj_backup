package com.oracle.S202350102.service.main;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.mainDao.UserDao;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.dto.UserLevel;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
	private final UserDao ud;

	/*
	 * 강한빛
	 *  유저의 정보를 불러오는 메소드
	 */
	@Override
	public User1 userSelect(int user_num) {
		if (user_num != 0) {
			User1 user = new User1();
			user = ud.userSelect(user_num);
			return user;
		} else {
			return null;
		}

	}

	/*
	 * 강한빛
	 * 해당 유저와 레벨 테이블간의 조인정보 조회(보통 로그인한 유저의 아이콘을 사용하기위함)
	 */
	@Override
	public UserLevel userLevelInfo(int user_num) {
		UserLevel userLevelInfo = ud.userLevelInfo(user_num);
		return userLevelInfo;
	}

	/*
	 * 강한빛
	 * User1 - Level1 간의 모든정보를 조회
	 */	
	@Override
	public List<UserLevel> userLevelInfoList() {
		List<UserLevel> userLevelInfoList = ud.userLevelInfoList();
		return userLevelInfoList;
	}
	
//	protected UserLevel userLevelInfo(int user_num) {
//		UserLevel userLevelInfo = ud.userLevelInfo(user_num);
//		return userLevelInfo;
//	}
	
	

	
	
	
}
