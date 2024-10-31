package com.bungeobbang.app.view.productController;

import com.bungeobbang.app.biz.product.ProductDTO;
import com.bungeobbang.app.biz.product.ProductService;
import com.bungeobbang.app.biz.productCate.ProductCateDTO;
import com.bungeobbang.app.biz.productCate.ProductCateService;
import com.bungeobbang.app.view.util.CookieUtil;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

@Controller("product")
@Slf4j
public class ProductController {
    @Autowired
    private ProductService productService;
    @Autowired
    private ProductCateService productCateService;

    private final int PAGE_SIZE = 6; // 페이지당 항목 수 설정
    private final String COOKIE_NAME = "viewedProducts"; //쿠키 이름 설정

    //상품 상세보기
    @RequestMapping("/infoProduct.do")
    public String infoProduct(HttpServletRequest request, Model model, ProductDTO productDTO,
                              //쿠키 관련
                              HttpServletResponse response) {
        log.info("log: /infoProduct.do infoProduct - start");

        // 상품 정보 조회
        productDTO.setCondition("MD_ONE"); //조회조건 설정
        productDTO = productService.selectOne(productDTO); // 해당 상품을 조회

        //쿠키에 조회 기록 추가
        Cookie[] cookies = request.getCookies(); //쿠키 받아오기
        try {
            if(!CookieUtil.cookieAddNewData(response, COOKIE_NAME, cookies, productDTO.getProductNum())){
                //쿠키 추가에 실패했더라도 해당 상품 정보를 사용자가 볼 수 있도록 개발자에게 안내만 제공
                log.error("log: [ERROR] infoProduct - create history add Cookie fail!");
            }
            else {
                log.info("log: infoProduct - create history add Cookie success");
            }
        } catch (NullPointerException e) {
            throw new RuntimeException(e);
        }

        //데이터 전달
        model.addAttribute("product", productDTO);
        //데이터 확인
        log.info("log: infoProduct - send product [{}]", productDTO);

        log.info("log: /infoProduct.do infoProduct - end / forward");
        return "productDetail";
    }

