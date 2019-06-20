INSERT INTO `mydb`.`account`
(`ID`,`PW`,`Username`,`state`,`report`,`evaluation`,`PhoneNumber`)
VALUES
('owner1@naver.com','Testacc1!','owner1','0','0','0','01011111111');

INSERT INTO `mydb`.`account`
(`ID`,`PW`,`Username`,`state`,`report`,`evaluation`,`PhoneNumber`)
VALUES
('owner2@naver.com','Testacc1!','owner2','0','0','0','01022222222');

INSERT INTO `mydb`.`account`
(`ID`,`PW`,`Username`,`state`,`report`,`evaluation`,`PhoneNumber`)
VALUES
('lessor1@naver.com','Testacc1!','lessor1','0','0','0','01033333333');

INSERT INTO `mydb`.`account`
(`ID`,`PW`,`Username`,`state`,`report`,`evaluation`,`PhoneNumber`)
VALUES
('lessor2@naver.com','Testacc1!','lessor2','0','0','0','01044444444');

INSERT INTO `mydb`.`room_info`
(`RoomID`,`cost`,`s_date`,`e_date`,`add1`,`add2`,`add3`,`add4`,`hostID`,`room_title`,`max_p`)
VALUES
('1','50000','2019-07-01','2019-07-30','대구광역시','북구','대현동', '집1', 'owner1@naver.com', '5');

INSERT INTO `mydb`.`room_info`
(`RoomID`,`cost`,`s_date`,`e_date`,`add1`,`add2`,`add3`,`add4`,`hostID`,`room_title`,`max_p`)
VALUES
('2','70000','2019-07-01','2019-07-30','서울특별시','강남구','삼성동', '우리집', 'owner2@naver.com', '10');

INSERT INTO `mydb`.`room_info`
(`RoomID`,`cost`,`s_date`,`e_date`,`add1`,`add2`,`add3`,`add4`,`hostID`,`room_title`,`max_p`)
VALUES
('3','100000','2019-07-01','2019-07-30','경상남도','창원시 진해구','풍호동', '본가', 'owner1@naver.com', '20');

INSERT INTO `mydb`.`room_info`
(`RoomID`,`cost`,`s_date`,`e_date`,`add1`,`add2`,`add3`,`add4`,`hostID`,`room_title`,`max_p`)
VALUES
('4','1000000','2019-07-01','2019-07-30','경상남도','밀양시','어느동', '집3', 'owner2@naver.com', '2');

INSERT INTO `mydb`.`room_option`
(`BedNumber`, `Kitchen`,`internet`,`parking`,`RoomID`,`content`)
VALUES
('3','1','1','1','1','좋아요 깨끗해요 바퀴없어요');

INSERT INTO `mydb`.`room_option`
(`BedNumber`, `Kitchen`,`internet`,`parking`,`RoomID`,`content`)
VALUES
('5','1','0','1','2','비싸요');

INSERT INTO `mydb`.`room_option`
(`BedNumber`, `Kitchen`,`internet`,`parking`,`RoomID`,`content`)
VALUES
('10','1','1','1','3','오션뷰 귀여운 강아지');

INSERT INTO `mydb`.`room_option`
(`BedNumber`, `Kitchen`,`internet`,`parking`,`RoomID`,`content`)
VALUES
('4','1','0','0','4','얼음골 시원해요');
