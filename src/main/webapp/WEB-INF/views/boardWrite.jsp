<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"
   import="java.util.ArrayList, java.util.HashMap, java.util.Map, java.util.List"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML>

<html>
<head>
   <title>게시글 작성</title>
   <meta charset="utf-8" />
   <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
   <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
   <link rel="stylesheet" href="${path}/resources/assets/css/main.css" />
   <link rel="stylesheet" href="${path}/resources/assets/css/pagination.css">
   <link rel="stylesheet" href="${path}/resources/assets/css/boardWrite.css">

</head>

<body class="subpage">
    <!-- Header -->
    <custom:header />
   <div class="container">


      <!-- Content -->
      <div class="row mt-5">
         <div class="col-md-3">
            <!-- Sidebar -->
            <section>
               <h5 class="text-secondary">게시판 선택하기</h5>
               <ul class="list-group">
                  <li class="list-group-item"><a href="listBoards.do?boardCateName=normal">일반 게시판</a></li>
                  <li class="list-group-item"><a href="listBoards.do?boardCateName=request">문의 게시판</a></li>
               </ul>
            </section>
         </div>
         <div class="col-md-9">
            <!-- Main Content -->
            <section>
               <h3 class="text-primary">게시물 작성</h3>
               <p>게시물을 작성하여 정보를 공유 해주세요!</p>
               <form id="postForm" action="insertBoard.do" method="post" class="mt-4">
                  <div class="form-group">
                     <label for="boardCateName">게시글을 올릴 게시판 선택</label>
                     <select id="boardCateName" name="boardCateName" class="form-control">
                        <option value="normal" <c:if test="${boardCateName == 'normal'}">selected</c:if>>일반</option>
                        <option value="request" <c:if test="${boardCateName == 'request'}">selected</c:if>>문의</option>
                     </select>
                  </div>

                  <c:if test="${boardCateName == 'request'}">
                     <div class="custom-checkbox">
                        <input type="checkbox" id="postSecret" name="boardOpen" value="on">
                        <label for="postSecret">비공개 게시물로 등록</label>
                     </div>
                  </c:if>

                  <div class="form-group mt-3">
                     <label for="boardTitle">게시글 제목</label>
                     <input type="text" id="boardTitle" name="boardTitle" class="form-control" placeholder="제목을 입력해주세요!" required />
                  </div>

                  <div class="form-group mt-3">
                     <label for="postContent">게시글 내용</label>
                     <textarea id="postContent" name="BoardContent" class="form-control" placeholder="내용을 입력해주세요!" required >${boardList.BoardContent}</textarea>
                  </div>

                  <button class="btn btn-primary btn-block" id="postButton" type="submit">게시글 등록</button>
               </form>
            </section>
         </div>
      </div>

      <!-- Footer -->
      <custom:footer />
   </div>

   <!-- Scripts -->
   <script src="${path}/resources/assets/js/jquery.min.js"></script>
   <script src="${path}/resources/assets/js/browser.min.js"></script>
   <script src="${path}/resources/assets/js/util.js"></script>

   <!-- CKEditor 5 스크립트 로드 -->
   <!-- CKEditor 메인 라이브러리 (ckeditor.js): 이 스크립트는 CKEditor 5의 메인 라이브러리 파일입니다. ckeditor.js는 CKEditor 에디터의 핵심 기능을 제공합니다. -->
   <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
   <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>


   <!-- CKEditor Scripts -->
   <script>
   let editorInstance; // CKEditor 인스턴스를 저장할 변수
   console.log("[DEBUG] CKEDitor 인스턴스 저장 변수 생성 완료");
      // let editorInstance; == CKEditor 인스턴스를 저장할 변수
      // 인스턴스란 CKEditor가 페이지 내의 특정 HTML 요소(예: <textarea> 또는 <div>)와 연결되어, 그 요소에서 직접 편집 작업을 수행할 수 있는 상태를 말합니다.
   // 예를들어 CKEditor의 데이터를 가져오거나 수정할때, 저장된 객체를 통해서 CKEditor 자체의 메서드를 사용할 수 있습니다. 

   // currentData == 현재 데이터
    // previousData == 이전 데이터
      
   //페이지 로드 시 CKEditor 인스턴스 초기화
   document.addEventListener('DOMContentLoaded', () => {
	  const fileUploadUrl = '<%= request.getAttribute("uploadUrl") %>';
	  const fileDeleteUrl = '<%= request.getAttribute("deleteUrl") %>';
	  
      console.log("[DEBUG] CKEDitor초기화 완료 업로드 시작:");
      ClassicEditor
       .create(document.querySelector('#postContent'), { // CKEditor의 ClassicEditor.create() 메서드를 사용하여 CKEditor 인스턴스를 생성합니다. 이 메서드는 주어진 DOM 요소(여기서는 #postContent)에 CKEditor를 초기화합니다.
           language: 'ko',
           
           ckfinder: { // ckfinder 설정은 CKEditor에서 파일 업로드와 관련된 기능을 관리하는 부분입니다
               uploadUrl: fileUploadUrl, 
               options: { 
                   resourceType: 'Images', // 업로드할 리소스의 유형을 설정합니다. 여기서는 'Images'로 설정되어 있어, 주로 이미지 파일의 업로드와 관리를 다룹니다. 
                                        // CKFinder는 다양한 리소스 타입을 지원할 수 있으며, 예를 들어 'Files'나 'Documents' 같은 옵션도 있습니다.                  
                   deleteUrl: fileDeleteUrl 
               }
           },
           height: 1000
       })
       .then(editor => {
           editorInstance = editor; // CKEditor가 사용자가 입력한 값으로 초기화가 되었을 때 실행되는 함수입니다.
           // CKEditor가 업로드한 이미지의 URL이 editorData에 포함되는지 확인해야 함
           editor.model.document.on('change:data', () => { // editor의 데이터를 변경될 때 마다 호출되는 이벤트
              // CKEditor가 초기화되면 editorInstance에 CKEditor 인스턴스를 저장합니다.
              
               const currentData = editor.getData(); // 현재의 데이터에 editor에 작성된 data를 덮어씌우기
               console.log("[DEBUG] 현재 에디터 데이터:", currentData);
               
               if (previousData) { // 이 조건문은 previousData 변수가 존재할 때만 실행됩니다. / 이전 데이터
                   const deletedImages = findDeletedImages(previousData, currentData); // findDeletedImages 함수가 두 값을 비교하여 삭제된 url을 찾습니다. (281번줄 함수 수행)
                   deletedImages.forEach(imageUrl => { // deletedImages == 삭제된 이미지를 담고 있는 배열 / imageUrl == 배열의 현재 요소 즉 삭제할 이미지의 url
                      // change:data (281번) 이벤트를 통해 사용자가 에디터의 데이터를 변경할 때마다 현재의 데이터(currentData)를 가져와서 이전 데이터(previousData)와 비교합니다.
                      // 이전 데이터와 현재 데이터의 차이를 분석하여 삭제된 이미지 URL을 찾고, 이를 삭제하는 함수(deleteFile)를 호출합니다.
                       console.log("[INFO] 삭제 요청할 이미지 URL:", imageUrl);
                       deleteFile(imageUrl); // deleteFile 함수는 imageUrl을 인자로 받아 해당 이미지 파일을 서버에서 삭제하도록 요청합니다.
                   });
               }
               
               previousData = currentData; // 현재 데이터를 previousData 변수에 저장하여 다음 데이터 변경 시 비교할 수 있게 합니다.
               console.log("[DEBUG] 이전 에디터 데이터 업데이트됨");
           });
       })
       .catch(error => {
           console.error("[ERROR] CKEditor 초기화 실패:", error);
       });
   });
   
   let previousData = ''; // 이전 에디터 데이터를 저장할 변수
   
