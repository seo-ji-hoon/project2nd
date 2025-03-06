<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>502 jsp study</title>
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Gaegu&family=Jua&family=Nanum+Pen+Script&family=Playwrite+AU+SA:wght@100..400&family=Single+Day&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">


    <style>
        body * {
            font-family: 'Jua';
        }


    </style>


    <script type="text/javascript">
        $(function(){
            photolist(); //처음 로딩시 사진들 출력

            //개별사진 삭제
            $(document).on("click",".delicon",function(){
                //아이콘에 넣어둔 num 얻기
                let num=$(this).attr("num");
                $.ajax({
                    type:"get",
                    dataType:"text",
                    data:{"num":num},
                    url:"./photodel",
                    success:function(res){
                        //사진 삭제후 사진목록 다시 출력
                        photolist();
                    }
                });
            });
        });

        function photolist(){

            let idx=${dto.idx};
            let url=`${naverurl}`;

            $.ajax({
                type:"get",
                dataType:"json",
                data:{"idx":idx},
                url:"./photolist",
                success:function(res){

                    let s="";

                    $.each(res,function(i,item){
                        s+=
                            `
							<img src="\${url}/board_pet/\${item.filename}">
							<i class="bi bi-x-circle delicon" num="\${item.num}"></i>
						`
                    });
                    $(".photos").html(s);
                }
            });
        }
    </script>
</head>
<body>
<jsp:include page="../../layout/title.jsp"/>
<div style="margin: 30px; width: 500px;">
    <form action="./update" method="post" enctype="multipart/form-data">

        <!-- hidden -->
        <input type="hidden" name="idx" value="${dto.idx}">
        <input type="hidden" name="pageNum" value="${pageNum}">

        <table class="tabform table table-bordered">
            <caption align="top">
                <h5>글수정</h5>
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
                <th width="150">사 진 </th>
                <td>
                    <div class="photos"></div>
                    <input type="file" name="upload" class="form-control"
                           multiple="multiple">
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
                    <button type="submit" class="btn btn-outline-secondary"
                            style="width: 100px;">글수정</button>

                    <button type="button" class="btn btn-outline-secondary"
                            style="width: 100px;" onclick="location.href='./detail?idx=${dto.idx}&pageNum=${pageNum }'">이전으로</button>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>