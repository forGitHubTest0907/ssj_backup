package com.oracle.S202350102.dao.bgDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BgBoardDaoImpl implements BgBoardDao {
	
	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;
	
	// 챌린지 정보 조회
	@Override
	public Challenge bgChgDetail(int chg_id) {
		System.out.println("BgDaoImpl bgChgDetail Start...");
		System.out.println("BgDaoImpl bgChgDetail chg_id -> "+chg_id);
		Challenge chg = null;
		try {
			chg = session.selectOne("bgChgDetail", chg_id);
			System.out.println("BgDaoImpl bgChgDetail chg -> "+chg);
		} catch (Exception e) {
			System.out.println("BgDaoImpl bgChgDetail e.getMessage() -> "+e.getMessage());
		}
		return chg;
	}
	

	@Override
	public List<Board> certBoard(Board board) {
		List<Board> boardCert = null;
		System.out.println("BgDaoImpl certBoard Start...");
		try {
			boardCert = session.selectList("bgCertBoardAll", board);
		} catch (Exception e) {
			System.out.println("BgDaoImpl certBoard e.getMessage() -> " + e.getMessage());
		}
		return boardCert;
	}
	
	@Override
	public List<Board> boardCert(Board board) {
		List<Board> certBoard = null;
		System.out.println("BgDaoImpl boardCert Start... ");
		try {
			certBoard = session.selectList("bkCertBoard", board);
		} catch (Exception e) {
			System.out.println("BgDaoImpl boardCert e.getMessage() -> " + e.getMessage());
		}
		return certBoard;
	}

	
	@Override
	public int insertCertBrd(Board board) {
		
		int result = 0;
		System.out.println("BgDaoImpl boardCert Start... ");
		
		try {
			result = session.insert("insertCertBrd", board);
		} catch (Exception e) {
			System.out.println("BgDaoImpl insertCertBrd e.getMessage() -> " + e.getMessage());
		}
		
		return result;
	}

	@Override
	public int updateCertBrd(Board board) {
		
		System.out.println("BgDaoImpl update Start...");
		int updateCount = 0;
		
		try {
			updateCount = session.update("updateCertBrd", board);
		} catch (Exception e) {
			System.out.println("BgDaoImpl updateCertBrd Exception -> "+e.getMessage());
		}
		return updateCount;
	}

	// 트랜젝션 1. 인증 게시판 원글 지우기
	@Override
	public int deleteCertBrd(Board board) {
		System.out.println("BgDaoImpl delete Start...");
		System.out.println("BgDaoImpl delete getBrd_num -> "+board.getBrd_num());
		TransactionStatus txStatus = transactionManager.getTransaction(new DefaultTransactionDefinition());
		int result = 0;
		try {
			// 좋아요 게시판 게시판에서 로우 삭제
			result = session.delete("bgDeleteBrdLike", board);
			System.out.println("보경 좋아요삭제 결과 --> " + result);
			
			// 신고 게시판 행 삭제
			result = session.delete("bgDeleteReport", board);
			System.out.println("보경 신고삭제 결과 --> " + result);

			// 보드게시판 댓글 삭제
			result = session.delete("deleteCertBrd", board);
			System.out.println("BgDaoImpl delete result -> "+result);
			
			// 3개 수행 완료 후 커밋
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			System.out.println("BgDaoImpl deleteCertBrd Exception -> "+e.getMessage());
			// 3개 수행 실패 후 롤백
			transactionManager.rollback(txStatus);
		}
		return result;
	}
	
	
	// 트랜젝션 2. 인증 게시판 댓글 지우기
	@Override
	public int deleteCertCmt(Board board) {
		System.out.println("BgDaoImpl deleteCertCmt Start...");
		System.out.println("BgDaoImpl deleteCertCmt getBrd_num -> "+board.getBrd_num());
		TransactionStatus txStatus = transactionManager.getTransaction(new DefaultTransactionDefinition());
		int result = 0;
		try {
			// 좋아요 게시판 게시판에서 로우 삭제
			result = session.delete("bgDeleteBrdLike", board);
			System.out.println("보경 좋아요삭제 결과 --> " + result);
			
			// 신고 게시판 행 삭제
			result = session.delete("bgDeleteReport", board);
			System.out.println("보경 신고삭제 결과 --> " + result);

			// 보드게시판 댓글 삭제
			result = session.delete("deleteCertBrd", board);
			System.out.println("BgDaoImpl delete result -> "+result);
			
			// 3개 수행 완료 후 커밋
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			System.out.println("BgDaoImpl deleteCertCmt Exception -> "+e.getMessage());
			// 3개 수행 실패 후 롤백
			transactionManager.rollback(txStatus);
		}
		return result;
	}
	
	

	@Override
	public int certTotal(int chg_id) {
		System.out.println("BgDaoImpl certTotal Start...");
		int certTotal = 0;
		
		try {
			certTotal = session.selectOne("certTotal", chg_id);
		} catch (Exception e) {
			System.out.println("BgDaoImpl certTotal e.getMessage() -> "+e.getMessage());
		}
		System.out.println("BgDaoImpl certTotal -> "+certTotal);
		
		return certTotal;
	}


	@Override
	public void commentInsert(Board board) {
		System.out.println("BgDaoImpl commentInsert Start...");
		session.selectOne("commentInsert", board);
		System.out.println("BgDaoImpl commentInsert Start..."+board.getResultCount());
	}


	@Override
	public int srchCrtBdCnt(Board board) {
		int crtBdCntSrch = 0;
		System.out.println("BgDaoImpl srchCrtBdCnt Start...");
		
		try {
			crtBdCntSrch = session.selectOne("srchCrtBdCnt", board);
			System.out.println("BgDaoImpl srchCrtBdCnt crtBdCntSrch -> "+crtBdCntSrch);
		} catch (Exception e) {
			System.out.println("BgDaoImpl srchCrtBdCnt Exception -> "+e.getMessage());
		}
		
		return crtBdCntSrch;
	}
	
	
	@Override
	public List<Board> searchCrtBd(Board board) {
		List<Board> crtBdSearch = null;
		System.out.println("BgDaoImpl searchCrtBd Start...");
		System.out.println("BgDaoImpl searchCrtBd board.getKeyword() -> "	+board.getKeyword());
		System.out.println("BgDaoImpl searchCrtBd board.getSearchType() -> "+board.getSearchType());
		System.out.println("BgDaoImpl searchCrtBd board.getSortBy() -> "	+board.getSortBy());
		try {
			crtBdSearch = session.selectList("searchCrtBd", board);
			for(Board board1   : crtBdSearch) {
				System.out.println("BgDaoImpl searchCrtBd board1->"+board1);
			}
		} catch (Exception e) {
			System.out.println("BgDaoImpl searchCrtBd Exception -> "+e.getMessage());
		}
		return crtBdSearch;
	}


	


	



}
