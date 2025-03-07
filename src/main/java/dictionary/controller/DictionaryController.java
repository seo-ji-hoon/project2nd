package dictionary.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import data.dto.BoardPetDto;
import data.dto.DictionaryDto;
import data.service.DictionaryRepleService;
import data.service.DictionaryService;
import data.service.MemberPetService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import naver.storage.NcpObjectStorageService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/dictionary")
public class DictionaryController {
	final DictionaryService dictionaryService;
	//final DictionaryRepleService dictionaryRepleService;
	final NcpObjectStorageService storageService;
	
	//네이버 버켓이름
    private String bucketName="bitcamp-bucket-110";
    
    @Autowired
    private MemberPetService memberPetService;
    
    @GetMapping("/dictionarylist")
    public String list(Model model)
    {
        int totalCount;//전체 게시글 갯수
        List<DictionaryDto> list=dictionaryService.getAllDictionary(); //전체 목록 조회
        
        //int replecount=dictionaryRepleService.getRepleByNum(dto.getNum()).size();

        totalCount=dictionaryService.getTotalCount();//총 글갯수

        //request에 저장
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("list", list);

        return "dictionary/dictionarylist";
    }
    
	/*
	 * @GetMapping("/dictionarywriteform") public String writeForm(
	 * 
	 * @RequestParam(value = "idx", defaultValue = "0") int idx,
	 * 
	 * @RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model
	 * model) {
	 * 
	 * model.addAttribute("idx", idx); model.addAttribute("pageNum", pageNum);
	 * 
	 * return "dictionary/dictionarywriteform"; }
	 * 
	 * //게시글 등록
	 * 
	 * @PostMapping("/dictionaryinsert") public String insertDictionary(
	 * 
	 * @ModelAttribute DictionaryDto dto,
	 * 
	 * @RequestParam int pageNum, HttpSession session){
	 * 
	 * //세션으로 부터 아이디를 얻는다 String myid=(String)session.getAttribute("loginid");
	 * 
	 * //아이디를 이용해서 멤버 테이블에서 작성자를 얻는다(아이디와 작성자는 dto에 넣어야함) String
	 * writer=memberPetService.getSelectByMyid(myid).getMname();
	 * 
	 * //dto에 넣기 dto.setMyid(myid); dto.setWriter(writer); //게시판 내용을 일단 db에 저장(idx를
	 * 얻어올수 있기떄문에 내용을 db에 저장해야함) dictionaryService.insertBoardPet(dto);
	 * 
	 * 
	 * return "redirect:./dictionarylist?pageNum=" + pageNum; }
	 */
    
}
