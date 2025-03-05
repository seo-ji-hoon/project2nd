package data.mapper;

import data.dto.BoardPetDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoarPetMapper {

    public int getTotalCount(); //게시판의 전체 글 개수 조회

    public int getMaxIdx(); //가장 큰 게시글 번호 조회

    public void insertBoard(BoardPetDto dto); //등록


}
