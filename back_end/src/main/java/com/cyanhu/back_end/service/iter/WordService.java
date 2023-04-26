package com.cyanhu.back_end.service.iter;

import com.cyanhu.back_end.pojo.dto.AddedWordDataDTO;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

public interface WordService {
    Map<String, Object> addWordData(AddedWordDataDTO dataDTO);
}
