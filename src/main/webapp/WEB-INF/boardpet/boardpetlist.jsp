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

<div class="container mt-4">
    <h5>
        총 ${totalCount}개의 글이 있습니다.
    </h5>
    <div class="d-flex justify-content-between align-items-center mb-3" style="top: 292px;
    position: absolute; right: 120px;">
        <div>
            <button type="button" class="btn btn-sm btn-success">정렬</button>
            <button type="button" class="btn btn-sm btn-success"
                style="float: right; margin-left: 10px;" onclick="location.href='./boardpetwriteform'">등록</button>
        </div>
    </div>

    <table class="tabboard table table-bordered">
        <thead class="table-light">
            <tr style="text-align: center;">
                <th style="width: 5%;">No</th>
                <th style="width: 10%;">사진</th>
                <th style="width: 15%;">작성자</th>
                <th style="width: 35%;">제목</th>
                <th style="width: 10%;">좋아요</th>
                <th style="width: 10%;">조회수</th>
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
                            ${no}
                        <c:set var="no" value="${no-1}"/>
                    </td>
                    <td style="text-align: center;">
                        <c:if test="${dto.fileName != null }">
                            <img src="${naverurl}/board_pet/${dto.fileName}" class="rounded-circle"
                                 style="width: 50px; height: 50px; object-fit: cover;"  alt="사진"/>
                        </c:if>
                    </td>
                    <td align="center">${dto.writer}</td>
                    <td>
                        <!-- 제목 -->
                        <a href="./petview?idx=${dto.idx}&pageNum=${pageNum}"
                           class="text-dark text-decoration-none fw-bold">
                                ${dto.subject}
                                    <!-- 댓글이 있는경우에만 갯수 출력 -->
                                    <c:if test="${dto.repleCounting>0 }">
                                        <span class="badge bg-success ms-1">[&nbsp;${dto.repleCounting}&nbsp;]</span>
                                    </c:if>
                        </a>
                    </td>
                    <td align="center">
                        <c:if test="${dto.likes == 0}">
                            <i class="bi bi-suit-heart"></i>
                        </c:if>
                        <c:if test="${dto.likes > 0}">
                            <i class="bi bi-suit-heart-fill text-danger"></i>
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
    <div style="width: 100px;">
        <ul class="pagination" style="margin-right : -70px; font-size : 0.8em;">
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
<%--<div class="container mt-4">
    <h5>총 ${totalCount} 개수</h5>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <button class="btn btn-outline-secondary btn-sm">정렬</button>
            <button class="btn btn-primary btn-sm">등록</button>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-hover table-striped text-center align-middle">
            <thead class="table-light">
            <tr>
                <th style="width: 5%;">No</th>
                <th style="width: 10%;">사진</th>
                <th style="width: 15%;">작성자</th>
                <th style="width: 35%;">제목</th>
                <th style="width: 10%;">좋아요</th>
                <th style="width: 10%;">조회수</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${totalCount > 0}">
                <c:forEach var="dto" items="${list}">
                    <tr>
                        <!-- 번호 -->
                        <td>${no}</td>
                        <c:set var="no" value="${no-1}"/>

                        <!-- 프로필 이미지 -->
                        <td>
                            <c:if test="${dto.fileName != null}">
                                <img src="${naverurl}/board_pet/${dto.fileName}"
                                     class="rounded-circle"
                                     style="width: 50px; height: 50px; object-fit: cover;"
                                     alt="사진"/>
                            </c:if>
                        </td>

                        <!-- 작성자 -->
                        <td>${dto.writer}</td>

                        <!-- 제목 및 댓글 수 -->
                        <td class="text-start">
                            <a href="./petview?idx=${dto.idx}&pageNum=${pageNum}"
                               class="text-dark text-decoration-none fw-bold">
                                    ${dto.subject}
                                <c:if test="${dto.repleCounting > 0}">
                                    <span class="badge bg-danger ms-1">[${dto.repleCounting}]</span>
                                </c:if>
                            </a>
                        </td>

                        <!-- 좋아요 -->
                        <td>
                            <c:choose>
                                <c:when test="${dto.likes > 0}">
                                    <i class="bi bi-suit-heart-fill text-danger"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-suit-heart"></i>
                                </c:otherwise>
                            </c:choose>
                                ${dto.likes}
                        </td>

                        <!-- 조회수 -->
                        <td>${dto.readcount}</td>
                    </tr>
                </c:forEach>
            </c:if>
            </tbody>
        </table>
    </div>

    <!-- 페이지네이션 -->
    <div class="d-flex justify-content-center mt-3">
        <nav>
            <ul class="pagination">
                <li class="page-item"><a class="page-link" href="#">«</a></li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">4</a></li>
                <li class="page-item"><a class="page-link" href="#">5</a></li>
                <li class="page-item"><a class="page-link" href="#">»</a></li>
            </ul>
        </nav>
    </div>
</div>--%>


<script type="text/javascript">

</script>
</body>
</html>