package com.bungeobbang.app.view.controller;

import com.bungeobbang.app.biz.reply.ReplyDTO;
import com.bungeobbang.app.biz.reply.ReplyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;

@RestController
public class ReplyAsyncController {
    @Autowired
    private ReplyService replyService;

    //댓글 추가
    @RequestMapping("/addReply.do")
    public @ResponseBody boolean addReply(@RequestBody ReplyDTO replyDTO) {
        return replyService.insert(replyDTO);
    }

    //댓글 삭제
    @RequestMapping("/deleteReply.do")
    public @ResponseBody boolean deleteReply(ReplyDTO replyDTO) {
        //작성자 확인 AOP 대상
        return replyService.delete(replyDTO);
    }

    //댓글 리스트
    @RequestMapping("/listReply.do")
    public @ResponseBody ArrayList<ReplyDTO> listReply(@RequestBody ReplyDTO replyDTO) {
        replyDTO.setCondition("ALL_REPLIES");
        return replyService.selectAll(replyDTO);
    }

    //댓글 수정
    //@RequestMapping("/updateReply.do") //구현하지 않음
//    public @ResponseBody String reply(ReplyDTO replyDTO) {
//        //작성자 확인 AOP 대상
//        if(!replyService.update(replyDTO)) {
//            return "false";
//        }
//        return "true";
//    }
}
