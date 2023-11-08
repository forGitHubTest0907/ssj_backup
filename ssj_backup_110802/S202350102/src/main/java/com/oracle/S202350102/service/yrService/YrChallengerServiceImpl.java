package com.oracle.S202350102.service.yrService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.yrDao.YrChallengerDao;
import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class YrChallengerServiceImpl implements YrChallengerService {
	private final YrChallengerDao ycd;
	
	

	// 소세지들 리스트 출력
//	@Override
//	public List<User1> getListSsj(int chg_id) {
//		System.out.println("YrChallengerServiceImpl listSsj Start...");
//		
//		// user list 가져오기
//		List<User1> userListSsj = ycd.getListSsj(chg_id);
//		
//		// 새로운 list 선언
//		List<User1> listSsj = new ArrayList<>();
//		
//		for(User1 user1 : userListSsj) {
//			List<Board> boardRegDate = ycd.getBoardRegDate(chg_id);
//			
//			User1 user = new User1();
//			
//		}
//		
//		
//		
//		return listSsj;
//	}
	
	
	
	
	@Override
	public List<User1> getListSsj(int chg_id) {
		System.out.println("YrChallengerServiceImpl listSsj Start...");
		List<User1> listSsj = ycd.getListSsj(chg_id); 
		return listSsj;
	}
	
	// 인증 게시판 작성 일자 출력
	@Override
	public String getBoardRegDate(int chg_id) {
		System.out.println("YrChallengerServiceImpl listSsj Start...");
		String boardRegDate = ycd.getBoardRegDate(chg_id);
		return boardRegDate;
	}

	// 챌린지 참가자 insert
	@Override
	public int insertChgr(Challenger chgr) {
		System.out.println("YrChallengerServiceImpl insertChgr Start...");
		int insertChgr = ycd.insertChgr(chgr);
		return insertChgr;
	}

	// 챌린지 참여인원 select
	@Override
	public int selectChgrParti(int chg_id) {
		System.out.println("YrChallengerServiceImpl selectChgrParti Start...");
		int selectChgrParti = ycd.selectChgrParti(chg_id);
		return selectChgrParti;
	}

	// 챌린지 참여 여부 판단
	@Override
	public int selectChgrJoinYN(Challenger chgr) {
		System.out.println("YrChallengerServiceImpl selectChgrJoinYN Start...");
		int selectChgrJoinYN = ycd.selectChgrJoinYN(chgr);
		return selectChgrJoinYN;
	}

}