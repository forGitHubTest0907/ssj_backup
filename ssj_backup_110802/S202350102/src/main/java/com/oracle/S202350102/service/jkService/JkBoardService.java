package com.oracle.S202350102.service.jkService;

import java.util.List;



import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.User1;

public interface JkBoardService {
	// 쉐어링 게시글 전체
	List<Board> 	sharing(Board board);
	User1 			userSelect(int user_num);
	Board 			likeService(int brd_num);
	void 			updateLikeStatus(int brd_num);
	int 			writeFormSharing(Board board);
	Board 			detailSharing(int brd_num);
	List<Board> 	mySharing(Board board);
	
	


}
