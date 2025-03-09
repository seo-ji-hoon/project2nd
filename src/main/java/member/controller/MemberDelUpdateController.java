package member.controller;

import data.dto.BoardPetDto;
import data.dto.BoardPetRepleDto;
import data.dto.DictionaryRepleDto;
import data.dto.MemberPetDto;
import data.service.BoardPetFileService;
import data.service.BoardPetRepleService;
import data.service.BoardPetService;
import data.service.DictionaryRepleService;
import data.service.MemberPetService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import naver.storage.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberDelUpdateController {
	
	@Autowired
	final MemberPetService memberPetService;
	final NcpObjectStorageService storageService;
	final BoardPetService boardPetSeravice;
	final BoardPetRepleService boardPetRepleService;
	final BoardPetFileService petFileService;
	final DictionaryRepleService dictionaryRepleService;
	
	//버켓 이름
	private String bucketName="bitcamp-bucket-110";
	
	@GetMapping("/mypage")
	public String goMypage(HttpSession session,Model model)
	{
		//세션으로부터 아이디 얻기
		String myid=(String)session.getAttribute("loginid");
		//아이디에 해당해당하는 dto얻기
		MemberPetDto dto=memberPetService.getSelectByMyid(myid);
		BoardPetRepleDto brdto=new BoardPetRepleDto();
		//DictionaryRepleDto dictinrepledto=new DictionaryRepleDto();
		
		//내가 쓴 글 가져오기
		List<BoardPetDto> list=boardPetSeravice.getSelectById(myid);
		//내가 쓴 댓글 가져오기
		List<BoardPetRepleDto> repleList=boardPetRepleService.getSelectRepleById(myid);
		//백과사전에 있는 내가 쓴 댓글 가져오기
		List<DictionaryRepleDto> dictionreList=dictionaryRepleService.getSelectRepleById(myid);
		
		// 댓글 데이터를 Map으로 변환하여 하나의 리스트로 합치기
	    List<Map<String, Object>> combinedList = new ArrayList<>();
	    
	    for (BoardPetRepleDto reple : repleList) {
	        Map<String, Object> map = new HashMap<>();
	        map.put("message", reple.getMessage());
	        map.put("writeday", reple.getWriteday());
	        map.put("board_idx", reple.getBoard_idx());
	        map.put("boardSubject", reple.getBoard_subject());
	        combinedList.add(map);
	    }
	    
	    for (DictionaryRepleDto reple : dictionreList) {
	        Map<String, Object> map = new HashMap<>();
	        map.put("message", reple.getMessage());
	        map.put("writeday", reple.getWriteday());
	        map.put("diction_idx", reple.getDiction_idx());
	        map.put("dictionSubject", reple.getDiction_subject());
	        combinedList.add(map);
	    }
		
		//모델에 dto 저장
		model.addAttribute("dto", dto);
		model.addAttribute("list",list);//커뮤니티에서 내가 쓴 글 목록
		//model.addAttribute("repleList",repleList); //커뮤니티에서 내가 쓴 댓글 목록
		//model.addAttribute("dictionreList",dictionreList);
		model.addAttribute("combinedList", combinedList); // 내가 쓴 댓글 목록 (커뮤니티 + 백과사전)
		model.addAttribute("brdto",brdto);
		model.addAttribute("naverurl", "https://kr.object.ncloudstorage.com/bitcamp-bucket-110");
		return "member/mypage";
	}
	
	@PostMapping("/updatemember")
	@ResponseBody
	public void updateMember(
			HttpSession session,
			@RequestParam("upload") MultipartFile upload,
			@RequestParam String mname,
			@RequestParam String mhp,
			@RequestParam String maddr,
			@RequestParam int num
			) 
	{
		//사진수정시 db 에 저장된 파일명을 받아서 스토리지에서 삭제후 추가할것
		String oldFilename=memberPetService.getSelectByNum(num).getMphoto();
		storageService.deleteFile(bucketName, "member2", oldFilename);

		//네이버 스토리지에 업로드
		String uploadFilename=storageService.uploadFile(bucketName, "member2", upload);
		//db 에서도 수정
		//memberPetService.changePhoto(uploadFilename, num);
		//세션도 변경
		session.setAttribute("loginphoto", uploadFilename);
		
		MemberPetDto dto=new MemberPetDto();
		dto.setMphoto(uploadFilename);
		dto.setMname(mname);
		dto.setMaddr(maddr);
		dto.setMhp(mhp);
		dto.setNum(num);
		memberPetService.updateMember(dto);
	}
	
	@GetMapping("/delete")
	public String deleteMember(@RequestParam int num) 
	{
		
		memberPetService.deleteMember(num);
		
		return "redirect:./list";
	}
	
	@GetMapping("/mypagedel")
	@ResponseBody
	public void mypageDelete(@RequestParam int num,HttpSession session) 
	{
		
		memberPetService.deleteMember(num);
		
		//모든 세션 제거
		session.removeAttribute("loginstatus");
		session.removeAttribute("loginid");
		session.removeAttribute("loginphoto");
	}
	
}
