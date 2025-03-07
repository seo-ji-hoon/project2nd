package boardpet.controller;


import data.dto.BoardPetRepleDto;
import data.service.BoardPetRepleService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import naver.storage.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardPetRepleContoller {

    @Autowired
    final BoardPetRepleService boardrepleServiceService;

    //네이버 버켓이름
    private String bucketName="bitcamp-bucket-110";

    @Autowired
    final NcpObjectStorageService storageService;

    @PostMapping("/addreple")
    public void insertBoardReple(
            @RequestParam int idx,
            @RequestParam String message,
            @RequestParam("upload") MultipartFile upload,
            HttpSession session
    ) {
        System.out.println("idx : "+idx);
        //네이버 스토리지에 사진 업로드
        String uploadFilename=storageService.uploadFile(bucketName, "board", upload);

        //세션으로 부터 아이디를 얻는다
        String myid=(String)session.getAttribute("loginid");


        //dto 생성
        BoardPetRepleDto dto = new BoardPetRepleDto();

        dto.setMyid(myid);
        dto.setIdx(idx);
        dto.setMessage(message);
        dto.setPhoto(uploadFilename);

        //db_insert
        boardrepleServiceService.insertBoardPetReple(dto);

    }

    @GetMapping("/boardreplelist")
    public List<BoardPetRepleDto> boardrepleList(
            @RequestParam int idx
    ) {
        List<BoardPetRepleDto> list=null;
        list=boardrepleServiceService.getboardRepleByNum(idx);

        return list;
    }

    @PostMapping("/updateReple")
    public void updateBoardReple(
            @RequestParam int id,
            @RequestParam String message,
            HttpSession session
    ) {

        //dto 생성
        BoardPetRepleDto dto = new BoardPetRepleDto();

       // dto.setNum(id);
        dto.setMessage(message);

        //db_insert
        boardrepleServiceService.updateBoardReple(dto);

    }

    @GetMapping("/deleteBoardReple")
    public void deleteBoardReple(
            @RequestParam int num
    ) {

        //String replePhoto=repleService.getSelectData(num).getPhoto();
        //null이 아닐경우 스토리지에서 삭제
//		if(replePhoto!=null) {
//			storageService.deleteFile(bucketName, "board", replePhoto);
//		}


        //db_delete
        //boardrepleService.deleteBoardReple(num);

    }
}
