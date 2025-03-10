<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
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
        
        .profilelargephoto{
        	width: 150px;
        
        }
        .myinfo{
        	display: flex;
    		justify-content: center;
    		align-items: center;
    		flex-direction: column; /* 요소들을 세로로 정렬 */
        	margin: 20px auto;
        }
        
        .mylist {
        	cursor:pointer;
    		display: flex;
    		justify-content: center; /* 가로 중앙 정렬 */
    		align-items: center;
    		font-size: 18px;
    		text-align: center;
		}
		.result{
			width:700px;
			margin: 30px auto;
		}
		
		.tabmyboard thead tbody{
    		display: flex;
    		justify-content: center;
    		align-items: center;
    		flex-direction: column; /* 요소들을 세로로 정렬 */
    		margin: 30px auto; /* 가로 중앙 정렬 */
    		text-align: center;
		}
		
		.picon:hover{
 			color: green;
		}
    </style>
    <script>
    	
    </script>
</head>
<body>
<jsp:include page="../../layout/title.jsp"/>

<!-- The Modal -->
<div class="modal" id="myMemberModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">내 정보 수정</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form id="updateform">
        <table class="logintab">
        	<tbody>
        		<tr>
        			<th width="80">이름</th>
        			<td>
        				<input type="text" id="mname" name="mname" value="${dto.mname }">
        			</td>
        		</tr>
        		<tr>
        			<th width="80">사진</th>
        			<td>
        				<input type="file" id="fileupload">
        			</td>
        		</tr>
        		
        		<script>
				$(".changeimage").click(function(){
					$("#fileupload").trigger("click");
				});
        		</script>
        		<tr>
        			<th width="80">전화번호</th>
        			<td>
        				<input type="text" id="mhp" name="mhp" value="${dto.mhp}">
        			</td>
        		</tr>
        		<tr>
        			<th width="80">주소</th>
        			<td>
        				<input type="text" id="maddr" name="maddr" value="${dto.maddr }">
        			</td>
        		</tr>
        		<tr>
        			<td colspan="2" align="center">
        				<button type="submit" class="btn btn-sm btn-success">수정</button>
        			</td>
        		</tr>
        	</tbody>	
        </table>
      </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<!-- 모달 끝 -->

<!-- 내 정보 노출 영역 -->
<div style="margin: 30px 100px;" class="myinfo">
	<%-- <img src="../save/${dto.mphoto}" class="profilelargephoto"
	  onerror="this.src='../save/noimage.png'" style="float: left;"> --%>
	  
	 <!-- naver storage 에 있는 사진으로 출력 -->
	 <img src="${naverurl}/member2/${dto.mphoto}" class="profilelargephoto"
	  onerror="this.src='${root}/noimage.png'" style="float: left;">
	  
	<div style="display: inline-block;margin: 20px 50px;">
		<h6>회원명 : ${dto.mname}</h6>
		<h6>아이디 : ${dto.myid}</h6>
		<h6>핸드폰 : ${dto.mhp}</h6>
		<h6>주소 : ${dto.maddr}</h6>
		<h6>가입일 :
		
			<fmt:formatDate value="${dto.gaipday}" pattern="yyyy-MM-dd"/>
		</h6>
		<br><br>
		<button type="button" class="btn btn-sm btn-danger"
		onclick="memberdel(${dto.num})">회원탈퇴</button>
		
		<script>
			function memberdel(num){
				let ans=confirm("정말 탈퇴하시겠습니까?");
				if(ans){
					$.ajax({
						type:"get",
						dataType:"text",
						data:{"num":num},
						url:"./mypagedel",
						success:function(){
							location.href='../';
						}
					});
				}
			}
		</script>
		
		<!-- 문제 : 아이디를 제외한 나머지 정보(mname,mhp,maddr) 수정(모달) 
		수정 후 reload 할거니까 @resonseBody로 메서드 구현 반환받지 않고 form으로 한번에 해도 되고-->
		<button type="button" class="btn btn-sm btn-success"
		data-bs-toggle="modal" data-bs-target="#myMemberModal">회원정보 수정</button>
		
		<script>
		//수정 이벤트
		$("#updateform").submit(function(e){
			e.preventDefault();//서브밋의 기본이벤트를 무효화(action호출)
			//alert("submit");
			let form=new FormData();
			let fileInput = $("#fileupload")[0].files[0];

		    if (fileInput) {
		        form.append("upload", fileInput); // 파일이 있을 때만 추가
		    }
			form.append("num",${dto.num});
			form.append("mname",$("#mname").val());
			form.append("mhp",$("#mhp").val());
			form.append("maddr",$("#maddr").val());
			
			//console.log(loginid);
			 $.ajax({
				type:"post",
				dataType:"text",
				data:form,
				url:"./updatemember",
				processData:false,
				contentType:false,
				success:function(res){
					alert("회원 정보가 수정되었습니다.");
		            location.reload();
				}
			});
		});
		</script>
	</div>
