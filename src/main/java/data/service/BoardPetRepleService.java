package data.service;

import data.dto.BoardPetRepleDto;
import data.dto.DictionaryRepleDto;
import data.mapper.BoardPetRepleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardPetRepleService {
	@Autowired
	BoardPetRepleMapper boardPetRepleMapper;
	
	/*마이페이지 아이디연결*/
	public List<BoardPetRepleDto> getSelectRepleById(String myid)
	{
		return boardPetRepleMapper.getSelectRepleById(myid);
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
		boardPetRepleMapper.deleteBoardReple(idx);
	}


}
