package com.cyanhu.back_end;

import cn.hutool.core.date.DateTime;
import cn.smallbun.screw.core.Configuration;
import cn.smallbun.screw.core.engine.EngineConfig;
import cn.smallbun.screw.core.engine.EngineFileType;
import cn.smallbun.screw.core.engine.EngineTemplateType;
import cn.smallbun.screw.core.execute.DocumentationExecute;
import cn.smallbun.screw.core.process.ProcessConfig;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.rules.DbColumnType;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import com.baomidou.mybatisplus.generator.fill.Column;
import com.cyanhu.back_end.entity.LearningTimeRecord;
import com.cyanhu.back_end.entity.LearningWord;
import com.cyanhu.back_end.entity.SignInRecord;
import com.cyanhu.back_end.entity.WordBook;
import com.cyanhu.back_end.entity.dto.AddedWordDataDTO;
import com.cyanhu.back_end.service.*;
import com.ruiyun.jvppeteer.core.Puppeteer;
import com.ruiyun.jvppeteer.core.browser.Browser;
import com.ruiyun.jvppeteer.core.page.Page;
import com.ruiyun.jvppeteer.options.LaunchOptions;
import com.ruiyun.jvppeteer.options.LaunchOptionsBuilder;
import com.ruiyun.jvppeteer.options.PDFOptions;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import net.sf.jsqlparser.expression.DateTimeLiteralExpression;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import javax.sql.DataSource;
import java.sql.Types;
import java.util.*;
import java.util.stream.Stream;

@SpringBootTest
class BackEndApplicationTests {