    //상품 출력
    @RequestMapping("/loadListProduct.do")
    public String loadListProduct(HttpServletResponse response, Model model, ProductDTO productDTO,
                                  //검색용 현재 페이지 정보
                                  int page, int minPrice, int maxPrice, String keyword, String searchCondition,
                                  //쿠키 작업에서 사용
                                  HttpServletRequest request ) {

        log.info("log: /loadListProduct.do loadListProduct - start");

        ArrayList<ProductDTO> recommendedProduct = null; //추천 상품 목록을 담을 리스트
        HashMap<String, String> filterList; //필터 검색용
        List<String> viewedProductList; //상품 조회용
        ArrayList<ProductDTO> resentProduct = null; //쿠키 저장용
        Map<Integer, Integer> categoryCount; //상품 카테고리 계산용
        ArrayList<String> deleteList; //쿠키 삭제용
        ArrayList<ProductCateDTO> productCategory; //카테고리 목록

        //쿠키 가져와서 디코딩 : 사용자가 최근에 조회한 상품 목록
        Cookie[] cookies = request.getCookies();
        Cookie cookie = CookieUtil.cookieData(cookies, COOKIE_NAME);
        String viewedProducts = null;
        if(cookie != null) {
            viewedProducts = URLDecoder.decode(cookie.getValue(), StandardCharsets.UTF_8);
            log.info("log: loadListProduct - viewedProducts : [{}]", viewedProducts);
        }

        // 쿠키에서 가져온 상품 목록이 있다면 리스트에 저장
        if (viewedProducts != null && !viewedProducts.isEmpty()) {
            //","를 통해 데이터 구분
            viewedProductList = Arrays.asList(viewedProducts.split(","));
            log.info("log: loadListProduct - viewedProductList : [{}]", viewedProductList);

            deleteList = new ArrayList<>(); //삭제용 리스트
            resentProduct = new ArrayList<>(); //추천 상품 목록
            categoryCount = new HashMap<>(); //카테고리 계산용

            // 쿠키에서 가져온 상품 ID를 기반으로 상품을 조회하고 카테고리별로 개수 카운팅
            for (String pNum : viewedProductList) {
                productDTO.setProductNum(Integer.parseInt(pNum));
                ProductDTO product = productService.selectOne(productDTO); // 상품 정보 조회
                log.info("log: loadListProduct - viewedProductList for product : [{}]", product);

                //존재하지 않는 상품일 경우
                if (product == null) {
                    log.error("log: loadListProduct - deleteList.add : [{}]", pNum);
                    //추후 쿠키에서 제거 작업하기 위해 저장
                    deleteList.add(pNum);
                    continue;
                }
                //해당 상품을 저장
                resentProduct.add(product);
                log.info("log: loadListProduct - resentProducts.add");
                // 카테고리 번호별로 상품 수 계산
                int categoryNum = product.getProductCategoryNum();
                log.info("log: loadListProduct - categoryNum : [{}]", categoryNum);
                categoryCount.put(categoryNum, categoryCount.getOrDefault(categoryNum, 0) + 1);
            }
            //없는 상품 쿠키에서 제거
            if(CookieUtil.cookieDataDelete(response, cookie, deleteList)){
                //쿠키 제거에 실패했더라도 상품리스트를 사용자가 볼 수 있도록 개발자에게 안내만 제공
                log.error("log: [ERROR] loadListProduct - delete history Cookie fail!");
            }

            // 가장 많이 본 카테고리
            // categoryCount Map에 저장된 카테고리별 조회 횟수를 기준으로 가장 많이 조회된 카테고리를 찾는다.
            // Map.Entry<Integer, Integer>는 카테고리 번호(Integer)와 해당 카테고리의 조회 수(Integer)를 의미.
            // max() 메서드는 가장 큰 값을 가진 카테고리를 찾는다.
            Optional<Map.Entry<Integer, Integer>> mostViewedCategoryOpt = categoryCount.entrySet().stream()
                    .max(Map.Entry.comparingByValue());

            // Optional이 비어있지 않으면 (가장 많이 본 카테고리가 존재할 경우)
            if (mostViewedCategoryOpt.isPresent()) {
                // 가장 많이 본 카테고리의 key 값을 가져옴 (카테고리 번호)
                int mostViewedCategory = mostViewedCategoryOpt.get().getKey();
                // 가장 많이 본 카테고리에 속하는 상품을 필터링하여 추천 상품으로 설정
                filterList = new HashMap<>(); //필터 검색용
                filterList.put("GET_MD_CATEGORY", "" + mostViewedCategory);  // 카테고리 필터 추가
                // ProductDTO 객체 생성 후 필터 설정
                productDTO.setFilterList(filterList);  // 필터를 설정하여 해당 카테고리의 상품만 검색
                // 데이터 범위 설정 (추천 상품 수를 3개로 제한)
                productDTO.setStartNum(1);
                productDTO.setEndNum(3);
                //확인
                log.info("log: loadListProduct - mostViewedCategory : [{}]", mostViewedCategory);
                log.info("log: loadListProduct - filter search filterList : [{}]", filterList);

                // 필터링된 상품 목록을 조회하여 추천 상품 리스트 생성
                recommendedProduct = productService.selectAll(productDTO); // 상품 목록 조회
            }
        }


        //카테고리 목록 조회
        productCategory = productCateService.selectAll(null); // 전체 카테고리 목록 조회

        //페이지에 해당하는 상품 목록
        int startNum = (page-1)*PAGE_SIZE+1;
        productDTO.setStartNum(startNum);
        productDTO.setEndNum(startNum+PAGE_SIZE-1);
        ArrayList<ProductDTO> productList = productService.selectAll(productDTO);
        //페이지네이션을 위한 총 데이터 정보
        productDTO.setCondition("FILTER_CNT");
        int allDataCnt = productService.selectOne(productDTO).getCnt();

        //데이터 전달
        model.addAttribute("resentProduct", resentProduct); // 최근에 본 상품
        model.addAttribute("recommProduct", recommendedProduct); // 추천 상품
        model.addAttribute("productCategory", productCategory); // 카테고리 목록
        model.addAttribute("productList", productList); //페이지 별 상품 리스트
        //검색어 유지데이터
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("keyword", keyword);
        model.addAttribute("searchCondition", searchCondition);
        model.addAttribute("page", page);

        //확인
        log.info("log: listProduct - send resentProducts : [{}]", resentProduct);
        log.info("log: listProduct - send recommendedProducts : [{}]", recommendedProduct);
        log.info("log: listProduct - send productCategories : [{}]", productCategory);
        log.info("log: listProduct - send productList : [{}]", productList);
        log.info("log: listProduct - send minPrice : [{}]", minPrice);
        log.info("log: listProduct - send maxPrice : [{}]", maxPrice);
        log.info("log: listProduct - send keyword : [{}]", keyword);
        log.info("log: listProduct - send page : [{}]", page);

        log.info("log: /listProduct.do listProduct - end / forward");
        return "productList";
    }
}