//-------------------------------------------------------------------------<수행되는 함수>---------------------------------------------------------------------------------------//
   
   // < 삭제된 url을 찾는 함수 수행 이후 추출 된 url을 서버에서 삭제 하도록 요청 하는 함수 >
   //이미지 삭제 요청을 서버에 보내는 함수
   // currentData == 현재 데이터
   // previousData == 이전 데이터
   
   function deleteFile(filePath) {
	// 서버에서 설정된 deleteUrl을 JSP에서 JavaScript로 전달
    const deleteUrl = '<%= request.getAttribute("deleteFetchUrl") %>'; 
    //ckEditor.delteFileFetchUrl=/MBProject/FileUpload?action=delete&filePath=
    console.log("[INFO] 파일 삭제 요청 중:", filePath); // 파일 삭제 요청 로그
    fetch( deleteUrl + encodeURIComponent(filePath), { // 파일 삭제 요청을 서버로 보냄
                                                 // ncodeURIComponent(filePath)는 파일 경로에 포함될 수 있는 특수 문자를 URL 인코딩하여 URL의 안전성을 확보합니다.
       method: 'POST',
         headers: {
             'Content-Type': 'application/x-www-form-urlencoded' // 명시적으로 Content-Type 설정
         }
    })
    .then(response => response.json()) // 응답을 JSON으로 파싱 / 
    .then(data => {
        if (data.deleted) {
            console.log('[INFO] 파일이 성공적으로 삭제되었습니다.'); // 파일 삭제 성공 로그
        } else {
            console.error('[ERROR] 파일 삭제 실패:', data.message); // 파일 삭제 실패 로그
        }
    })
    .catch(error => console.error('[ERROR] 파일 삭제 요청 오류:', error)); // 파일 삭제 요청 중 오류 발생 시 로그
   }
   
