package org.example.controller;

import lombok.extern.log4j.Log4j;
import org.example.domain.SampleDTO;
import org.example.domain.TodoDTO;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.print.DocFlavor;
import java.text.SimpleDateFormat;

@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, false));
    }

    @RequestMapping("")
    public  void basic(){
        log.info("basic...........");
    }



    @GetMapping("/ex01")
    public String ex01(SampleDTO dto){
        log.info(""+dto);
        return "ex01";
    }
    @GetMapping("/ex02")
    public String ex02(@RequestParam("name") String name, @RequestParam("age") int age) {

        log.info("name" + name);
        log.info("age" + age);
        return "ex02";
    }

    @GetMapping("/ex03")
        public String ex03(TodoDTO todo) {
            log.info("todo : " + todo );
            return "ex03";

    }
    @GetMapping("/ex04")
    public String ex04(SampleDTO dto) {
        log.info("dto:" + dto);

     return "/sample/ex04";
    }

    @GetMapping("/ex05")
    public void ex05() {
        log.info("/ex05........");

    }


    @GetMapping("/ex06")
    public @ResponseBody SampleDTO ex06() {
        log.info("/ex06........");
        SampleDTO dto =new SampleDTO();
        dto.setAge(10);
        dto.setName("yuseongpyo");
        return dto;
    }

    @GetMapping("/ex07")
    public ResponseEntity<String> ex07(){
        log.info("ex07....");

        //{"name":"홀길동"}
        String msg ="{\"name\": \"홍길동\"}";

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");

        return  new ResponseEntity<>(msg, headers, HttpStatus.OK);
    }
}
