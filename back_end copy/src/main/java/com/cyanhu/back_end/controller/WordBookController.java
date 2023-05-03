package com.cyanhu.back_end.controller;

import com.cyanhu.back_end.mapper.BookWordMapper;
import com.cyanhu.back_end.mapper.WordBookMapper;
import com.cyanhu.back_end.pojo.BookWord;
import com.cyanhu.back_end.pojo.WordBook;
import com.cyanhu.back_end.pojo.dto.AddedWordDataDTO;
import com.cyanhu.back_end.pojo.dto.WordBookDTO;
import com.cyanhu.back_end.service.iter.WordService;
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
    WordService wordService;
    @Autowired
    BookWordMapper bookWordMapper;
    @Autowired
    WordBookMapper wordBookMapper;

    @Transactional
    @PostMapping(value = "/wordBook/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public Map<String, Object>  uploadWordBook(@ModelAttribute  WordBookDTO wbDTO) throws IOException {
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
        wordBookMapper.insert(wordBook);
        Integer bookId = wordBook.getId();
        while ((word=bufferedReader.readLine())!=null){
            word = word.trim();
            try {
                 addedWordDataDTO = wordService.crawlWordData(word, page);
                 if (addedWordDataDTO == null) {
                     nonExistWordList.add(word);
                     continue;
                 }
                 Map<String, Object> map1 = wordService.addWordData(addedWordDataDTO);
                 if (map1.get("error_message") == "单词已存在") existWordList.add(word);
                 Integer wordId = (Integer) ((Map)map1.get("data")).get("wordId");
                 bookWordMapper.insert(new BookWord(null, bookId, wordId));
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
        res.put("error_message", "成功");
        res.put("data", Map.of("exist_list", existWordList, "non-exist_list", nonExistWordList));
        return res;
    }
}
