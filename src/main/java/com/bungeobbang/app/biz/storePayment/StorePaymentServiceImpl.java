package com.fproject.app.biz.storePayment;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//storePaymentService 구현체
@Service("storePaymentService")
public class StorePaymentServiceImpl  implements StorePaymentService{
	
	@Autowired
	private StorePaymentDAO storePaymentDAO;
	
	@Override
	public ArrayList<StorePaymentDTO> selectAll(StorePaymentDTO storePaymentDTO) {
		return this.storePaymentDAO.selectAll(storePaymentDTO);
	}

	@Override
	public StorePaymentDTO selectOne(StorePaymentDTO storePaymentDTO) {
		return this.storePaymentDAO.selectOne(storePaymentDTO);
	}

	@Override
	public boolean insert(StorePaymentDTO storePaymentDTO) {
		return this.storePaymentDAO.insert(storePaymentDTO);
	}

	@Override
	public boolean update(StorePaymentDTO storePaymentDTO) {
		return this.storePaymentDAO.update(storePaymentDTO);
	}

	@Override
	public boolean delete(StorePaymentDTO storePaymentDTO) {
		//return this.storePaymentDAO.delete(storePaymentDTO);
		return false;
	}
	
}
