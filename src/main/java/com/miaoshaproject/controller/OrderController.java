package com.miaoshaproject.controller;

import com.miaoshaproject.error.BusinessException;
import com.miaoshaproject.error.EmBusinessError;
import com.miaoshaproject.response.CommonReturnType;
import com.miaoshaproject.service.OrderService;
import com.miaoshaproject.service.model.OrderModel;
import com.miaoshaproject.service.model.UserModel;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller("order")
@RequestMapping("/order")
@CrossOrigin(allowCredentials = "true", allowedHeaders = "*")
public class OrderController extends BaseController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private HttpServletRequest httpServletRequest;

    @Autowired
    private RedisTemplate redisTemplate;

    @RequestMapping(value = "/createorder", method = {RequestMethod.POST}, consumes = {CONTENT_TYPE_FORMED})
    @ResponseBody
    public CommonReturnType createOrder(@RequestParam(name="itemId")Integer itemId,
                                        @RequestParam(name="promoId", required = false)Integer promoId,
                                        @RequestParam(name="amount")Integer amount) throws BusinessException {

        //Boolean isLogin = (Boolean) httpServletRequest.getSession().getAttribute("IS_LOGIN");
        String token = httpServletRequest.getParameterMap().get("token")[0];

        if(StringUtils.isEmpty(token)) {
            throw new BusinessException(EmBusinessError.USER_NOT_LOGIN, "用户还未登陆, 不能下单");
        }

        UserModel userModel = (UserModel) redisTemplate.opsForValue().get(token);

        if(userModel == null) {
            throw new BusinessException(EmBusinessError.USER_NOT_LOGIN, "用户还未登陆, 不能下单");
        }

//        if(isLogin == null || !isLogin.booleanValue()) {
//            throw new BusinessException(EmBusinessError.USER_NOT_LOGIN, "用户还未登陆, 不能下单");
//        }

//        UserModel userModel = (UserModel) httpServletRequest.getSession().getAttribute("LOGIN_USER");

        final OrderModel orderModel = orderService.createOrder(userModel.getId(), itemId, promoId, amount);
        return CommonReturnType.create(null);
    }
}
