package com.cyanhu.back_end.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cyanhu.back_end.entity.WordData;
import com.cyanhu.back_end.entity.WordExampleSentence;
import com.cyanhu.back_end.entity.WordMeaning;
import com.cyanhu.back_end.entity.WordPronunciation;
import com.cyanhu.back_end.entity.dto.AddedWordDataDTO;
import com.cyanhu.back_end.entity.vo.WordDataVO;
import com.cyanhu.back_end.service.IWordDataService;
import com.cyanhu.back_end.service.IWordExampleSentenceService;
import com.cyanhu.back_end.service.IWordMeaningService;
import com.cyanhu.back_end.service.IWordPronunciationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
public class WordDataController {
    @Autowired
    IWordDataService wordDataService;
    @Autowired
    IWordPronunciationService wordPronunciationService;
    @Autowired
    IWordMeaningService wordMeaningService;
    @Autowired
    IWordExampleSentenceService wordExampleSentenceService;

    @GetMapping("/wordData/{wordId}")
    public Map<String, Object> getWordData(@PathVariable Integer wordId) {
        WordData wordData = wordDataService.getById(wordId);
        if (wordData == null) {
            return Map.of("error_message", "单词不存在");
        }
        WordDataVO wordDataVO = new WordDataVO();
        wordDataVO.setWordId(wordId);
        String word = wordData.getWord();
        wordDataVO.setWord(word);
        List<WordPronunciation> wordPronunciations = wordPronunciationService.list(new QueryWrapper<WordPronunciation>().eq("word_id", wordId));

        for (WordPronunciation wordPronunciation : wordPronunciations) {
            if ("美".equals(wordPronunciation.getType())) {
                wordDataVO.setAmPhoneticSymbol(wordPronunciation.getPhoneticSymbol());
            } else if ("英".equals(wordPronunciation.getType())) {
                wordDataVO.setEnPhoneticSymbol(wordPronunciation.getPhoneticSymbol());
            }
        }
        List<WordExampleSentence> wordExampleSentences = wordExampleSentenceService.list(new QueryWrapper<WordExampleSentence>().eq("word_id", wordId));
        wordDataVO.setExampleSentences(wordExampleSentences);

        List<WordMeaning> wordMeanings = wordMeaningService.list(new QueryWrapper<WordMeaning>().eq("word_id", wordId));
        wordDataVO.setMeanings(wordMeanings);
        return Map.of("error_message", "成功", "data", Map.of("wordData", wordDataVO));


    }
}
