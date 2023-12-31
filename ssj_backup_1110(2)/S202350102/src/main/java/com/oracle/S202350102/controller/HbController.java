package com.oracle.S202350102.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.buf.UDecoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Level1;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.dto.UserLevel;
import com.oracle.S202350102.service.hbService.Paging;
import com.oracle.S202350102.service.hbService.QBoardService;
import com.oracle.S202350102.service.main.Level1Service;
import com.oracle.S202350102.service.main.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import oracle.net.aso.l;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HbController {
	private final QBoardService qbs;
	private final UserService   us;
	private final Level1Service ls;
	
	// 문의게시판 리스트
	@RequestMapping("qBoardList")
	public String qBoardList(Board board, 
							 Model model,
							 String currentPage,
							 HttpSession session) {
		
		// 유저 세션 불러오기
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			// 전체 게시글 수
			int total = qbs.totalQBoard();
			
			// Paging 작업
			Paging page = new Paging(total, currentPage);
			
			board.setStart(page.getStart());
			board.setEnd(page.getEnd());
			
			// 보드 리스트 불러오기
			List<Board> qBoardList = qbs.qBoardList(board);
			
			user_num = (int) session.getAttribute("user_num");
			
			// 유저 정보 불러오기
			User1 user1 = us.userSelect(user_num);
			
			// 게시판 유저 정보 BoardList에 저장하기
			qBoardList = us.boardWriterLevelInfo(qBoardList);
			
			model.addAttribute("total", total);
			model.addAttribute("page", page);		
			model.addAttribute("user1", user1);
			model.addAttribute("qBoardList", qBoardList);
			
			return "hb/qBoardList";
		}
		return "redirect:/loginForm";

	}
	
	// 문의 게시판 상세보기
	@RequestMapping("qBoardDetail")
	public String qBoardDetail(@RequestParam("brd_num") int brd_num, Model model, HttpSession session) {
		System.out.println("qBoardDetail controller start..");
		qbs.readCnt(brd_num);
		Board board = qbs.qBoardSelect(brd_num);
		
		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
		
		User1 user1 = us.userSelect(user_num);
		
		model.addAttribute("user1", user1);
		model.addAttribute("board", board);
		
		return "hb/qBoardDetail";
	}
	
	// 문의게시판 수정화면
	@RequestMapping("qBoardUpdateForm")
	public String qBoardUpdateForm(@RequestParam("brd_num") int brd_num, Model model, HttpSession session) {
		System.out.println("qBoardUpdateForm contoller start...");
		
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			User1 user1 = us.userSelect(user_num);
			System.out.println("brd_num->"+brd_num);
			Board board = qbs.qBoardSelect(brd_num);
			if (user_num == board.getUser_num() || user1.getStatus_md() == 102) {
				System.out.println("board->"+board);
				model.addAttribute("board", board);
				return "hb/qBoardUpdate";
			}
			return "잘못된 접근";
		}
		return "잘못된 접근";
	}
	
	// 문의게시판 수정로직
	@RequestMapping("qBoardUpdate")
	public String qBoardUpdate(Board board, HttpServletRequest request) {
		System.out.println("qBoardUpdate contoller start...");
		int result = 0;
		result = qbs.qBoardUpdate(board);
		
		request.setAttribute("brd_num", board.getBrd_num());
		
		return "forward:qBoardDetail";
	}
	
	// 글작성 페이지
	@RequestMapping("qBoardWriteForm")
	public String qBoardInsertForm(Model model, HttpSession session) {
		
		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			
			User1 user1 = us.userSelect(user_num);
			model.addAttribute("user1", user1);
			return "hb/qBoardWrite";
		}
		return "잘못된접근";
	}
	
	// 글작성 로직
	@RequestMapping("qBoardWrite")
	public String qBoardInsert(Board board, Model model, HttpSession session, HttpServletRequest request) {	
		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			ls.userExp(user_num, board.getBrd_lg(), board.getBrd_md());
			ls.userLevelCheck(user_num);
			
		}
		board.setUser_num(user_num);
		int result = qbs.qBoardInsert(board);
		User1 user1 = us.userSelect(user_num);
		board.setNick(user1.getNick());
		request.setAttribute("board", board);
		System.out.println("user exp ->" + user1.getUser_exp());
		
		return "redirect:qBoardList";
	}
	
	// 글삭제
	@RequestMapping("qBoardDelete")
	public String qBoardDelete(int brd_num, Model model, HttpSession session) {
		int user_num = 0;
		if (session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
		int result = qbs.qBoardDelete(brd_num);
		
		model.addAttribute("result",result);
		
		return "forward:qBoardList";
	}
	
	// 레벨 리스트
	@RequestMapping("level")
	public String levelView(Model model) {
		
		List<Level1> level1List = ls.level1List();
		
		model.addAttribute("level1List", level1List);
		
		return "hb/level";
	}
	
	// 문의게시판 검색 비동기통신
	@ResponseBody
	@RequestMapping(value = "qboardListSearch", method = RequestMethod.GET)
	public List<Board> qboardListSearch(@RequestParam(value = "keyword") String keyword){
		
		return qbs.qboardListSearch(keyword);
	}
	
	
	
}