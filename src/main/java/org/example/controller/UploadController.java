package org.example.controller;

import lombok.extern.log4j.Log4j;
import org.example.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

@Log4j
@Controller
public class UploadController {

    @GetMapping("/uploadAjax")
    public void uploadAjax(){

        log.info("upload ajax");

    }

    @PostMapping("/uploadAjaxAction")
    public void uploadAjaxPost(MultipartFile[] uploadFile){
        log.info("update ajax post......");

        String uploadFolder = "/Users/yuseongpyo/Desktop/ImageUpload";

        for(MultipartFile multipartFile : uploadFile) {

            log.info("--------------------------------");
            log.info("Upload File Name: "+multipartFile.getOriginalFilename());
            log.info("Upload File Size: " + multipartFile.getSize() );
            String uploadFileName = multipartFile.getOriginalFilename();

            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") +1);
            log.info("only file name:" + uploadFileName);

            File saveFile =new File(uploadFolder, uploadFileName);

            try{
                multipartFile.transferTo(saveFile);

            }catch (Exception e){
                log.error(e.getMessage());

            }
        }
    }
}
