package data.service;

import java.util.List;

import org.springframework.stereotype.Service;

import data.dto.DictionaryDto;
import data.mapper.DictionaryMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class DictionaryService {
	DictionaryMapper dictionaryMapper;
	
	//게시판의 전체 글 개수 조회
    public int getTotalCount() {

        return dictionaryMapper.getTotalCount();
    }

    public DictionaryDto getSelectByIdx (int idx){
        return dictionaryMapper.getSelectByIdx(idx);
    }

    public List<DictionaryDto> getSelectById(String myid){

        return dictionaryMapper.getSelectById(myid);
    }

    public void insertBoardPet(DictionaryDto dto) {

        //db insert
    	dictionaryMapper.insertBoardPet(dto);
    }

    public void updateBoardPet(DictionaryDto dto){
    	dictionaryMapper.updateBoardPet(dto);
    }

    public void deleteBoardPet(int idx){
    	dictionaryMapper.deleteBoardPet(idx);
    }

    //조회수
    public void updateReadCount (int idx) {
    	dictionaryMapper.updateReadCount(idx);
    }
    
    public List<DictionaryDto> getAllDictionary()
    {
    	return dictionaryMapper.getAllDictionary();
    }
}
