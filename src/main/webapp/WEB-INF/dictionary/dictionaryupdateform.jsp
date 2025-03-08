<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동물백과 수정</title>
	<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Gaegu&family=Jua&family=Nanum+Pen+Script&family=Playwrite+AU+SA:wght@100..400&family=Single+Day&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style type="text/css">
    	body *{
            font-family: 'Jua';
        }
        .dictionupdate{
        	margin: 30px auto;
        }
    </style>
</head>
<body>
<jsp:include page="../../layout/title.jsp"/>
<div style="width: 500px;" class="dictionupdate">
    <form action="./dictionaryupdate" method="post">

        <!-- hidden -->
        <input type="hidden" name="idx" value="${dto.idx}">

        <table class="tabform table table-bordered">
            <caption align="top">
                <h5>동물백과 수정</h5>
            </caption>
            <tbody>
            <tr>
                <th width="150">제 목 </th>
                <td>
                    <input type="text" name="subject" class="form-control"
                           required="required" autofocus="autofocus" value="${dto.subject }">
                </td>
            </tr>
            <tr>
                <th width="150">내 용 </th>
                <td>
						<textarea name="content" class="form-control"
                                  required="required" style="width: 100%;height:150px;">${dto.content }</textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button type="submit" class="btn btn-outline-success"
                            style="width: 100px;">글수정</button>

                    <button type="button" class="btn btn-outline-success"
                            style="width: 100px;" onclick="location.href='./dictionview?idx=${dto.idx}'">이전으로</button>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>	
</body>
</html>