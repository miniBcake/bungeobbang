package com.bungeobbang.app.biz.point;

import java.util.List;

public interface PointService {
	boolean insert(PointDTO pointDTO);
	boolean update(PointDTO pointDTO);
	boolean delete(PointDTO pointDTO);
	List<PointDTO> selectAll(PointDTO pointDTO);
	PointDTO selectOne(PointDTO pointDTO);
}
