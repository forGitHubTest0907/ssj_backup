package com.oracle.S202350102.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import com.oracle.S202350102.service.jhService.LoginInterceptor;
import com.oracle.S202350102.service.thService.ThAdminInterceptor;

@Configuration
public class WebMvcConfiguration implements WebMvcConfigurer {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new LoginInterceptor()).addPathPatterns("/replyInsert")
													   .addPathPatterns("/reviewPost")
													   .addPathPatterns("/writeCertBrd")
													   .addPathPatterns("/commentInsert")
													   .addPathPatterns("/chgApplicationForm")												   
													   .addPathPatterns("/thkakaoPayForm")			// 태현 - 구독안내 페이지
													   .addPathPatterns("/mypage")					// 진기 - 마이페이지
													   ;
		
		registry.addInterceptor(new ThAdminInterceptor()).addPathPatterns("/detailUserByAdmin")			// 태현 - 관리자 유저 상세
														 .addPathPatterns("/updateUserFormAdmin")		// 태현 - 관리자 유저 업데이트
														 .addPathPatterns("/updateUserAdmin")			// 태현 - 관리자 유저 업데이트 처리
														 .addPathPatterns("/delUserByAdmin")			// 태현 - 관리자 유저 삭제
														 .addPathPatterns("/listUserAdmin")				// 태현 - 관리자 유저 리스트
														 .addPathPatterns("/sharAdminList")				// 진기 - 관리자 쉐어링 관리
														 .addPathPatterns("/communityAdminList")		// 연아 - 관리자 커뮤니티 관리
														 .addPathPatterns("/reportListAdmin")			// 보경 - 관리자 인증게시판 관리
														 .addPathPatterns("/chgAdminList");				// 지혜 - 관리자 챌린지 리스트 관리
		
		
	}
}
