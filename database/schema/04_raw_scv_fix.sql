-- fixes for created database

insert into category_translation
values 
('pc_gamer', 'gaming_pc')
('portateis_cozinha_e_preparadores_de_alimentos', 'portable_kitchen_and_food_preparators')

alter table reviews 
add  PRIMARY KEY (review_id, order_id);

alter table geolocation
drop constraint geolocation_pkey

alter table geolocation
alter column geolocation_id type integer
