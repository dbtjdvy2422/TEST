package org.example.domain;

import lombok.Data;

@Data
public class AttatchFileDTO {

    private String fileName;
    private String uploadPath;
    private String uuid;
    private boolean image;
}
