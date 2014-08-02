--script

insert into TipoDemanda values
('N1','Nivel 1'),
('N2','Nivel 2'),
('N3','Nivel 3');

insert into TipoUsuario values
('ADMINISTRADOR'),
('ESTUDIANTE');

insert into Categoria values
('NOVELA'),
('COMICS'),
('DESARROLLO WEB'),
('EDUCACION'),
('INFORMATICA'),
('MATEMATICAS'),
('FILOSOFIA'),
('GEOGRAFIA / TURISMO'),
('IDIOMAS'),
('MARKETING / BUSINESS'),
('MULTIMEDIA'),
('REVISTAS'),
('LENGUAJE'),
('HISTORIA');

insert into Editorial values
('ASOCIACIÓN EDITORIAL BRUÑO','Sr. Augusto Federico Díaz Tineo','Av. Arica 751. Breña', '4244134 / 4237890'),
('CENTAURO EDICIONES S.A.C.','Sr. Óscar Gustavo Zevallos García','Jr. Luis Varela y Orbegoso 565.', '4440900'),
('EDICIONES SM S.A.C.','Guillermo Alejandro Rivas','Calle Micaela Bastidas 125. San Isidro.', '6148900 / 6148904'),
('EDITORIAL COVEÑAS S.A.C','Manuel Coveñas Naquiche','Jr. Las Verdolagas No. 199 Urb. Micaela Bastidas. Los Olivos.', '521-0949 / 4867957'),
('EDITORIAL SAN MARCOS E.I.R.L.','Sr. Anibal Jesús Paredes Galván','Jr. Dávalos Lisson 135. Lima.', '3311522 / 3311535'),
('EMPRESA EDITORA MACRO E.I.R.L.','Sra. Isabel Rosario Ramos','Av. Paseo de la República 5613. Miraflores.', '7199701 / 7199702'),
('GRUPO EDITORIAL NORMA S.A.C.','Álvaro Ruíz','Av. Canaval y Moreyra 345. San Isidro.', '7103000'),
('LIBRERÍA PERUANO BRITÁNICA S.R.L.','Franco Ramírez Reyes','Av. Uiversitaria Mz A Lt 5. Urb. La Libertad. Los Olivos','531-7712 -2413768'),
('MACMILLAN PUBLISHERS S.A.','Sr. Javier Lombardi Wilson','Calle Manuel Tovar 252. Miraflores.','4410311'),
('MEGA EDITORES S.A.C.','Sr. Mario Jesús Minaya García','Calle Río Majes Nº246.Parque San Martín-Ruinas Puruchuco. Ate.','4626221 / 4093030'),
('NUEVAS TÉCNICAS EDUCATIVAS S.A.C. – NUTESA','Sr. Enrique Cappelletti Sotomayor','Av. República de Panamá 2197, 2º piso – Of. 2B. La Victoria.','4721712 / 2058642'),
('PEARSON EDUCACIÓN DEL PERÚ S.A.C.','Sr. Eduardo Guzmán Barro','Av. Javier Prado Este 4491. Surco.','4372010 / 4372015'),
('SANTILLANA S.A.','Sr. Javier Laría Quincoces','Av. Primavera 2160. Surco.','3134000'),
('SPECIAL BOOKS SERVICES S.A.','Sra. PaulaTapia Álvarez Gerente ','Av. Angamos Oeste 301. Miraflores.','206-4900');


