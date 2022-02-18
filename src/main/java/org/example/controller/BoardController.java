package org.example.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.example.domain.BoardVO;
import org.example.domain.Criteria;
import org.example.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    }

    @GetMapping("/register")
    public void register(){

    }
    @PostMapping("/register")
    public String register (BoardVO board, RedirectAttributes rttr) {
        log.info("register" +board);
        service.register(board);
        rttr.addFlashAttribute("result" , board.getBno());
        return "redirect:/board/list";
    }
    @GetMapping({"/get","/modify"})
    public void get(@RequestParam("bno") Long bno, Model model) {
        log.info("/get or modify");
        model.addAttribute("board",service.get(bno));
    }
}
