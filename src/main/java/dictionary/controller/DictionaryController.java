package dictionary.controller;

import java.util.List;
import java.util.Vector;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import data.dto.BoardPetDto;
import data.dto.BoardPetFileDto;
import data.dto.DictionaryDto;
import data.dto.MemberPetDto;
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
	final DictionaryRepleService dictionaryRepleService;
	final NcpObjectStorageService storageService;
	
	//네이버 버켓이름
    private String bucketName="bitcamp-bucket-110";
    
    @Autowired
    private MemberPetService memberPetService;
    
    @GetMapping("/dictionarylist")
    public String list(Model model) {
        int totalCount = dictionaryService.getTotalCount(); // 전체 게시글 수
        List<DictionaryDto> list = dictionaryService.getAllDictionary(); // 전체 목록 조회

        // 각 글에 대해 댓글 수 설정
        for (DictionaryDto dto : list) {
            int repleCount = dictionaryRepleService.getDictionRepleByIdx(dto.getIdx()).size();
            dto.setReplecount(repleCount); // DTO에 댓글 수 저장
        }

        // Model에 데이터 추가
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("list", list);

        return "dictionary/dictionarylist";
    }
    
	
	  @GetMapping("/dictionarywriteform") 
	  public String writeForm(
			  @RequestParam(value = "idx", defaultValue = "0") int idx,
			  Model model) 
	  {
		  model.addAttribute("idx", idx); 
	  
		  return "dictionary/dictionarywriteform"; 
	  }
	  
	  //게시글 등록
	  @PostMapping("/dictionaryinsert") 
	  public String insertDictionary(
			  @ModelAttribute DictionaryDto dto,
			  HttpSession session
	  ){
	  //세션으로 부터 아이디를 얻는다 
	  String myid=(String)session.getAttribute("loginid");
	  
	  //아이디를 이용해서 멤버 테이블에서 작성자를 얻는다(아이디와 작성자는 dto에 넣어야함) 
	  String writer=memberPetService.getSelectByMyid(myid).getMname();
	
	  //dto에 넣기 
	  dto.setMyid(myid); 
	  dto.setWriter(writer); 
	  //게시판 내용을 일단 db에 저장(idx를
	  //얻어올수 있기떄문에 내용을 db에 저장해야함) 
	  dictionaryService.insertDictionary(dto);
	  
	  return "redirect:./dictionarylist";//완료 시 목록으로 이동 
	  }
	  
	  //상세보기
	  @GetMapping("/dictionview")
	  public String dictionview (@RequestParam int idx, Model model){

	        //조회수 1증가
	        dictionaryService.updateReadCount(idx);
	        //idx 에 해당하는 dto 얻기
	        DictionaryDto dto = dictionaryService.getSelectByIdx(idx);

	        //해당 아이디에 대한 사진을 멤버 테이블에서 얻기
	        System.out.println(">>>>>>>" + dto.getMyid());
	        String memberPhoto=memberPetService.getSelectByMyid(dto.getMyid()).getMphoto();
	        System.out.println(dto.getMyid());

	        //모델에 저장
	        model.addAttribute("dto", dto);
	        model.addAttribute("memberPhoto", memberPhoto);
	        model.addAttribute("naverurl", "https://kr.object.ncloudstorage.com/"+bucketName);

	        return  "dictionary/dictionarydetail";
	    }
	  
	  	//게시글삭제
	    @GetMapping("/dictionarydelete")
	    @ResponseBody
	    public void deleteDitctionary(@RequestParam int idx) {

	        dictionaryService.deleteDictionary(idx);
	    }
	    
	    @GetMapping("/dictionaryupdateform") 
		  public String updateForm(
				  @RequestParam(value = "idx", defaultValue = "0") int idx,
				  Model model) 
		  {
	    	DictionaryDto dto = dictionaryService.getSelectByIdx(idx); // 데이터 조회
			  model.addAttribute("dto", dto); 
			  return "dictionary/dictionaryupdateform"; 
		  }
	    
	    //게시글 수정
	    @PostMapping("/dictionaryupdate")
	    public String updateDictionary(
	            @RequestParam int idx,
	            @RequestParam String subject,
	            @RequestParam String content
	    ) {            
	        DictionaryDto dto = dictionaryService.getSelectByIdx(idx); // 기존 데이터 조회
	        dto.setSubject(subject);
	        dto.setContent(content);
	        dictionaryService.updateDictionary(dto);

	        return "redirect:/dictionary/dictionview?idx=" + idx; // 수정 후 상세보기 페이지로 이동
	    }
    
}
