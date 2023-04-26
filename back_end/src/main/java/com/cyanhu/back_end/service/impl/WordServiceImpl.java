package com.cyanhu.back_end.service.impl;

import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cyanhu.back_end.mapper.WordDataMapper;
import com.cyanhu.back_end.mapper.WordExampleSentenceMapper;
import com.cyanhu.back_end.mapper.WordMeaningMapper;
import com.cyanhu.back_end.mapper.WordPronunciationMapper;
import com.cyanhu.back_end.pojo.WordData;
import com.cyanhu.back_end.pojo.WordExampleSentence;
import com.cyanhu.back_end.pojo.WordMeaning;
import com.cyanhu.back_end.pojo.WordPronunciation;
import com.cyanhu.back_end.pojo.dto.AddedWordDataDTO;
import com.cyanhu.back_end.service.iter.WordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
public class WordServiceImpl implements WordService {
    @Autowired
    WordDataMapper wordDataMapper;
    @Autowired
    WordExampleSentenceMapper wordExampleSentenceMapper;
    @Autowired
    WordMeaningMapper wordMeaningMapper;
    @Autowired
    WordPronunciationMapper wordPronunciationMapper;

    @Override
    @Transactional
    public Map<String, Object> addWordData(AddedWordDataDTO dataDTO) {

        Map<String, Object> map = new HashMap<>();

        WordData wordData = new WordData(null, dataDTO.getWord());
        QueryWrapper<WordData> wrapper = new QueryWrapper<>();
        wrapper.eq("word", wordData.getWord());
        if (wordDataMapper.selectOne(wrapper) != null) {
            map.put("error_message", "单词已存在");
            map.put("data", Map.of("word", dataDTO.getWord()));
            return map;
        }
        wordDataMapper.insert(wordData);
        Integer wordId = wordData.getId();

        WordPronunciation wordPronunciationEn = new WordPronunciation(null, wordId, "英", dataDTO.getEnPhoneticSymbol());
        WordPronunciation wordPronunciationAM = new WordPronunciation(null, wordId, "美", dataDTO.getAmPhoneticSymbol());

        wordPronunciationMapper.insert(wordPronunciationAM);
        wordPronunciationMapper.insert(wordPronunciationEn);

        for (WordExampleSentence wordExampleSentence : dataDTO.getExampleSentences()) {
            wordExampleSentence.setWordId(wordId);
            wordExampleSentence.setSource("Collins");
            wordExampleSentenceMapper.insert(wordExampleSentence);
        }

        for (WordMeaning wordMeaning : dataDTO.getMeanings()) {
            wordMeaning.setWordId(wordId);
            wordMeaningMapper.insert(wordMeaning);
        }


        map.put("error_message", "成功");
        return map;

    }
}
