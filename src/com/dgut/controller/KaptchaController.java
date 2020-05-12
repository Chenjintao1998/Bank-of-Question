package com.dgut.controller;

import java.awt.image.BufferedImage;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Producer;

@Controller
public class KaptchaController {
	private Producer kaptchaProducer = null;

	@Autowired
	public void setCaptchaProducer(Producer kaptchaProducer) {
		this.kaptchaProducer = kaptchaProducer;
	}

	@RequestMapping("/kaptcha")
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// System.out.println("ssss");
		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("image/jpeg");
		String capText = kaptchaProducer.createText();
		// 将生产的验证码保存到session域中
		request.getSession().setAttribute("checkcode", capText);
		BufferedImage bi = kaptchaProducer.createImage(capText);
		System.out.println("生成的验证码是：" + capText);
		ServletOutputStream out = response.getOutputStream();
		ImageIO.write(bi, "jpg", out);
		try {
			out.flush();
		} finally {
			out.close();
		}
		return null;
	}

	@RequestMapping("/check")
	@ResponseBody
	public String check(String checkcode, HttpSession session) {
		String string = (String) session.getAttribute("checkcode");
		System.out.println("session中的验证码：" + string);
		System.out.println("checkcode==" + checkcode);

		String checkinfo = "0";
//		比较验证码

		if (checkcode.equalsIgnoreCase(string)) {
			checkinfo = "1";
		}

		return checkinfo;
	}

}
