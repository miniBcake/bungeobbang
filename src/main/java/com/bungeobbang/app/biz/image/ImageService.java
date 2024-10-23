package com.bungeobbang.app.biz.image;

import java.util.ArrayList;

public interface ImageService {
	ArrayList<ImageDTO> selectAll(ImageDTO imageDTO);
	ImageDTO selectOne(ImageDTO imageDTO);
	boolean insert(ImageDTO imageDTO);
	boolean update(ImageDTO imageDTO);
	boolean delete(ImageDTO imageDTO);
}
