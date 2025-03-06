package member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import data.dto.MemberPetDto;
import data.service.MemberPetService;

@Controller
@RequestMapping("/member")
public class MemberPetListController {

	@Autowired
	MemberPetService memberPetService;

	@GetMapping("/list")
	public String memberList(Model model)
	{
		List<MemberPetDto> list=memberPetService.gellAllMembers();
		
		model.addAttribute("list",list);
		model.addAttribute("naverurl", "https://kr.object.ncloudstorage.com/bitcamp-bucket-110");
		model.addAttribute("fronturl", "https://dqyxjfhq8740.edge.naverncp.com/t0rx4BxTP8");
		model.addAttribute("backurl", "?type=f&w=100&h=120&faceopt=true&ttype=jpg");
		
		return "member/memberlist";
	}
	
}
