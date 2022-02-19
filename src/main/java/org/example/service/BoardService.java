package org.example.service;

import org.example.domain.BoardVO;
import org.example.domain.Criteria;

import java.util.List;

public interface BoardService {

    public void register(BoardVO board);

    public BoardVO get(Long bno);

    public boolean modify(BoardVO board);

    public boolean remove(Long bno);

    public List<BoardVO> getList(Criteria cri);

    int getTotal(Criteria cri);
}
