<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
 <title>Main</title>
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Gaegu&family=Jua&family=Nanum+Pen+Script&family=Playwrite+AU+SA:wght@100..400&family=Single+Day&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style type="text/css">
        body *{
            font-family: 'Jua';
            margin: 20px auto;
        }
        .mainimg{
            width: 700px;
            display: flex;
            justify-content: center; /* 가로 중앙 정렬 */
            align-items: center; /* 세로 중앙 정렬 */
        }
        .maindiv{
            display: flex;
            margin-top: 30px; /* 상단 여백 추가 */
            margin-left: 15%;
            margin-right: 15%;
        }
        .maindiv img{
            width: 250px;
        }

        .maindiv>.mainone, .maindiv>.maintwo{
            width: 300px;
            border: 1px solid black;
            border-radius: 20px;
            text-align: center;
            padding: 10px;
        }
    </style>
</head>
<body>
<!-- 커뮤니티 게시판 로그인 안했을시 경고창 -->
<c:if test="${sessionScope.loginstatus==null }">
    <script type="text/javascript">
        alert("회원게시판입니다\n먼저 로그인해주세요.");
        history.back();
    </script>
</c:if>

<jsp:include page="../../layout/title.jsp"/>

<div style="margin:20px; width:700px;">
    <h5 class="alert alert-danger">
        총 ${totalCount}개의 글이 있습니다.

        <button type="button" class="btn btn-sm btn-success"
                style="float: right;" onclick="location.href='./boardpetwriteform'">등록</button>
    </h5>
    <table class="tabboard table table-bordered">
        <thead>
        <tr>
            <th >번호</th>
            <th >사진</th>
            <th >작성자</th>
            <th >제목</th>
            <th >좋아요</th>
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
            <c:forEach var="dto" items="${list}">
                <tr>
                    <td align="center">
                            ${no}/${dto.idx}
                        <c:set var="no" value="${no-1}"/>
                    </td>
                    <td>
                        <c:if test="${dto.fileName != null }">
                            <img src="${naverurl}/board_pet/${dto.fileName}" style="max-width: 50px;"  alt="사진"/>
                        </c:if>
                    </td>
                    <td align="center">${dto.writer}</td>
                    <td>
                        <!-- 제목 -->
                        <a href="./petview?idx=${dto.idx}&pageNum=${pageNum}"
                           style="color: black; text-decoration:none;">
                                ${dto.subject}
                        </a>
                    </td>
                    <td align="center">
                        <c:if test="${dto.likes == 0}">
                            <i class="bi bi-suit-heart"></i>
                        </c:if>
                        <c:if test="${dto.likes > 0}">
                            <i class="bi bi-suit-heart-fill"></i>
                        </c:if>
                            ${dto.likes}
                    </td>
                    <td align="center">${dto.readcount}</td>
                </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>

    <!--  페이징 처리 -->
    <div style="width: 700px;">
        <ul class="pagination" style="margin-left : 200px; font-size : 0.8em;">
            <c:if test="${startPage>1}">
                <li class="page-item">
                    <a class="page-link" href="./boardpetlist?pageNum=${startPage-1}">Prev</a>
                </li>
            </c:if>
            <c:forEach var="pp" begin="${startPage}" end="${endPage}">
                <c:if test="${pp==pageNum}">
                    <li class="page-item active">
                        <a class="page-link" href="./boardpetlist?pageNum=${pp}">${pp}</a>
                    </li>
                </c:if>

                <c:if test="${pp!=pageNum}">
                    <li class="page-item">
                        <a class="page-link" href="./boardpetlist?pageNum=${pp}">${pp}</a>
                    </li>
                </c:if>
            </c:forEach>
            <c:if test="${endPage<totalPage}">
                <li class="page-item">
                    <a class="page-link" href="./boardpetlist?pageNum=${endPage+1}">Next</a>
                </li>
            </c:if>
        </ul>
    </div>
</div>

<script type="text/javascript">

</script>
</body>
</html>