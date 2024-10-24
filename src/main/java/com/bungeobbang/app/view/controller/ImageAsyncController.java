package com.bungeobbang.app.view.controller;

import com.bungeobbang.app.biz.imageFile.ImageFileDTO;
import com.bungeobbang.app.view.util.FileUtil;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;

@RestController
@Slf4j
public class ImageAsyncController {

    private String FOLDER_PATH = "uploads/board/"; //webapp기준
    private final String SESSION_IMAGE_SRC = "boardFile";

    @RequestMapping("/addImage.do")
    public @ResponseBody String addImage(HttpSession session, ServletContext servletContext, @RequestBody ImageFileDTO imageFileDTO) {
        //폴더명은 게시글 작성 페이지가 열릴 때 view에 전달
        MultipartFile file = imageFileDTO.getFile();
        String fileName = FileUtil.insertFile(servletContext, FOLDER_PATH+imageFileDTO.getFolder(), file, FileUtil.createFileName());
        if(fileName == null){
            return "false";
        }
        HashMap<String, String> sessionFolder = (HashMap<String, String>) session.getAttribute(SESSION_IMAGE_SRC);
        if(sessionFolder != null) {
            //이미 세션에 저장된 값이 있을 경우 불러와 추가
            sessionFolder.put(fileName, file.getOriginalFilename());
        }
        else{ //만약 세션이 없다면 생성 후 저장
            sessionFolder = new HashMap<>();
            sessionFolder.put(fileName, file.getOriginalFilename()); //새로 만든 이름에 기존 이름
            session.setAttribute(SESSION_IMAGE_SRC, sessionFolder); //세션 생성
        }
        return "true";
    }
}
