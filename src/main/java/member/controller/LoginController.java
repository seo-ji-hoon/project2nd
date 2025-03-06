package member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import data.service.MemberPetService;
import jakarta.servlet.http.HttpSession;

@RestController
public class LoginController {
	
	@Autowired
	MemberPetService memberPetService;
	
	@GetMapping("/member/login")
	public Map<String, String> login(
			@RequestParam("loginid") String loginid,@RequestParam("loginpass") String loginpass,
			HttpSession session
			)
	{
		Map<String, String> map=new HashMap<>();
		boolean b=memberPetService.loginCheck(loginid, loginpass);
		//아이디와 비번이 맞을경우 세션저장
		if(b) {
			session.setMaxInactiveInterval(60*60*4);//4시간유지
			session.setAttribute("loginstatus", "success");
			session.setAttribute("loginid", loginid);
			//session.setAttribute("mname", mname);
			
			//아이디에 해당하는 nmame 얻기
			String mname=memberPetService.getSelectByMyid(loginid).getMname();
			session.setAttribute("mname", mname);
			
			//아이디에 해당하는 프로필 사진 얻기
			String photo=memberPetService.getSelectByMyid(loginid).getMphoto();
			session.setAttribute("loginphoto", photo);
		}
		
		map.put("result", b?"success":"fail");
		
		return map;
	}
	
	@GetMapping("/member/logout")
	public void memberLogout(HttpSession session)
	{
		session.removeAttribute("loginstatus");
		session.removeAttribute("loginid");
		session.removeAttribute("loginphoto");
	}
	
	
}
