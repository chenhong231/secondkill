package com.miaoshaproject.service.impl;

import com.miaoshaproject.dao.UserDOMapper;
import com.miaoshaproject.dao.UserPasswordDOMapper;
import com.miaoshaproject.dataobject.UserDO;
import com.miaoshaproject.dataobject.UserPasswordDO;
import com.miaoshaproject.error.BusinessException;
import com.miaoshaproject.error.EmBusinessError;
import com.miaoshaproject.service.UserService;
import com.miaoshaproject.service.model.UserModel;
import com.miaoshaproject.validator.ValidationResult;
import com.miaoshaproject.validator.ValidatorImpl;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDOMapper userDOMapper;

    @Autowired
    private UserPasswordDOMapper userPasswordDOMapper;

    @Autowired
    private ValidatorImpl validator;

    @Override
    public UserModel getUserById(Integer id) {
        final UserDO userDO = userDOMapper.selectByPrimaryKey(id);
        if(userDO == null) {
            return null;
        }
        final UserPasswordDO userPasswordDO = userPasswordDOMapper.selectByPrimaryKey(userDO.getId());

        return convertFromDataObject(userDO, userPasswordDO);
    }

    @Override
    @Transactional
    public void register(UserModel userModel) throws BusinessException {
        if(userModel == null) {
            throw new BusinessException(EmBusinessError.PARAMETER_VALIDATION_ERROR);
        }

//        if(StringUtils.isEmpty(userModel.getName())
//            || userModel.getGender() == null
//            || userModel.getAge() == null
//            || StringUtils.isEmpty(userModel.getTelphone())) {
//            throw new BusinessException(EmBusinessError.PARAMETER_VALIDATION_ERROR);
//        }

        final ValidationResult result = validator.validate(userModel);

        if(result.isHasErrors()) {
            throw new BusinessException(EmBusinessError.PARAMETER_VALIDATION_ERROR, result.getErrMsg());
        }

        UserDO userDO = convertFromModel(userModel);
        try {
            userDOMapper.insertSelective(userDO);
        } catch (DuplicateKeyException ex) {
            throw new BusinessException(EmBusinessError.PARAMETER_VALIDATION_ERROR, "手机号已重复注册");
        }


        userModel.setId(userDO.getId());

        final UserPasswordDO userPasswordDO = convertPasswordFromModel(userModel);
        userPasswordDOMapper.insertSelective(userPasswordDO);
    }

    private UserPasswordDO convertPasswordFromModel(UserModel userModel) {
        if(userModel == null) {
            return null;
        }

        UserPasswordDO userPasswordDO = new UserPasswordDO();
        userPasswordDO.setEncrptPassword(userModel.getEncrptPassword());
        userPasswordDO.setUserId(userModel.getId());

        return userPasswordDO;
    }

    private UserDO convertFromModel(UserModel userModel) {
        if(userModel == null) {
            return null;
        }

        UserDO userDO = new UserDO();
        BeanUtils.copyProperties(userModel, userDO);
        return userDO;
    }

    private UserModel convertFromDataObject(UserDO userDO, UserPasswordDO userPasswordDO) {
        if(userDO == null) {
            return null;
        }

        UserModel userModel = new UserModel();
        BeanUtils.copyProperties(userDO, userModel);

        if(userPasswordDO != null) {
            userModel.setEncrptPassword(userPasswordDO.getEncrptPassword());
        }

        return userModel;
    }

    @Override
    public UserModel validateLogin(String telphone, String encryptPassword) throws BusinessException {
        final UserDO userDO = userDOMapper.selectByTelphone(telphone);

        if(userDO == null) {
            throw new BusinessException(EmBusinessError.USER_LOGIN_FAIL);
        }

        final UserPasswordDO userPasswordDO = userPasswordDOMapper.selectByUserId(userDO.getId());
        final UserModel userModel = convertFromDataObject(userDO, userPasswordDO);

        if(!StringUtils.equals(encryptPassword, userModel.getEncrptPassword())) {
            throw new BusinessException(EmBusinessError.USER_LOGIN_FAIL);
        }

        return userModel;
    }
}
