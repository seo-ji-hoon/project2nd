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


    <!-- 댓글 -->
    <script type="text/javascript">

        let file;

        $(function() { //처음 로딩시 댓글 출력
            replelist();//처음 로딩시 댓글 출력
            //카메라 아이콘 이벤트
            $(".replephoto").click(function(){
                $("#photoupload").trigger("click");
            });

            //파일 업로드 이벤트
            $("#photoupload").change(function(e){
                file=e.target.files[0];
                console.log(file);
            });

            $("#addreple").click(function(){
                let m=$("#message").val();
                if(m==''){
                    alert("댓글을 입력해주세요");
                    return;

                }

                if(file==null){
                    alert("사진을 선택해주세요");
                    return;
                }

                let form=new FormData();
                form.append("upload",file);
                form.append("message",m);
                form.append("idx",${dto.idx});
                form.append("board_idx",${dto.idx});

                $.ajax({
                    type:"post",
                    dataType:"text",
                    url:"./addreple",
                    data:form,
                    processData:false,
                    contentType:false,
                    success:function(){
                        alert("댓글이 등록되었습니다.");
                        $("#message").val("");  // 입력 필드 초기화
                        file = null;
                        $("#photoupload").val(""); // 파일 선택 초기화
                        replelist(); // 댓글 목록 새로고침
                    },
                    error: function(){
                        alert("error");
                    }

                });
            });

        });


        function replelist() {

            let sessionId = "${sessionScope.loginid}"; // 현재 로그인한 사용자 ID

            $.ajax({
                type:"get",
                dataType:"json",
                url:"./boardreplelist",
                data:{"idx":${dto.idx}},
                success:function(res){
                    let s="";

                    $.each(res,function(idx,item){
                        console.log(item);
                        s+=
                            `

                	<div class="item" style="margin-bottom:5px;" data-repleid="\${item.id}">
			            <span class="day">\${item.myid}</span>
            			<img src="${naverurl}/board_pet_reple/\${item.photo}" class="photo"
                 			data-bs-toggle="modal" data-bs-target="#myRepleModal" style="width:30px;">
            			<span class="message-text">\${item.message}</span>
			            <span class="day">\${item.writeday}</span>
			        `;

                    // 현재 로그인한 사용자와 댓글 작성자(myid)가 같을 경우에만 수정/삭제 버튼 표시
                    if (sessionId === item.myid) {
                        s += `
                        <button type="button" class="btn btn-primary mt-2 updatereple" data-id="\${item.idx}"
                            data-message="\${item.message}" data-photo="\${item.photo}">댓글수정</button>
                        <button type="button" class="btn btn-danger mt-2 boardRepledel" data-id="\${item.idx}">댓글삭제</button>
                    `;
                    }
                });

                    s+="</div>";
                    $("div.replelist").html(s);
                }
            });
        }


        $(document).on("click", ".updatereple", function () {
            let repleId = $(this).data("id");  // 댓글 ID
            let message = $(this).data("message"); // 기존 댓글 내용
            let photo = $(this).data("photo"); // 기존 사진

            console.log("댓글 ID:", repleId);
            console.log("댓글 내용:", message);
            console.log("사진 경로:", photo);

            // 기존 댓글 div 찾기
            let parentDiv = $(this).closest(".item");

            // 기존 내용을 textarea로 변경하면서 사진도 유지
            let editHtml = `
		        <div class="item">
		            <div style="display: flex; align-items: center;">
		                <img src="${naverurl}/board_pet_reple/\${photo}" class="mini edit-photo" style="width: 30px; margin-right: 5px;">
		                <button class="btn btn-danger btn-sm delete-photo">X</button>
		            </div>
		            <textarea class="form-control edit-message">\${message}</textarea>
		            <button class="btn btn-success mt-2 save-reple" data-id="\${repleId}">저장</button>
		            <button class="btn btn-secondary mt-2 cancel-reple">취소</button>
		        </div>
		    `;

            parentDiv.html(editHtml);
        });

        $(document).on("click", ".delete-photo", function () {
            $(this).siblings(".edit-photo").remove(); // 사진 삭제
            $(this).remove(); // X 버튼 삭제
        });

        $(document).on("click", ".save-reple", function () {
            let repleId = $(this).data("id");
            let newMessage = $(this).siblings(".edit-message").val(); // 수정된 댓글 내용
            let hasPhoto = $(this).siblings("div").find(".edit-photo").length > 0; // 사진이 남아있는지 확인

            var data = {
                "id": repleId,
                "message": newMessage,
                "deletePhoto": hasPhoto ? "false" : "true" // 사진이 삭제되었는지 여부
            };


            $.ajax({
                type: "post",
                url: "./updateReple",
                data: data,
                success: function (res) {
                    alert("댓글이 수정되었습니다.");
                    replelist(); // 댓글 목록 다시 로드
                }
            });
        });


        $(document).on("click", ".cancel-reple", function () {
            replelist(); // 원래 댓글 목록 다시 로드
        });



        //댓글 삭제
        $(document).on("click",".boardRepledel",function(){
            let repleId = $(this).data("id");
            let ans=confirm("해당 댓글을 삭제할까요?");
            if(!ans) return;//취소 클릭시 함수 종료

            $.ajax({
                type:"get",
                dataType:"text",
                data:{
                    "idx": repleId,
                },
                url:"./deleteBoardReple",
                success:function(){
                    //댓글 삭제후 전체 댓글 다시 출력
                    replelist();
                }
            });
        });

        //댓글의 작은사진 클릭시 원본사진 모달로 나오게 하기
        $(document).on("click","img.photo",function(){
            //현재 사진 src 얻기
            let imgSrc=$(this).attr("src");

            //모달에 넣기
            $(".modalphoto").attr("src",imgSrc);
        });

        // 클릭 시 좋아요 +1
        function likes(idx) {
            // 1. 데이터 셋팅
            var data = {
                "idx" : idx
            };

            // 2. ajax 호출 (+1) -> 하트 눌렀어요
            $.ajax({
                type: "post",
                url: "./update-like",
                data: data,
                success: function (res) {
                    alert("좋아요 눌렀어요~");
                }
            });
        }
    </script>
