package com.oracle.S202350102.service.jkService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.jkDao.JkBoardDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JkBoardServiceImpl implements JkBoardService {

	private final JkBoardDao jbd;

	
	@Override
	public List<Board> Sharing(Board board) {
		List<Board> Sharing = null;
		System.out.println("JkCommunityServiceImpl start...");
		Sharing = jbd.Sharing(board);
		System.out.println("JkCommunityServiceImpl Sharing.size()-->"+Sharing.size());
		return Sharing ;
	}

	@Override
	public User1 userSelect(int user_num) {
		return jbd.userSelect(user_num);
	}
	
	@Override
	public Board likeService(int brd_num) {
		System.out.println("likeService start...");
		 try {
		        Board board = jbd.getboardBybrd_num(brd_num);

		        if (board != null) {
		            jbd.updateLikeStatus(brd_num); // 좋아요 증가

		            return board;
		        } else {
		            return null;
		        }
		    } catch (Exception e) {
		        System.out.println("Error while getting like status: " + e.getMessage());
		        return null;
		    }
		}

	@Override
	public void updateLikeStatus(int brd_num) {
		  System.out.println("BoardServiceImpl updateLikeStatus start..." + brd_num);
	        jbd.updateLikeStatus(brd_num);
		
	}

	@Override
	public int writeFormSharing(Board board) {
	    System.out.println("BoardServiceImpl writeFormSharing start...");

	    try {
	        int rowsInserted = jbd.writeFormSharing(board); 

	        if (rowsInserted > 0) {
	            return rowsInserted; // 삽입된 행의 수를 반환
	        } else {
	            return 0; // 삽입된 행이 없을 때 0 반환
	        }
	    } catch (Exception e) {
	        System.out.println("Error while writing the new sharing: " + e.getMessage());
	        return 0; // 에러 발생 시 0 반환
	    }
	}

}