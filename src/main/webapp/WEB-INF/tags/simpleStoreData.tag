<%@ tag language="java" pageEncoding="UTF-8"%>

<div class="storeData">
	<div class="storeDataTitle">
		<h4>{store.name}</h4>
	</div>
	<div class="storeDataContent">
		<img class="icon" src="resources\assets\images\address_icon.png"
			alt="주소 아이콘"> <span>{store.address} <br>
			{store.detail.address}
		</span>
		<button class="copy" id="copy">복사</button>
	</div>
	<div class="storeDataContent">
		<img class="icon" src="resources\assets\images\address_icon.png"
			alt="전화번호 아이콘"> <span>{store.phone}</span>
		<button class="copy" id="copy">복사</button>
	</div>
</div>