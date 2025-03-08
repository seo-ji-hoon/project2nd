package data.service;

import data.dto.BoardPetDto;
import data.mapper.BoardPetMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class BoardPetService {

    private final BoardPetMapper boardPetMapper;
    BoardPetMapper boarPetMapper;

    //게시판의 전체 글 개수 조회
    public int getTotalCount() {

        return boarPetMapper.getTotalCount();
    }


    public BoardPetDto getSelectByIdx (int idx){
        return boarPetMapper.getSelectByIdx(idx);
    }

    public List<BoardPetDto> getSelectById(String myid){

        return boarPetMapper.getSelectById(myid);
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

    // 페이징과 정렬 처리를 위해 그냥 새로 생성 !! (위에 그냥 getlist 이건 냅둬봐)
    public List<BoardPetDto> getPagingList(int startNum, int perPage) {
        return boarPetMapper.getPagingList(startNum, perPage);
    }

    //조회수
    public void updateReadCount (int idx) {
        boardPetMapper.updateReadCount(idx);
    }

    public void updateBoardLikes(int idx) {
        boardPetMapper.updateBoardLikes(idx);
    }
}
