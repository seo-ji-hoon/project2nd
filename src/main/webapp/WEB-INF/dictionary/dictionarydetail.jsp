<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동물백과 상세</title>
	<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Gaegu&family=Jua&family=Nanum+Pen+Script&family=Playwrite+AU+SA:wght@100..400&family=Single+Day&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style type="text/css">
    	body *{
            font-family: 'Jua';
        }
        .dictiondetail{
        	margin: 30px auto;
        	width: 650px;
        	
        }
        .day {
            font-size: 13px;
            color: gray;
        }
		.profilePhoto{
            width: 40px;
            height: 40px;
            border: 1px solid gray;
            margin-right: 10px;
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

            $("#addreple").click(function() {
                let m = $("#message").val();
                if (m == '') {
                    alert("댓글을 입력해주세요");
                    return;
                }

                if (file == null) {
                    alert("사진을 선택해주세요");
                    return;
                }

                let dictionIdx = $("#diction_idx").val(); // input 요소의 값 가져오기
            

                let form = new FormData();
                form.append("upload", file);
                form.append("message", m);
                form.append("diction_idx", dictionIdx); // 올바른 값 전송

                // 디버깅용: FormData 내용 확인
                for (let pair of form.entries()) {
                    console.log(pair[0] + ": " + pair[1]);
                }

                $.ajax({
                    type: "post",
                    dataType: "text",
                    url: "./addreple", // 절대 경로 사용
                    data: form,
                    processData: false,
                    contentType: false,
                    success: function() {
                        alert("댓글이 등록되었습니다.");
                        $("#message").val("");
                        file = null;
                        $("#photoupload").val("");
                        replelist();
                    }
                });
            });
        });


        function replelist() {
        	let dictionIdx = $("#diction_idx").val();
            if (!dictionIdx || isNaN(dictionIdx)) {
                console.log("유효하지 않은 diction_idx: " + dictionIdx);
                return;
            }
              $.ajax({
                type:"get",
                dataType:"json",
                url:"/dictionary/dictionreplelist",
                data:{"diction_idx":dictionIdx},
                success:function(res){
                    let s="";

                    $.each(res,function(idx,item){
                        console.log(item);
                        s+=
                            `
                	<div class="item" style="margin-bottom:5px;" data-repleid="\${item.id}">
			            <span >\${item.myid}</span>
            			<img src="${naverurl}/board_dictionary/\${item.photo}" class="photo"
                 			data-bs-toggle="modal" data-bs-target="#myRepleModal" style="width:30px;">
            			<span class="message-text">\${item.message}</span>
			            <span class="day">\${item.writeday}</span>
			            <button type="button" class="btn btn-success mt-2 btn-sm updatereple" data-id="\${item.num}"
			                    data-message="\${item.message}" data-photo="\${item.photo}">댓글수정</button>
			            <button type="button" class="btn btn-danger mt-2 btn-sm dictionRepledel" data-id="\${item.num}">댓글삭제</button>
			        </div>`;
                    });

                    s+="</div>";
                    $("div.replelist").html(s);
                }
            });
        }


        $(document).on("click", ".updatereple", function () {
            let repleId = $(this).data("id");  // 댓글 num
            let message = $(this).data("message"); // 기존 댓글 내용

            console.log("댓글 num:", repleId);
            console.log("댓글 내용:", message);

            let parentDiv = $(this).closest(".item");
            let editHtml = `
                <div class="item">
                    <textarea class="form-control edit-message">\${message}</textarea>
                    <button class="btn btn-success mt-2 btn-sm save-reple" data-id="\${repleId}">저장</button>
                    <button class="btn btn-secondary mt-2 btn-sm cancel-reple">취소</button>
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
                "num": repleId,
                "message": newMessage,
                "deletePhoto": hasPhoto ? "false" : "true" // 사진이 삭제되었는지 여부
            };


            $.ajax({
                type: "post",
                url: "/dictionary/updateReple",
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
        $(document).on("click",".dictionRepledel",function(){
            let repleId = $(this).data("id");
            let ans=confirm("해당 댓글을 삭제할까요?");
            if(!ans) return;//취소 클릭시 함수 종료

            $.ajax({
                type:"get",
                dataType:"text",
                data:{
                    "num": repleId ,
                },
                url:"/dictionary/deleteDictionReple",
                success:function(){
                	alert("댓글이 삭제되었습니다.");
                    //댓글 삭제후 전체 댓글 다시 출력
                    replelist();
                }
            });
        });
 
    </script>
</head>
<body>
<jsp:include page="../../layout/title.jsp"/>

<div class="dictiondetail">
    <input type="hidden" id="diction_idx" value="${dto.idx}"> <!-- ✅ 수정 -->
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
    
    <!-- 댓글목록 출력 -->
    <div class="replelist">
    </div>

     <!-- 댓글 -->
    <div style="margin-top: 20px; padding:10px; width: 600px; background-color: #eee;">
        <h5>댓글</h5>
        <textarea id="message" class="form-control" rows="2" placeholder="댓글을 입력하세요"></textarea>
        <div style="margin-top: 10px;">
            <input type="file" id="photoupload">
            <button class="replephoto btn btn-outline-success btn-sm mt-2">이미지첨부</button>
            <button type="button"  class="btn btn-success mt-2 btn-sm" id="addreple">댓글저장</button>
        </div>

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
                            data:{"num":${dto.num}},
                            url:"./petdelete",
                            success:function(){
                                alert("삭제되었습니다.");
                                //삭제 성공후 목록으로 이동
                                location.href="./dictionarylist";
                            }
                        });
                    }
                }
            </script>
        </c:if>
    </div>

    <!-- 댓글 -->

    <div style="margin-top: 30px;">
        

        <%--<button type="button" class="btn btn-outline-secondary btn-sm" style="width: 80px;"
                onclick="location.href='./writeform?idx=${dto.idx}&regroup=${dto.regroup}&restep=${dto.restep}&relevel=${dto.relevel }&pageNum=${pageNum}'">답글</button>--%>

        <c:if test="${sessionScope.loginid==dto.myid }">
        	<button type="button" class="btn btn-success btn-sm" style="width: 80px;"
                onclick="location.href='./dictionarywriteform'">
            <i class="bi bi-pencil-square"></i>
            글쓰기
        	</button>
            <button type="button" class="btn btn-outline-secondary btn-sm" style="width:80px;"
                    onclick="location.href='./dictionaryupdateform?idx=${dto.idx}'">수정</button>

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
                                location.href="./dictionarylist?";
                            },
                            error:function (){
                                console.log("실패입니다.")
                            }
                        });
                    }
                }
            </script>
        </c:if>

        <button type="button" class="btn btn-outline-success btn-sm" style="width: 80px;"
                onclick="location.href='./dictionarylist'">목록</button>
    </div>
</div>
</body>
</html>