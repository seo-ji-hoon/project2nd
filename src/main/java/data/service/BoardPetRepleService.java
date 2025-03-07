package data.service;

import java.util.List;

import org.springframework.stereotype.Service;

import data.dto.BoardPetRepleDto;
import data.mapper.BoardPetRepleMapper;

@Service
public class BoardPetRepleService {
	
	BoardPetRepleMapper boardPetRepleMapper;
	
	public List<BoardPetRepleDto> getSelectById(String myid)
	{
		return boardPetRepleMapper.getSelectById(myid);
	}

	/*댓글등록*/
	public void insertBoardPetReple (BoardPetRepleDto dto) {

		boardPetRepleMapper.insertBoardPetReple(dto);
	}

	/*댓글순서*/
	public List<BoardPetRepleDto> getboardRepleByNum (int idx){

		return boardPetRepleMapper.getboardReplePetByIdx(idx);
	}

	/*댓글사진*/
	public String getboardPetPhoto(int idx) {
		return boardPetRepleMapper.getboardPetPhoto(idx);
	}
	/*댓글수정*/
	public void updateBoardReple(BoardPetRepleDto dto) {
		boardPetRepleMapper.updateBoardPetReple(dto);
	}

	/*댓글삭제*/
	public void deleteBoardReple(int idx) {
		boardPetRepleMapper.deleteBoardPetReple(idx);
	}

}
