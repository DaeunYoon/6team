CREATE TABLE `account` (
  `ID` varchar(45) NOT NULL,
  `PW` varchar(45) NOT NULL,
  `Username` varchar(45) NOT NULL,
  `state` tinyint(3) unsigned zerofill NOT NULL,
  `report` int(10) unsigned zerofill NOT NULL,
  `evaluation` double unsigned zerofill NOT NULL,
  `PhoneNumber` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `review` (
  `SendID` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `contents` longtext NOT NULL,
  `evaluation` int(11) NOT NULL,
  `Rnum` int(11) NOT NULL,
  `RecieverID` varchar(45) NOT NULL,
  PRIMARY KEY (`Rnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `room_info` (
  `RoomID` int(11) NOT NULL,
  `cost` int(11) NOT NULL,
  `s_date` date NOT NULL,
  `e_date` date NOT NULL,
  `RoomScore` double unsigned zerofill NOT NULL DEFAULT '0000000000000000000000',
  `add1` varchar(45) NOT NULL,
  `add2` varchar(45) NOT NULL,
  `add3` varchar(45) NOT NULL,
  `add4` varchar(45) NOT NULL,
  `hostID` varchar(45) NOT NULL,
  `room_title` varchar(45) NOT NULL,
  PRIMARY KEY (`RoomID`),
  KEY `fk_Room_Info_Account1_idx` (`hostID`),
  CONSTRAINT `fk_Room_Info_Account1` FOREIGN KEY (`hostID`) REFERENCES `account` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `room_option` (
  `BedNumber` int(11) DEFAULT NULL,
  `Kitchen` tinyint(4) DEFAULT NULL,
  `internet` tinyint(4) DEFAULT NULL,
  `parking` tinyint(4) DEFAULT NULL,
  `RoomID` int(11) NOT NULL,
  PRIMARY KEY (`RoomID`),
  KEY `fk_Room_option_Room_Info_idx` (`RoomID`),
  CONSTRAINT `fk_Room_option_Room_Info` FOREIGN KEY (`RoomID`) REFERENCES `room_info` (`RoomID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `room_reserve_info` (
  `reserveNum` int(11) NOT NULL,
  `RoomID` int(11) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `conform` tinyint(4) NOT NULL DEFAULT '0',
  `guestID` varchar(45) NOT NULL,
  PRIMARY KEY (`reserveNum`),
  KEY `RoomID_idx` (`RoomID`),
  KEY `ID_idx` (`guestID`),
  CONSTRAINT `ID` FOREIGN KEY (`guestID`) REFERENCES `account` (`ID`),
  CONSTRAINT `RoomID` FOREIGN KEY (`RoomID`) REFERENCES `room_info` (`RoomID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
