package com.fproject.app.biz.payment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("paymentService")
public class PaymentServiceImpl implements PaymentService{
	@Autowired
	private PaymentDAO paymentDAO;
	
	@Override
	public boolean insert(PaymentDTO paymentDTO) {
		return this.paymentDAO.insert(paymentDTO);
	}

	@Override
	public boolean update(PaymentDTO paymentDTO) {
		return this.paymentDAO.update(paymentDTO);
	}

	@Override
	public boolean delete(PaymentDTO paymentDTO) {
		//return this.paymentDAO.delete(paymentDTO);
		return false;
	}

	@Override
	public List<PaymentDTO> selectAll(PaymentDTO paymentDTO) {
		return this.paymentDAO.selectAll(paymentDTO);
	}

	@Override
	public PaymentDTO selectOne(PaymentDTO paymentDTO) {
		return this.paymentDAO.selectOne(paymentDTO);
	}

}
