<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>boardpetdetail</title>
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Gaegu&family=Jua&family=Nanum+Pen+Script&family=Playwrite+AU+SA:wght@100..400&family=Single+Day&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">


    <style>
        body * {
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

        .profilePhoto{
            width: 40px;
            height: 40px;
            border: 1px solid gray;
            margin-right: 10px;
        }

        .day {
            font-size: 13px;
            color: gray;
        }

        #photoupload{
            display: none;
        }


    </style>

</head>
<body>
<jsp:include page="../../layout/title.jsp"/>
<div style="margin: 30px;">
    <h3><b>${dto.subject }</b></h3>
    <img alt="" src="${naverurl}/member2/${memberPhoto }" class="profilePhoto" align="left"
         onerror="this.src='${root}/noimage.png'">
    <span>${dto.writer }</span><br>
    <span class="day">
			<fmt:formatDate value="${dto.writeday }" pattern="yyyy-MM-dd HH:mm"/>
			&nbsp;&nbsp;
			조회&nbsp;${dto.readcount}
		</span>
    <pre style="margin-top: 30px; font-size: 15px;">${dto.content }</pre>
    <div style="margin-top: 30px;">
        <c:forEach var="photo" items="${dto.photos }">
            <img src="${naverurl}/board_pet/${photo}" style="max-width: 300px;">
        </c:forEach>
    </div>
    <!-- 댓글목록 출력 -->
    <div class="replelist">
    </div>

    <!-- 댓글 -->
    <div style="margin-top: 20px; padding:10px; width: 600px; background-color: #eee;">
        <h5>댓글</h5>
        <textarea id="message" class="form-control" rows="2" placeholder="댓글을 입력하세요..."></textarea>
        <div style="margin-top: 10px;">
            <input type="file" id="photoupload">
            <i class="bi bi-image replephoto"></i>
        </div>

        <button type="button"  class="btn btn-primary mt-2" id="addreple">댓글저장</button>
        <c:if test="${sessionScope.loginid==dto.myid }">

            <script type="text/javascript">
                function repledel()
                {

                    //삭제할지 물어보고 확인 누르면 삭제후 목록으로 이동 (페이지 번호 전달)
                    let ans=confirm("해당 댓글을 삭제 하시겠습니까?");

                    if(ans){
                        $.ajax({
                            type:"get",
                            dataType:"text",
                            data:{"idx":${dto.idx}},
                            url:"./delete",
                            success:function(){
                                alert("삭제되었습니다.");
                                //삭제 성공후 목록으로 이동
                                location.href="./list?pageNum="+${pageNum};
                            }
                        });
                    }
                }
            </script>
        </c:if>
    </div>

    <!-- 댓글 -->

    <div style="margin-top: 30px;">
        <button type="button" class="btn btn-success btn-sm" style="width: 80px;"
                onclick="location.href='./writeform'">
            <i class="bi bi-pencil-square"></i>
            글쓰기
        </button>

        <%--<button type="button" class="btn btn-outline-secondary btn-sm" style="width: 80px;"
                onclick="location.href='./writeform?idx=${dto.idx}&regroup=${dto.regroup}&restep=${dto.restep}&relevel=${dto.relevel }&pageNum=${pageNum}'">답글</button>--%>

        <c:if test="${sessionScope.loginid==dto.myid }">
            <button type="button" class="btn btn-outline-secondary btn-sm" style="width:80px;"
                    onclick="location.href='./petupdate?idx=${dto.idx}&pageNum=${pageNum}'">수정</button>

            <button type="button" class="btn btn-outline-secondary btn-sm" style="width: 80px;"
                    onclick="boarddel()">삭제</button>
        </c:if>

        <button type="button" class="btn btn-outline-secondary btn-sm" style="width: 80px;"
                onclick="location.href='./boardpetlist?pageNum=${pageNum }'">목록</button>

    </div>
</div>
</body>
</html>