package com.oracle.S202350102.service.thService;

import com.oracle.S202350102.dto.Order1;

public interface ThKakaoPay {

	String 			kakaoPayReady(Order1 order1);
	Object 			kakaoPayInfo(String pg_token);

}
