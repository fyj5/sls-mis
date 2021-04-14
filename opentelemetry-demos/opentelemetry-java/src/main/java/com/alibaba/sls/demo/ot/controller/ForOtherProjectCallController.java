package com.alibaba.sls.demo.ot.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ForOtherProjectCallController {

    @RequestMapping("/service")
    public String forOtherProject() {
        return "Greeting from Java Demo";
    }
}
