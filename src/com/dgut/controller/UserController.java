package com.dgut.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.dgut.bean.User;
import com.dgut.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class UserController {

	@Autowired
	private UserService service;

	@RequestMapping(value = "myupdate", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String myupdate(User user, HttpSession session) {

		int i = service.updateUser(user);

		if (i == 1) {
			session.setAttribute("user", user);
			return "1";
		}
		return "0";

	}

	@RequestMapping(value = "updatepassword", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String updatepassword(Long id, String oldPassword, String password, HttpSession session) {
		if (id != null) {
			User user = service.findUser(id);
			if (!user.getPassword().equals(oldPassword))
				return "0";
			user.setPassword(password);
			int i = service.updateUser(user);
			if (i == 1) {
				return "1";
			}
		}
		return "0";

	}

	@RequestMapping(value = "update", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String update(User user, HttpSession session) {

		int i = service.updateUser(user);

		if (i == 1) {
			return "1";
		}
		return "0";

	}

	@RequestMapping(value = "adduser", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String adduser(User user, HttpSession session) {

		System.out.println(user);
		int i = service.selectbyusername(user.getUsername());
		int j = 0;
		if (i == 1)
			j = service.adduser(user);

		if (i == 1 && j == 1) {
			return "1";
		}
		return "0";

	}

	@RequestMapping(value = "findusers", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String findusers(int page, int limit) {
		PageHelper.startPage(page, limit);// 分页查询数据
		List<User> data = service.findUsers();
		String datajson = JSON.toJSONString(data);
		PageInfo<User> info = new PageInfo<>(data);// 查询总数
		long total = info.getTotal();
		String json = "{\"code\":0,\"msg\":\"\",\"count\":" + total + ",\"data\":" + datajson + "}";
		return json;
	}

	@RequestMapping("/deleteuser")
	@ResponseBody
	public String deleteuser(int[] userId, Model model) {

		// System.out.println("---334----------->" + couseId.length);
		int i;
		for (int j = 0; j < userId.length; j++) {
			i = service.deleteUser(userId[j]);
			if (i == 0)
				return "0";
		}
		return "1";

	}

	@RequestMapping(value = "queryusers", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String queryusers(User user, int page, int limit) {

		PageHelper.startPage(page, limit);// 分页查询数据
		List<User> data = service.findUserLike(user);
		PageInfo<User> info = new PageInfo<>(data);// 查询总数
		long total = info.getTotal();

		String datajson = JSON.toJSONString(data);
		String json = "{\"code\":0,\"msg\":\"\",\"count\":" + total + ",\"data\":" + datajson + "}";

		return json;

	}

	@RequestMapping(value = "login", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String login(User login_user, HttpSession session) {
		String loginInfo = null;
		List<User> user = service.login(login_user.getUsername());
		if (user.size() != 0) {
			if (login_user.getPassword().equals(user.get(0).getPassword())) {
				String sf = null;
				session.setAttribute("user", user.get(0));
				switch (Integer.parseInt(user.get(0).getIdentity())) {
				case 1:
					sf = "超级管理员";
					break;
				case 2:
					sf = "管理员";
					break;
				case 3:
					sf = "教师";
					break;
				default:
					break;
				}
				loginInfo = "欢迎 " + sf + " " + user.get(0).getName() + " 登入系统！";
				String json = JSON.toJSONString(loginInfo);
				return json;
			} else {
				loginInfo = "用户名或密码错误！";
			}
		} else {
			loginInfo = "用户名或密码错误！";
		}
		// System.out.println(loginInfo);
		// model.addAttribute("loginInfo", loginInfo);
		// String json = "{\"loginInfo\":" + loginInfo + "}";
		String json = JSON.toJSONString(loginInfo);
		// System.out.println(json);
		return json;
	}

	@RequestMapping("/quit")
	public String quit(HttpSession session) {
		session.removeAttribute("user");
		return "/login";
	}

}
