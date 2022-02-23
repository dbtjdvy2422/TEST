package org.example.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.example.domain.Criteria;
import org.example.domain.ReplyVO;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
    @Setter(onMethod_ = {@Autowired})
    private ReplyMapper mapper;

    //테스트 전에 해당 번호 게시물이 존재하는지 꼭 확인
    private Long[] bnoArr = {1310732L, 1310731L, 1310730L, 1310729L, 1310728L };

    @Test
    public void testCreate() {
        IntStream.rangeClosed(1,  10).forEach(i->{
            ReplyVO vo = new ReplyVO();

            vo.setBno(bnoArr[i%5]);
            vo.setReply("댓글 테스트 " + i);
            vo.setReplyer("replyer" + i);

            mapper.insert(vo);
        });
    }

    @Test
    public void testMapper( ) {
        log.info(mapper);
    }

    @Test
    public void testRead() {
        Long targetRno = 5L;
        ReplyVO vo = mapper.read(targetRno);
        log.info(vo);
    }

    @Test
    public void testDelete() {
        Long targetRno = 2L;
        mapper.delete(targetRno);
    }

    @Test
    public void testUpdate() {
        Long targetRno = 3L;
        ReplyVO vo = mapper.read(targetRno);

        vo.setReply("Update Reply ");
        int count = mapper.update(vo);

        log.info("UPDATE COUNT: " + count);
    }

    @Test
    public void testList() {
        Criteria cri = new Criteria();
        List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
        replies.forEach(reply->log.info(reply));
    }

    @Test
    public void testList2() {
        Criteria cri = new Criteria(2, 10);
        List<ReplyVO> replies = mapper.getListWithPaging(cri, 1310732L );

        replies.forEach(reply -> log.info(reply));
    }
}
