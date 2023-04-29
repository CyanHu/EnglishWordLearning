package com.cyanhu.back_end.entity.dto;

import com.cyanhu.back_end.entity.WordExampleSentence;
import com.cyanhu.back_end.entity.WordMeaning;
import lombok.*;
import lombok.experimental.Accessors;

import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
public class AddedWordDataDTO {
    String word;
    String enPhoneticSymbol;
    String amPhoneticSymbol;
    List<WordMeaning> meanings;
    List<WordExampleSentence> exampleSentences;
}
