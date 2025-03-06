package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.BoardPetRepleDto;

@Mapper
public interface BoardPetRepleMapper {

	public List<BoardPetRepleDto> getSelectById(String myid);
}
