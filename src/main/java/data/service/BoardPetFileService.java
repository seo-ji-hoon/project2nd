package data.service;

import data.dto.BoardPetFileDto;
import data.mapper.BoardPetFileMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class BoardPetFileService {

    BoardPetFileMapper boardPetFileMapper;

    public void insertBoardPetFile(BoardPetFileDto dto) {
        boardPetFileMapper.insertBoardPetFile(dto);
    }

    public List<BoardPetFileDto> getFiles (int idx){
        return boardPetFileMapper.getFiles(idx);
    }

    public void deleteFile(int num) {

        boardPetFileMapper.deleteFile(num);

    }

    public String getFilename(int num) {

        return boardPetFileMapper.getFilename(num);
    }
}
