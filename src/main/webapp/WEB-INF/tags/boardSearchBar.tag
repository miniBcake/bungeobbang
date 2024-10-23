<%@ tag language="java" pageEncoding="UTF-8"%>

<!-- search line -->
<form>
	<div class="col-3 justify-content-center">
		<div class="categoryBox">
			<!-- 카테고리 -->
			<select id="contentFilter" name="contentFilter" class="category half"
				required>
				<option value="" disabled selected>카테고리</option>
				<option value="제목">제목</option>
				<option value="내용">내용</option>
			</select>
			<!-- 날짜 -->
			<select id="date" name="date" class="category half" required>
				<option value="" disabled selected>기간</option>
				<option value="제목">전체</option>
				<option value="제목">일주일</option>
				<option value="내용">1년</option>
			</select>
		</div>
	</div>
	<div class="col-8">
		<p hidden>검색창</p>
		<div class="searchInput" id="searchBox">
			<img src="resources/assets/images/search_icon.png" alt="검색창 아이콘 이미지"
				width="30px" height="30px"> <input type="text" id="keyword"
				name="keyword" placeholder="검색어를 입력해주세요." value="${keyword}">
			<input type="submit" value="검색">
		</div>
	</div>
</form>

<div class="col-1 text-end justify-content-center">
	<p hidden>글쓰기</p>
	<button class="boardWriteBtn">글쓰기</button>
</div>