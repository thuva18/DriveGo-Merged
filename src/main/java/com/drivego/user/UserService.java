package com.drivego.user;

import com.drivego.dto.UserDto;
import com.drivego.entity.Role;
import com.drivego.entity.User;

import java.util.List;

public interface UserService {
    void saveUser(UserDto userDto);
    User findUserByEmail(String email);
    List<UserDto> findAllUsers();
    User findUserById(Integer id);
    void updateUser(Integer id, UserDto userDto);
    void deleteUserById(Integer id);
    void updateUserRoles(Integer userId, List<String> roleNames);
    List<Role> getAllRoles();
}
