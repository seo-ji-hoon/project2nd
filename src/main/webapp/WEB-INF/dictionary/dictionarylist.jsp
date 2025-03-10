<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동물백과 목록</title>
	<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Gaegu&family=Jua&family=Nanum+Pen+Script&family=Playwrite+AU+SA:wght@100..400&family=Single+Day&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style type="text/css">
    	body *{
            font-family: 'Jua';
            margin: 20px auto;
        }
        
        .totalnbtn, #tabdictionary {
        	width: 600px;
        	margin: 30px auto;
        }
    </style>
</head>
<body>
<jsp:include page="../../layout/title.jsp"/>

<div class="totalnbtn">
        총 ${totalCount} 개
		<c:if test="${sessionScope.loginstatus!=null and sessionScope.loginid=='admin' }">
        	<button type="button" class="btn btn-sm btn-success"
                style="float: right;" onclick="location.href='./dictionarywriteform'">등록</button>
        </c:if>
</div>

<table class="table table-bordered" id="tabdictionary">
        <thead>
        <tr>
            <th >번호</th>
            <th >작성자</th>
            <th >제목</th>
            <th>조회수</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${totalCount==0}">
            <tr>
                <td colspan="6" align="center">
                    등록된 글이 없습니다
                </td>
            </tr>
        </c:if>

        <c:if test="${totalCount>0}">
            <c:forEach var="dto" items="${list}" varStatus="i">
                <tr>
                    <td align="center">
                            ${i.count}
                    </td>
                    <td align="center">${dto.writer}</td>
                    <td>
                        <!-- 제목 -->
                        <a href="./dictionview?idx=${dto.idx}"
                           style="color: black; text-decoration:none;">
                                ${dto.subject}
                           <!-- 댓글 수 노출 -->
							<c:if test="${dto.replecount>0}">
				   				<span class="badge bg-success">${dto.replecount}</span>
				   			</c:if>
                        </a>
                    </td>
                    <td align="center">${dto.readcount}</td>
                </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
    
<div class="text-center">
    <button id="loadMore" class="btn btn-success" style="display:none;">더보기</button>
	<button id="showLess" class="btn btn-danger mt-2" style="display:none;">접기</button>
</div>
</div>
    
<script type="text/javascript">
$(document).ready(function(){
    function setupLoadMore(tableSelector) {
        let rows = $(tableSelector + " tbody tr"); // 모든 행 가져오기
        let rowsPerPage = 5; // 한 번에 표시할 행 개수
        let currentIndex = 5; // 처음 5개는 보이도록 설정

        rows.hide().slice(0, rowsPerPage).show(); // 처음 5개만 보이게 설정

        // 버튼 상태 초기화
        $("#loadMore").hide();
        $("#showLess").hide();

        if (rows.length > rowsPerPage) {
            $("#loadMore").show();
        }

        $("#loadMore").off("click").on("click", function(){
            rows.slice(currentIndex, currentIndex + rowsPerPage).fadeIn();
            currentIndex += rowsPerPage;

            if (currentIndex >= rows.length) {
                $(this).hide();
                $("#showLess").show();
            }
        });

        $("#showLess").off("click").on("click", function(){
            rows.hide().slice(0, rowsPerPage).show();
            currentIndex = rowsPerPage;
            $(this).hide();
            $("#loadMore").show();
        });
    }
    
    setupLoadMore("#tabdictionary");
});
</script>
</body>
</html>