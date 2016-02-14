CREATE SCHEMA `perltest` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE `perltest`.`distros` (
  `id` VARCHAR(32) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `date` DATE NULL,
  `update_timestamp` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`));
