package org.example.service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.example.domain.BoardVO;
import org.example.domain.Criteria;
import org.example.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Override
    public void register(BoardVO board) {

        log.info("register...."+board);
        mapper.insertSelectKey(board);
    }

    @Override
    public BoardVO get(Long bno) {
        log.info("get....");
        return mapper.read(bno);
    }

    @Override
    public boolean modify(BoardVO board) {
        return false;
    }

    @Override
    public boolean remove(Long bno) {
        return false;
    }

    @Override
    public List<BoardVO> getList(Criteria cri) {
        log.info("getList with criteria:" +cri);
        return mapper.getListWithPaging(cri);
    }
    @Override
    public int getTotal(Criteria cri) {
        log.info("get total cnt");
        return mapper.getTotalCount(cri);
    }

}