//------------------------------------------------------------------------------------------------------------------------------------------------------------------//
   
   // < 서버에 보낼 삭제된 url을 전송할 때 삭제된 이미지의 url을 찾는 함수 >
   //이전 데이터와 현재 데이터를 비교하여 삭제된 이미지를 찾는 함수
   function findDeletedImages(previousData, currentData) {
    // 이전 데이터에서 이미지 URL을 추출
    const prevImageUrls = Array.from(previousData.matchAll(/<img[^>]+src="([^">]+)"/g)).map(match => match[1]);
    console.log("[DEBUG] 이전 이미지 URL 목록:", prevImageUrls); // 이전 이미지 URL 목록 로그

    // 현재 데이터에서 이미지 URL을 추출
    const currImageUrls = Array.from(currentData.matchAll(/<img[^>]+src="([^">]+)"/g)).map(match => match[1]);
    console.log("[DEBUG] 현재 이미지 URL 목록:", currImageUrls); // 현재 이미지 URL 목록 로그
    //currImageUrls: 함수가 실행될 때, currentData로부터 이미지 URL들을 추출하여 동적으로 생성됩니다. 현재 데이터에 포함된 이미지 URL 목록을 담고 있습니다.

   
    // 이전 데이터에 있었으나 현재 데이터에 없는 이미지 URL을 필터링하여 반환
    const deletedImages = prevImageUrls.filter(url => !currImageUrls.includes(url));
    console.log("[DEBUG] 삭제된 이미지 URL 목록:", deletedImages); // 삭제된 이미지 URL 목록 로그
    return deletedImages;
    /* 
    findDeletedImages 함수는 이전 데이터(previousData)와 현재 데이터(currentData)에서 이미지 URL을 추출하여 비교합니다.
    이전 데이터에서 현재 데이터에 없는 이미지 URL을 찾아 deletedImages 배열에 저장합니다.
    deletedImages 배열을 반환하여 삭제된 이미지의 URL 목록을 제공합니다.
    */
    //deletedImages: prevImageUrls와 currImageUrls를 비교하여 이전 데이터에 있었지만 현재 데이터에는 없는 이미지 URL을 동적으로 계산하여 생성됩니다.
   // 즉 이전 데이터와 현재의 데이터를 비교하여서 삭제된 파일의 경로를 추출함 / 이전 데이터가 있는 경우에만 실행 되는 함수
   }
   
