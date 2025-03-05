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
	private String bucketName="bitcamp-bucket-101";//지훈님 것으로 수정해야함
	
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
	
}
