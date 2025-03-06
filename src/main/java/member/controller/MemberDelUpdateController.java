package member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import data.dto.BoardPetDto;
import data.dto.BoardPetRepleDto;
import data.dto.MemberPetDto;
import data.service.BoardPetFileService;
import data.service.BoardPetRepleService;
import data.service.BoardPetService;
import data.service.MemberPetService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import naver.storage.NcpObjectStorageService;

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
	
	//버켓 이름
	private String bucketName="bitcamp-bucket-110";
	
	@GetMapping("/mypage")
	public String goMypage(HttpSession session,Model model)
	{
		//세션으로부터 아이디 얻기
		String myid=(String)session.getAttribute("loginid");
		//아이디에 해당해당하는 dto얻기
		MemberPetDto dto=memberPetService.getSelectByMyid(myid);
		
		//내가 쓴 글 가져오기
		List<BoardPetDto> list=boardPetSeravice.getSelectById(myid);
		//내가 쓴 댓글 가져오기
		//List<BoardPetRepleDto> repleList=boardPetRepleService.getSelectById(myid);
		
		//모델에 dto 저장
		model.addAttribute("dto", dto);
		model.addAttribute("list",list);
		//model.addAttribute("repleList",repleList);
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
