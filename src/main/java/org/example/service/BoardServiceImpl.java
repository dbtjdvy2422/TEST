package org.example.service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.example.domain.BoardAttachVO;
import org.example.domain.BoardVO;
import org.example.domain.Criteria;
import org.example.mapper.BoardAttachMapper;
import org.example.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Setter(onMethod_ = @Autowired)
    private BoardAttachMapper attachMapper;

    @Override
    public void register(BoardVO board) {
        log.info("register: " + board);
        mapper.insertSelectKey(board);

        if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
            return;
        }

        board.getAttachList().forEach(attach -> {
            attach.setBno(board.getBno());
            attachMapper.insert(attach);
        });

    }

    @Override
    public BoardVO get(Long bno) {
        log.info("get...............: " + bno);
        return mapper.read(bno);
    }

    @Transactional
    @Override
    public boolean modify(BoardVO board) {
        log.info("modify..............: " + board);

        attachMapper.deleteAll(board.getBno());

        boolean modifyResult = mapper.update(board) == 1;
        if (board != null) {
            if (modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
                System.out.println("여기도 안올리가?");
                board.getAttachList().forEach(attach -> {
                    attach.setBno(board.getBno());
                    attachMapper.insert(attach);
                });
            }
        }

        return mapper.update(board) == 1;
    }

    @Transactional
    @Override
    public boolean remove(Long bno) {
        log.info("remove......: " + bno);

        attachMapper.deleteAll(bno);

        return mapper.delete(bno) == 1;
    }

    @Override
    public List<BoardVO> getList(Criteria cri) {
        log.info("getList.............. with criteria: " + cri);
        return mapper.getList(cri);
    }

    @Override
    public int getTotal(Criteria cri) {
        log.info("get total count");
        return mapper.getTotalCount(cri);
    }

    @Override
    public List<BoardAttachVO> getAttachList(Long bno) {
        log.info("get Attach list by bno: " + bno);
        return attachMapper.findByBno(bno);
    }


}