package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.BoardPetRepleDto;

@Mapper
public interface BoardPetRepleMapper {

	public List<BoardPetRepleDto> getSelectById(String myid);

	/*댓글등록*/
	public void insertBoardPetReple(BoardPetRepleDto dto);

	/*댓글순서*/
	public List<BoardPetRepleDto> getboardReplePetByIdx (int idx);

	/*댓글사진*/
	public String getboardPetPhoto (int idx);

	/*댓글수정*/
	public void updateBoardPetReple(BoardPetRepleDto dto);

	/*댓글삭제*/
	public void deleteBoardPetReple(int idx);

}
