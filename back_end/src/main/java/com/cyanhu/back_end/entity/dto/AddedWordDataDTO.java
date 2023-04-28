package com.cyanhu.back_end.entity.dto;

import com.cyanhu.back_end.entity.WordExampleSentence;
import com.cyanhu.back_end.entity.WordMeaning;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AddedWordDataDTO {
    String word;
    String enPhoneticSymbol;
    String amPhoneticSymbol;
    List<WordMeaning> meanings;
    List<WordExampleSentence> exampleSentences;
}
