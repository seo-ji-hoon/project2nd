package data.mapper;

import data.dto.BoardPetFileDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardPetFileMapper {

    public void insertBoardPetFile(BoardPetFileDto dto);
    public List<BoardPetFileDto> getFiles (int idx);
    public void deleteFile(int num);
    public String getFilename(int num);
}
