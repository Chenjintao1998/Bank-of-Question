package com.dgut.bean;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class FreemarkerWordUtils {
	HttpServletRequest request;
	private Logger log = LoggerFactory.getLogger(FreemarkerWordUtils.class);
	private Configuration configuration;
	private static final String ENCODING = "UTF-8";
	/** word模板存放的目录 */
	private static final String MODEL_FILE = "/com/dgut/template";
	/** 模板文件，不需要添加目录，只需文件名 */
	private String modelFileName;
	/** 生成的目标路径 */
	// private String filePath = request.getServletContext().getRealPath("/paper/");
	/** 生成的目标文件名 */
	private String fileName;
	/** 需替换的数据Map */
	private Map dataMap;

	/**
	 * 构造函数
	 * 
	 * @param modelFileName 模板文件名（不用带目录）
	 * @param descFileName  生成word文件地址
	 * @param dataMap       文件数据
	 */
	public FreemarkerWordUtils(String modelFileName, String fileName, Map dataMap) {
		configuration = new Configuration();
		configuration.setDefaultEncoding(ENCODING);
		try {
			// 为了使freemarker可以使用key为非字符串的map
			configuration.setSetting("object_wrapper", "freemarker.ext.beans.BeansWrapper");
		} catch (TemplateException e) {
			log.error("导出word出错：", e);
		}
		this.modelFileName = modelFileName;
		this.fileName = fileName;
		this.dataMap = dataMap;
	}

	/**
	 * 创建word文件
	 * 
	 * @return
	 */
	public File createDoc() {
		if (modelFileName == null || fileName == null) {
			return null;
		}
		// 设置模本装置方法和路径,FreeMarker支持多种模板装载方法。可以重servlet，classpath，数据库装载，
		// 这里我们的模板是放在com.gjtc.template包下面
		configuration.setClassForTemplateLoading(this.getClass(), MODEL_FILE);
		// 需要装载的模板
		Template template = null;
		try {
			template = configuration.getTemplate(modelFileName);
			template.setEncoding(ENCODING);
		} catch (IOException e) {
			log.error("获取word模版出错：", e);
		}
		int endIndex = fileName.lastIndexOf(File.separator);
		String fileDir = fileName.substring(0, endIndex);
		File dir = new File(fileDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		File resultFile = new File(fileName);
		Writer out = null;
		try {
			out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(resultFile), ENCODING));
		} catch (Exception e) {
			log.error("导出word出错：", e);
		}
		try {
			template.process(dataMap, out);
		} catch (Exception e) {
			log.error("导出word模版出错：", e);
		} finally {
			try {
				if (out != null) {
					out.flush();
					out.close();
				}
			} catch (IOException e) {
				log.error("", e);
			}
		}
		return resultFile;
	}
}
