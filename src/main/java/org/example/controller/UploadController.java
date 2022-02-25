package org.example.controller;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import org.aspectj.apache.bcel.generic.MULTIANEWARRAY;
import org.example.domain.AttatchFileDTO;
import org.example.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Log4j
@Controller
public class UploadController {

    private String getFolder() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
        Date date = new Date();

        String str = sdf.format(date);
        return str.replace("-", File.separator);
    }

    @GetMapping("/uploadAjax")
    public void uploadAjax(){

        log.info("upload ajax");

    }

    @PostMapping(value="/uploadAjaxAction",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<AttatchFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
        log.info("update ajax post......");

        List<AttatchFileDTO> list = new ArrayList<>();
        String uploadFolder = "/Users/yuseongpyo/Desktop/ImageUpload";

        String uploadFolderPath = getFolder();
        //---- make folder------
        File uploadPath = new File(uploadFolder, uploadFolderPath);
        log.info("upload path: " + uploadPath);

        if (uploadPath.exists() == false) {
            uploadPath.mkdirs();
        }
        //make yyyy/MM/dd folder

        for (MultipartFile multipartFile : uploadFile) {

            log.info("--------------------------------");
            log.info("Upload File Name: " + multipartFile.getOriginalFilename());
            log.info("Upload File Size: " + multipartFile.getSize());
            String uploadFileName = multipartFile.getOriginalFilename();

            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
            log.info("only file name:" + uploadFileName);

            UUID uuid = UUID.randomUUID();
            uploadFileName = uuid.toString() + "_" + uploadFileName;


            try {
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);
                if (checkImageType(saveFile)) {
                    FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));

                    Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
                    thumbnail.close();
                }
            } catch (Exception e) {
                log.error(e.getMessage());

            }
        }
     return  new ResponseEntity<>(list, HttpStatus.OK);
    }

    private boolean checkImageType(File file) {
        try {
            String contentType = Files.probeContentType(file.toPath());
            return contentType.startsWith("image");
        }catch (IOException e){
            e.printStackTrace();
        }
        return false;
    }
}