</head>
<body>

<jsp:include page="../../layout/title.jsp"/>
<div style="margin: 30px;">
    <h3><b>${dto.subject }</b></h3>
    <img alt="" src="${naverurl}/member2/${memberPhoto}" class="profilePhoto" align="left"
         onerror="this.src='${root}/noimage.png'">
    <span>${dto.writer }</span><br>
    <span class="day">
			<fmt:formatDate value="${dto.writeday }" pattern="yyyy-MM-dd HH:mm"/>
			&nbsp;&nbsp;
			조회&nbsp;${dto.readcount}
            <input type="button" value="♡" onClick="likes(${dto.idx})"/>
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
                            url:"./deleteBoardReple",
                            success:function(){
                                alert("삭제되었습니다.");
                                //삭제 성공후 목록으로 이동
                                location.href="./petview?pageNum="+${pageNum};
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

            <script type="text/javascript">
                function boarddel()
                {
                    //삭제할지 물어보고 확인 누르면 삭제후 목록으로 이동(페이지번호 전달)
                    let ans=confirm("해당 글을 삭제하시겠습니까?");
                    if(ans){
                        $.ajax({
                            type:"get",
                            dataType:"text",
                            data:{"idx":${dto.idx}},
                            url:"./petdelete",
                            success:function(){
                                alert("삭제되었습니다.")
                                //삭제 성공후 목록으로 이동
                                location.href="./boardpetlist?pageNum="+${pageNum};
                            },
                            error:function (){
                                console.log("실패입니다.")
                            }
                        });
                    }
                }
            </script>
        </c:if>

        <button type="button" class="btn btn-outline-secondary btn-sm" style="width: 80px;"
                onclick="location.href='./boardpetlist?pageNum=${pageNum }'">목록</button>
    </div>
</div>
</body>
</html>