package data.mapper;

import data.dto.BoardPetDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardPetMapper {

    public int getTotalCount(); //게시판의 전체 글 개수 조회

    public BoardPetDto getSelectByIdx (int idx);

    public void insertBoardPet(BoardPetDto dto); //등록

    public void updateBoardPet(BoardPetDto dto);

    public void deleteBoardPet(int idx);

    List<BoardPetDto> getPagingList(int startNum, int perPage);
}
