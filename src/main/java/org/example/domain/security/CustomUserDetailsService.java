package org.example.domain.security;

import org.example.domain.CustomUser;
import org.example.domain.MemberVO;
import org.example.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

    @Setter(onMethod_ = @Autowired)
    private MemberMapper memberMapper;

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        log.warn("Load User By UserName: " + userName);

        // userName means userid
        MemberVO vo = memberMapper.read(userName);

        log.warn("queried by member mapper: " + vo);


        return vo == null ? null : new CustomUser(vo);
    }

}