//------------------------------------------------------------------------------------------------------------------------------------------------------------------//
   
   // CKEditor에서 입력된 데이터에서 이미지 경로를 추출하는 함수
   function getImagePathsFromEditorData(editorData) {
    // editorData에서 <img> 태그의 src 속성을 찾아서 배열로 반환
       return Array.from(editorData.matchAll(/<img[^>]+src="([^">]+)"/g)).map(match => match[1]);
   }
   
 //------------------------------------------------------------------------------------------------------------------------------------------------------------------//
   
    // CKEditor에서 입력된 데이터 가져오기
    function getEditorData() {
        if (editorInstance) {
            return editorInstance.getData(); // CKEditor에서 데이터 가져오기
        }
        return ''; // CKEditor가 초기화되지 않았을 경우 빈 문자열 반환
    }

//------------------------------------------------------------------------------------------------------------------------------------------------------------------//

    // 게시글 등록 함수
    function createPost() { // 게시글 등록 버튼을 눌러 실행된 함수
    	 // JSP에서 전달된 URL을 가져옴
        const createPostFetchUrl = '<%= request.getAttribute("createPostBoardFetchUrl") %>';
        const formData = new FormData(); // 전달할 데이터를 담을 변수 생성 / 주로 파일 업로드, 텍스트 필드, 체크박스 등 다양한 폼 필드를 서버로 전송할 때 사용
        const editorData = getEditorData(); // CKEditor에 작성된 데이터를 담을 변수 생성 / 이 함수는 CKEditor의 인스턴스에서 현재 작성된 콘텐츠를 문자열 형태로 반환

        formData.append('boardTitle', document.getElementById('boardTitle').value); // 제목 필드
        formData.append('boardContent', editorData); // CKEditor 데이터
        formData.append('boardCateName', document.getElementById('boardCateName').value); // 게시판 선택 필드
        
        // postSecret 체크박스가 있는지 확인하고, 없으면 기본값을 '공개'로 설정
        const postSecretCheckbox = document.getElementById('postSecret');
        if (postSecretCheckbox) {
            formData.append('boardOpen', postSecretCheckbox.checked ? 'N' : '');
        } else {
            formData.append('boardOpen', 'Y'); // 기본값을 공개로 설정
        }

        const imagePaths = getImagePathsFromEditorData(editorData).join(','); // CKEditor의 콘텐츠(editorData)에서 이미지 URL을 추출 하는 함수
                                                     // 이 함수는 HTML 문자열에서 <img> 태그의 src 속성 값을 찾아 배열로 반환
                                                     // join 메서드가 배열의 모든 요소를 ' , ' 로 연결하여 하나의 문자열로 만들어줌
        console.log('[INFO] Image 경로 전송 직전:', imagePaths);
        formData.append('imagePaths', imagePaths); // formData객체에 imagePaths 값을 추가

        console.log('[DEBUG] Form Data:', formData);

        return fetch(createPostFetchUrl, { // fetch 함수는 웹 브라우저에서 HTTP 요청을 보내는 메서드 / 첫번째 인자에서는 요청을 보낼 url을 지정
            method: 'POST', // 두 번째 인자는 요청의 옵션을 설정하는 객체 여기서는 HTTP 메서드와 요청 본문(body)을 설정
            body: formData // FormData 객체를 그대로 전송
        });
    }

 // 게시글 등록 버튼 클릭 시 게시글 등록 함수 호출
document.getElementById('').addEventListener('click', (event) => {
    event.preventDefault(); // 기본 폼 제출 동작 방지

    createPost()
    .then(response => {
        if (!response.ok) {
            alert('게시글 등록에 실패했습니다.');
            throw new Error('게시글 등록 실패');
        }
        return response.json(); // 응답을 JSON으로 파싱
    })
    .then(data => {
        const boardNum = data.boardNum; // 응답에서 boardNum 추출
        if (!boardNum) {
            console.error("게시글 번호가 유효하지 않습니다.", boardNum);
            return;
        }
        
        alert("게시글 등록 성공! 게시글 번호는 " + boardNum + "입니다.");

        if (confirm('게시글이 성공적으로 등록되었습니다! 확인 버튼을 누르면 작성한 게시글을 보는 페이지로 이동합니다!')) {
            // 클라이언트 측에서 URL 리다이렉션
            window.location.href = `viewBoard.do?boardNum=`+boardNum;
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
});

</script>
</body>
</html>