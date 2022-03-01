package org.example.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.example.domain.BoardAttachVO;
import org.example.domain.BoardVO;
import org.example.domain.Criteria;
import org.example.domain.PageDTO;
import org.example.service.BoardService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

    private BoardService service;

    @GetMapping("/list")
    public void list(Criteria cri, Model model){
        log.info("list" + cri);
        model.addAttribute("list",service.getList(cri));
        model.addAttribute("pageMaker", new PageDTO(cri,123));

        int total =service.getTotal(cri);

        log.info("total: " + total);

        model.addAttribute("pageMaker" ,new PageDTO(cri, total));
    }

    @GetMapping("/register")
    @PreAuthorize("isAuthenticated()")
    public void register(){

    }
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/register")
    public String register(BoardVO board, RedirectAttributes rttr) {

        log.info("=================================================");
        log.info("register: " + board);

        if (board.getAttachList() != null) {
            board.getAttachList().forEach(attach -> log.info(attach));
        }

        log.info("=================================================");

        service.register(board);

        rttr.addFlashAttribute("result", board.getBno());

        return "redirect:/board/list";
    }

    @GetMapping({"/get","/modify"})
    public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
        log.info("/get or modify");
        model.addAttribute("board",service.get(bno));
    }

    @PreAuthorize("principal.username == #writer")
    @PostMapping("/modify")
    public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) {
        log.info("modify: " + board);
        if(service.modify(board)) {
            rttr.addFlashAttribute("result", "sucess");
        }
        return "redirect:/board/list" + cri.getListLink();
    }

    @PreAuthorize("principal.username == #writer")
    @PostMapping("/remove")
    public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr ,String writer) {
        List<BoardAttachVO> attachList = service.getAttachList(bno);
        log.info("remove..." + bno);;
        if(service.remove(bno))
        {
            //delete attach files
            deleteFiles(attachList);
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/board/list" + cri.getListLink();
    }

    private void deleteFiles(List<BoardAttachVO> attachList) {
        if (attachList == null || attachList.size() == 0) {
            return;
        }

        log.info("delete attach files.......................");
        log.info(attachList);

        attachList.forEach(attach -> {
            try {
                Path file = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());

                Files.deleteIfExists(file);

                if (Files.probeContentType(file).startsWith("image")) {
                    Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());

                    Files.delete(thumbNail);
                }

            } catch(Exception e) {
                log.error("delete file error " + e.getMessage());
            }


        });

    }
}
