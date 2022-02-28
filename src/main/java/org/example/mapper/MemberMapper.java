package org.example.mapper;

import org.example.domain.MemberVO;

public interface MemberMapper {
    public MemberVO read(String userid);
}