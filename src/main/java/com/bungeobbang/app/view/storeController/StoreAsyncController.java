package com.bungeobbang.app.view.storeController;

import com.bungeobbang.app.biz.store.StoreDTO;
import com.bungeobbang.app.biz.store.StoreService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@RestController
public class StoreAsyncController {
    @Autowired
    private StoreService storeService;

    //지도 옆 주소 검색 : 가게
    @RequestMapping(value = "/loadListStoreMap.do", method = RequestMethod.POST)
    public ArrayList<StoreDTO> loadListStoreMap(String keyword){
        log.info("log: /loadListStoreMap.do loadListStoreMap - start");
        log.info("log: loadListStoreMap - param keyword: " + keyword);
        HashMap<String, String> filterList = new HashMap<>(); //필터 검색용 맵
        filterList.put("STORE_ADDRESS", keyword); //필터 검색용 값 설정
        StoreDTO storeDTO = new StoreDTO(); //DB조회를 위한 정보 전달 용
        storeDTO.setCondition("SELECTALL_VIEW_FILTER");
        storeDTO.setFilterList(filterList);
        log.info("log: /loadListStoreMap.do loadListStoreMap - end");
        return storeService.selectAll(storeDTO); //DB검색 결과 반환
    }
}
