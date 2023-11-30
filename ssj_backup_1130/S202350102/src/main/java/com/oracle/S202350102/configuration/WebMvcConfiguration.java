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
													   .addPathPatterns("/chgAdminList")
													   .addPathPatterns("/thkakaoPayForm")			// 태현 - 구독안내 페이지
													   .addPathPatterns("/mypage")					// 진기님 - 마이페이지
													   ;
		
		registry.addInterceptor(new ThAdminInterceptor()).addPathPatterns("/detailUserByAdmin")			// 태현 - 관리자 유저 상세
														 .addPathPatterns("/updateUserFormAdmin")		// 태현 - 관리자 유저 업데이트
														 .addPathPatterns("/updateUserAdmin")			// 태현 - 관리자 유저 업데이트 처리
														 .addPathPatterns("/delUserByAdmin")			// 태현 - 관리자 유저 삭제
														 .addPathPatterns("/listUserAdmin")
														 .addPathPatterns("/sharAdminList");			// 연아님 - 커뮤니티관리
	}
}
