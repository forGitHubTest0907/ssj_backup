package com.oracle.S202350102.controller;

import java.io.IOException;
import java.net.http.HttpHeaders;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONArray;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.yaService.YaCommunityService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class YaController {
	
	private final YaCommunityService ycs;
	
	//커뮤니티 게시글 전체조회
	@RequestMapping(value="/listCommunity")
	public String listCommunity(Board board, Model model) {
		System.out.println("YaController listCommunity start....");
		List<Board> listCommunity = ycs.listCommunity(board);
		System.out.println("YaController list listCommunity.size()?"+listCommunity.size());
		
		model.addAttribute("listCommunity", listCommunity);
		
		return "listCommunity";
	}
	
	
	//게시글 제목을 누르면 자세히 보기 
	@GetMapping(value="detailCommunity")
	public String detailCommunity(int brd_num, Model model, HttpSession session) {
		System.out.println("YaController Start detailCommunity start...");
		
	    // 게시글 상세 정보 확인
		Board board = ycs.detailCommunity(brd_num);
		
		//로그인 상태 확인 
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
		
	
		//조회수 증가
		int upViewCnt = 0;
		ycs.upViewCnt(brd_num);
			
		model.addAttribute("board", board);
		model.addAttribute("upViewCnt", upViewCnt);	
	    model.addAttribute("loggedIn", user_num!= 0);
			
	    System.out.println("nick: " + board.getNick());
	    System.out.println("userName:"+board.getUser_name());
	    System.out.println("user_num:"+board.getUser_num());
	    System.out.println("user_id:"+board.getUser_id());
	    System.out.println("sessionScope.usernum: " + session.getAttribute("user_num"));
	
		return"ya/detailCommunity";
	}
	
	// 커뮤니티 게시글 작성폼으로 이동
		@RequestMapping(value="/writeFormCommunity")
		public String writeFormCommunity(HttpSession session, Model model ) {
			System.out.println("YaController writeFormCommunity Start... ");
		
			if(session.getAttribute("user_num") != null) {
				
				return "ya/writeFormCommunity"; 
			}
			System.out.println("user_num?"+ session.getAttribute("user_num"));
				return "redirect:/loginForm";
				
			}

	 // 게시글 작성
	
		@PostMapping(value="/writeCommunity") 
		public String insertCommunity(@ModelAttribute Board board, HttpSession session,  Model model) {
			System.out.println("YaController start insertCommunity... "); 
			
			int user_num = 0;
			if (session.getAttribute("user_num") != null) {
				user_num = (int) session.getAttribute("user_num");
			}
			board.setUser_num(user_num);
	
			int insertResult = ycs.insertCommunity(board);
			board.setUser_num(user_num);
			
			System.out.println("brd_lg :"+board.getBrd_lg());
			System.out.println("brd_md :"+board.getBrd_md());

			if (insertResult >0) 
				return "redirect:listCommunity";			
				else {
					 model.addAttribute("msg", "작성 실패, 확인해보세요");
				 }
			return "forward:writeCommunity";
		 }
		
		
		// 게시글 수정폼이동
		@GetMapping(value="/updateCommunityForm")
		public String updateCommunity(int brd_num, Model model) {
			System.out.println("YaController updaetCommunityForm start...");
			
			Board board = ycs.detailCommunity(brd_num);
			// 정전
			System.out.println("title :"+board.getTitle());
			System.out.println("conts :"+board.getConts());
			
			model.addAttribute("board", board);
			
			return "ya/updateCommunityForm";
		}
		
		
		// 게시글 수정
		@GetMapping(value="/updateCommunity")
		public String updateCommunity(Board board, Model model) {
	
			
			int updateCommunity = ycs.updateCommunity(board);
			
			System.out.println("YaController ycs.updateCommunity updateBoard updateCommunity?"+updateCommunity);
			model.addAttribute("updateCommunity", updateCommunity);
			//수정후
			System.out.println("title update:"+board.getTitle());
			System.out.println("conts update:"+board.getConts());
			
			return "forward:listCommunity";
		}
		
		//게시글 삭제
		@GetMapping(value="/deleteCommunity")
		public String deleteCommuinty(int brd_num, Model model) {
			
			int deleteResult = ycs.deleteCommunity(brd_num);
			System.out.println("YaController ycs.deleteCommunity start....");
		
			return "redirect:listCommunity";
			
		}
		
		//자유게시판 게시글조건(이름,제목)검색 -> 객체로 변경해야 json 형식으로 데이터 반환 가능
		@GetMapping(value="/listBoardSearch", produces = "application/json")
		@ResponseBody
		public List<Board> listBoardSearch(HttpServletRequest request) {
			System.out.println("YaController ycs.listSearchBoardart....");
			String keyword = request.getParameter("keyword");
		    System.out.println("사용자 검색한 키워드: " + keyword);
		   
		    List<Board> listSearchBoard = ycs.listSearchBoard(keyword);
		    System.out.println("YaController listSearchBoard.size?" + listSearchBoard.size());

		    return listSearchBoard;
		}
		
		@GetMapping("/listBoardSort")
		@ResponseBody
		public  List<Board> listBoardSort(HttpServletRequest request ) {
			System.out.println("YaController ycs.listBoardSort start....");
			String sort = request.getParameter("sort");
			List<Board> listSortedBoard = ycs.listBoardSort(sort);
		
		    return listSortedBoard;
		}
		
		//상세 게시글 댓글  조회
		@RequestMapping(value="/listComment", method=RequestMethod.GET)
		@ResponseBody
		public List<Board> listComment(@RequestParam("brd_num") int brd_num) {
			System.out.println("YaController ycs.listComment start....");
			
			//부모글(본글)의 brd_num을 사용하여 댓글조회  부모글 brd_num = 댓글 brd_group = 부모글 brd_group
			
			List<Board> listComment = ycs.listComment(brd_num);
			System.out.println("YaController listComment size?" + listComment.size());
	
			return listComment; 
		}
		
		//게시글 답글 작성
		@RequestMapping("/commentWrite")
		@ResponseBody
		public Map<String, String> commentWrite(HttpSession session, HttpServletRequest request, @ModelAttribute Board board) {
		    Map<String, String> response = new HashMap<>();

		    try {
		        System.out.println("YaController ycs.commentWrite start....");

		        int user_num = 0;
		        if (session.getAttribute("user_num") != null) {
		            user_num = (int) session.getAttribute("user_num");
		            board.setUser_num(user_num);
		              try {
		    	            int brd_num = Integer.parseInt(request.getParameter("brd_num"));
				            board.setBrd_num(brd_num);
		                } catch (NumberFormatException e) {
		                    // 숫자로 변환할 수 없는 경우에 대한 예외 처리
		                    response.put("result", "failure");
		                    response.put("error", "Invalid brd_num format");
		                    return response;
		                }
		            
		            ycs.commentWrite(board);
		            // 값이 담기는지 확인
		            System.out.println("board user_num?" + board.getUser_num());
		            System.out.println("board conts?" + board.getConts());
		            System.out.println("board brd_num?" + board.getBrd_num());

		            // 성공한 경우, 상세 페이지로 리다이렉트
		            response.put("result", "success");
		            response.put("redirectUrl", "/ya/detailCommunity?brd_num=" + board.getBrd_num());
		        } else {
		            // 사용자가 로그인되지 않은 경우
		            response.put("result", "failure");
		            response.put("error", "User not logged in");
		        }

		    } catch (Exception e) {
		        e.printStackTrace();
		        // 실패한 경우
		        response.put("result", "failure");
		        response.put("error", "An error occurred");
		    }

		    return response;
		}
		// 게시글 댓글 수정 전 값 불러오기
		@GetMapping(value="/commentSelect")
		public String commentSelect(int brd_num, Model model) {
			System.out.println("YaController commentSelect start...");
			
			Board board = ycs.commentSelect(brd_num);	
			model.addAttribute("Board", board);
			System.out.println("board 댓글 수정 전 conts?"+board.getConts());
			return "/ya/detailCommunity";
			
		}	
		// 게시글 수정
		@PostMapping(value="/commentUpdate")
		public Map<String, Object> commentUpdate(@RequestParam("brd_num")int brd_num, @RequestParam("conts") String conts){
			Map<String, Object> map = new HashMap<String, Object>();
			try {
				Board board = new Board();
				board.setBrd_num(brd_num);
				board.setConts(conts);
				ycs.commentUpdate(board);
				
				System.out.println("board 댓글 수정후 conts?"+board.getConts());
				
				map.put("result", "success");
				
			} catch (Exception e) {
				System.out.println("YaController commentUpdate e.getmessage?"+e.getMessage());
				map.put("result", "fail");
				map.put("error", "An error occurred");
			}
			return map;
		}
	
		
		
		
}		