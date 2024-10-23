package com.bungeobbang.app.biz.payment;

import java.util.List;

public interface PaymentService {
	boolean insert(PaymentDTO paymentDTO);
	boolean update(PaymentDTO paymentDTO);
	boolean delete(PaymentDTO paymentDTO);
	List<PaymentDTO> selectAll(PaymentDTO paymentDTO);
	PaymentDTO selectOne(PaymentDTO paymentDTO);
}
