package com.bungeobbang.app.biz.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// BoardService의 구현체
@Service("boardService")
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardDAO boardDAO;

	@Override
	public List<BoardDTO> selectAll(BoardDTO boardDTO) {
		return this.boardDAO.selectAll(boardDTO);
	}

	@Override
	public BoardDTO selectOne(BoardDTO boardDTO) {
		
		return this.boardDAO.selectOne(boardDTO);
	}

	@Override
	public boolean insert(BoardDTO boardDTO) {
		
		return this.boardDAO.insert(boardDTO);
	}

	@Override
	public boolean update(BoardDTO boardDTO) {
		return this.boardDAO.update(boardDTO);
	}

	@Override
	public boolean delete(BoardDTO boardDTO) {
		return this.boardDAO.delete(boardDTO);
	}
	
	
	
}
