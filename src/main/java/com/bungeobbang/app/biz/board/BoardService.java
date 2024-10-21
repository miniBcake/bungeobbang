package com.fproject.app.biz.board;

import java.util.ArrayList;

public interface BoardService {
	ArrayList<BoardDTO> selectAll(BoardDTO boardDTO);
	BoardDTO selectOne(BoardDTO boardDTO);
	boolean insert(BoardDTO boardDTO);
	boolean update(BoardDTO boardDTO);
	boolean delete(BoardDTO boardDTO);
}
