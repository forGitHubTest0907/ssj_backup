<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

	<div class="col-12 col-md-2">

            <!-- Filters -->
            <form class="mb-10 mb-md-0">
              <ul class="nav nav-vertical" id="filterNav">
                <li class="nav-item">

                  <!-- Toggle -->
                  <a class="nav-link dropdown-toggle fs-lg text-reset border-bottom mb-6"   href="/listUserAdmin" id="listUserDropDown">
                    	회원 관리
                  </a>

    		    </li>
    
                <li class="nav-item">

                  <!-- Toggle -->
                  <a class="nav-link dropdown-toggle fs-lg text-reset border-bottom mb-6" data-bs-toggle="collapse" href="#challengeAdmin" id="listChgDropDown">
                    	챌린지 관리
                  </a>

                  <!-- Collapse -->
                  <div class="collapse" id="challengeAdmin">
                    <div class="form-group">
                      <ul class="list-styled mb-0" id="listChg">
                        <li class="list-styled-item">
                          <a class="list-styled-link" data-bs-target="#challengeAdmin" href="/chgAdminList?chg_lg=200&state_lg=300&state_md=100">
                            	신청 챌린지
                          </a>
                        </li>
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="/chgAdminList?state_lg=300&state_md=102">
                            	진행중 챌린지
                          </a>
                        </li>
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="/chgAdminList?state_md=103">
                            	종료된 챌린지
                          </a>
                        </li>
                      </ul>
                    </div>
    			  </div>
    			  
    			</li>
    
                <li class="nav-item">

                  <!-- Toggle -->
                  <a class="nav-link dropdown-toggle fs-lg text-reset border-bottom mb-6" data-bs-toggle="collapse" href="/listShrAdmin" id="listShrDropDown">
                    	쉐어링 관리
                  </a>

                  <!-- Collapse -->
                  <div class="collapse" id="sharingAdmin">
                    <div class="form-group">
                      <ul class="list-styled mb-0" id="listShr">
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="/thChgList?state_md=102">
                            	전체
                          </a>
                        </li>
                      </ul>
                    </div>
    			  </div>
    			  
    			</li>
    			
                <li class="nav-item">

                  <!-- Toggle -->
                  <a class="nav-link dropdown-toggle fs-lg text-reset border-bottom mb-6" data-bs-toggle="collapse" href="/listFrBoardAdmin" id="listFrBoardDropDown">
                    	자유게시판 관리
                  </a>

                  <!-- Collapse -->
                  <div class="collapse" id="freBoardAdmin">
                    <div class="form-group">
                      <ul class="list-styled mb-0" id="listFreBoard">
                        <li class="list-styled-item">
                          <a class="list-styled-link" href="#">
                            	전체
                          </a>
                        </li>
                      </ul>
                    </div>
    			  </div>
    			  
    			</li>
			</ul>
		</form>
	</div>
          
</body>
</html>