package boardpet.controller;

import data.dto.BoardPetDto;
import data.dto.BoardPetFileDto;
import data.service.BoardPetFileService;
import data.service.BoardPetRepleService;
import data.service.BoardPetService;
import data.service.MemberPetService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import naver.storage.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Vector;


@Controller
@RequiredArgsConstructor
@RequestMapping("/boardpet")
public class BoardPetController {

    final BoardPetService boardpetService;
    final NcpObjectStorageService storageService;
    final BoardPetFileService boardPetFileService;


    //네이버 버켓이름
    private String bucketName="bitcamp-bucket-110";
    @Autowired
    private MemberPetService memberPetService;
    @Autowired
    private BoardPetRepleService boardPetRepleService;

    // /boardpet/boardpetlist
    @GetMapping("/boardpetlist")
    public String list(
            @RequestParam(value = "pageNum",defaultValue = "1") int pageNum,
            Model model)
    {

        //페이징처리
        int perPage=5;//한페이지당 출력할 글의 갯수
        int perBlock=5;//한 블럭당 출력할 페이지 갯수
        int totalCount;//전체 게시글 갯수
        int totalPage;//총 페이지수
        int startNum;//각 페이지에서 가져올 시작번호 (mysql은 첫 데이타가 0번,오라클은 1번)
        int startPage;//각 블럭에서 출력할 시작페이지
        int endPage;//각 블럭에서 출력할 끝 페이지
        int no;//각 페이지에서 출력할 시작번호
        List<BoardPetDto> list = null; //페이징에 필요한 데이타

        totalCount=boardpetService.getTotalCount();//총 글갯수
        //totalPage=totalCount/perPage+(totalCount%perPage>0?1:0);//총 페이지 갯수,나머지가 있으면 무조건 1페이지를 더한다
        totalPage=(int)Math.ceil((double)totalCount/perPage);//방법2, 무조건 올림함수를 이용해서 구하는방법

        //시작페이지
        startPage=(pageNum-1)/perBlock*perBlock+1;//예) 현재페이지가 7일 경우 startPage 가 (6) (perBlock이 5일경우)
        endPage=startPage+perBlock-1;//끝페이지
        //endPage 는 totalPage를 넘을수 없다.
        if(endPage>totalPage) {
            endPage=totalPage;
        }

        //각 페이지에서 불러올
        startNum=(pageNum-1)*perPage; //mysql은 첫글이 0번(오라클은 1번이므로 +1해야한다)


        list=boardpetService.getPagingList(startNum, perPage);
        //마지막 페이지의 1개남은 글을 지우고 다시 해당페이지를
        //왔을경우 데이타가 안나오는 현상
        if(list.size()==0) {
            return "redirect:./boardpetlist?pageNum="+(pageNum-1);
        }

        //게시글에 대표사진을 1개 list에 출력
        for(int i=0; i<list.size();i++) {
            
            BoardPetDto dto = list.get(i);
            String filename=boardPetFileService.getBoardFileimge(dto.getIdx());
            list.get(i).setFileName(filename);

            //댓글수 저장
            int repleCounting=boardPetRepleService.getboardRepleByNum(dto.getIdx()).size();
            dto.setRepleCounting(repleCounting);
        }

        //각페이지의 글앞에 출력할 시작번호(예: 총글이 20개일 경우 1페이지는 20,2페이즈는 15..)
        no=totalCount-(pageNum-1)*perPage;


        //request에 저장
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("list", list);

        //페이지 출력에 필요한 모든 변수를 request에 넣는다.
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("no", no);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("naverurl", "https://kr.object.ncloudstorage.com/"+bucketName);
        return "boardpet/boardpetlist";
    }


    // 등록 시작 !!!!
    // boardpetwriteform
    @GetMapping("/boardpetwriteform")
    public String writeForm(
            // 아래 4개의 값은 답글일떄만 넘어온다, 새글일떄는 null값이 넘어오므로
            // require 를 false 로 주거나 defaultValue 를 지정해야한다.

            @RequestParam(value = "idx", defaultValue = "0") int idx,
            @RequestParam(value = "regroup", defaultValue = "0") int regroup,
            @RequestParam(value = "restep", defaultValue = "0") int restep,
            @RequestParam(value = "relevel", defaultValue = "0") int relevel,
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model model) {

        model.addAttribute("idx", idx);
        model.addAttribute("regroup", regroup);
        model.addAttribute("restep", restep);
        model.addAttribute("relevel", relevel);
        model.addAttribute("pageNum", pageNum);

        return "boardpet/boardpetwriteform";
    }



