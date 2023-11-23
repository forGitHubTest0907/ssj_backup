<%@ include file="/WEB-INF/views/header4.jsp" %>

<script type="text/javascript">
    // 찜하기 기능
	function chgPick(p_index) {

        $.ajax({
            url : "/chgPickPro",
            type : "POST",
            data : {chg_id : p_index},
            dataType : 'json',
            success : function(chgPickResult) {
                if(chgPickResult.chgPick > 0) {
                    $("#chgPick" + p_index).removeClass("btn-white-primary").addClass("btn-primary");
                } else {
                    $("#chgPick" + p_index).removeClass("btn-primary").addClass("btn-white-primary");
                }

            },
            error : function() {
                alert("찜하기 오류");
            }
        });
        }
</script>

    <!-- Slider -->
    <div class="flickity-buttons-lg flickity-buttons-offset px-lg-12" data-flickity='{"prevNextButtons": true}'>

		<c:forEach var="pickList" items="${chgPickList }">

            <div class="col px-4" style="max-width: 250px;">
                <div class="card">

                    <!-- 찜하기 있음 -->
                    <button type="button" class="btn btn-xs btn-circle btn-primary card-action card-action-end" data-toggle="button" onclick="chgPick(${pickList.chg_id})" id="chgPick${pickList.chg_id}">
                        <i class="fe fe-heart"></i>
                    </button>

                    <!-- Button -->
                    <button class="btn btn-xs w-100 btn-dark card-btn">
                        <i class="fe me-2 mb-1"></i>챌린지에 도전하세요!
                    </button>
    
                    <!-- Image -->
                    <a class="text-body" href="chgDetail?chg_id=${pickList.chg_id }">
                        <c:if test="${pickList.thumb != null}">
                            <img class="card-img-top" src="${pageContext.request.contextPath}/upload/${pickList.thumb}" alt="thumb" style="width: 100%; height: 250px; border-radius: 10px;" >
                        </c:if>
                        <c:if test="${pickList.thumb == null}">
                            <img class="card-img-top" src="assets/img/chgDfaultImg.png" alt="chgDfault" style="width: 100%; height: 250px; border-radius: 10px;">
                        </c:if>
                    </a>
    
                    <!-- Body -->
                    <div class="card-body py-4 px-0 text-start">
    
                        <a class="text-body fw-bolder fs-6" href="chgDetail?chg_id=${pickList.chg_id }">${pickList.title }</a>
                        <div> 
                            <fmt:formatDate value="${pickList.create_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
                            ~ 
                            <fmt:formatDate value="${pickList.end_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
                        </div>
    
                    </div>
    
                </div>
            </div>

		</c:forEach>
    </div>