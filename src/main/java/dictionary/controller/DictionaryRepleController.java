package dictionary.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import data.dto.BoardPetRepleDto;
import data.dto.DictionaryRepleDto;
import data.dto.MemberPetDto;
import data.service.BoardPetRepleService;
import data.service.DictionaryRepleService;
import data.service.MemberPetService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import naver.storage.NcpObjectStorageService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/dictionary")
public class DictionaryRepleController {
	
	@Autowired
	final MemberPetService memberPetService;
	final DictionaryRepleService dictionaryRepleService;
	final NcpObjectStorageService storageService;
	
	//네이버 버켓이름
    private String bucketName="bitcamp-bucket-110";
    
    @PostMapping("/addreple")
    @ResponseBody
    public Map<String, String> insertDictionReple(
        @RequestParam("diction_idx") int diction_idx,
        @RequestParam("message") String message,
        @RequestParam(value = "upload", required = false) MultipartFile upload,
        HttpSession session
    ) {
        Map<String, String> response = new HashMap<>();

        try {

            String myid = (String) session.getAttribute("loginid");
            if (myid == null) {
                response.put("status", "error");
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            String uploadFilename = null;
            if (upload != null && !upload.isEmpty()) {
                uploadFilename = storageService.uploadFile(bucketName, "board_dictionary", upload);
            }

            DictionaryRepleDto dto = new DictionaryRepleDto();
            dto.setMyid(myid);
            dto.setDiction_idx(diction_idx);
            dto.setMessage(message);
            dto.setPhoto(uploadFilename);

            dictionaryRepleService.insertDictionReple(dto);

            response.put("status", "success");
            response.put("message", "댓글이 등록되었습니다.");
            return response;

        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "오류: " + e.getMessage());
            return response;
        }
    }
    
    @GetMapping("/dictionreplelist")
    @ResponseBody //JSON 응답 명시
    public List<DictionaryRepleDto> dictionreplelist(@RequestParam("diction_idx") int diction_idx) {

        List<DictionaryRepleDto> list = dictionaryRepleService.getDictionRepleByIdx(diction_idx);
        if (list == null || list.isEmpty()) {
            System.out.println("댓글 목록이 비어있습니다.");
            return Collections.emptyList(); // 빈 리스트 반환
        }

        for (int i = 0; i < list.size(); i++) {
            MemberPetDto member = memberPetService.getSelectByMyid(list.get(i).getMyid());
            if (member != null) {
                list.get(i).setWriter(member.getMname());
                list.get(i).setProfilePhoto(member.getMphoto());
            } else {
                list.get(i).setWriter("알 수 없는 사용자");
                list.get(i).setProfilePhoto(null);
            }
        }
        return list;
    }
    
    @PostMapping("/updateReple")
    @ResponseBody
    public Map<String, String> updateBoardReple(
        @RequestParam int num,
        @RequestParam String message,
        HttpSession session
    ) {
        Map<String, String> response = new HashMap<>();

            DictionaryRepleDto dto = new DictionaryRepleDto();
            dto.setNum(num);
            dto.setMessage(message);

            dictionaryRepleService.updateDictionReple(dto);
            response.put("status", "success");
            response.put("message", "댓글이 수정되었습니다.");
        
        return response;
    }
    
    @GetMapping("/deleteDictionReple")
    @ResponseBody // JSON 응답 명시
    public Map<String, String> repleDelete(@RequestParam("num") int num) {
        Map<String, String> response = new HashMap<>();

            String photo = dictionaryRepleService.getSelectData(num).getPhoto();
            if (photo != null) {
                storageService.deleteFile(bucketName, "board_dictionary", photo);
            }
            dictionaryRepleService.deleteDictionReple(num);
            
            response.put("status", "success");
            response.put("message", "댓글이 삭제되었습니다.");
            return response;
        
    }
	
}