insert into Universidad values
('Universidad Nacional del Callao (UNAC)','Av. Juan Pablo II 306, Bellavista - Callao'),
('Universidad Nacional Mayor de San Marcos (UNMSM)','Av. Universitaria /Av. Germán Amézaga s/n. Edificio Jorge Basadre Ciudad Universitaria'),
('Universidad Nacional Agraria La Molina','Av. La Molina'),
('Univ. Nac. de Educación Enrique Guzmán y Valle (UNE)','Av. Enrique Guzmán y Valle s/n, La Cantuta - Chosica'),
('Universidad Nacional de Ingeniería - UNI','Av. Túpac Amaru 210 - Rimac '),
('Universidad Privada San Juan Bautista (UPSJB)','Av. Jose Antonio Lavalle s/n Hacienda Villa - Chorrillos'),
('Universidad Inca Garcilaso de la Vega (UIGV)',' Av. San Felipe 890, Jesús María'),
('Universidad Peruana de las Américas','Av. Garcilaso de la Vega Nº 1880'),
('Universidad Tecnológica del Perú (UTP)','Esquina Av. 28 de Julio y Av. Petit Thouars'),
('Universidad del Pacífico (UP)','Av. Salaverry 2020 Jesús María'),
('Universidad San Ignacio de Loyola (USIL)','Av. La Fontana 550, La Molina'),
('Universidad Femenina del Sagrado Corazón (UNIFE)','Av. Los Frutales 954 Urb. Santa Magdalena Sofía, La Molina'),
('Universidad Peruana de Ciencias Aplicadas (UPC)','Prolongación Primavera 2390, Monterrico'),
('Universidad de Lima (ULIMA)','Av. Javier Prado Este s/n, Monterrico'),
('Universidad de San Martín de Porres (USMP)','Ciudad Universitaria Av. Las Calandrias s/n Santa Anita'),
('Pontificia Universidad Católica del Perú (PUCP)','Av. Universitaria 1801, San Miguel'),
('Universidad Peruana Cayetano Heredia (UPCH)','Av. Honorio Delgado 430, Urb. Ingeniería, S.M.P.'),
('Universidad de Piura - PAD',' Aldebarán 160, Surco'),
('Universidad Científica del Sur (UCSUR)','Cantuarias 385, Miraflores '),
('Universidad Privada del Norte (UPNORTE)','Av. Del Ejército 920 - Urb. El Molino'),
('Universidad Católica Sedes Sapientiae (UCSS)','Esquina Constelaciones y Sol de Oro S/N Urbanización Sol de Oro. Los Olivos'),
('Universidad Cesar Vallejo (UCV)','AV. Alfredo Mendiola 6232 - Panamericana Norte, Los Olivos'),
('Universidad Alas Peruanas (UAP)','Av. San Felipe 1109. Jesús Maria');

insert into Instituto values
('Toulouse Lautrec','Av. Primavera 970 Chacarilla Surco'),
('Tecsup','Av. Cascanueces 2221 Santa Anita'),
('Sencico','Av. De la Poesía 351- San Borja'),
('Senati','Av. Alfredo Mendiola # 3520 Independencia'),
('ISIL','Av. La Fontana 795'),
('CIMAS','Avenida Garcilaso de la Vega, Lima 15001'),
('SISE','Av. Larco 756 - Miraflores'),
('IPP','Av Jorge Basadre, Lima'),
('IPM','Vía Expresa Paseo de la República 6099'),
('IPAD','Av. Benavides 715 Miraflores'),
('Instituto Metropolitano','Av. Arequipa 694 (Frente al Parque de las Aguas)'),
('Iberotec','Av. Arenales 1555, Lince'),
('IFB','Av. Santiago de Surco 4717 Surco'),
('Cibertec','Psje. Tello 285 cruce con Av. Diez Canseco'),
('ADEX','Av Javier Prado Este 2875'),
('I.E.S.T.P “Daniel Alcides Carrión”','Jr. Saco Oliveros 150 / Av. Arequipa'),
('Computronic','Av. Uruguay 360 – Cercado de Lima '),
('Columbia','Av. Paseo de la República 2232 Via Expresa- Lince');

insert into Distribuidor values
('20112949101','Libun','Avenida Petit Thouars, 4799 MIRAFLORES ','446 5048'),
('20100472342','Librería Minerva','Avenida Angamos Este, 2593 SAN BORJA','475 5510'),
('20100845789','Librería Pizarro','Avenida Ignacio Merino, 2330 LINCE','422 6420'),
('20108945689','Grandes Libros','Calle Casagrande, 157 SANTIAGO DE SURCO','387 5520');
