package data.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("BoardPetFileDto")
public class BoardPetFileDto {

    private int idx;
    private int board_idx;
    private String filename;
}
