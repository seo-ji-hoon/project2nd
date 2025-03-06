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
	
}
