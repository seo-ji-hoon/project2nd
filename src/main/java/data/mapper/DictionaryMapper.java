package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.BoardPetDto;
import data.dto.DictionaryDto;

@Mapper
public interface DictionaryMapper {
	
	public int getTotalCount(); //게시판의 전체 글 개수 조회

    public void insertBoardPet(DictionaryDto dto); //등록

    public void updateBoardPet(DictionaryDto dto);

    public void deleteBoardPet(int idx);

    public void updateReadCount(int idx);

    public List<DictionaryDto> getSelectById(String myid);

    public DictionaryDto getSelectByIdx (int idx);
    
    public List<DictionaryDto> getAllDictionary();
}
