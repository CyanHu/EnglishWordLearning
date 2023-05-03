package com.cyanhu.back_end;

import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.rules.DbColumnType;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import com.baomidou.mybatisplus.generator.fill.Column;
import com.cyanhu.back_end.pojo.dto.AddedWordDataDTO;
import com.ruiyun.jvppeteer.core.Puppeteer;
import com.ruiyun.jvppeteer.core.browser.Browser;
import com.ruiyun.jvppeteer.core.page.Page;
import com.ruiyun.jvppeteer.options.LaunchOptions;
import com.ruiyun.jvppeteer.options.LaunchOptionsBuilder;
import com.ruiyun.jvppeteer.options.PDFOptions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.sql.Types;
import java.util.*;

@SpringBootTest
class BackEndApplicationTests {

	@Test
	void crawlerTest() {
		try {
			String word = "phone";
			//自动下载，第一次下载后不会再下载
			ArrayList<String> arrayList = new ArrayList<>();
			//生成pdf必须在无厘头模式下才能生效
			LaunchOptions options = new LaunchOptionsBuilder().withArgs(arrayList).withHeadless(true).withExecutablePath("/Applications/Google Chrome.app/Contents/MacOS/Google Chrome").build();
			arrayList.add("--no-sandbox");
			arrayList.add("--disable-setuid-sandbox");
			Browser browser = Puppeteer.launch(options);
			Page page = browser.newPage();


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

			AddedWordDataDTO dto = JSON.parseObject(res.get("data").toString(), AddedWordDataDTO.class);
			System.out.println(dto);
			page.close();
			browser.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	@Test
	void mybatisPlusGeneratorTest() {
		FastAutoGenerator.create("jdbc:mysql://81.68.190.197:3306/ewl_database?serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=utf-8", "ewl_user", "Ccqpalzm001.")
				.globalConfig(builder -> {
					builder.author("cyanhu") // 设置作者
//							.enableSwagger() // 开启 swagger 模式
							.fileOverride() // 覆盖已生成文件
							.outputDir("/tmp/mpg"); // 指定输出目录
				})
				.dataSourceConfig(builder -> builder.typeConvertHandler((globalConfig, typeRegistry, metaInfo) -> {
					int typeCode = metaInfo.getJdbcType().TYPE_CODE;
					if (typeCode == Types.SMALLINT) {
						// 自定义类型转换
						return DbColumnType.INTEGER;
					}
					return typeRegistry.getColumnType(metaInfo);

				}))
				.packageConfig(builder -> {
					builder.parent("com.cyanhu.back_end") // 设置父包名
							.pathInfo(Collections.singletonMap(OutputFile.xml, "/tmp/mpg/mapper")); // 设置mapperXml生成路径
				})
				.strategyConfig(builder -> {
					builder.addInclude(Collections.emptyList());
				})
				.templateEngine(new FreemarkerTemplateEngine()) // 使用Freemarker引擎模板，默认的是Velocity引擎模板
				.execute();
	}

	@Test
	void test1() {
		PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		System.out.println(passwordEncoder.encode("pcc"));
	}

}
