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
import com.ruiyun.jvppeteer.core.Puppeteer;
import com.ruiyun.jvppeteer.core.browser.Browser;
import com.ruiyun.jvppeteer.core.browser.BrowserFetcher;
import com.ruiyun.jvppeteer.core.page.Page;
import com.ruiyun.jvppeteer.options.LaunchOptions;
import com.ruiyun.jvppeteer.options.LaunchOptionsBuilder;
import com.ruiyun.jvppeteer.options.PDFOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
        wordData = wordDataMapper.selectOne(wrapper);
        if (wordData != null) {
            map.put("error_message", "单词已存在");
            map.put("data", Map.of("word", wordData.getWord(), "wordId", wordData.getId()));
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
        map.put("data", Map.of("word", wordData.getWord(), "wordId", wordData.getId()));
        return map;

    }

    @Override
    public AddedWordDataDTO crawlWordData(String word, Page page) throws InterruptedException {
        page.goTo("http://dict.youdao.com/w/" + word);
        Map<String, Object> res = (Map<String, Object>) page.evaluate("(word) => {\n" +
                "        const data = {\n" +
                "            word: word,\n" +
                "            enPhoneticSymbol: null,\n" +
                "            amPhoneticSymbol: null,\n" +
                "            meanings: null,\n" +
                "            exampleSentences: null\n" +
                "        };\n" +
                "        const symbols = Array.from(document.querySelectorAll('.baav .pronounce .phonetic'), (e) => e.innerText)\n" +
                "        if (symbols.length == 0) {\n" +
                "            return {\n" +
                "                error_message: '单词不存在',\n" +
                "                data: {\n" +
                "                    word: word\n" +
                "                }\n" +
                "            }\n" +
                "        }\n" +
                "        data.enPhoneticSymbol = symbols[0];\n" +
                "        data.amPhoneticSymbol = symbols[1];\n" +
                "        const meanings = Array.from(document.querySelectorAll('#phrsListTab .trans-container ul li'), (e) => e.innerText).filter((e) => e.indexOf('.') != -1)\n" +
                "        data.meanings = Array.from(meanings, (e) => {\n" +
                "            const index = e.indexOf('.');\n" +
                "            return {\n" +
                "                wordType: e.substring(0, index).trim(),\n" +
                "                meaning: e.substring(index + 1).trim().split('；').slice(0, 4).join('；')\n" +
                "            }\n" +
                "        })\n" +
                "        const sentences = Array.from(document.querySelectorAll('#authTransToggle .exampleLists .examples'), (e) => {\n" +
                "            const children = e.children;\n" +
                "            return {\n" +
                "                sentence: children[0].innerText,\n" +
                "                sentenceTranslation: children[1].innerText\n" +
                "            }\n" +
                "        })\n" +
                "        data.exampleSentences = [sentences[0], sentences[1]];\n" +
                "        return {\n" +
                "            error_message: \"成功\",\n" +
                "            data: JSON.stringify(data)\n" +
                "        }\n" +
                "    }", List.of(word));
        if ("单词不存在".equals(res.get("error_message"))) return null;
        return JSON.parseObject(res.get("data").toString(), AddedWordDataDTO.class);
    }


}
