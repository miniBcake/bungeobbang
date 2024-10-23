package com.bungeobbang.app.biz.product;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
//productService 구현체
@Service("productService")
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductDAO productDAO;

	@Override
	public ArrayList<ProductDTO> selectAll(ProductDTO productDTO) {
		return this.productDAO.selectAll(productDTO);
	}

	@Override
	public ProductDTO selectOne(ProductDTO productDTO) {
		
		return this.productDAO.selectOne(productDTO);
	}

	@Override
	public boolean insert(ProductDTO productDTO) {
		return this.productDAO.insert(productDTO);
	}

	@Override
	public boolean update(ProductDTO productDTO) {
		return this.productDAO.update(productDTO);
	}

	@Override
	public boolean delete(ProductDTO productDTO) {
		return this.productDAO.delete(productDTO);
	}
	
}
