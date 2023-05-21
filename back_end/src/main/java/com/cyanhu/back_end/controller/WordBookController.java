package com.cyanhu.back_end.controller;

import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
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
    @Autowired
    IUserService userService;

    @Transactional
    @PostMapping(value = "/wordBook/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public Map<String, Object>  uploadWordBook(@ModelAttribute WordBookDTO wbDTO) throws IOException {

        //判断类型的正确性和用户是否存在
        if (Objects.equals(wbDTO.getBookType(), "用户") && wbDTO.getUserId() == null) return Map.of("error_message","用户单词书没有用户id");
        if (wbDTO.getBookType().equals("用户")) {
            User user = userService.getById(wbDTO.getUserId());
            if (user == null) {
                return Map.of("error_message"," 该用户不存在");
            }
        }


        //爬虫启动
        ArrayList<String> arrayList = new ArrayList<>();
        LaunchOptions options = new LaunchOptionsBuilder().withArgs(arrayList).withHeadless(true).withExecutablePath("/Applications/Google Chrome.app/Contents/MacOS/Google Chrome").build();
        arrayList.add("--no-sandbox");
        arrayList.add("--disable-setuid-sandbox");
        Browser browser = Puppeteer.launch(options);
        Page page = browser.newPage();


        AddedWordDataDTO addedWordDataDTO;
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(wbDTO.getBookFile().getInputStream()));
        String word;
        Map<String, Object> res = new HashMap<>();
        List<String> nonExistWordList = new ArrayList<>();
        WordBook wordBook = new WordBook();
        wordBook.setBookDescription(wbDTO.getBookDescription());
        wordBook.setBookType(wbDTO.getBookType());
        wordBook.setBookTitle(wbDTO.getBookTitle());
        wordBook.setUserId(wbDTO.getUserId());
        WordBook wordBook1;

        //判断单词书是否存在，如果存在则返回错误信息
        if ("系统".equals(wbDTO.getBookType())) {
            wordBook1 = wordBookService.getOne(new QueryWrapper<WordBook>().eq("book_title", wbDTO.getBookTitle()).eq("book_type", wbDTO.getBookType()));
        } else if ("用户".equals(wbDTO.getBookType()))  {
            wordBook1 = wordBookService.getOne(new QueryWrapper<WordBook>().eq("book_title", wbDTO.getBookTitle()).eq("book_type", wbDTO.getBookType()).eq("user_id", wbDTO.getUserId()));
        } else {
            return Map.of("error_message", "bookType 类型错误");
        }
        if (wordBook1 != null) return Map.of("error_message","该单词书已存在");
        wordBookService.save(wordBook);


        Integer bookId = wordBook.getId();
        while ((word=bufferedReader.readLine())!=null){
            word = word.trim();
            WordData wordData = wordDataService.getOne(new QueryWrapper<WordData>().eq("word", word));
            if (wordData != null) {
                //添加单词到单词书中
                bookWordService.save(new BookWord().setBookId(bookId).setWordId(wordData.getId()));
                continue;
            }
            try {
                //调用爬虫来获取单词数据
                 addedWordDataDTO = crawlWordData(word, page);
                 if (addedWordDataDTO == null) {
                     nonExistWordList.add(word);
                     continue;
                 }
                 //添加单词数据到数据库中
                 Integer wordId = addWordData(addedWordDataDTO);;

                 //添加单词到单词书中
                 bookWordService.save(new BookWord().setBookId(bookId).setWordId(wordId));
            } catch (InterruptedException e) {
                System.out.println("出问题的单词:" + word);
                throw new RuntimeException(e);
            }
        }
        browser.close();
        res.put("error_message", "成功");
        res.put("data", Map.of("non-exist_list", nonExistWordList));
        return res;
    }

    @Transactional
    @PostMapping(value = "/wordBook/delete/{bookId}")
    public Map<String, Object>  deleteWordBook(@PathVariable Integer bookId) {

        bookWordService.remove(new QueryWrapper<BookWord>().eq("book_id", bookId));
        wordBookService.removeById(bookId);

        return Map.of("error_message", "删除成功");

    }

    @Transactional
    @PostMapping(value = "/wordBook/update")
    public Map<String, Object>  updateWordBook(@RequestBody WordBook wordBook) {
        wordBookService.updateById(wordBook);
        return Map.of("error_message", "更新成功");
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
    public int addWordData(AddedWordDataDTO dataDTO) {
        String word = dataDTO.getWord();

        Map<String, Object> map = new HashMap<>();

        WordData wordData;
        wordData = new WordData().setWord(word);
        wordDataService.save(wordData);
        Integer wordId = wordData.getId();

        if (dataDTO.getEnPhoneticSymbol() != null && !dataDTO.getEnPhoneticSymbol().isEmpty()) {
            WordPronunciation wordPronunciationEn = new WordPronunciation().setWordId(wordId).setType("英").setPhoneticSymbol(dataDTO.getEnPhoneticSymbol());
            wordPronunciationService.save(wordPronunciationEn);
        }

        if (dataDTO.getAmPhoneticSymbol() != null && !dataDTO.getAmPhoneticSymbol().isEmpty()) {
            WordPronunciation wordPronunciationAm = new WordPronunciation().setWordId(wordId).setType("美").setPhoneticSymbol(dataDTO.getAmPhoneticSymbol());

            wordPronunciationService.save(wordPronunciationAm);
        }


        if (!dataDTO.getExampleSentences().isEmpty()) {
            for (WordExampleSentence wordExampleSentence : dataDTO.getExampleSentences()) {
                if (wordExampleSentence != null) {
                    wordExampleSentence.setWordId(wordId);
                    wordExampleSentence.setSource("Collins");
                    wordExampleSentenceService.save(wordExampleSentence);
                }
            }
        }


        if (!dataDTO.getMeanings().isEmpty()) {
            for (WordMeaning wordMeaning : dataDTO.getMeanings()) {
                if (wordMeaning != null) {
                    wordMeaning.setWordId(wordId);
                    wordMeaningService.save(wordMeaning);
                }
            }
        }
        return wordData.getId();

    }

    @Transactional
    @PostMapping("/wordBook/rawBook/{userId}/{word}")
    public Map<String, Object> addWordToRawBook (@PathVariable String word, @PathVariable Integer userId) throws IOException {

        //用户不存在则返回错误信息
        User user = userService.getById(userId);
        if (user == null) {
            return Map.of("error_message", "用户不存在");
        }
        WordBook rawWordBook = wordBookService.getOne(new QueryWrapper<WordBook>().eq("user_id", userId).eq("book_title", "生词本"));

        //用户没有创建生词本则先新建
        if (rawWordBook == null) {
            rawWordBook = new WordBook();
            rawWordBook.setUserId(userId).setBookTitle("生词本").setBookDescription("这是生词本").setBookType("用户");
            wordBookService.save(rawWordBook);
        }


        WordData wordData = wordDataService.getOne(new QueryWrapper<WordData>().eq("word", word));

        //数据库中有生词对应的数据，则只用将生词添加到生词本中即可
        if (wordData != null) {
            BookWord bookWord = bookWordService.getOne(new QueryWrapper<BookWord>().eq("word_id", wordData.getId()).eq("book_id", rawWordBook.getId()));
            if (bookWord != null) {
                return Map.of("error_message", "单词已添加");
            } else {
                bookWordService.save(new BookWord().setBookId(rawWordBook.getId()).setWordId(wordData.getId()));
                return Map.of("error_message", "成功");
            }
        }

        //数据库中没有生词对应的数据，则需要调取爬虫来获取数据保存到数据库中
        ArrayList<String> arrayList = new ArrayList<>();
        LaunchOptions options = new LaunchOptionsBuilder().withArgs(arrayList).withHeadless(true).withExecutablePath("/Applications/Google Chrome.app/Contents/MacOS/Google Chrome").build();
        arrayList.add("--no-sandbox");
        arrayList.add("--disable-setuid-sandbox");
        Browser browser = Puppeteer.launch(options);
        Page page = browser.newPage();
        AddedWordDataDTO addedWordDataDTO;
        int wordId;


        try {
            addedWordDataDTO = crawlWordData(word, page);
            if (addedWordDataDTO == null) {
                return Map.of("error_message", "单词不存在");
            }
            wordId = addWordData(addedWordDataDTO);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }

        bookWordService.save(new BookWord().setBookId(rawWordBook.getId()).setWordId(wordId));

        browser.close();

        return Map.of("error_message", "成功");

    }
    @Autowired
    IUserSelectedBookService userSelectedBookService;
    @GetMapping("/wordBook/selected/{userId}")
    public Map<String, Object> getSelectedWordBook(@PathVariable Integer userId) {
        UserSelectedBook userSelectedBook = userSelectedBookService.getOne(new QueryWrapper<UserSelectedBook>().eq("user_id", userId));
        if (userSelectedBook == null) {
            return Map.of("error_message", "该用户未选择单词书");
        }
        WordBook wordBook = wordBookService.getById(userSelectedBook.getBookId());
        return Map.of("error_message", "成功", "data", Map.of("selectedWordBook", wordBook));
    }
    @GetMapping("/wordBook/user/{userId}")
    public Map<String, Object> getUserWordBook(@PathVariable Integer userId) {
        List<WordBook> wordBookList = wordBookService.list(new QueryWrapper<WordBook>().eq("user_id", userId));
        return Map.of("error_message", "成功", "data", Map.of("userWordBookList", wordBookList));
    }

    @GetMapping("/wordBook/system")
    public Map<String, Object> getSystemWordBook() {
        List<WordBook> wordBookList = wordBookService.list(new QueryWrapper<WordBook>().eq("book_type", "系统"));
        return Map.of("error_message", "成功", "data", Map.of("systemWordBookList", wordBookList));
    }


    @PostMapping("/wordBook/selected/update/{userId}/{bookId}")
    public Map<String, Object> updateSelectedWordBook(@PathVariable Integer bookId, @PathVariable Integer userId) {
        UserSelectedBook userSelectedBook = new UserSelectedBook();
        userSelectedBook.setBookId(bookId).setUserId(userId);
        UpdateWrapper<UserSelectedBook> wrapper = new UpdateWrapper<UserSelectedBook>().eq("user_id", userId).set("book_id", bookId);
        userSelectedBookService.saveOrUpdate(userSelectedBook, wrapper);
        return Map.of("error_message", "成功");
    }

    @GetMapping("/wordBook/{bookId}")
    public Map<String, Object> getBookWordList(@PathVariable Integer bookId) {
        List<String> bookWordList = wordBookService.getBookWordList(bookId);
        return Map.of("error_message", "成功", "data", Map.of("bookWordList", bookWordList));
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
