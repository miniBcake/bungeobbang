package com.bungeobbang.app.biz.common;

import java.util.ArrayList;
import java.util.Random;

import com.bungeobbang.app.biz.crawler.Crawling;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import com.bungeobbang.app.biz.product.ProductDTO;
import com.bungeobbang.app.biz.product.ProductService;
import com.bungeobbang.app.biz.productCate.ProductCateDTO;
import com.bungeobbang.app.biz.productCate.ProductCateService;


//@Component //Spring 컨테이너가 이 클래스를 관리
public class BasicDataListener implements ApplicationListener<ContextRefreshedEvent> {
	//Spring의 DI
	//@Autowired
	private ProductService productService;
	//@Autowired
	private ProductCateService productCateService;

	private ProductDTO productDTO;
	private ProductCateDTO productCateDTO;

	//프로그램에 필요한 데이터
	private String[] productCategory = {"문구/사무", "리빙", "패션/잡화", "디지털/IT", "홈데코"}; //View에 노출되는 데이터
	private String[] boardCategory = {"NOTICE", "COMMUNITY"}; //프로그램 상의 카테고리 구분값

	//샘플데이터



	//생성자
	public BasicDataListener(){ //생성자 초기화
		this.productDTO = new ProductDTO();
		this.productCateDTO = new ProductCateDTO();
		productDTO.setStartNum(0);
        productDTO.setEndNum(10);//페이지네이션 용 값
	}

	@Override //ApplicationContext가 초기화될 때 호출
	public void onApplicationEvent(ContextRefreshedEvent event) {
		initData(); //초기화 로직
	}
	
	private void initData() {
		System.out.println("리스너시작");
		if(productCateService.selectAll(productCateDTO).isEmpty()) {
           for (String categoryName : productCategory) {
               productCateDTO.setProductCategoryName(categoryName);  // 카테고리 이름 설정
               boolean flag = productCateService.insert(productCateDTO);  // DB에 삽입
               if (flag) {
                   System.out.println("카테고리 삽입 성공: " + categoryName);
               } else {
                   System.out.println("카테고리 삽입 실패: " + categoryName);
               }
           }
		}
		
		if(productService.selectAll(productDTO).isEmpty()) {
       	 System.out.println("log: Listener Product isEmpty");
       	 //만약 상품 DB가 비어있을 경우
       	 //크롤링한 데이터 받아오기
       	 ArrayList<ProductDTO> datas = Crawling.findProductInfo();

       	 //랜덤값을 위한 랜덤 객체 선언
       	 //현재 있는 상품 카테고리 리스트 받아오기
       	 ArrayList<ProductCateDTO> productCateList = productCateService.selectAll(productCateDTO);
       	 Random rand = new Random();
       	 for(ProductDTO data : datas) {
       		 //크롤링한 데이터를 순회하며 카테고리 번호를 랜덤값으로 넣어
       		 data.setProductCategoryNum(productCateList.get(rand.nextInt(productCateList.size())).getProductCategoryNum());
       		 data.setCondition("CRAWLING_ONLY");
       		 //DB에 상품 추가
       		 productService.insert(data);
       	 }
        }
        System.out.println("log: Listener End");

	}
}