	@Test
	void crawlerTest() {
		try {
			String word = "permission";
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
					builder.addInclude(Collections.emptyList())
							.entityBuilder()
							.enableFileOverride()
							.enableLombok()
							.disableSerialVersionUID()
							.enableChainModel();

				})
				.templateEngine(new FreemarkerTemplateEngine()) // 使用Freemarker引擎模板，默认的是Velocity引擎模板
				.execute();
	}


	@Autowired
	ILearningWordService learningWordService;

	@Test
	void MPlogTest() {
		String level = "easy";
		UpdateWrapper<LearningWord> wrapper = new UpdateWrapper<>();
		wrapper.eq("id", "1");
		if ("easy".equals(level)) {
			wrapper.setSql("`learning_count` = `learning_count` + 1");
		} else if ("medium".equals(level)) {
			wrapper.setSql("SET learning_count = (\n" +
					"\tCASE\n" +
					"\tWHEN learning_count < 2 THEN 0\n" +
					"\tELSE learning_count - 2\n" +
					"\tEND\n" +
					")");
		} else {
			wrapper.set("learning_count", 0);
		}
		learningWordService.update(wrapper);

	}

	@Autowired
	ILearningTimeRecordService learningTimeRecordService;
	@Autowired
	ILearningWordRecordService learningWordRecordService;

	@Test
	void getLearningBriefTest() {
		Long todayTime = learningTimeRecordService.getTodayTimeByUserId(1);
		Long totalTime = learningTimeRecordService.getTotalTimeByUserId(1);
		int todayMinutes = (int) (todayTime / 60);
		int totalMinutes = (int) (totalTime / 60);
		int todayWordCounts = learningWordRecordService.getTodayWordCountsByUserId(1);
		int totalWordCounts = learningWordRecordService.getTotalWordCountsByUserId(1);

		System.out.println(todayMinutes);
		System.out.println(todayWordCounts);
		System.out.println(totalMinutes);
		System.out.println(totalWordCounts);
	}

	@Autowired
	ISignInRecordService signInRecordService;

	@Test
	void isSignInTest() {
		System.out.println(signInRecordService.isSingInByUserId(1));
		System.out.println(signInRecordService.isSingInByUserId(2));
		System.out.println(signInRecordService.count(new QueryWrapper<SignInRecord>().eq("user_id", 1)));
		System.out.println(signInRecordService.count(new QueryWrapper<SignInRecord>().eq("user_id", 2)));

	}

	@Test
	void recentWeekLearningTimeRecordTest() {
		List<Map<String, Object>> mapList = learningTimeRecordService.getRecentWeekTimeByUserId(1);
		List<Map<String, Object>> mapList1 = learningWordRecordService.getRecentWeekWordCountsByUserId(1);

		List<Map<String, Object>> timeList = mapList.stream().map(e -> Map.of("interval", e.get("interval"), "minutes", (int) e.get("sum") / 60)).toList();
		System.out.println(mapList);
		System.out.println(mapList1);
		System.out.println("==========================");
	}

	@Test
	void mapTest() {
		List<String> list = new ArrayList<>();
		list.add("123");
		list.add("456");
		list.add("789");
		List<String> list1 = list.stream().map(e -> e + "123").toList();
		Map<String, Object> map = new HashMap<>();
		map.put("interval", 1);
		map.put("learning_time", 100);
	}

	@Test
	void getLearningBrief1Test() {
		int nonLearningWordCount = learningWordService.getNonLearningWordCount(1, 18);
		long needReviewWordCount = learningWordService.count(new QueryWrapper<LearningWord>().le("next_review_time", DateTime.now()));
		System.out.println(nonLearningWordCount);
		System.out.println(needReviewWordCount);
	}

	@Test
	void ScrewTest() {
		documentGeneration();
	}

	void documentGeneration() {
		//数据源
		HikariConfig hikariConfig = new HikariConfig();
		hikariConfig.setDriverClassName("com.mysql.cj.jdbc.Driver");
		hikariConfig.setJdbcUrl("jdbc:mysql://81.68.190.197:3306/ewl_database?serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=utf-8");
		hikariConfig.setUsername("ewl_user");
		hikariConfig.setPassword("Ccqpalzm001.");
		//设置可以获取tables remarks信息
		hikariConfig.addDataSourceProperty("useInformationSchema", "true");
		hikariConfig.setMinimumIdle(2);
		hikariConfig.setMaximumPoolSize(5);
		DataSource dataSource = new HikariDataSource(hikariConfig);
		//生成配置
		EngineConfig engineConfig = EngineConfig.builder()
				//生成文件路径
				.fileOutputDir("/Users/cc/Desktop")
				//打开目录
				.openOutputDir(true)
				//文件类型
				.fileType(EngineFileType.WORD)
				//生成模板实现
				.produceType(EngineTemplateType.freemarker)
				//自定义文件名称
				.fileName("自定义文件名称").build();

		//忽略表
		ArrayList<String> ignoreTableName = new ArrayList<>();
		ignoreTableName.add("test_user");
		ignoreTableName.add("test_group");
		//忽略表前缀
		ArrayList<String> ignorePrefix = new ArrayList<>();
		ignorePrefix.add("test_");
		//忽略表后缀
		ArrayList<String> ignoreSuffix = new ArrayList<>();
		ignoreSuffix.add("_test");
		ProcessConfig processConfig = ProcessConfig.builder()
				//指定生成逻辑、当存在指定表、指定表前缀、指定表后缀时，将生成指定表，其余表不生成、并跳过忽略表配置
				//根据名称指定表生成
				.designatedTableName(new ArrayList<>())
				//根据表前缀生成
				.designatedTablePrefix(new ArrayList<>())
				//根据表后缀生成
				.designatedTableSuffix(new ArrayList<>())
				//忽略表名
				.ignoreTableName(ignoreTableName)
				//忽略表前缀
				.ignoreTablePrefix(ignorePrefix)
				//忽略表后缀
				.ignoreTableSuffix(ignoreSuffix).build();
		//配置
		Configuration config = Configuration.builder()
				//版本
				.version("1.0.0")
				//描述
				.description("数据库设计文档生成")
				//数据源
				.dataSource(dataSource)
				//生成配置
				.engineConfig(engineConfig)
				//生成配置
				.produceConfig(processConfig)
				.build();
		//执行生成
		new DocumentationExecute(config).execute();
	}


	@Test
	void get10Test() {
		List<Integer> nonLearningWordIdList = learningWordService.getNonLearningWordIdList(1, 18);
	}


	@Test
	void test1() {
		PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		System.out.println(passwordEncoder.encode("pcc"));
	}

}
