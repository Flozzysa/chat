USE `es_extended`;

ALTER TABLE `owned_vehicles`
ADD COLUMN `stored` TINYINT NOT NULL DEFAULT '0';
