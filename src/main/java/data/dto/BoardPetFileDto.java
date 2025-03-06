package data.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("BoardPetFileDto")
public class BoardPetFileDto {

    private int num;
    private int idx;
    private String filename;
}
