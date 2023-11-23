package com.oracle.S202350102.service.thService;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.oracle.S202350102.dao.thDao.ThOrder1Dao;
import com.oracle.S202350102.dto.KakaoPayApprovalVO;
import com.oracle.S202350102.dto.KakaoPayReadyVO;
import com.oracle.S202350102.dto.Order1;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ThKakaoPayImpl implements ThKakaoPay {
    
	private static final String HOST = "https://kapi.kakao.com";
    
    private KakaoPayReadyVO 	kakaoPayReadyVO;
    private KakaoPayApprovalVO	kakaoPayApprovalVO;

    
    //결제 요청및 인증
    public String kakaoPayReady(Order1 order1) {
    	System.out.println("ThKakaoPayImpl kakaoPayReady Start...");

        RestTemplate restTemplate = new RestTemplate();
 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "47b09ab850144b4a5618939d2b5cb91f");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "1001");
        params.add("item_code", "1002");
        params.add("partner_user_id", "Ssj");
        params.add("item_name", "프리미엄 구독");
        params.add("quantity", "1");
        params.add("total_amount", "5000");
        params.add("tax_free_amount", "100");
        params.add("approval_url", "https://localhost:8222/kakaoPaySuccess");
        params.add("cancel_url", "https://localhost:8222/kakaoPayCancel");
        params.add("fail_url", "https://localhost:8222/kakaoPayFail");
 
         HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
        try {
            kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
            
            log.info("" + kakaoPayReadyVO);
            System.out.println("kakaoPayReadyVO.getNext_redirect_pc_url() --> " + kakaoPayReadyVO.getNext_redirect_pc_url());
            return kakaoPayReadyVO.getNext_redirect_pc_url();
 
        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        
        return "/pay";   
    }
    
    // 결제승인후 값 가져옴
    public KakaoPayApprovalVO kakaoPayInfo(String pg_token) {
    	 
        log.info("KakaoPayInfoVO............................................");
        log.info("-----------------------------");
        
        RestTemplate restTemplate = new RestTemplate();
 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "47b09ab850144b4a5618939d2b5cb91f");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
 
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id", "1001");
        params.add("partner_user_id", "J.JSsj");
        params.add("item_code", "1002");
        params.add("pg_token", pg_token);
        params.add("total_amount", "5000");
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
            log.info("" + kakaoPayApprovalVO);
          
            return kakaoPayApprovalVO;
        
        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
}
