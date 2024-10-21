package com.fproject.app.biz.crawler;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;

import com.fproject.app.biz.product.ProductDTO;

import io.github.bonigarcia.wdm.WebDriverManager;


public class Crawling {
	
	@Autowired
    private WebDriver driver;  // 웹 드라이버 객체
	
    private ChromeOptions options;  // 크롬 옵션 설정 객체
    private JavascriptExecutor js;  // 자바스크립트 실행 객체

    // 네이버 쇼핑에서 '붕어빵 악세서리' 검색 URL
    private static final String URL = "https://search.shopping.naver.com/search/all?query=%EB%B6%95%EC%96%B4%EB%B9%B5%20%EC%95%85%EC%84%B8%EC%84%9C%EB%A6%AC";
    
    // CSS 선택자를 통해 가격 정보 가져오는 경로
    private static final String CSS_ELEMENTS_PRICE = "div > div.product_info_area__xxCTi > div.product_price_area__eTg7I > strong > span.price > span > em";
    
    // CSS 선택자를 통해 이미지 정보 가져오는 경로
    private static final String CSS_ELEMENTS_IMAGE = "div > div.product_img_area__cUrko > div > a > img";
    
    // 스크롤 양 설정 (한 번에 100픽셀씩 스크롤)
    private static final int SCROLL_AMOUNT = 100;

    // 기본 생성자: WebDriverManager를 사용하여 크롬 드라이버 설정 및 크롬 옵션 구성
    public Crawling() {
        // WebDriverManager로 크롬 드라이버 자동 설정
        WebDriverManager.chromedriver().setup();
        options = new ChromeOptions();
        // 팝업 차단, 기본 앱 비활성화, 알림 비활성화 등 옵션 추가
        options.addArguments("--disable-popup-blocking");
        options.addArguments("--disable-default-apps");
        options.addArguments("--disable-notifications");
        options.addArguments("--disable-blink-features=AutomationControlled");
    }

    // 드라이버 초기화 (크롬 드라이버를 실행)
    public void initDriver() {
        driver = new ChromeDriver(options);  // 크롬 드라이버 실행
        js = (JavascriptExecutor) driver;  // 자바스크립트 실행을 위한 객체 초기화
    }

    // 드라이버 종료 (자원 해제)
    public void closeDriver() {
        if (driver != null) {
            driver.quit();  // 크롬 드라이버 종료
        }
    }
    
    // 제품 정보를 크롤링하는 메소드
    public ArrayList<ProductDTO> findProductInfo() {
        ArrayList<ProductDTO> datas = new ArrayList<>();  // 크롤링한 제품 정보를 담을 리스트
        try {
            initDriver();  // 드라이버 초기화
            driver.get(URL);  // 네이버 쇼핑 페이지로 이동
            List<WebElement> priceElements;  // 가격 정보가 담긴 요소 리스트
            List<WebElement> imageElements;  // 이미지 정보가 담긴 요소 리스트
            int index = 0;  // 가격 요소 인덱스

            // 스크롤을 내려가면서 이미지와 가격 정보를 크롤링
            while (true) {
                priceElements = driver.findElements(By.cssSelector(CSS_ELEMENTS_PRICE));  // 가격 요소 찾기
                imageElements = driver.findElements(By.cssSelector(CSS_ELEMENTS_IMAGE));  // 이미지 요소 찾기

                // 자바스크립트를 사용하여 페이지 스크롤 (100px씩)
                js.executeScript("window.scrollBy(0, " + SCROLL_AMOUNT + ");"); 
                driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));  // 대기 시간 설정 (5초)

                // 이미지 요소가 35개 이상 수집되면 크롤링 중단
                if (imageElements.size() >= 35) {
                    System.out.println("log: Crawling Elements find 35 up");
                    break;
                }
            }

            // 수집된 이미지 및 가격 정보를 ProductDTO 객체로 저장
            for (WebElement image : imageElements) {
                ProductDTO data = new ProductDTO();
                // 이미지 요소의 'alt' 속성에서 제품명을 가져옴
                data.setProductName(image.getAttribute("alt")); 
                // 이미지 요소의 'src' 속성에서 이미지 경로를 가져옴
                data.setProductProfileWay(image.getAttribute("src")); 
                // 가격 정보를 파싱하여 정수형으로 변환한 뒤 저장
                data.setProductPrice(Integer.parseInt(priceElements.get(index++).getText().replaceAll("[^\\d]", "")));
                datas.add(data);  // 리스트에 제품 정보 추가
            }

        } catch (Exception e) {
            System.err.println("log: Crawling Exception: " + e.getMessage());  // 예외 발생 시 로그 출력
            datas.clear();  // 예외 발생 시 데이터 리스트 초기화
        } finally {
            closeDriver();  // 크롤링이 끝나면 드라이버 종료
        }
        return datas;  // 수집한 제품 정보를 반환
    }
}
