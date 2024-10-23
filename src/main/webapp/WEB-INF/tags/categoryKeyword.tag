<%@ tag language="java" pageEncoding="UTF-8"%>

<!-- 사용할 속성들의 이름을 정의 -->
<%@ attribute name="value" %>
<%@ attribute name="id" %>
<%@ attribute name="name" %>

<div class="col-3">
	<section>
		<label class="customCheckbox"> <input type="checkbox"
			name="${name}" value="${value}" id="${id}"> <span
			class="checkmark hover-text"> <jsp:doBody></jsp:doBody> </span>
		</label>
	</section>
</div>
