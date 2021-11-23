-- 음악 정보 뷰
create view music_view (musicname, playtime, singer, writer, composer, albumname, publishdate, genrename)
as select mu.musicname, mu.playtime, mk.singer, mk.writer, mk.composer, a.albumname, a.publishdate, g.genrename
from music mu, genre g, maker mk, album a
where mu.musicid = mk.musicid and mu.albumid = album.albumid and m.genreid = g.genreid;

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

-- 멤버십 선택 및 결제(완성아님)
insert into usermembership (userid , membershipid)
select u.usernum, m.membershipid
from userinfo u, membership m
where u.usernum = 현재유저변수값 or m.membershipid = 클라이언트입력값;
UPDATE  USERMEMBERSHIP
SET     CARDNUMBER = '0000_1111_2222_3333'
WHERE   USERID = 현재유저변수값;

-- 멤버십 결제확인 후 관리자가 추가(완성아님)
update membership
set startdate = 확인날짜, enddate = 끝날짜
where userid = 확인된유저변수값;

--

-- 최근재생내역 보기
select m.musicname, h.timesplayed
from history h, music m, user u
where h.usernum = u.usernum and h.musicid = m.musicid
order by h.recenttime;