</div>

<hr style="width: 700px;margin: 20px auto">

<!-- 내가 쓴 글/내가 쓴 댓글 버튼 영역 -->
<div class="mylist">
	<button type="button" id="myboard" class="btn btn-sm btn-success">내가 쓴 글</button>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<button type="button" id="myreple" class="btn btn-sm btn-success">내가 쓴 댓글</button>
</div>
 
<!-- 내가 쓴 글, 내가 쓴 댓글 목록 노출 영역 -->
<div class="result">
 
</div>

<script type="text/javascript">
$(document).ready(function(){
    function setupLoadMore(tableSelector) {
        let rows = $(tableSelector + " tbody tr"); // 모든 행 가져오기
        let rowsPerPage = 5; // 한 번에 표시할 행 개수
        let currentIndex = 5; // 처음 5개는 보이도록 설정

        rows.hide().slice(0, rowsPerPage).show(); // 처음 5개만 보이게 설정

        // 기존 "더보기" 버튼 삭제 후 새로 추가
        $("#loadMore").remove();
        if (rows.length > rowsPerPage) {
            $(".result").append('<button id="loadMore" class="btn btn-success mt-2">더보기</button>');
            
            $("#loadMore").click(function(){
                rows.slice(currentIndex, currentIndex + rowsPerPage).fadeIn();
                currentIndex += rowsPerPage;

                // 모든 행이 노출되면 버튼 숨기기
                if (currentIndex >= rows.length) {
                    $(this).hide();
                }
            });
        }
    }

    function renderBoardList() {
        $(".result").html(`
            <table class="table table-bordered tabmyboard">
                <thead>
                    <tr>
                        <th width="60">번호</th>
                        <th width="450">제목</th>
                        <th width="100">작성일</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dto" items="${list}" varStatus="i">
                        <tr>
                            <td align="center" width="60">${i.count}</td>
                            <td>
                                <a href="../boardpet/petview?idx=${dto.idx}" style="color: black;text-decoration: none">
                                    <i class="bi bi-image picon">${dto.subject}</i>
                                </a>
                            </td>
                            <td align="center">
                                <span style="font-size: 0.8em;">
                                    <fmt:formatDate value="${dto.writeday}" pattern="yyyy-MM-dd"/>
                                </span>
                            </td>
                            <td align="center">${dto.readcount}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        `);
        setupLoadMore(".tabmyboard");
    }

    function renderRepleList() {
        $(".result").html(`
            <table class="table table-bordered tabmyboard">
                <thead>
                    <tr>
                        <th width="60">번호</th>
                        <th width="250">댓글 내용</th>
                        <th width="100">작성일</th>
                        <th>원제목</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="dto" items="${combinedList}" varStatus="i">
                <tr>
                    <td align="center" width="60">${i.count}</td>
                    <td>${dto.message}</td>
                    <td align="center">
                        <span style="font-size: 0.8em;">
                            <fmt:formatDate value="${dto.writeday}" pattern="yyyy-MM-dd"/>
                        </span>
                    </td>
                    <td class="orginsubject">
                    <c:choose>
                    <c:when test="${not empty dto.board_idx}">
                        <a href="../boardpet/petview?idx=${dto.board_idx}" style="color: black; text-decoration: none">
                            ${dto.boardSubject}
                        </a>
                    </c:when>
                    <c:when test="${not empty dto.diction_idx}">
                        <a href="../dictionary/dictionview?idx=${dto.diction_idx}" style="color: black; text-decoration: none">
                         <b style="color:green;">[백과] &nbsp;</b>${dto.dictionSubject}
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span>연결된 게시글 없음</span>
                    </c:otherwise>
                </c:choose>
                    </td>
                </tr>
            </c:forEach>
                </tbody>
            </table>
        `);
        setupLoadMore(".tabmyboard");
    }

    // 페이지 로드 시 "내가 쓴 글" 자동 표시
    renderBoardList();

    // 내가 쓴 글 버튼 클릭 시
    $("#myboard").click(function(){
        renderBoardList();
    });

    // 내가 쓴 댓글 버튼 클릭 시
    $("#myreple").click(function(){
        renderRepleList();
    });
});
</script>

</body>
</html>