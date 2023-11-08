package com.oracle.S202350102.service.jhService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.jhDao.JhChallengeDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JhCallengeServiceImpl implements JhCallengeService {
	
	private final JhChallengeDao jhChgDao;
	
	//챌린지 정보 조회
	@Override
	public Challenge chgDetail(int chg_id) {
		System.out.println("JhCallengeServiceImpl chgDetail Start...");

		System.out.println("JhCallengeServiceImpl chgDetail  chg_id -> "+ chg_id);

		Challenge chgDetail = jhChgDao.chgDetail(chg_id);
		
		
		return chgDetail;
	}

	@Override
	public List<Board> chgReviewList(int chg_id) {
		System.out.println("JhCallengeServiceImpl chgReviewList Start...");
		
		List<Board> chgReviewList = jhChgDao.chgReviewList(chg_id);
		
		return chgReviewList;
	}


	
	

}
