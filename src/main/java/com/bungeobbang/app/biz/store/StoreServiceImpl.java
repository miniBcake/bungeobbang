package com.bungeobbang.app.biz.store;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//StoreService 구현체
@Service("storeService")
public class StoreServiceImpl implements StoreService{
	@Autowired
	private StoreDAO storeDAO;

	@Override
	public ArrayList<StoreDTO> selectAll(StoreDTO storeDTO) {
		// TODO Auto-generated method stub
		return this.storeDAO.selectAll(storeDTO);
	}

	@Override
	public StoreDTO selectOne(StoreDTO storeDTO) {
		// TODO Auto-generated method stub
		return this.storeDAO.selectOne(storeDTO);
	}

	@Override
	public boolean insert(StoreDTO storeDTO) {
		// TODO Auto-generated method stub
		return this.storeDAO.insert(storeDTO);
	}

	@Override
	public boolean update(StoreDTO storeDTO) {
		// TODO Auto-generated method stub
		return this.storeDAO.update(storeDTO);
	}

	@Override
	public boolean delete(StoreDTO storeDTO) {
		// TODO Auto-generated method stub
		return this.storeDAO.delete(storeDTO);
	}
	
}
