package com.bungeobbang.app.biz.store;

import java.util.List;

public interface StoreService {
	List<StoreDTO> selectAll(StoreDTO storeDTO);
	StoreDTO selectOne(StoreDTO storeDTO);
	boolean insert(StoreDTO storeDTO);
	boolean update(StoreDTO storeDTO);
	boolean delete(StoreDTO storeDTO);
}
