USE `essentialmode`;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('nightclub',0,'bouncer','Bouncer',24,'{}','{}'),
	('nightclub',1,'bartender','Bartender',24,'{}','{}'),
	('nightclub',2,'security','Security',36,'{}','{}'),
	('nightclub',3,'manager',"Manager",48,'{}','{}'),
	('nightclub',4,'boss','Owner',60,'{}','{}'),
    ('offnightclub',0,'bouncer','Bouncer',0,'{}','{}'),
    ('offnightclub',1,'bartender','Bartender',0,'{}','{}'),
    ('offnightclub',2,'security','Security',0,'{}','{}'),
    ('offnightclub',3,'manager','Manager',0,'{}','{}'),
    ('offnightclub',4,'boss','Owner',0,'{}','{}')
;

INSERT INTO `jobs` (`name`, `label`) VALUES
    ('nightclub', 'Nightclub'),
    ('offnightclub', 'Off Duty Nightclub')
;

INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_nightclub','nightclub',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_nightclub','nightclub',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_nightclub', 'nightclub', 1)
;

CREATE TABLE `nightclub` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`zone` varchar(255) NOT NULL,
	`item` varchar(255) NOT NULL,
	`price` int(11) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `nightclub_store` (`zone`, `item`, `price`) VALUES
	('nightclub', 'WEAPON_SMOKEGRENADE', 100),
	('nightclub', 'WEAPON_APPISTOL', 1100),
	('nightclub', 'WEAPON_CARBINERIFLE', 12000),
	('nightclub', 'WEAPON_HEAVYSNIPER', 30000),
	('nightclub', 'WEAPON_MINIGUN', 45000),
	('nightclub', 'WEAPON_RAILGUN', 50000),
	('nightclub', 'WEAPON_STICKYBOMB', 500)
;
