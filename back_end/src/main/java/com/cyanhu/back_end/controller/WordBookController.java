package com.cyanhu.back_end.controller;

import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cyanhu.back_end.entity.*;
import com.cyanhu.back_end.entity.dto.AddedWordDataDTO;
import com.cyanhu.back_end.entity.dto.WordBookDTO;
import com.cyanhu.back_end.mapper.*;
import com.cyanhu.back_end.service.*;
import com.ruiyun.jvppeteer.core.Puppeteer;
import com.ruiyun.jvppeteer.core.browser.Browser;
import com.ruiyun.jvppeteer.core.page.Page;
import com.ruiyun.jvppeteer.options.LaunchOptions;
import com.ruiyun.jvppeteer.options.LaunchOptionsBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.*;

@RestController
public class WordBookController {
    @Autowired
    IBookWordService bookWordService;
    @Autowired
    IWordBookService wordBookService;

    @Transactional
    @PostMapping(value = "/wordBook/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public Map<String, Object>  uploadWordBook(@ModelAttribute WordBookDTO wbDTO) throws IOException {
        if (Objects.equals(wbDTO.getBookType(), "用户") && wbDTO.getUserId() == null) return Map.of("error_message","用户单词书没有用户id");
        //自动下载，第一次下载后不会再下载
        ArrayList<String> arrayList = new ArrayList<>();
        //生成pdf必须在无厘头模式下才能生效
        LaunchOptions options = new LaunchOptionsBuilder().withArgs(arrayList).withHeadless(true).withExecutablePath("/Applications/Google Chrome.app/Contents/MacOS/Google Chrome").build();
        arrayList.add("--no-sandbox");
        arrayList.add("--disable-setuid-sandbox");
        Browser browser = Puppeteer.launch(options);
        Page page = browser.newPage();
        AddedWordDataDTO addedWordDataDTO;
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(wbDTO.getBookFile().getInputStream()));
        String word;
        Map<String, Object> res = new HashMap<>();
        List<String> existWordList = new ArrayList<>();
        List<String> nonExistWordList = new ArrayList<>();
        WordBook wordBook = new WordBook();
        wordBook.setBookDescription(wbDTO.getBookDescription());
        wordBook.setBookType(wbDTO.getBookType());
        wordBook.setBookTitle(wbDTO.getBookTitle());
        wordBook.setUserId(wbDTO.getUserId());
        wordBookService.save(wordBook);
        Integer bookId = wordBook.getId();
        while ((word=bufferedReader.readLine())!=null){
            word = word.trim();
            try {
                 addedWordDataDTO = crawlWordData(word, page);
                 if (addedWordDataDTO == null) {
                     nonExistWordList.add(word);
                     continue;
                 }
                 Map<String, Object> map1 = addWordData(addedWordDataDTO);
                 if (map1.get("error_message") == "单词已存在") existWordList.add(word);
                 Integer wordId = (Integer) ((Map)map1.get("data")).get("wordId");
                 bookWordService.save(new BookWord().setBookId(bookId).setWordId(wordId));
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
        res.put("error_message", "成功");
        res.put("data", Map.of("exist_list", existWordList, "non-exist_list", nonExistWordList));
        return res;
    }

    @Autowired
    IWordDataService wordDataService;
    @Autowired
    IWordExampleSentenceService wordExampleSentenceService;
    @Autowired
    IWordMeaningService wordMeaningService;
    @Autowired
    IWordPronunciationService wordPronunciationService;

    @Transactional
    public Map<String, Object> addWordData(AddedWordDataDTO dataDTO) {

        Map<String, Object> map = new HashMap<>();

        WordData wordData = new WordData().setWord(dataDTO.getWord());
        QueryWrapper<WordData> wrapper = new QueryWrapper<>();
        wrapper.eq("word", wordData.getWord());
        wordData = wordDataService.getOne(wrapper);
        if (wordData != null) {
            map.put("error_message", "单词已存在");
            map.put("data", Map.of("word", wordData.getWord(), "wordId", wordData.getId()));
            return map;
        }
        wordDataService.save(wordData);
        Integer wordId = wordData.getId();

        WordPronunciation wordPronunciationEn = new WordPronunciation().setWordId(wordId).setType("英").setPhoneticSymbol(dataDTO.getEnPhoneticSymbol());
        WordPronunciation wordPronunciationAm = new WordPronunciation().setWordId(wordId).setType("美").setPhoneticSymbol(dataDTO.getEnPhoneticSymbol());

        wordPronunciationService.save(wordPronunciationAm);
        wordPronunciationService.save(wordPronunciationEn);

        for (WordExampleSentence wordExampleSentence : dataDTO.getExampleSentences()) {
            wordExampleSentence.setWordId(wordId);
            wordExampleSentence.setSource("Collins");
            wordExampleSentenceService.save(wordExampleSentence);
        }

        for (WordMeaning wordMeaning : dataDTO.getMeanings()) {
            wordMeaning.setWordId(wordId);
            wordMeaningService.save(wordMeaning);
        }


        map.put("error_message", "成功");
        map.put("data", Map.of("word", wordData.getWord(), "wordId", wordData.getId()));
        return map;

    }

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
