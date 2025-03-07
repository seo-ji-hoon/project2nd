package data.service;

import java.util.List;

import org.springframework.stereotype.Service;

import data.dto.BoardPetRepleDto;
import data.mapper.BoardPetRepleMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BoardPetRepleService {
	
	BoardPetRepleMapper boardPetRepleMapper;
	
	//마이페이지에서 내가 쓴 댓글 노출 용도
	public List<BoardPetRepleDto> getSelectRepleById(String myid)
	{
		return boardPetRepleMapper.getSelectRepleById(myid);
	}
	
	
}
