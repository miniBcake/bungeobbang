package com.bungeobbang.app.biz.image;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//imageService 구현체
@Service("imageService")
public class ImageServiceImpl implements ImageService{
	@Autowired
	private ImageDAO imageDAO;
	
	@Override
	public ArrayList<ImageDTO> selectAll(ImageDTO imageDTO) {
		
		return this.imageDAO.selectAll(imageDTO);
	}

	@Override
	public ImageDTO selectOne(ImageDTO imageDTO) {
	
		return null;
	}

	@Override
	public boolean insert(ImageDTO imageDTO) {
	
		return this.imageDAO.insert(imageDTO);
	}

	@Override
	public boolean update(ImageDTO imageDTO) {
	
		return false;
	}

	@Override
	public boolean delete(ImageDTO imageDTO) {

		return this.imageDAO.delete(imageDTO);
	}
	
}
