package com.bungeobbang.app.biz.boardCate;

import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

//@Repository
@Slf4j
public class BoardCateDAO2 {
    //@Autowired
    private JdbcTemplate jdbcTemplate;

    private final String INSERT = "INSERT INTO BB_BOARD_CATEGORY (CATEGORY_NAME) VALUES (?)";
    private final String UPDATE = "UPDATE BB_BOARD_CATEGORY SET CATEGORY_NAME = ? WHERE CATEGORY_NUM = ?";
    private final String DELETE = "DELETE FROM BB_BOARD_CATEGORY WHERE CATEGORY_NUM = ?";
    private final String SELECTALL = "SELECT CATEGORY_NUM, CATEGORY_NAME FROM BB_BOARD_CATEGORY ORDER BY CATEGORY_NUM";

    public boolean insert(BoardCateDTO boardCateDTO) {
        log.info("Insert BoardCateDTO getBoardCateName: [{}]", boardCateDTO.getBoardCateName());
        return jdbcTemplate.update(INSERT, boardCateDTO.getBoardCateName()) > 0;
    }

    public boolean update(BoardCateDTO boardCateDTO) {
        log.info("Update BoardCateDTO getBoardCateName : [{}] getBoardCateNum : [{}]", boardCateDTO.getBoardCateName(), boardCateDTO.getBoardCateNum());
        return jdbcTemplate.update(UPDATE, boardCateDTO.getBoardCateName(), boardCateDTO.getBoardCateNum()) > 0;
    }

    public boolean delete(BoardCateDTO boardCateDTO) {
        log.info("Delete BoardCateDTO getBoardCateNum : [{}]", boardCateDTO.getBoardCateNum());
        return jdbcTemplate.update(DELETE, boardCateDTO.getBoardCateNum()) > 0;
    }

    public List<BoardCateDTO> selectAll(BoardCateDTO boardCateDTO) {
        //Object[] args = {};넣을 값이 없으므로 생략
        //반환타입이 List
        return jdbcTemplate.query(SELECTALL, new BoardCateMapper());
    }

    private BoardCateDTO selectOne(BoardCateDTO boardCateDTO) {
        BoardCateDTO data = null;
        return data;
    }
}

//반환 타입 설정
class BoardCateMapper implements RowMapper<BoardCateDTO> {
    @Override
    public BoardCateDTO mapRow(ResultSet resultSet, int i) throws SQLException {
        BoardCateDTO data = new BoardCateDTO();
        data.setBoardCateName(resultSet.getString("CATEGORY_NAME"));
        data.setBoardCateNum(resultSet.getInt("CATEGORY_NUM"));
        return data;
    }
}
