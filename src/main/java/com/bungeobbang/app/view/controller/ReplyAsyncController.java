package com.bungeobbang.app.view.controller;

import com.bungeabbang.app.biz.reply.ReplyDTO;
import com.bungeabbang.app.biz.reply.ReplyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
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
    public @ResponseBody String addReply(HttpSession session, ReplyDTO replyDTO) {
        replyDTO.setMemberNum((int) session.getAttribute("memberPK"));
        if (!replyService.insert(replyDTO)) {
            return "false";
        }
        return "true";
    }

    //댓글 삭제
    @RequestMapping("/deleteReply.do")
    public @ResponseBody String deleteReply(ReplyDTO replyDTO) {
        //작성자 확인 AOP 대상
        if (!replyService.delete(replyDTO)) {
            return "false";
        }
        return "true";
    }

    //댓글 리스트
    @RequestMapping("/listReply.do")
    public @ResponseBody ArrayList<ReplyDTO> listReply(ReplyDTO replyDTO) {
        replyDTO.setCondition("ALL_REPLIES");
        return replyService.selectAll(replyDTO);
    }

    //댓글 수정
    //@RequestMapping("/updateReply.do") //구현하지 않음
    public @ResponseBody String reply(ReplyDTO replyDTO) {
        //작성자 확인 AOP 대상
        if(!replyService.update(replyDTO)) {
            return "false";
        }
        return "true";
    }
}
