package boardpet.controller;

import data.dto.BoardPetDto;
import data.service.BoardPetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/boardpet")
public class BoardPetController {

    @Autowired
    BoardPetService boardService;

// /boardpet/boardpetlist
    @GetMapping("/boardpetlist")
    public String list(
            @RequestParam(value = "pageNum",defaultValue = "1") int pageNum,
                       Model model)
    {

        return "boardpet/boardpetlist";
    }

    @GetMapping("/petview")
    public BoardPetDto getSelectByIdx (@RequestParam int idx){
        return boardService.getSelectByIdx(idx);
    }

    @PostMapping("/petinsert")
    public void insertBoardPet(@ModelAttribute BoardPetDto dto){
        boardService.insertBoardPet(dto);
        // 처리만 하면 끝인건지
    }

    @PostMapping("/petupdate")
    public void updateBoardPet(@ModelAttribute BoardPetDto dto){
        boardService.updateBoardPet(dto);
    }

    @PostMapping("/petdelete")
    public void deleteBoardPet(@RequestParam int idx) {
        boardService.deleteBoardPet(idx);
    }
}
