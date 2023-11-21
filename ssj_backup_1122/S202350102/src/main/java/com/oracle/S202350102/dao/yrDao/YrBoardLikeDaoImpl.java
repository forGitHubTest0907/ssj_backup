package com.oracle.S202350102.dao.yrDao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.S202350102.dto.BoardLike;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class YrBoardLikeDaoImpl implements YrBoardLikeDao {
	private final PlatformTransactionManager transactionmanager;
	private final SqlSession session;
	
	@Override
	public int selectBrdLikeYN(BoardLike brdLike) {
		int result = 0;
		try {
			result = session.selectOne("yrSelectBrdLikeYN", brdLike);
		} catch (Exception e) {
			System.out.println(e.getMessage());			
		}
		return result;
	}

	@Override
	public int deleteBrdLike(BoardLike brdLike) {
		
		TransactionStatus txStatus = transactionmanager.getTransaction(new DefaultTransactionDefinition());
		int result = 0;
		
		try {
			result = session.delete("yrDeleteBrdLike", brdLike);
			result = session.update("yrUpdateBrdLikeCtn", brdLike.getBrd_num());
			transactionmanager.commit(txStatus);
		} catch (Exception e) {
			transactionmanager.rollback(txStatus);
			System.out.println(e.getMessage());
			result = -1;
		}
		return result;
	}

	@Override
	public int insertBrdLike(BoardLike brdLike) {

		TransactionStatus txStatus = transactionmanager.getTransaction(new DefaultTransactionDefinition());
		int result = 0;
		
		try {
			result = session.insert("yrInsertBrdLike", brdLike);
			result = session.update("yrUpdateBrdLikeCtn", brdLike.getBrd_num());
			transactionmanager.commit(txStatus);
		} catch (Exception e) {
			transactionmanager.rollback(txStatus);
			System.out.println(e.getMessage());
			result = -1;
		}
		
		return result;
	}

}
