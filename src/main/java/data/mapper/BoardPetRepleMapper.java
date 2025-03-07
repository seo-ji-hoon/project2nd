package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.BoardPetRepleDto;

@Mapper
public interface BoardPetRepleMapper {
	
	//마이페이지에서 내가 쓴 댓글 노출 용도
	public List<BoardPetRepleDto> getSelectRepleById(String myid);

}
