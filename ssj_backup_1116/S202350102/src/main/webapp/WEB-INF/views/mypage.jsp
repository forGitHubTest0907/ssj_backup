<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="header4.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="./assets/css/libs.bundle.css" />
    <link rel="stylesheet" href="./assets/css/theme.bundle.css" />
    <title>Insert title here</title>
</head>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css); 
    	body{
    	font-family: 'Noto Sans KR', sans-serif;} 
			
    </style>
<style>
.profile {
  margin: 20px 0;
}

/* Profile sidebar */
.profile-sidebar {
  padding: 20px 0 10px 0;
  background: #fff;
  
}
.profile-userpic {
   text-align: center; /* 추가된 부분 */ 
}
.profile-userpic img {
  float: none;
  margin: 0 auto;
  width: 50%;
  height: 50%;
  -webkit-border-radius: 50% !important;
  -moz-border-radius: 50% !important;
  border-radius: 50% !important;

}

.profile-usertitle {
  text-align: center;
  margin-top: 20px;
}

.profile-usertitle-name {
  color: #5a7391;
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 7px;
}

.profile-usertitle-job {
  text-transform: uppercase;
  color: #5b9bd1;
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 15px;
}


/* Profile Content */
.profile-content {
  padding: 20px;
  background: #fff;
  min-height: 460px;
}




a, button, code, div, img, input, label, li, p, pre, select, span, svg, table, td, textarea, th, ul {
    -webkit-border-radius: 0!important;
    -moz-border-radius: 0!important;
    border-radius: 0!important;
}
.dashboard-stat, .portlet {
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    -ms-border-radius: 4px;
    -o-border-radius: 4px;
}
.portlet {
    margin-top: 0;
    margin-bottom: 25px;
    padding: 0;
    border-radius: 4px;
}
.portlet.bordered {
    border-left: 2px solid #e6e9ec!important;
}
.portlet.light {
    padding: 12px 20px 15px;
    background-color: #fff;
}
.portlet.light.bordered {
    border: 1px solid #e7ecf1!important;
}
.list-separated {
    margin-top: 10px;
    margin-bottom: 15px;
}
.profile-stat {
    padding-bottom: 20px;
    border-bottom: 1px solid #f0f4f7;
}
.profile-stat-title {
    color: #7f90a4;
    font-size: 25px;
    text-align: center;
}
.uppercase {
    text-transform: uppercase!important;
}

.profile-stat-text {
    color: #5b9bd1;
    font-size: 10px;
    font-weight: 600;
    text-align: center;
}
.profile-desc-title {
    color: #7f90a4;
    font-size: 17px;
    font-weight: 600;
}
.profile-desc-text {
    color: #7e8c9e;
    font-size: 14px;
}
.margin-top-20 {
    margin-top: 20px!important;
}
[class*=" fa-"]:not(.fa-stack), [class*=" glyphicon-"], [class*=" icon-"], [class^=fa-]:not(.fa-stack), [class^=glyphicon-], [class^=icon-] {
    display: inline-block;
    line-height: 14px;
    -webkit-font-smoothing: antialiased;
}
.profile-desc-link i {
    width: 22px;
    font-size: 19px;
    color: #abb6c4;
    margin-right: 5px;
}



