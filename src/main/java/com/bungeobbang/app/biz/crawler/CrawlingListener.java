package com.bungeobbang.app.biz.crawler;

import java.util.ArrayList;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;

import com.bungeobbang.app.biz.product.ProductDAO;
import com.bungeobbang.app.biz.product.ProductDTO;
import com.bungeobbang.app.biz.productCate.ProductCateDAO;
import com.bungeobbang.app.biz.productCate.ProductCateDTO;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

//@WebListener
public class CrawlingListener implements ServletContextListener {
	@Autowired
	private ProductDAO productDAO;
	@Autowired
	private ProductCateDAO productCateDAO;
	
	@Autowired
	private ProductDTO productDTO;
	@Autowired
	private ProductCateDTO productCateDTO;
	
	@Autowired
	private Crawling crawling;
	

	//생성자
    public CrawlingListener() {
        productDTO.setEndNum(10);//페이지네이션 용 값
    }

    //서버 시작시
    public void contextInitialized(ServletContextEvent sce)  { 
         if(productDAO.selectAll(productDTO).isEmpty()) {
        	 System.out.println("log: Listener Product isEmpty");
        	 //만약 상품 DB가 비어있을 경우
        	 
        	 //카테고리 더미데이터
        	 ArrayList<String> categoryNames = new ArrayList<>();
             categoryNames.add("문구류");
             categoryNames.add("악세사리");
             categoryNames.add("생활용품");
             categoryNames.add("의류");
             categoryNames.add("전자기기 및 관련 제품");
             
             // 리스트를 순회하며 카테고리 이름을 DTO에 설정 후 DB에 삽입
             for (String categoryName : categoryNames) {
                 productCateDTO.setProductCateName(categoryName);  // 카테고리 이름 설정
                 boolean flag = productCateDAO.insert(productCateDTO);  // DB에 삽입
                 if (flag) {
                     System.out.println("카테고리 삽입 성공: " + categoryName);
                 } else {
                     System.out.println("카테고리 삽입 실패: " + categoryName);
                 }
             }
        	 
        	 //크롤링한 데이터 받아오기
        	 ArrayList<ProductDTO> datas = crawling.findProductInfo();
        	 //현재 있는 상품 카테고리 리스트 받아오기

        	 ArrayList<ProductCateDTO> productCateList = productCateDAO.selectAll(productCateDTO);
        	 //랜덤값을 위한 랜덤 객체 선언
        	 Random rand = new Random();
        	 for(ProductDTO data : datas) {
        		 //크롤링한 데이터를 순회하며 카테고리 번호를 랜덤값으로 넣어
        		 data.setProductCateNum(productCateList.get(rand.nextInt(productCateList.size())).getProductCateNum());
        		 data.setCondition("CRAWLING_ONLY");
        		 //DB에 상품 추가
        		 productDAO.insert(data);
        	 }
         }
         System.out.println("log: Listener End");

    }

    //서버 종료시
    public void contextDestroyed(ServletContextEvent sce)  { 
    	
    }
}
