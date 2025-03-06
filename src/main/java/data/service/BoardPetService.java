package data.service;

import data.dto.BoardPetDto;
import data.mapper.BoardPetMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class BoardPetService {

    BoardPetMapper boarPetMapper;

    //게시판의 전체 글 개수 조회
    public int getTotalCount() {

        return boarPetMapper.getTotalCount();
    }

    public BoardPetDto getSelectByIdx (int idx){
        return boarPetMapper.getSelectByIdx(idx);
    }

    public void insertBoardPet(BoardPetDto dto) {

        //db insert
        boarPetMapper.insertBoardPet(dto);
    }

    public void updateBoardPet(BoardPetDto dto){
        boarPetMapper.updateBoardPet(dto);
    }

    public void deleteBoardPet(int idx){
        boarPetMapper.deleteBoardPet(idx);
    }
}
