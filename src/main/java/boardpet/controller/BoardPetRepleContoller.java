package boardpet.controller;


import data.dto.BoardPetRepleDto;
import data.service.BoardPetRepleService;
import data.service.MemberPetService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import naver.storage.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/boardpet")
public class BoardPetRepleContoller {

    @Autowired
    final BoardPetRepleService boardrepleServiceService;

    //네이버 버켓이름
    private String bucketName="bitcamp-bucket-110";

    @Autowired
    final NcpObjectStorageService storageService;
    @Autowired
    private MemberPetService memberPetService;

    @PostMapping("/addreple")
    @ResponseBody
    public void insertBoardReple(
            @RequestParam int idx,
            @RequestParam String message,
            @RequestParam("upload") MultipartFile upload,
            HttpSession session
    ) {
        //네이버 스토리지에 사진 업로드
        String uploadFilename=storageService.uploadFile(bucketName,"board_pet_reple",upload);
        //세션으로 부터 아이디를 얻는다
        String myid=(String)session.getAttribute("loginid");

        //dto 생성
        BoardPetRepleDto dto = new BoardPetRepleDto();
        dto.setMyid(myid);
        dto.setBoard_idx(idx);
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

    /*@GetMapping("/boardreplelist")
    public List<BoardPetRepleDto> boardrepleList(@RequestParam int idx) {

        List<BoardPetRepleDto> list = boardrepleServiceService.getboardRepleByNum(idx);

        for(int i=0;i<list.size();i++)
        {
            String writer=memberPetService.getSelectByMyid(list.get(i).getMyid()).getMname();
            String profilePhoto=memberPetService.getSelectByMyid(list.get(i).getMyid()).getMphoto();
            list.get(i).setWriter(writer);//댓글 작성자 저장
            list.get(i).setProfile(profilePhoto);//댓글 작성자 프로필사진 저장
        }

        return list;
    }*/




    @PostMapping("/updateReple")
    public void updateBoardReple(
            @RequestParam int id,
            @RequestParam String message,
            HttpSession session
    ) {

        //dto 생성
        BoardPetRepleDto dto = new BoardPetRepleDto();

        dto.setIdx(id);
        dto.setMessage(message);

        //db_insert
        boardrepleServiceService.updateBoardReple(dto);

    }

    @GetMapping("/deleteBoardReple")
    public void deleteBoardReple(
            @RequestParam int idx
    ) {

        //num 에 해당하는 이미지명 얻기
        String replePhoto=boardrepleServiceService.getboardPetPhoto(idx);
        //null 이 아닐경우 스토리지에서 삭제
        if(replePhoto!=null) {
            storageService.deleteFile(bucketName, "board_pet_reple", replePhoto);
        }

        //db 에서 삭제
        boardrepleServiceService.deleteBoardReple(idx);

    }
}
