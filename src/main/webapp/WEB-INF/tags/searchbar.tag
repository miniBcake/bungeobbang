<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="searchbar"%>
<%@ attribute name="placeholder" %>
<%@ attribute name="value" %>

<div class="searchInput">
	<i class="bi bi-search"></i> <input type="text" name="storeName"
		placeholder="${placeholder}" value="${value}"> <input  id="searchInputBTN" type="submit"
		value=" 검색 ">
</div>