package com.cyanhu.back_end.entity.vo;

import com.cyanhu.back_end.entity.WordExampleSentence;
import com.cyanhu.back_end.entity.WordMeaning;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
public class WordDataVO {
    Integer wordId;
    String word;
    String enPhoneticSymbol;
    String amPhoneticSymbol;
    List<WordMeaning> meanings;
    List<WordExampleSentence> exampleSentences;
}
