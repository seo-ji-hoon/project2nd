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
			margin: 20px auto;
        }
        .mlist{
        	width:650px;
    		display: flex;
    		flex-direction: column;
    		align-items: center;
    		justify-content: center;
    		margin: 0 auto;
        }
        img.small{
        	width: 30px;
        	height: 30px;
        	border: 1px solid gray;
        	margin-right: 5px;
        }
    </style>
</head>
<body>
<jsp:include page="../../layout/title.jsp"/>

<div class="mlist">
	<table class="tab1 table table-bordered">
		<thead>
			<tr>
				<th width="150">회원명</th>
				<th width="100">아이디</th>
				<th width="150">핸드폰</th>
				<th width="180">주소</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${list }">
				<tr>
					<td>
						<img src="${naverurl}/member2/${dto.mphoto}" class="small"
						onerror="this.src='${root}/noimage.png'" num="${dto.num}">
						${dto.mname}
					</td>
					<td>${dto.myid}</td>
					<td>${dto.mhp}</td>
					<td>${dto.maddr}</td>
					<td>
						<button type="button" class="btn btn-sm btn-danger"
						onclick="memdel(${dto.num})">탈퇴</button>
						<script type="text/javascript">
						function memdel(num)
						{
							let ans=confirm("해당 멤버를 탈퇴시키겠습니까?");
							if(ans){
								location.href='./delete?num='+num;
							}
						}
						</script>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        let rows = $("tbody tr"); // 모든 행 가져오기
        let rowsPerPage = 5; // 한 번에 보여줄 행 개수
        let currentIndex = 0; // 현재 인덱스

        // 처음 5개만 보이게 설정
        rows.hide().slice(0, rowsPerPage).show();

        // 더보기 버튼 추가
        $(".mlist").append('<button id="loadMore" class="btn btn-success mt-2">더보기</button>');
        
        // 더보기 버튼 클릭 이벤트
        $("#loadMore").click(function(){
            currentIndex += rowsPerPage;
            rows.slice(currentIndex, currentIndex + rowsPerPage).fadeIn();
            
            // 더 이상 보여줄 행이 없으면 버튼 숨김
            if (currentIndex + rowsPerPage >= rows.length) {
                $(this).hide();
            }
        });
    });
</script>	
</body>
</html>