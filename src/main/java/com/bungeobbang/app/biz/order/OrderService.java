package com.bungeobbang.app.biz.order;

import java.util.List;

public interface OrderService {
	boolean insert(OrderDTO orderDTO);
	boolean update(OrderDTO orderDTO);
	boolean delete(OrderDTO orderDTO);
	List<OrderDTO> selectAll(OrderDTO orderDTO);
	OrderDTO selectOne(OrderDTO orderDTOs);
}
