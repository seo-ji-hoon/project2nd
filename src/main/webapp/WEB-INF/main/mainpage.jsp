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
<jsp:include page="../../layout/title.jsp"/>
	<img src="./18.png" class="mainimg">
<div class="maindiv">
	<div class="mainone">
		<img src="./main1.png">
		<hr>
		<h5><b>커뮤니티</b></h5>
		<h6>회원이면 사용가능한 게시판</h6>
		<button type="button" class="btn btn-success"
		onclick="location.href='${root}/boardpet/boardpetlist'">커뮤니티</button>
	</div>
	<div class="maintwo">
		<img src="./main2.png" >
		<hr>
		<h5><b>동물백과</b></h5>
		<h6>담당자가 공유해주는 다양한 동물정보</h6>
		<button type="button" class="btn btn-success"
		onclick="location.href='${root}/dictionary/dictionarylist'">동물백과</button>
	</div>
</div>
</body>
</html>