package com.bungeobbang.app.view.util;

import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.time.LocalDate;
import java.util.UUID;

/**@author 한지윤 */
@Slf4j
public class FileUtil {

    //파일 이름을 받아 확장자 추출 후 UUID와 현재 시간으로 파일명 생성 String 반환
    public static String createFileName(String file){
        log.info("log: createFileName start");
        String extension = ""; //확장자, 만약 문자열에 .이 없다면 ""으로 확장자 없음
        if(file != null && file.contains(".")){ //.이 있는 문자열이라면
            log.info("log: createFileName file contains '.'");
            extension = file.substring(file.lastIndexOf("."));//확장자 저장
        }
        String fileName = LocalDate.now() + "+" +  UUID.randomUUID() + extension; //파일명 구성
        log.info("log: file name [{}]", fileName);
        log.info("log: createFileName end");
        return fileName;
    }

    //해당 폴더 하위의 폴더와 파일 삭제
    public static boolean deleteFileAndDirectory (File folder){
        log.info("log: deleteFile - start");
        //서버에 해당 경로의 폴더가 있다면
        if(folder.exists()) {
            File[] files = folder.listFiles(); //해당 폴더의 파일리스트 데이터
            if(files != null) { //빈 폴더가 아니라면
                for(File file : files) {
                    log.info("log: deleteFile - board image file delete file : [{}]", file);
                    if(file.isDirectory()){ //만약 파일이 아니라 폴더라면
                        log.info("log: deleteFile - {} is directory", file);
                        //재귀함수
                        deleteFileAndDirectory(file);
                    }
                    if(!file.delete()){ //해당 파일 삭제
                        //파일 삭제 실패 시
                        //개발자에게 안내
                        log.error("log: deleteFile - board image file delete fail!!!! file : [{}]", file.getPath());
                    }
                }
                if(!folder.delete()){
                    //폴더 삭제 실패 시 개발자에게 안내
                    log.error("log: deleteFile - board image folder delete fail!!!! folder : [{}]", folder.getPath());
                    return false;
                }
            }
        }
        else{
            //해당 경로에 폴더가 존재하지 않음을 안내
            log.error("log: deleteFile - no image folder error imagePath: [{}]", folder.getPath());
            return false;
        }
        log.info("log: deleteFile - end / true");
        return true;
    }

    //입력받은 경로에 입력받은 파일을 저장
    public static boolean insertFile (File folder, String file){
        //KS 작성바람, 프로필 이미지 게시글 이미지 둘 다 작업 가능하도록
        log.info("log: insertFile - start");
        return false;
    }
}
