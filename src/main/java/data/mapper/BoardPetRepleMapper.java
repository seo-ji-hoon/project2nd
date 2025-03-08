package data.mapper;

import data.dto.BoardPetRepleDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardPetRepleMapper {

	public List<BoardPetRepleDto> getSelectRepleById(String myid);

	/*댓글등록*/
	public void insertBoardPetReple(BoardPetRepleDto dto);

	/*댓글순서*/
	public List<BoardPetRepleDto> getboardReplePetByIdx (int idx);

	/*댓글사진*/
	public String getboardPetPhoto (int idx);

	/*댓글수정*/
	public void updateBoardPetReple(BoardPetRepleDto dto);

	/*댓글삭제*/
	public void deleteBoardReple(int idx);

}
