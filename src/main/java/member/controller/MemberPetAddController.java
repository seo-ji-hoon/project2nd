package member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import data.dto.MemberPetDto;
import data.service.MemberPetService;
import jakarta.servlet.http.HttpServletRequest;
import naver.storage.NcpObjectStorageService;

@Controller
@RequestMapping("/member")
public class MemberPetAddController {
	
	@Autowired
	MemberPetService memberPetService;
	
	//버켓이름
	private String bucketName="bitcamp-bucket-110";//지훈님 것으로 수정해야함
	
	@Autowired
	NcpObjectStorageService storageService;
	
	@GetMapping("/form")
	public String form()
	{
		return "member/memberform";
	}
	
	@GetMapping("/idcheck")
	@ResponseBody
	public Map<String, String> idCheck(@RequestParam String myid)
	{
		Map<String, String> map=new HashMap<>();
		if(memberPetService.checkMyid(myid))
			map.put("result", "fail");
		else
			map.put("result", "success");
		return map;
	}
	
	@PostMapping("/insert")
	public String insert(
			HttpServletRequest request,
			@ModelAttribute MemberPetDto dto,
			@RequestParam("upload") MultipartFile upload
			)
	{
		//사진선택을 안했을경우 upload 의 파일명을 확인후
		//사진선택을 안했다면 upload하지말고 mphoto 에 "no" 저장
		System.out.println("filename:"+upload.getOriginalFilename());
		
		if(upload.getOriginalFilename().equals("")) {
			dto.setMphoto("no");
		}else {
			//네이버 스토리지에 사진 저장하기-
			//네이버 오브젝트스토리지에 사진을 업로드후 업로드한 파일명을 반환
			String uploadFilename=storageService.uploadFile(bucketName, "member2", upload);
			dto.setMphoto(uploadFilename);
		}
		
		memberPetService.insertMember(dto);
		
		return "redirect:../";//일단은 홈으로 이동
		
	}
	
	
}
