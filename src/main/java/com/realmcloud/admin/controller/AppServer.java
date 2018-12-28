package com.realmcloud.admin.controller;


import com.realmcloud.admin.util.RestResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 */
@Controller
@RequestMapping("/api")
public class AppServer {

    @GetMapping("/test")
    @ResponseBody
    public RestResponse getTagsStatistics() {

        RestResponse.success("成功！");

        return RestResponse.success();

    }
}

