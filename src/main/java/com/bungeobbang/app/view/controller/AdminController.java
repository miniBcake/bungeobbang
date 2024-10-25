package com.bungeobbang.app.view.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {
    @RequestMapping("/deleteStore.do")
    public String deleteStore(){
        return "";
    }
}
