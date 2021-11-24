-- 음악 정보 뷰
create view music_view (musicname, playtime, singer, writer, composer, albumname, publishdate, genrename)
as select mu.musicid mu.musicname, mu.playtime, mk.singer, mk.writer, mk.composer, a.albumname, a.publishdate, g.genrename
from music mu, genre g, maker mk, album a
where mu.musicid = mk.musicid and mu.albumid = album.albumid and m.genreid = g.genreid
with read only;

-- 유저 정보 뷰
create view user_view
as select u.emailid, u.nickname, u.userfname, u.userlname, u.bday, u.passwd, m.membershipname, um.startdate, um.enddate
from userinfo u, membership m, usermembership um
where u.usernum = um.userid and um.membershipid = m.membershipid and u.countryid = m.countryid;

-- 이용자 회원가입
insert into userinfo values (랜덤함수, '입력값', '입력값','입력값','입력값', '0000-00-00', '입력값','KOR');

-- 이용자 로그인
select *
from userinfo
where emailid = '입력값' and passwd = '입력값';

-- 멤버십 선택 및 결제
insert into usermembership (userid , membershipid)
select u.usernum, m.membershipid
from userinfo u, membership m
where u.usernum = 현재유저변수값 or m.membershipid = 클라이언트입력값;
UPDATE  USERMEMBERSHIP
SET     CARDNUMBER = '0000_1111_2222_3333'
WHERE   USERID = 현재유저변수값;
-- 멤버십 결제확인 후 관리자가 추가
update membership
set startdate = 확인날짜, enddate = 끝날짜
where userid = 확인된유저변수값;

-- 재생목록 만들기
insert into playlist(userid, plid, plname, is_public, createdate)
select u.usernum, 랜덤값함수, 클라이언트입력값, 0, 현재날짜값
from userinfo u
where u.usernum = 현재유저변수값;
-- (공개여부 변경시)
update playlist
set is_public = 1
where u.usernum = 현재유저변수값 and p.plid = 현재재생목록값(클라이언트);
-- 곡 추가[미완/정상작동보장x]
insert into music_playlist(plid, musicid, priority)
select p.plid, m.musicid, max(p.priority)+1
from playlist p, music m
where p.plid = 클라이언트선택값 and p.userid = 현재유저변수값 or m.musicid = 클라이언트선택값
-- 재생목록 곡 순서변경[미완]: 아이디어가 안떠오름


-- 곡 검색(뷰 사용)
select musicname, playtime, singer, albumname
from music_view
where musicname = 클라이언트입력값;

-- 곡 재생(뷰 사용)
select playtime, musicname, singer, albumname
from music_view
where musicid = 클라이언트선택값;

-- 최근재생내역 보기
select m.musicname, h.timesplayed
from history h, music m, user u
where h.usernum = u.usernum and h.musicid = m.musicid
order by h.recenttime;

-- 이용자 정보 수정
update user_view
set emailid = 입력값, nickname = 입력값, userfname = 입력값, userlname = 입력값 -- 일부만 쿼리도 가능
where emailid = 기존id값 -- 식별용
-- 비밀번호 변경: 인증번호는 클라이언트단에서 처리
update user_view
set passwd = 변경값
where emailid = 클라이언트입력값
-- id찾기
select emailid
from user_view
where userfname = 입력값 and userlname = 입력값 and bday = 입력값

-- 고객지원
insert into support
select 랜덤값, u.usernum, st.inquiry_code, 현재시간, 0
from userinfo u, support_type st
where u.usernum = 현재유저변수값 or inquiry_reason = 클라이언트선택값;
-- 문의처리여부 변경
update support
   set iscomplete = 1
 where csid = 서버선택값;

-- 계정탈퇴요청
insert into support
select 랜덤값, u.usernum, 2, 현재시간, 0 -- 코드2번 계정삭제
from userinfo u
where u.usernum = 현재유저변수값;
-- 계정탈퇴처리
delete from userinfo
 where usernum in
 ( select usernum
   from support
  where inquiry_code = 2 and inquiry_time = 서버선택값 );

-- 앨범추가
-- 음원추가
-- 앨범삭제
-- 음원삭제

