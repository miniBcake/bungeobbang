package com.bungeobbang.app.biz.board;

import java.util.List;

public interface BoardService {
	boolean insert(BoardDTO boardDTO);
	boolean update(BoardDTO boardDTO);
	boolean delete(BoardDTO boardDTO);
	List<BoardDTO> selectAll(BoardDTO boardDTO);
	BoardDTO selectOne(BoardDTO boardDTO);
}