    @GetMapping("/petview")
    public String petview (@RequestParam int idx, @RequestParam(defaultValue = "1") int pageNum, Model model){

        //조회수 1증가
        boardpetService.updateReadCount(idx);
        //idx 에 해당하는 dto 얻기
        BoardPetDto dto = boardpetService.getSelectByIdx(idx);

        //idx 글에 등록된 파일들 가져오기
        List<String> fileList=new Vector<>();

        List<BoardPetFileDto> flist=boardPetFileService.getFiles(idx);
        for(BoardPetFileDto fdto:flist) {
            fileList.add(fdto.getFilename());
        }

        dto.setPhotos(fileList);


        //해당 아이디에 대한 사진을 멤버 테이블에서 얻기
        String memberPhoto=memberPetService.getSelectByMyid(dto.getMyid()).getMphoto();

        //모델에 저장
        model.addAttribute("dto", dto);
        model.addAttribute("memberPhoto", memberPhoto);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("naverurl", "https://kr.object.ncloudstorage.com/"+bucketName);

        return  "boardpet/boardpetdetail";
    }

    //게시글 등록
    @PostMapping("/petinsert")
    public String insertBoardPet(
            @ModelAttribute BoardPetDto dto,
            @RequestParam int pageNum,
            @RequestParam("upload") List<MultipartFile> upload,
            HttpSession session){

        //세션으로 부터 아이디를 얻는다
        String myid=(String)session.getAttribute("loginid");

        //아이디를 이용해서 멤버 테이블에서 작성자를 얻는다(아이디와 작성자는 dto에 넣어야함)
        String writer=memberPetService.getSelectByMyid(myid).getMname();

        //dto에 넣기
        dto.setMyid(myid);
        dto.setWriter(writer);
        //게시판 내용을 일단 db에 저장(idx를 얻어올수 있기떄문에 내용을 db에 저장해야함)
        boardpetService.insertBoardPet(dto);



        //파일이 있는 경우에만 해당, 네이버 스토리지에 저장후 파일저장(idx,filename 필요함)
        //반복문 안에서 이루어져야만한다.
        BoardPetFileDto filedto = new BoardPetFileDto();

        for(MultipartFile file:upload) {
            if (!file.isEmpty()) {
                String filename = storageService.uploadFile(bucketName, "board_pet", file);

                filedto.setBoard_idx(dto.getIdx());
                filedto.setFilename(filename);

                boardPetFileService.insertBoardPetFile(filedto);

            }
        }

        return "redirect:./boardpetlist?pageNum=" + pageNum;
    }
    
    
    //게시글 수정
    @GetMapping("/dictionaryupdate")
    public String updateBoardPet(@RequestParam int idx, @RequestParam int pageNum, Model model) {

        BoardPetDto dto = boardpetService.getSelectByIdx(idx);

        model.addAttribute("dto", dto);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("naverurl", "https://kr.object.ncloudstorage.com/" + bucketName);

        return "boardpet/boardpetupdateform";

    }

    //수정에서 사진 나오게
    // 수정폼에서 기존 사진목록 나타냄
    @GetMapping("/photolist")
    @ResponseBody
    public List<BoardPetFileDto> photoList(@RequestParam int idx) {

        List<BoardPetFileDto> list = boardPetFileService.getFiles(idx);

        return list;

    }

    // 수정폼에서 각각의 사진 삭제시
    @GetMapping("/photodel")
    @ResponseBody
    public void deletePhoto(@RequestParam int idx) {

        // 스토리지에 있는 파일명 얻기
        String filename = boardPetFileService.getFilename(idx);
        // 스토리지 에서 사진 삭제
        storageService.deleteFile(bucketName, "board_pet", filename);

        // 사진삭제
        boardPetFileService.deleteFile(idx);
    }

    //수정 파일
    @PostMapping("/update")
    public String update(@ModelAttribute BoardPetDto dto, @RequestParam int pageNum,
                         @RequestParam("upload") List<MultipartFile> upload) {
        // 제목 및 내용 수정
        boardpetService.updateBoardPet(dto);

        // 사진은 추가
        // 파일이 있는 경우에만 해당, 네이버 스토리지에 저장 후 파일저장(이때 필요한 게 idx, filename)***
        // => 반복문 안에서 이루어져야 함
        if (!upload.get(0).getOriginalFilename().equals("")) {

            for (MultipartFile f : upload) {
                String filename = storageService.uploadFile(bucketName, "board_pet", f);
                BoardPetFileDto bdto = new BoardPetFileDto();
                bdto.setBoard_idx(dto.getIdx());
                bdto.setFilename(filename);

                // boardfile에 insert
                boardPetFileService.insertBoardPetFile(bdto); // 사진은 수정이 아니라 추가이므로 insertBoardFile(dto);
            }
        }

        return "redirect:./petview?idx=" + dto.getIdx() + "&pageNum=" + pageNum;

    }
    
    //게시글삭제
    @GetMapping("/petdelete")
    @ResponseBody
    public void deleteBoardPet(@RequestParam int idx) {

        // idx 에 해당하는 파일들 삭제
        List<BoardPetFileDto> fileList = boardPetFileService.getFiles(idx);
        for (BoardPetFileDto fdto : fileList) {

            String filename = fdto.getFilename();
            storageService.deleteFile(bucketName, "board_pet", filename);
        }

        boardpetService.deleteBoardPet(idx);


    }



    // 좋아요 기능
    @PostMapping("/update-like")
    @ResponseBody
    public void updateLike(@RequestParam int idx) {
        boardpetService.updateBoardLikes(idx);
    }

}
