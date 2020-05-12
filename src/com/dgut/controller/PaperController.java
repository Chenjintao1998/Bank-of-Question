package com.dgut.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.dgut.bean.FreemarkerWordUtils;
import com.dgut.bean.Paper;
import com.dgut.bean.Question;
import com.dgut.bean.Questiontype;
import com.dgut.service.PaperService;
import com.dgut.service.QuestionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import sun.misc.BASE64Encoder;

@Controller
public class PaperController {

	@Autowired
	private PaperService paperService;

	@Autowired
	private QuestionService questionService;

	@RequestMapping(value = "findpapers", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String findpapers(int page, int limit) {
		PageHelper.startPage(page, limit);// 分页查询数据
		List<Paper> data = paperService.paper_findall();
		String datajson = JSON.toJSONString(data);
		PageInfo<Paper> info = new PageInfo<>(data);// 查询总数
		long total = info.getTotal();
		String json = "{\"code\":0,\"msg\":\"\",\"count\":" + total + ",\"data\":" + datajson + "}";
		return json;
	}

	public String getImageStr(String imgFile) {
		InputStream in = null;
		byte[] data = null;
		try {
			in = new FileInputStream(imgFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		try {
			data = new byte[in.available()];
			// 注：FileInputStream.available()方法可以从输入流中阻断由下一个方法调用这个输入流中读取的剩余字节数
			in.read(data);
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(data);

	}

	@RequestMapping(value = "paperstatus", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String paperstatus(Long id, int status) {

		Paper paper = paperService.findbyid(id);
		paper.setState(status);
		int i = paperService.updatepaper(paper);
		if (i == 1)
			return "1";
		else
			return "0";
	}

	@RequestMapping(value = "paperdelectbyid", produces = "application/json;charset=utf-8")
	@ResponseBody
	public void paperdelectbyid(HttpServletRequest requests, Long paperId, Model model) {

		Paper paper = paperService.findbyid(paperId);
		if (paper != null) {
			String[] paperurl = new String[1];
			paperurl[0] = paper.getPaperurl();
			String[] answerurl = new String[1];
			answerurl[0] = paper.getAnswerurl();
			int[] Id = new int[1];
			Id[0] = paperId.intValue();
			deletepaper(requests, Id, answerurl, paperurl, model);
		}

	}

	@RequestMapping(value = "querypapers", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String querypapers(String start_time, String end_time, Paper paper, int page, int limit) {

		String[] knowledge1 = paper.getKnowledgeId().split(",");
		ArrayList<String> knowledge = new ArrayList<String>();
		if (end_time != null && end_time != "")
			end_time = end_time + " 23:59:59";

		paper.setPaperName("%" + paper.getPaperName() + "%");
		if (knowledge1[0] != "")
			for (int i = 0; i < knowledge1.length; i++) {
				knowledge.add(knowledge1[i]);
			}
		PageHelper.startPage(page, limit);// 分页查询数据
		List<Paper> data = paperService.paper_query(start_time, end_time, paper, knowledge);
		PageInfo<Paper> info = new PageInfo<>(data);// 查询总数
		long total = info.getTotal();

		String datajson = JSON.toJSONString(data);
		String json = "{\"code\":0,\"msg\":\"\",\"count\":" + total + ",\"data\":" + datajson + "}";

		return json;

	}

	@RequestMapping(value = "extracting", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String extracting(String a_qid, String founder, HttpServletRequest request, String start_time,
			String end_time, String semester, String type, String courseId, String numberstring,
			String difficultystring, String qtypestring, String scorestring, String paperName, String remake,
			String totalscore, String knowledge, String qtypename) {

		if (type.equals("A")) {
			String[] know = knowledge.split("/");
			String[] numb = numberstring.split("/");
			String[] qtype = qtypestring.split("/");
			String[] dif = difficultystring.split("/");
			String qidstring = "";
			for (int i = 0; i < qtype.length; i++) {

				List<Question> questions = questionService.extractingquestion(qtype[i], dif[i], know[i]);
				if (questions.size() < Integer.parseInt(numb[i])) {
					return "{\"id\":0,\"state\":0}";
				}
				questions = getRandomList(questions, Integer.parseInt(numb[i]));
				System.out.println(questions.toString());
				for (int j = 0; j < questions.size(); j++) {
					if (i == 0 && j == 0) {
						qidstring = String.valueOf(questions.get(j).getQid());

					} else {
						if (i != 0 && j == 0) {
							qidstring += questions.get(j).getQid();
						} else {
							qidstring += "," + questions.get(j).getQid();
						}
					}
				}

				if (i != qtype.length - 1)
					qidstring += "/";
			}
			List<String> list = removal(qtypename, qidstring, scorestring);
			qtypename = list.get(0);
			qidstring = list.get(1);
			scorestring = list.get(2);

			String idString = addpaper(request, founder, start_time, end_time, semester, type, qidstring, qtypename,
					scorestring, paperName, remake, totalscore);
			String[] qid = qidstring.split("/");
			String string = null;
			for (int i = 0; i < qid.length; i++) {
				if (i == 0)
					string = qid[i];
				else
					string += "," + qid[i];
			}
			Object succesResponse = JSON.parse(idString); // 先转换成Object
			Map map = (Map) succesResponse; // Object强转换为Map
			String json = "{\"id\":" + map.get("id") + ",\"state\":1,\"qid\":\"" + string + "\"}";
			System.out.println(string);
			return json;

		} else {

			String[] qid;
			String[] know;
			String[] numb;
			String[] qtype;
			String[] dif;
			String qidstring;
			int number = 0;
			while (true) {
				number++;
				qid = a_qid.split(",");
				know = knowledge.split("/");
				numb = numberstring.split("/");
				qtype = qtypestring.split("/");
				dif = difficultystring.split("/");
				qidstring = "";
				int count = 0;
				int flag = 0;
				for (int i = 0; i < qtype.length; i++) {

					List<Question> questions = questionService.extractingquestion(qtype[i], dif[i], know[i]);
					if (questions.size() < Integer.parseInt(numb[i])) {
						return "0";
					}
					questions = getRandomList(questions, Integer.parseInt(numb[i]));

					for (int j = 0; j < questions.size(); j++) {
						if (i == 0 && j == 0) {
							qidstring = String.valueOf(questions.get(j).getQid());

						} else {
							if (i != 0 && j == 0) {
								qidstring += questions.get(j).getQid();
							} else {
								qidstring += "," + questions.get(j).getQid();
							}
						}
					}

					if (i != qtype.length - 1)
						qidstring += "/";
				}
				String[] b_qid = qidstring.replaceAll("/", ",").split(",");
				for (int i = 0; i < b_qid.length; i++) {
					if (Arrays.asList(qid).contains(b_qid[i]))
						count++;
				}

				float bfb = (float) count / (float) b_qid.length;
				System.out.println(bfb);
				System.out.println(number);
				if (bfb <= 0.3)
					flag = 1;
				if (flag == 1)
					break;
				if (number > 10) {
					return "{\"id\":0,\"state\":0}";
				}
			}
			List<String> list = removal(qtypename, qidstring, scorestring);
			qtypename = list.get(0);
			qidstring = list.get(1);
			scorestring = list.get(2);

			addpaper(request, founder, start_time, end_time, semester, type, qidstring, qtypename, scorestring,
					paperName, remake, totalscore);
			return "{\"id\":0,\"state\":1}";
		}
	}

	public static List<String> removal(String qtypename, String qidstring, String scorestring) {// 同题型合并

		List<String> list = new ArrayList<String>();
		String[] qid = qidstring.split("/");
		String[] qtype = qtypename.split("/");
		String[] score = scorestring.split("/");

		String new_qtype = "";
		String new_qid = "";
		String new_score = "";
		// int j = 0;
		for (int i = 0; i < qtype.length; i++) {
			for (int k = i + 1; k < qtype.length; k++) {
				if (qtype[i] != "" && qtype[k] != "" && qtype[i].equals(qtype[k])) {
					qtype[k] = "";
					qid[i] += "," + qid[k];
					score[i] = String.valueOf(Integer.parseInt(score[i]) + Integer.parseInt(score[k]));

				}
			}
		}
		for (int i = 0; i < qtype.length; i++) {
			if (qtype[i] != "") {
				if (new_qtype == "") {
					new_qtype = qtype[i];
					new_qid = qid[i];
					new_score = score[i];
				} else {
					new_qtype += "/" + qtype[i];
					new_qid += "/" + qid[i];
					new_score += "/" + score[i];
				}
			}
		}

		list.add(new_qtype);
		list.add(new_qid);
		list.add(new_score);

		return list;

	}

	public static List<Question> getRandomList(List<Question> paramList, int count) {
		if (paramList.size() < count) {
			return paramList;
		}
		Random random = new Random();
		List<Integer> tempList = new ArrayList<Integer>();
		List<Question> newList = new ArrayList<Question>();
		int temp = 0;
		for (int i = 0; i < count; i++) {
			temp = random.nextInt(paramList.size());// 将产生的随机数作为被抽list的索引
			if (!tempList.contains(temp)) {
				tempList.add(temp);
				newList.add(paramList.get(temp));
			} else {
				i--;
			}
		}
		return newList;
	}

	@RequestMapping("/addpaper")
	@ResponseBody
	public String addpaper(HttpServletRequest request, String founder, String start_time, String end_time,
			String semester, String type, String qidstring, String qtypestring, String scorestring, String paperName,
			String remake, String totalscore) {

		String timeString;
		if (semester == null || start_time == null || end_time == null)
			timeString = null;
		else {
			timeString = start_time + "--" + end_time + "学年   第" + semester + "学期";
		}
		String totalqid = qidstring.replace("/", ",");
		String[] qid = qidstring.split("/");
		String[] qtype = qtypestring.split("/");
		String[] score = scorestring.split("/");

		List<Questiontype> questiontypelist = new ArrayList<Questiontype>();
		List<String> prefacelist = new ArrayList<String>();
		String qKid = "";
		for (int i = 0; i < qid.length; i++) {
			prefacelist.add(num2Chinese(i + 1));
			Questiontype questiontype = new Questiontype();
			List<Question> questionlist = new ArrayList<Question>();
			questiontype.setQuestiontypeName(num2Chinese(i + 1) + "、" + qtype[i]);
			questiontype.setScore(Integer.parseInt(score[i]));
			String new_qid[] = qid[i].split(",");

			for (int j = 0; j < new_qid.length; j++) {

				Question question = questionService.question_find(Long.parseLong(new_qid[j]));
				if (j == 0) {
					qKid = question.getKnowledgeId();
				} else
					qKid = qKid + "," + question.getKnowledgeId();

				question.setQuestionimgpathList(getImgSrc(question.getQuestion()));
				question.setQuestion((j + 1) + "、" + question.getQuestion().replaceAll("\\&[a-zA-Z]{1,10};", "")
						.replaceAll("<[^>]*>", "").replaceAll("[(/>)<]", ""));

				if (question.getQuestiontype().getOptions()) {

					question.setSlelectsimgpathList(getImgSrc(question.getSlelects()));
					question.setSlelects(question.getSlelects().replaceAll("\\&[a-zA-Z]{1,10};", "")
							.replaceAll("<[^>]*>", "").replaceAll("[(/>)<]", ""));
					Object succesResponse = JSON.parse(question.getSlelects()); // 先转换成Object
					Map map = (Map) succesResponse; // Object强转换为Map
					int letter = 65;
					question.setSlelectslist(new ArrayList<String>());
					for (int k = 0; k < Integer.parseInt(map.get("total").toString()); k++) {
						question.getSlelectslist()
								.add("" + (char) letter + "、" + map.get("" + (char) letter).toString());
						letter++;
					}
				}
				Object succesResponse = JSON.parse(question.getAnswer()); // 先转换成Object
				Map map = (Map) succesResponse; // Object强转换为Map
				question.setAnswerimgpathList(getImgSrc(map.get("answer").toString()));
				question.setAnswer(map.get("answer").toString().replaceAll("\\&[a-zA-Z]{1,10};", "")
						.replaceAll("<[^>]*>", "").replaceAll("[(/>)<]", ""));
				question.setAnalysisimgpathList(getImgSrc(question.getAnalysis()));
				question.setAnalysis(question.getAnalysis().replaceAll("\\&[a-zA-Z]{1,10};", "")
						.replaceAll("<[^>]*>", "").replaceAll("[(/>)<]", ""));
				question.setAnswer("答案：" + question.getAnswer());
				question.setAnalysis("解析：" + question.getAnalysis());

				if (question.getImagePath() != null && question.getImagePath() != "") {
					try {
						question.setImagePath(getImageStr(
								request.getSession().getServletContext().getRealPath("/") + question.getImagePath()));
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				} else {
					question.setImagePath(null);
				}

				questionlist.add(question);
			}

			questiontype.setQuestionlist(questionlist);
			questiontype.setSinglscore(
					(questiontype.getScore() - questiontype.getScore() % questiontype.getQuestionlist().size())
							/ questiontype.getQuestionlist().size());

			if (questiontype.getScore() % questiontype.getQuestionlist().size() != 0)
				questiontype.setExtrascore(
						questiontype.getSinglscore() + questiontype.getScore() % questiontype.getQuestionlist().size());

			questiontypelist.add(questiontype);
		}
		String[] qKString = array_unique(qKid.split(","));
		String knowledgeId = "";
		for (int k = 0; k < qKString.length; k++) {
			if (k == 0)
				knowledgeId = qKString[k];
			else
				knowledgeId = knowledgeId + "," + qKString[k];
		}

		String modelFileName = "/答案模板.ftl";
		String answerurl = createReport(request, questiontypelist, prefacelist, paperName, modelFileName, timeString,
				type);
		modelFileName = "/试卷模板.ftl";
		String paperurl = createReport(request, questiontypelist, prefacelist, paperName, modelFileName, timeString,
				type);
		Paper paper = new Paper();
		paper.setKnowledgeId(knowledgeId);
		paper.setCreateDate(new Date());
		paper.setPaperName(paperName);
		paper.setRemark(remake);
		String json = "{\"score\":" + totalscore + ",\"totalqid\":" + totalqid + "}";
		paper.setContent(json);
		paper.setFounder(founder);
		paper.setPaperurl(paperurl);
		paper.setAnswerurl(answerurl);
		paper.setYears(timeString);
		paper.setType(type);
		paper.setState(0);
		int i = paperService.paper_add(paper);
		if (i == 1)
			return "{\"id\":" + paper.getPaperId() + ",\"state\":1}";
		else
			return "{\"id\":" + paper.getPaperId() + ",\"state\":0}";

	}

	public static String[] array_unique(String[] ss) {
		// array_unique
		List<String> list = new ArrayList<String>();
		for (String s : ss) {
			if (!list.contains(s)) // 或者list.indexOf(s)!=-1
				list.add(s);
		}
		return list.toArray(new String[list.size()]);
	}

	public static List<String> getImgSrc(String content) {

		List<String> list = new ArrayList<String>();
		// 目前img标签标示有3种表达式
		// <img alt="" src="1.jpg"/> <img alt="" src="1.jpg"></img> <img alt=""
		// src="1.jpg">
		// 开始匹配content中的<img />标签
		Pattern p_img = Pattern.compile("<(img|IMG)(.*?)(/>|></img>|>)");
		Matcher m_img = p_img.matcher(content);
		boolean result_img = m_img.find();
		if (result_img) {
			while (result_img) {
				// 获取到匹配的<img />标签中的内容
				String str_img = m_img.group(2);

				// 开始匹配<img />标签中的src
				Pattern p_src = Pattern.compile("(src|SRC)=(\"|\')(.*?)(\"|\')");
				Matcher m_src = p_src.matcher(str_img);
				if (m_src.find()) {
					String str_src = m_src.group(3);
					list.add(str_src);
				}
				// 结束匹配<img />标签中的src

				// 匹配content中是否存在下一个<img />标签，有则继续以上步骤匹配<img />标签中的src
				result_img = m_img.find();
			}
		}
		return list;
	}

	public static String createReport(HttpServletRequest request, List<Questiontype> questiontypelist,
			List<String> prefacelist, String paperName, String modelFileName, String timeString, String type) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
		String res = sdf.format(new Date());
		// 服务器上使用
		String rootPath = request.getServletContext().getRealPath("/uploads/paper/");// 目录
		// String rootPath = "H:/uploads/paper";
		// 新的文件名称
		String newFileName = null;
		if (type != null && type != "") {
			if (modelFileName.equals("/答案模板.ftl"))
				newFileName = paperName + "(" + type + "卷)" + "_答案_" + res + ".docx";
			else
				newFileName = paperName + "(" + type + "卷)" + "_试卷_" + res + ".docx";
		} else {
			if (modelFileName.equals("/答案模板.ftl"))
				newFileName = paperName + "_答案_" + res + ".docx";
			else
				newFileName = paperName + "_试卷_" + res + ".docx";
		}
		// 创建年月文件夹
		Calendar date = Calendar.getInstance();
		File dateDirs = new File(date.get(Calendar.YEAR) + File.separator + (date.get(Calendar.MONTH) + 1));
		// 新文件
		File newFile = new File(rootPath + File.separator + dateDirs + File.separator + newFileName);
		// 判断目标文件所在的目录是否存在
		if (!newFile.getParentFile().exists()) {
			// 如果目标文件所在的目录不存在，则创建父目录
			newFile.getParentFile().mkdirs();
		}
		// 完整的url
		String fileUrl = "/uploads/paper/" + date.get(Calendar.YEAR) + "/" + (date.get(Calendar.MONTH) + 1) + "/"
				+ newFileName;

		Map<String, Object> dataMap = new HashMap<String, Object>();

		dataMap.put("paperName", paperName);
		dataMap.put("prefacelist", prefacelist);
		dataMap.put("questiontypelist", questiontypelist);
		if (timeString != null && timeString != "")
			dataMap.put("timeString", timeString);

		if (type != null && type != "")
			dataMap.put("type", type);
		String fileName = rootPath + File.separator + dateDirs + File.separator + newFileName;
		FreemarkerWordUtils wordUtils = new FreemarkerWordUtils(modelFileName, fileName, dataMap);
		File file = wordUtils.createDoc();

		return fileUrl;
	}

	public static String num2Chinese(int section) {
		if (section >= 10 && section < 20)
			return "十" + num2Chinese(section % 10);
		String[] chnNumChar = { "零", "一", "二", "三", "四", "五", "六", "七", "八", "九" };
		String[] chnUnitChar = { "", "十", "百", "千" };
		StringBuilder chnStr = new StringBuilder();
		StringBuilder strIns = new StringBuilder();
		int unitPos = 0;
		boolean zero = true;
		while (section > 0) {
			int v = section % 10;
			if (v == 0) {
				if (!zero) {
					zero = true;
					chnStr.append(chnNumChar[v]).append(chnStr);
				}
			} else {
				zero = false;
				strIns.delete(0, strIns.length());
				strIns.append(chnNumChar[v]);
				strIns.append(chnUnitChar[unitPos]);
				chnStr.insert(0, strIns);
			}
			unitPos++;
			section = (int) Math.floor(section / 10f);
		}
		return chnStr.toString();
	}

	@RequestMapping("/deletepaper")
	@ResponseBody
	public String deletepaper(HttpServletRequest requests, int[] paperId, String[] answerurl, String[] paperurl,
			Model model) {

		int i;
		for (int j = 0; j < paperId.length; j++) {
			i = paperService.paper_delete(paperId[j]);

			if (i == 0)
				return "0";
			delFile(requests, answerurl[j]);
			delFile(requests, paperurl[j]);
		}
		return "1";

	}

	public static void delFile(HttpServletRequest request, String filePathAndName) {
		try {
			String filePath = request.getSession().getServletContext().getRealPath("/") + filePathAndName;
			filePath = filePath.toString();
			java.io.File myDelFile = new java.io.File(filePath);
			myDelFile.delete();
		} catch (Exception e) {
			System.out.println("删除文件操作出错");
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "download", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ResponseEntity<byte[]> download(HttpServletRequest request, String path) throws IOException {

		path = request.getSession().getServletContext().getRealPath("/") + java.net.URLDecoder.decode(path, "UTF-8");
		String filename = path.split("/")[path.split("/").length - 1];
		String myFileName = new String(filename.getBytes("utf-8"), "iso-8859-1");

		String string = path;

		HttpHeaders headers = new HttpHeaders();

		headers.setContentDispositionFormData("attachment", myFileName);

		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(new File(string)), headers, HttpStatus.CREATED);

	}

}
