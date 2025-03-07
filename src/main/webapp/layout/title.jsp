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
        a:link,a:visited {
			color: black;
			text-decoration: none;
		}
		
        .navdiv img{
        	width: 300px;
        	display: block;
    		margin: 0 auto;
        }
        
        ul#titlemenu{
			list-style: none;
    		display: flex;
    		justify-content: center; /* 가로 가운데 정렬 */
    		align-items: center;/* 세로 정렬 */
    		flex-grow: 1;
    		margin-left: 15%;
    		margin-right: 15%;
		}
		ul#titlemenu li{
			float: none;
			width: 100px;
			height: 40px;
			line-height: 40px;
			text-align: center;
			background-color:mediumaquamarine;
			border: 1px solid gray;
			border-radius: 20px;
		}
		
		img.profilephoto{
			width: 40px;
			height: 40px;
			border: 1px solid gray;
			border-radius: 100px;
			margin-right: 10px;
			cursor: pointer;
		}
		
		.navdiv {
    		display: flex;
    		justify-content: space-between; /* 양쪽 정렬 */
    		align-items: center; /* 세로 중앙 정렬 */
    		position: relative;
		}

		#titlemember {
    		position: absolute;
    		right: 20px; /* 오른쪽 끝 정렬 */
    		bottom: 10px; /* 아래쪽 배치 */
    		display: flex;
    		align-items: center;
    		gap: 15px;
		}

		#titleinfo {
			position: absolute;
			top:120px;
    		right: 20px; /* 오른쪽 끝 정렬 */
    		bottom: 10px; /* 아래쪽 배치 */
    		display: flex;
    		align-items: center;
    		gap: 10px;
    		font-size: 16px;
		}
		
		#titlemember a, #titlemember span {
    		font-size: 18px;
    		cursor: pointer;
		}
		#myLoginModal{
			margin: 10px;
		}
    </style>
</head>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<body>
<!-- The Login Modal -->
<div class="modal" id="myLoginModal">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원 로그인</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body" style="margin-top: -30px;">
      <form id="loginfrm">
	        <table class="logintab">
	        	<tbody>
	        		<tr>
	        			<th width="80">아이디</th>
	        			<td>
	        				<input type="text" id="loginid" placeholder="아이디"
	        				 class="form-control" required="required">
	        			</td>
	        		</tr>
	        		<tr>
	        			<th width="80" >비밀번호</th>
	        			<td>
	        				<input type="password" id="loginpass" placeholder="비밀번호"
	        				 class="form-control" required="required"
	        				 style="margin-top: 10px;">
	        			</td>
	        		</tr>
	        		<tr>
	        			<td colspan="2" align="center" >
							<button type="submit" class="btn btn-success"
							style="margin-top: 20px;">로그인</button>
						</td>
	        		</tr>
	        	</tbody>
	        </table>
        </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer" style="margin-top: -20px;">
        <button type="button" class="btn btn-danger btnclose" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


<div style="margin: 20px;" class="navdiv alert alert-success">
	<!-- 로고 클릭 시 메인 페이지로 이동 -->
	<h2>
		<a href="${root}/">
			<img src="/logo1.png">
		</a>
	</h2>

	<!-- 로그인/회원가입 영역 -->
	<div id="titlemember">
		<c:if test="${sessionScope.loginstatus==null}">
			<a data-bs-toggle="modal" data-bs-target="#myLoginModal">로그인</a>
			<a id="join" href="${root}/member/form">회원가입</a>
		</c:if>
		<c:if test="${sessionScope.loginstatus!=null}">
			<span id="logout">로그아웃</span>
		</c:if>
	</div>
	
	
	<!-- 로그인 정보 영역 -->
	<div id="titleinfo">
		<c:if test="${sessionScope.loginstatus!=null}">
			<c:set var="naverurl" value="https://kr.object.ncloudstorage.com/bitcamp-bucket-110"/>

			<img src="${naverurl}/member2/${sessionScope.loginphoto}" class="profilephoto"
			onerror="this.src='${root}/noimage.png'">
			<script>
				$(".profilephoto").click(function(){
					location.href=`${root}/member/mypage`;
				});
			</script>
			<b style="color:green">${sessionScope.mname}</b> 님이 로그인 중입니다
		</c:if>
	</div>
</div>
	
<ul id="titlemenu">
		  <li>
			<a href="${root}/">Home</a>
		</li>
		<li>
			<a href="${root}/boardpet/boardpetlist">커뮤니티</a>
		</li>
		<c:if test="${sessionScope.loginstatus!=null and sessionScope.loginid=='admin' }">
			<li>
				<a href="${root}/member/list">회원목록</a>
			</li>
		</c:if>
		<li>
			<a href="${root}/dictionary/dictionarylist">백과사전</a>
		</li>
	</ul>
	
<script type="text/javascript">
		$("#loginfrm").submit(function(e){
			e.preventDefault();//서브밋의 기본이벤트를 무효화(action호출)
			//alert("submit");
			let loginid=$("#loginid").val();
			let loginpass=$("#loginpass").val();
			
			$.ajax({
				type:"get",
				dataType:"json",
				data:{"loginid":loginid,"loginpass":loginpass},
				url:"${root}/member/login",
				success:function(res){
					if(res.result=='success'){
						//값 초기화
						$("#loginid").val("");
						$("#loginpass").val("");
						//모달창 닫기
						$(".btnclose").trigger("click");
						//새로고침
						location.reload();
					}else{
						수정수정
						alert("아이디나 비밀번호가 맞지 않습니다");
						$("#loginpass").val("");
					}
				}
			});
		});
		
		//로그아웃 클릭 시 이벤트
		$(".titlemember #logout").click(function(){
			$.ajax({
				type:"get",
				dataType:"text",
				url:"${root}/member/logout",
				success:function(res){
					//새로고침
					location.reload();
				}
			});
		});
		
	</script>
</body>
</html>