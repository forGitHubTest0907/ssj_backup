package com.oracle.S202350102.dao.jhDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class JhChallengeDaoImpl implements JhChallengeDao {
	
	private final SqlSession session;

	//챌린지 정보 조회
	@Override
	public Challenge chgDetail(int chg_id) {
		System.out.println("JhChallengeDaoImpl chgDetail Start...");
		System.out.println("JhChallengeDaoImpl chgDetail  chg_id -> "+ chg_id);
		
		Challenge chgDetail = null;
		try {
			
			chgDetail = session.selectOne("jhChgDetail", chg_id);
			System.out.println("JhChallengeDaoImpl chgDetail  chg -> "+ chgDetail);
			
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl chgDetail e.getMessage() -> "+ e.getMessage());
		}
		
		return chgDetail;
	}

	@Override
	public List<Board> chgReviewList(int chg_id) {
		System.out.println("JhChallengeDaoImpl chgReviewList Start...");
		System.out.println("JhChallengeDaoImpl chgReviewList  chg_id -> "+ chg_id);
		List<Board> chgReviewList = null;
		
		try {
			
			chgReviewList = session.selectList("jhChgReviewList", chg_id);
		} catch (Exception e) {
			System.out.println("JhChallengeDaoImpl chgReviewList e.getMessage() -> "+ e.getMessage());
		}
		
		System.out.println("JhChallengeDaoImpl chgReviewList  chgReviewList.size() -> "+ chgReviewList.size());

		return chgReviewList;
	}



}
