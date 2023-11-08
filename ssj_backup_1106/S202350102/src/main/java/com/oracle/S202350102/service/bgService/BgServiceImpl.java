package com.oracle.S202350102.service.bgService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.bgDao.BgDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BgServiceImpl implements BgService {
	
	public final BgDao	bd;
	
	@Override
	public Challenge bgChgDetail(int chg_id) {
		System.out.println("BgServiceImpl bgChgDetail Start...");
		System.out.println("BgServiceImpl bgChgDetail chg_id"+chg_id);
		Challenge chg = bd.bgChgDetail(chg_id);
		return chg;
	}
	
	@Override
	public int totalCert() {
		System.out.println("BgServiceImpl totalCert Start...");
		int totCertCnt = bd.totalCert();
		System.out.println("BgServiceImpl totalCert totCertCnt -> "+totCertCnt);
		return totCertCnt;
	}
	
	@Override
	public List<Board> certBoard(Board board) {
		List<Board> boardCert = null;
		System.out.println("BgServiceImpl certBoard Start...");
		boardCert = bd.certBoard(board);
		System.out.println("BgServiceImpl certBoard boardCert.size() -> "+boardCert.size());
		return boardCert;
	}

	@Override
	// Ajax용
	public List<Board> boardCert(Board board) {
		
		List<Board> certBoard = null;
		System.out.println("BgServiceImpl boardCert Start...");
		certBoard = bd.boardCert(board);
		System.out.println("BgServiceImpl certBoard.size() -> "+certBoard.size());
		return certBoard;
	}

	
	
	@Override
	public int insertCertBrd(Board board) {
		
		int result = bd.insertCertBrd(board);
		System.out.println("BgServiceImpl insert Start...");
		
		return result;
	}





}
