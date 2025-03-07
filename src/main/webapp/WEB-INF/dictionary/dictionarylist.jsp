<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Gaegu&family=Jua&family=Nanum+Pen+Script&family=Playwrite+AU+SA:wght@100..400&family=Single+Day&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style type="text/css">
    	body *{
            font-family: 'Jua';
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
<jsp:include page="../../layout/title.jsp"/>
<h5>
        총 ${totalCount} 개
		<c:if test="${sessionScope.loginstatus!=null and sessionScope.loginid=='admin' }">
        	<button type="button" class="btn btn-sm btn-success"
                style="float: right;" onclick="location.href='./dictionarywriteform'">등록</button>
        </c:if>
</h5>

<table class="tabdictionary table table-bordered">
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
                            ${no}
                        <c:set var="no" value="${no-1}"/>
                    </td>
                    <td align="center">${dto.writer}</td>
                    <td>
                        <!-- 제목 -->
                        <a href="./petview?idx=${dto.idx}&pageNum=${pageNum}"
                           style="color: black; text-decoration:none;">
                                ${dto.subject}
                        </a>
                    </td>
                    <td align="center">${dto.readcount}</td>
                </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>

</body>
</html>