package com.dgut.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dgut.bean.User;

@Service
public interface UserService {
	List<User> login(String username);

	int selectbyusername(String username);

	// int selectbyemail(String email);
	int adduser(User user);

	List<User> findUsers();

	List<User> findUserLike(User user);

	int deleteUser(int userId);

	User findUser(Long id);

	int updateUser(User user);

}
