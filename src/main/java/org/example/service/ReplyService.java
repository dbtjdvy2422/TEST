package org.example.service;

import org.example.domain.Criteria;
import org.example.domain.ReplyPageDTO;
import org.example.domain.ReplyVO;

import java.util.List;

public interface ReplyService {

    public int register(ReplyVO vo);
    public ReplyVO get(Long rno);
    public int modify(ReplyVO vo);
    public int remove(Long rno);
    public List<ReplyVO> getList(Criteria cri, Long bno);
    public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
