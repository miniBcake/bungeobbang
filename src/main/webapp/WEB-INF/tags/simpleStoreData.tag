<%@ tag language="java" pageEncoding="UTF-8"%>

<div class="storeData">
	<div class="storeDataTitle">
		<a href="/viewStorePage.do?storeNum=${store.Num}"><h4
				class="text-hover">{store.name}</h4></a>
	</div>
	<div class="storeDataContent">
		<div class="col-1 nonePadding">
			<i class="fas fa-map"></i>
		</div>
		<div class="col-9 leftPadding text-start">
			<span>{store.address} <br> {store.detail.address}
			</span>
		</div>
		<div class="col-2 nonePadding">
			<button class="copy" value="${store.address} ${store.detail.address}">복사</button>
		</div>
	</div>
	<div class="storeDataContent">
		<div class="col-1 nonePadding">
			<i class="fas fa-phone"></i>
		</div>
		<div class="col-9 leftPadding text-start">
			<span>{store.phone}</span>
		</div>
		<div class="col-2 nonePadding">
			<button class="copy" value="${store.phone}">복사</button>
		</div>
	</div>
</div>