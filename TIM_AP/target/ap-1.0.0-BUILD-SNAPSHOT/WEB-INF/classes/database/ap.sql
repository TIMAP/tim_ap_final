USE MYSQL;

SELECT * FROM user;

CREATE USER 'ap'@'%' IDENTIFIED BY 'ap';

GRANT ALL PRIVILEGES ON *.* to 'ap'@'%';

CREATE DATABASE AP;

USE AP;

SHOW TABLES;

CREATE TABLE MEMBER (
	ID			INT(11)			UNSIGNED	NOT NULL	AUTO_INCREMENT,
	EMAIL		VARCHAR(255)	NOT NULL,
	PW			VARCHAR(255)	NOT NULL,
	NAME_LAST	VARCHAR(10)		NOT NULL,
	NAME_FIRST	VARCHAR(20)		NOT NULL,
	ROLE		CHAR(1)			NOT NULL	DEFAULT 'N',
    AUTH		CHAR(1)			NOT NULL	DEFAULT 'N',
	PRIMARY KEY (ID),
    UNIQUE KEY (EMAIL)
) ENGINE=INNODB;

CREATE TABLE CONFERENCE (
    ID		INT(11)			UNSIGNED	NOT NULL	AUTO_INCREMENT,
	TITLE	VARCHAR(255)	NOT NULL,
	DATE	VARCHAR(10)		NOT NULL,
	ROLE	CHAR(1)			NOT NULL DEFAULT 'N',
	ENTRY	TINYINT(2)		NOT NULL DEFAULT '2',
	PRIMARY KEY (ID)
) ENGINE=INNODB;

CREATE TABLE AUDIO (
	ID				INT(11)				UNSIGNED	NOT NULL	AUTO_INCREMENT,
	C_ID			INT(11)				UNSIGNED	NOT NULL,
	M_EMAIL			VARCHAR(255)		NOT NULL,
	TIME_BEG		VARCHAR(6)			NOT NULL,
	TIME_END		VARCHAR(6)			NOT NULL,
	AD_TEXT			TEXT,
	AD_WAV_FILEPATH	VARCHAR(500)		NOT NULL,
	AD_DOWNLOAD_CNT	INT(11) UNSIGNED	NOT NULL	DEFAULT '0',
	PRIMARY KEY (ID),
    INDEX `IDX_AUDIO_C_ID` (`C_ID`),
    INDEX `IDX_AUDIO_M_EMAIL` (`M_EMAIL`),
    FULLTEXT `IDX_AUDIO_AD_TEXT` (`AD_TEXT`)
) ENGINE=MYISAM;