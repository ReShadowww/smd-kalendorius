DROP DATABASE if EXISTS smdcal;
CREATE DATABASE smdcal;

USE smdcal;

create table bureliai(
    id int auto_increment primary key,
    burelis varchar(255) not null,
    UNIQUE (burelis)
);

INSERT INTO `bureliai` (`id`, `burelis`) VALUES
	(10, 'Abdominalinės chirurgijos būrelis'),
	(16, 'Akių ligų būrelis'),
	(17, 'Anesteziologijos būrelis'),
	(3, 'Ausų, nosies ir gerklės ligų būrelis'),
	(23, 'Chirurgijos pagrindų mokykla'),
	(13, 'Endokrinologijos būrelis'),
	(18, 'Hematologijos, onkologijos ir transfuziologijos būrelis'),
	(6, 'Imunologijos ir alergologijos būrelis'),
	(5, 'Kardiologijos būrelis'),
	(7, 'Kineziterapijos būrelis'),
	(1, 'Klinikinės farmakologijos būrelis'),
	(9, 'Kraujagyslių chirurgijos būrelis'),
	(8, 'Maisto mokslo būrelis'),
	(11, 'Odos ir venerinių ligų būrelis'),
	(12, 'Ortopedijos – traumatologijos būrelis'),
	(4, 'Plastinės ir rekonstrukcinės chirurgijos būrelis'),
	(15, 'Psichiatrijos būrelis'),
	(2, 'Reabilitacijos būrelis'),
	(19, 'Širdies - krūtinės chirurgijos būrelis'),
	(14, 'Sveikatos psichologijos būrelis'),
	(20, 'Urologijos būrelis'),
	(21, 'Veido ir žandikaulių chirurgijos būrelis'),
	(22, 'Veterinarinės medicinos būrelis');