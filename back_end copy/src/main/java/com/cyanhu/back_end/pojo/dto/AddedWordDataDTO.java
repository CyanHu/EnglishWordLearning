package com.cyanhu.back_end.pojo.dto;

import com.cyanhu.back_end.pojo.WordExampleSentence;
import com.cyanhu.back_end.pojo.WordMeaning;
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
