package com.bungeobbang.app.biz.point;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("pointService")
public class PointServiceImpl implements PointService{
	
	@Autowired
	private PointDAO pointDAO;
	
	@Override
	public boolean insert(PointDTO pointDTO) {
		return this.pointDAO.insert(pointDTO);
	}

	@Override
	public boolean update(PointDTO pointDTO) {
		//return this.pointDAO.update(pointDTO);
		return false;
	}

	@Override
	public boolean delete(PointDTO pointDTO) {
		//return this.pointDAO.delete(pointDTO);
		return false;
	}

	@Override
	public List<PointDTO> selectAll(PointDTO pointDTO) {
		return this.pointDAO.selectAll(pointDTO);
	}

	@Override
	public PointDTO selectOne(PointDTO pointDTO) {
		return this.pointDAO.selectOne(pointDTO);
	}

}
