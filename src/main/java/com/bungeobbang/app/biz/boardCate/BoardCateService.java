package com.bungeobbang.app.biz.boardCate;

import java.util.List;

public interface BoardCateService {
	List<BoardCateDTO> selectAll(BoardCateDTO boardCateDTO);
	BoardCateDTO selectOne(BoardCateDTO boardCateDTO);
	boolean insert(BoardCateDTO boardCateDTO);
	boolean update(BoardCateDTO boardCateDTO);
	boolean delete(BoardCateDTO boardCateDTO);
}
