package com.oracle.S202350102.dao.jkDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class JkBoardDaoImpl implements JkBoardDao {
	
	private final SqlSession session;

	@Override
	public List<Board> sharing(Board board) {
		// board 테이블 쉐어링게시판조회
		List<Board> sharing = null;
		System.out.println("JkBoardDaoImpl Sharing start...");
		try {
			sharing = session.selectList("sharing", board);
			System.out.println("JkBoardDaoImpl Sharing.size()-->"+sharing.size());
		} catch (Exception e) {
			System.out.println("JkBoardDaoImpl Sharing e.getMessage()?"+e.getMessage());
		}
		
		return sharing;
	}

	@Override
	public User1 userSelect(int user_num) {
		 return session.selectOne("userSelect", user_num);
	}

		
	@Override
	public Board getboardBybrd_num(int brd_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean getLikeStatus(int brd_num) {
	    try {
	        return session.selectOne("getLikeStatus", brd_num);
	    } catch (Exception e) {
	        System.out.println("Error while getting like status: " + e.getMessage());
	        return false;
	    }
	}

	@Override
	 public void updateLikeStatus(int brd_num) {
        System.out.println("MyBatisBoardRepository updateLikeStatus start..." + brd_num);
        session.update("updateLikeStatus", brd_num);
	}

	@Override
	public int writeFormSharing(Board board) {
	    System.out.println("JkBoardDaoImpl writeFormSharing start...");
	   
	    int insertResult=0;
	    try {
	        insertResult = session.insert("writeFormSharing", board);
	    } catch (Exception e) {
	    	System.out.println("jkBoarDaoImpl void upViewCnt e.getMessage?"+e.getMessage());
		}
	        return insertResult;
	    }

	@Override
	public Board detailSharing(int brd_num) {
		System.out.println("JkBoardDaoImpl detailSharing start...");
		Board board = new Board();
		try {
			board = session.selectOne("detailSharing", brd_num);
		} catch (Exception e) {
			System.out.println("JkBoardDaoImpl dtailSHaring e.getMessage)?"+e.getMessage());
		}
		return board;
	}

	@Override
	public List<Board> mySharing(Board board) {
	    System.out.println("JkBoardDaoImpl mySharing start...");

	    List<Board> mySharing = null;
	    try {
	        mySharing = session.selectList("mySharingList", board);
	        System.out.println("JkBoardDaoImpl Sharing.size()-->" + mySharing.size());
	    } catch (Exception e) {
	        System.out.println("JkBoardDaoImpl Sharing e.getMessage()?" + e.getMessage());
	    }

	    return mySharing;
	}

		
	

}