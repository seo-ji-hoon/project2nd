package data.service;

import data.dto.BoardPetDto;
import data.mapper.BoarPetMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class BoardPetService {

    BoarPetMapper boarPetMapper;

    //게시판의 전체 글 개수 조회
    public int getTotalCount() {
        return boarPetMapper.getTotalCount();
    }

    //가장 큰 게시글 번호 조회
    public int getMaxIdx() {
        return boarPetMapper.getMaxIdx();
    }

    public void insertBoard(BoardPetDto dto) {

        int idx=dto.getIdx();



        //db insert
        boarPetMapper.insertBoard(dto);
    }

}
