package com.oracle.S202350102.controller;



import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.multipart.MultipartFile;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.jkService.JkBoardService;
import com.oracle.S202350102.service.jkService.JkUserService;
import com.oracle.S202350102.service.yaService.YaCommunityService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class JkController {
	private static final Logger logger = LoggerFactory.getLogger(JkController.class);
	private final JkUserService jus;
	private final JkBoardService jbs;
	private final YaCommunityService ycs;
	
	//좋아요 기능 컨트롤러
	//좋아요 상태 가져오는 메소드
	@GetMapping("/board/{brd_num}/like")
	public ResponseEntity<String> getLikeStatus(@PathVariable int brd_num) {
		System.out.println("JkController getlikestatus start...");
	   
	    return new ResponseEntity<>("Like status of Board with brd_num " + brd_num, HttpStatus.OK);
	}

	@PostMapping("/board/{brd_num}/like")
	public ResponseEntity<String> updateLikeStatus(@PathVariable int brd_num) {
		System.out.println("JkController updateLikeStatus start..." + brd_num);
		
		jbs.updateLikeStatus(brd_num);
	    return new ResponseEntity<>("Updated like status of Board with brd_num " + brd_num, HttpStatus.OK);
	}

	//쉐어링 게시글 유저 정보조회
	@RequestMapping(value="/sharingUserDetail")
	public String sharingUserDetail(Board board, Model model, HttpSession session) {
		System.out.println("JkController sharingUserDetail start...");
		List<Board> sharing = jbs.sharing(board);
		System.out.println("JkController list Sharing.size()?"+sharing.size());
		
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
		
		User1 user1 = jbs.userSelect(user_num);
		
		model.addAttribute("user1", user1);
		model.addAttribute("Sharing", sharing);
		
		return "jk/writeFormSharing";
		}
	
	
	//쉐어링 게시글 전체조회
	@RequestMapping(value="/sharing")
	public String Sharing(Board board, Model model, HttpSession session) {
		System.out.println("JkController Sharing start...");
		List<Board> sharing = jbs.sharing(board);
		System.out.println("JkController list Sharing.size()?"+sharing.size());
		
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
		
		User1 user1 = jbs.userSelect(user_num);
		
		model.addAttribute("user1", user1);
		model.addAttribute("sharing", sharing);
		
		return "sharing";
		}
	
	//쉐어링 게시글 상세조회
	@GetMapping(value="/detailSharing")
	public String detailSharing(int brd_num, Model model, HttpSession session) {
		System.out.println("JkController detailSharing Start...");
		System.out.println("brd_num->"+brd_num);
		
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
		
		Board board = jbs.detailSharing(brd_num);
		
		int upViewCnt = 0;
		ycs.upViewCnt(brd_num);
			
		model.addAttribute("board", board);
		model.addAttribute("upbiewCnt", upViewCnt);
		model.addAttribute("loggedIn", user_num!=0);
		
		System.out.println("nick: " + board.getNick());
	    System.out.println("userName:"+board.getUser_name());
	    System.out.println("user_num:"+board.getUser_num());
	    System.out.println("user_id:"+board.getUser_id());
	    System.out.println("sessionScope.usernum: " + session.getAttribute("user_num"));
	
		return"jk/detailSharing";
				
	}
	
	
	@PostMapping("/sharingUpload")
	public ResponseEntity<String> handleImageUpload(@RequestParam("file") MultipartFile file) {
		logger.info("handleImageUpload method is called.");
		System.out.println("upload start...");
	    if (file.isEmpty()) {
	        return new ResponseEntity<>("이미지를 선택해주세요", HttpStatus.BAD_REQUEST);
	    }

	    try {
	        String uploadRootDir = System.getProperty("user.dir") + "/src/main/resources/static/images/b_upload";
	        System.out.println("Upload Root Directory: " + uploadRootDir);

	        // 파일 이름 생성
	        Path filePath = Paths.get(uploadRootDir, file.getOriginalFilename());
	        System.out.println("File Path: " + filePath);

	        // 이미지 업로드 처리
	        if (!Files.exists(filePath)) {
	            try (InputStream inputStream = file.getInputStream()) {
	                Files.copy(inputStream, filePath);
	                String imageURL = "b_upload/" + file.getOriginalFilename();
	                System.out.println("Image URL: " + imageURL);
	                return new ResponseEntity<>(imageURL, HttpStatus.OK);
	            }
	        } else {
	            return new ResponseEntity<>("동일한 이름의 파일이 이미 존재합니다", HttpStatus.CONFLICT);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return new ResponseEntity<>("이미지 업로드 실패: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

	@PostMapping("/writeShare")
	public String writeShare(@RequestParam("file") MultipartFile file, Board board) {
		logger.info("writeShare method is called.");
		System.out.println("writeshare start..");
	    ResponseEntity<String> imageResponse = handleImageUpload(file);

	    if (imageResponse.getStatusCode().is2xxSuccessful()) {
	        String imageURL = imageResponse.getBody(); // 이미지 업로드 후 반환된 URL 사용
	        System.out.println("Image URL: " + imageURL); // Add this line for logging
	        board.setImg(imageURL);
	    } else {
	        // 이미지 업로드 실패 시의 처리
	    }


	    jbs.writeFormSharing(board);

	    return "jk/writeFormSharing"; // 이미지가 성공적으로 업로드되었을 때의 뷰 페이지
	}

	
	
	@RequestMapping(value="/challengeManagement")
	public String challengeManagement(Integer user_num, Model model ) {
		System.out.println("JkController challengeManagement Start... ");
		
		return "jk/challengeManagement";	
	}
	
	// 회원정보 조회
	@GetMapping("/userDetail")
	public String userUpdate(Model model, HttpSession session) {
	    System.out.println("JkController userDetail start...");

	    int user_num = 0;
	    if (session.getAttribute("user_num") != null) {
	        user_num = (int) session.getAttribute("user_num");
	    }

	    if (user_num != 0) {
	        User1 user1 = jbs.userSelect(user_num);
	        model.addAttribute("user1", user1);
	        return "jk/userUpdate";
	    } else {
	        return "redirect:/loginForm";
	    }
	}

	// 회원정보 수정
	 @PostMapping("/updateUser1")
	 public String updateUser(User1 user1, Model model) {
		 System.out.println("JkController updateUser start...");

	     int updateResult = jus.updateUser1(user1);
	     model.addAttribute("updateResult", updateResult);
	     if (updateResult > 0) {
	         return "forward:/jk/updateResult.jsp"; // 업데이트 성공 시의 뷰 페이지로 이동
	     } else {
	         model.addAttribute("msg", "수정 실패 확인해 보세요");
	         return "forward:/jk/mypage.jsp"; // 업데이트 실패 시의 뷰 페이지로 이동
	     }
	 }
	@RequestMapping("/mySharing")
	public String mySharing(Board board, Model model, HttpSession session) {
		System.out.println("JkController mySharing start...");
		
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
		
		List<Board> mySharing = jbs.mySharing(board);
		System.out.println("JkController list mySharing.size()?" + mySharing.size());
		
	
		User1 user1 = jbs.userSelect(user_num);
		System.out.println("usernum"+user_num);
		model.addAttribute("user1", user1);
		model.addAttribute("mySharing", mySharing);
		
			return "jk/mySharing";
		}
	
	@RequestMapping("/followManagement")
	public String challengeManagement() {
		System.out.println("JkController followManagement start...");
		
		return "jk/followManagement";
	}
	
	@RequestMapping("/sharingManagement")
	public String sharingManagement() {
		System.out.println("JkController sharingManagement start...");
		
		return "jk/sharingManagement";
	}
	
	@RequestMapping("/subscriptionManagement")
	public String subscriptionManagementManagement() {
		System.out.println("JkController subscriptionManagement start...");
		
		return "jk/subscriptionManagement";
	}
	
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
	    System.out.println("JkController mypage start...");

	    System.out.println("session.getAttribute(\"user_num\") --> " + session.getAttribute("user_num"));
	    int user_num = 0;
	    if (session.getAttribute("user_num") != null) {
	        user_num = (int) session.getAttribute("user_num");
	    }

	    return user_num != 0 ? "mypage" : "redirect:/loginForm";
	}

	
}   
	