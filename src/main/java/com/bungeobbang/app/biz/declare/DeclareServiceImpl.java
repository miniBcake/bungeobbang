package com.bungeobbang.app.biz.declare;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("declareService")
public class DeclareServiceImpl implements DeclareService{
	@Autowired
	private DeclareDAO declareDAO;

	@Override
	public boolean insert(DeclareDTO declareDTO) {
		return declareDAO.insert(declareDTO);
	}

	@Override
	public boolean update(DeclareDTO declareDTO) {
		return false;
	}

	@Override
	public boolean delete(DeclareDTO declareDTO) {
		return declareDAO.delete(declareDTO);
	}
	
	@Override
	public List<DeclareDTO> selectAll(DeclareDTO declareDTO) {
		return declareDAO.selectAll(declareDTO);
	}
	
	@Override
	public DeclareDTO selectOne(DeclareDTO declareDTO) {
		return null;
	}
}
