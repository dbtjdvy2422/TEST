package org.example.domain;

import lombok.Data;

import java.util.Date;

@Data
public class BoardVO {

    private Long bno;
    private String title;
    private String Content;
    private String writer;
    private Date regdate;
    private Date updateDate;
}