</style>
<body>
<div class="container">
    <div class="row profile">
		<div class="col-md-3">
			<div class="profile-sidebar">
				<!-- SIDEBAR USERPIC -->
				<div class="profile-userpic">
					<img src="upload/프로필기본.png">
				</div>
				<!-- END SIDEBAR USERPIC -->
				<!-- SIDEBAR USER TITLE -->
				<div class="profile-usertitle">
					<div class="profile-usertitle-name">
						${sessionScope.user_num }
					</div>
					<div class="profile-usertitle-job">
						level 1
					</div>
				</div>
				<!-- END SIDEBAR USER TITLE -->


           <div class="portlet light bordered">
                                                <!-- STAT -->
                                                <div class="row list-separated profile-stat">
                                                    <div class="col-md-4 col-sm-4 col-xs-6">
                                                        <div class="uppercase profile-stat-title"> 37 </div>
                                                        <div class="uppercase profile-stat-text"> 팔로우 </div>
                                                    </div>
                                                    <div class="col-md-4 col-sm-4 col-xs-6">
                                                        <div class="uppercase profile-stat-title"> 51 </div>
                                                        <div class="uppercase profile-stat-text"> 팔로잉 </div>
                                                    </div>
                                                    <div class="col-md-4 col-sm-4 col-xs-6">
                                                        <div class="uppercase profile-stat-title"> 61 </div>
                                                        <div class="uppercase profile-stat-text"> 내가 쓴 글</div>
                                                    </div>
                                                </div>
                                                
                                                 <div class="col-12 col-md-16">

									            <!-- Nav -->
									          <nav class="mb-10 mb-md-0" >
									              <div class="list-group list-group-sm list-group-strong list-group-flush-x">
									               <a class="list-group-item list-group-item-action dropend-toggle " href="/challengeManagement">
									                  	활동정보
									                </a>
									                <a class="list-group-item list-group-item-action dropend-toggle " href="/challengeManagement">
									                  	챌린지 관리
									                </a>
									                <a class="list-group-item list-group-item-action dropend-toggle " href="/followList">
									                 	팔로우 관리
									                </a>
									                <a class="list-group-item list-group-item-action dropend-toggle " href="/subscriptionManagement">
									                 	구독 관리
									                </a>
									                <a class="list-group-item list-group-item-action dropend-toggle " href="/sharingManagement">
									                 	쉐어링 관리
									                </a>
									             
									               <a class="btn w-100 btn-dark mb-2" href="/userDetail" style=" margin-top: 50px;">	회원정보수정
									               </a>
									                
									              </div>
									            </nav>
									 			<!-- Nav End -->
									          </div>
                                                <!-- END STAT -->
                                               </div>                   
                                           
        
        
			</div>
		</div>
		 <!-- CATEGORIES -->

      <div class="container" style="width : 75%">
        <div class="row">
          <div class="col-12">

            <!-- Heading -->
            <h5 class="mb-4">챌린지 목록</h5>
            <!-- Nav -->
            <div class="nav justify-content-center mb-10">
              <a class="nav-link active" href="#topSellersTab" data-bs-toggle="tab">참여 챌린지</a>
              <a class="nav-link" href="#topSellersTab" data-bs-toggle="tab">신청한 챌린지</a>
              <a class="nav-link" href="#topSellersTab" data-bs-toggle="tab">최근 본 챌린지</a>
              <a class="nav-link" href="#topSellersTab" data-bs-toggle="tab">찜한 챌린지</a>
            </div>

            <!-- Content -->
            <div class="tab-content">

              <!-- Pane -->
              <div class="tab-pane fade show active" id="topSellersTab">

                <!-- Slider -->
                <div class="flickity-buttons-lg flickity-buttons-offset px-lg-12" data-flickity='{"prevNextButtons": true}'>

	
                  <!-- Item -->
               <div class="col px-4" style="max-width: 200px;">
                    <div class="card">

                      <!-- Image -->
                      <img class="card-img-top" src="assets/img/products/product-26.jpg" alt="...">

                      <!-- Body -->
                      <div class="card-body py-4 px-0 text-center">

                        <!-- Heading -->
                        <a class="stretched-link text-body" href="shop.html">
                          <h7>챌린지명 <small>(35)</small></h7>
                        </a>

                      </div>

                    </div>
                  </div>

          
                </div>
                    </div>
                  </div>
		</div>

      <div class="container"style="margin-top: 60px;">
        <div class="row">
          <div class="col-12">

            <!-- Heading -->
            <h5 class="mb-4">내가 쓴 글</h5>
            <!-- Nav -->
            <div class="nav justify-content-center mb-10">
              <a class="nav-link active" href="#board-list" data-bs-toggle="tab">나의 게시글</a>
              <a class="nav-link" href="#board-list" data-bs-toggle="tab">챌린지</a>
              <a class="nav-link" href="#board-list" data-bs-toggle="tab">커뮤니티</a>
              <a class="nav-link" href="#board-list" data-bs-toggle="tab">1:1 문의</a>
            </div>

            <!-- Content -->
               <!-- 게시판리스트  -->
                 <div class="tab-pane fade show active" id="board-list">
        <div id="board-list">
            <div class="container">
                <table id="boardtable">
                    <thead>
                        <tr>
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-nick">작성자</th>
                            <th scope="col" class="th-date">등록일</th>
                            <th scope="col" class="th-view_cnt">조회수</th>
                            <th  scope="col" class="th-replyCount">댓글수</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="board" items="${myCommunity}">
                            <tr>
                                <td>${num}</td>
                                <td><a href="detailCommunity?user_num=${board.user_num}&brd_num=${board.brd_num}">${board.title}</a></td>
                                <td>${board.nick}</td>
                                <td><fmt:formatDate value="${board.reg_date}" pattern="yy-MM-dd"/></td>
                                <td>${board.view_cnt}</td>
				         		<td>${board.replyCount}</td>
				         		<c:set var="num" value="${num-1}"></c:set> 			       
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
            </div>
        </div>
       
       		<!-- Content -->
		</div>



            </div>
            
            

          </div>
        </div>
    
</div>
</div>
</div>



    <button type="button" class="btn btn-primary" onclick="location.href='/chgCommManagement'">챌린지 카테고리 관리</button><p>
    <button type="button" class="btn btn-primary" onclick="location.href='/myConts'">내가 쓴 글 </button><p>
</body>
<%@ include file="footer.jsp" %>
</html>
