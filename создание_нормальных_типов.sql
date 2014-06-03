--создаем последовательность для будущей таблицы area_type
CREATE SEQUENCE area_type_gid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE area_type_gid_seq
  OWNER TO postgres;

-- создаем новый тип area
CREATE TABLE area_type
(
  gid integer DEFAULT nextval('area_type_gid_seq'::regclass),
  name character varying(100),
  CONSTRAINT area_type_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE area_type
  OWNER TO postgres;

INSERT INTO area_type(gid, name) VALUES (1, 'область');
INSERT INTO area_type(gid, name) VALUES (2, 'город');
INSERT INTO area_type(gid, name) VALUES (3, 'район');
INSERT INTO area_type(gid, name) VALUES (4, 'городской округ');
INSERT INTO area_type(gid, name) VALUES (5, 'сельсовет');
INSERT INTO area_type(gid, name) VALUES (6, 'поселок городского типа');
INSERT INTO area_type(gid, name) VALUES (7, 'рабочий поселок');
INSERT INTO area_type(gid, name) VALUES (8, 'курортный посёлок');
INSERT INTO area_type(gid, name) VALUES (9, 'село');
INSERT INTO area_type(gid, name) VALUES (10, 'поселок');
INSERT INTO area_type(gid, name) VALUES (11, 'деревня');
INSERT INTO area_type(gid, name) VALUES (12, 'слобода');
INSERT INTO area_type(gid, name) VALUES (13, 'микрорайон');

--меняем тип колонки type на text, чтобы мы могли поменять значения
ALTER TABLE locality ALTER COLUMN type TYPE text;

--меняем в таблице locality колонку type
--на gid из таблицы area_type
UPDATE locality SET type=3 WHERE type='город';
UPDATE locality SET type=6 WHERE type='поселок городского типа';
UPDATE locality SET type=7 WHERE type='рабочий поселок';
UPDATE locality SET type=9 WHERE type='село';
UPDATE locality SET type=10 WHERE type='поселок';
UPDATE locality SET type=11 WHERE type='деревня';
UPDATE locality SET type=12 WHERE type='слобода';

--меняем тип колонки type на integer
ALTER TABLE locality ALTER COLUMN type TYPE integer USING type::integer;

--меняем имя колонки на area_type_id
ALTER TABLE locality RENAME COLUMN type TO area_type_id;

--добавление ограничения с помощью внешнего ключа
ALTER TABLE locality ADD FOREIGN KEY (area_type_id) REFERENCES area_type;

