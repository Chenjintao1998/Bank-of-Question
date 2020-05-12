package com.dgut.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgut.bean.User;
import com.dgut.bean.UserExample;
import com.dgut.bean.UserExample.Criteria;
import com.dgut.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper mapper;

	private UserExample example = new UserExample();

	@Override
	public List<User> login(String username) {
		// TODO Auto-generated method stub
		example.clear();
		Criteria criteria = example.createCriteria();
		criteria.andUsernameEqualTo(username);
		return mapper.selectByExample(example);
	}

	@Override
	public int selectbyusername(String username) {
		// TODO Auto-generated method stub
		example.clear();
		Criteria criteria = example.createCriteria();
		criteria.andUsernameEqualTo(username);
		if (mapper.selectByExample(example).size() > 0)
			return 0;
		else
			return 1;
	}

	@Override
	public int adduser(User user) {
		// TODO Auto-generated method stub
		return mapper.insert(user);
	}

	@Override
	public List<User> findUsers() {
		// TODO Auto-generated method stub
		example.clear();
		return mapper.selectByExample(example);
	}

	@Override
	public List<User> findUserLike(User user) {
		// TODO Auto-generated method stub
		example.clear();
		Criteria criteria = example.createCriteria();
		if (user.getUserId() != null) {
			criteria.andUserIdEqualTo(user.getUserId());

		}
		if (user.getEmail() != null && user.getEmail() != "") {
			criteria.andEmailLike("%" + user.getEmail() + "%");

		}
		if (user.getPhone() != null && user.getPhone() != "") {
			criteria.andPhoneLike("%" + user.getPhone() + "%");
			System.out.println("1试试");
		}
		if (user.getName() != null && user.getName() != "") {
			criteria.andNameLike("%" + user.getName() + "%");

		}
		if (user.getSex() != null) {
			criteria.andSexEqualTo(user.getSex());

		}
		if (user.getIdentity() != null && user.getIdentity() != "") {
			criteria.andIdentityEqualTo(user.getIdentity());

		}

		return mapper.selectByExample(example);
	}

	@Override
	public int deleteUser(int userId) {
		// TODO Auto-generated method stub
		Long id = new Long((long) userId);
		return mapper.deleteByPrimaryKey(id);
	}

	@Override
	public User findUser(Long id) {
		// TODO Auto-generated method stub
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateUser(User user) {
		// TODO Auto-generated method stub
		return mapper.updateByPrimaryKey(user);
	}

}