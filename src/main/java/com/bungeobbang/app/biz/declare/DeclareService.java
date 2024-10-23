package com.bungeobbang.app.biz.declare;

import java.util.List;

public interface DeclareService {
	boolean insert(DeclareDTO declareDTO);
	boolean update(DeclareDTO declareDTO);
	boolean delete(DeclareDTO declareDTO);
	List<DeclareDTO> selectAll(DeclareDTO declareDTO);
	DeclareDTO selectOne(DeclareDTO declareDTO);
}
