<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>

<html>
   <head>
      <title>Main</title>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
      <link rel="stylesheet" href="${path}/resources/assets/css/main.css" />
   </head>
   <body>
      <div id="page-wrapper">
      
<!-- Header 커스터 태그 -->
<custom:header/>

         <!-- Features -->
           
         <!-- Content -->
            <section id="content">
               <div class="container">
                  <div class="row aln-center">
                     <div class="col-4 col-12-medium">

                        <!-- Box #1 -->
                           <section>
                              <header>
                                 <h2>Who We Are</h2>
                                 <h3>A subheading about who we are</h3>
                              </header>
                              <a href="#" class="feature-image"><img src="" alt="" /></a>
                              <p>
                              </p>
                           </section>

                     </div>
                     <div class="col-4 col-6-medium col-12-small">

                        <!-- Box #2 -->
                           <section>
                              <header>
                                 <h2>What We Do</h2>
                                 <h3>A subheading about what we do</h3>
                              </header>
                              <ul class="check-list">
                                 <li>Sed mattis quis rutrum accum</li>
                                 <li>Eu varius nibh suspendisse lorem</li>
                                 <li>Magna eget odio amet mollis justo</li>
                                 <li>Facilisis quis sagittis mauris</li>
                                 <li>Amet tellus gravida lorem ipsum</li>
                              </ul>
                           </section>

                     </div>
                     <div class="col-4 col-6-medium col-12-small">

                        <!-- Box #3 -->
                           <section>
                              <header>
                                 <h2>인기 게시물 TOP 3</h2>
                                 <h4>일반 게시판에서 작성된 인기 게시물</h4>
                              </header>
								<ul class="quote-list">
								   <c:forEach var="boardList" items="${hotBoardList}" varStatus="status">
								      <li>
								         <h2>Top ${status.index + 1}</h2> <!-- 인덱스 값을 1부터 표시 -->
								         <img src="images/pic06.jpg" alt="" />
								         <p>${boardList.boardTitle}</p>
								         <span>${boardList.memberNickname}</span>
								         <span>
								            <c:choose>
								               <c:when test="${fn:length(boardList.boardContent) > 30}">
								                  ${fn:substring(boardList.boardContent, 0, 30)}...
								               </c:when>
								               <c:otherwise>
								                  ${boardList.boardContent}
								               </c:otherwise>
								            </c:choose>
								         </span>
								         <button>
								            <a href="viewBoard.do?boardNum=${boardList.boardNum}"> 게시글 보러 가기</a>
								         </button>
								      </li>
								   </c:forEach>
								</ul>
                           </section>

                     </div>
                  </div>
               </div>
            </section>
            
         <!-- footer 커스텀 태그 -->
         <custom:footer/>


      </div>

      <!-- Scripts -->
         <script src="${path}/resources/assets/js/jquery.min.js"></script>
         <script src="${path}/resources/assets/js/browser.min.js"></script>
         <script src="${path}/resources/assets/js/util.js"></script>

   </body>
</html>