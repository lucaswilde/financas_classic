--
-- PostgreSQL database dump
--

-- Started on 2014-04-13 20:25:34

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1759 (class 1262 OID 17877)
-- Name: financas; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE financas WITH TEMPLATE = template0 ENCODING = 'UTF8';


ALTER DATABASE financas OWNER TO postgres;

\connect financas

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 298 (class 2612 OID 16386)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1470 (class 1259 OID 17878)
-- Dependencies: 6
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE categoria (
    cod_categoria integer NOT NULL,
    descricao character varying(50) NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 1471 (class 1259 OID 17881)
-- Dependencies: 6
-- Name: lancamento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lancamento (
    cod_lancamento integer NOT NULL,
    valor numeric(9,2) NOT NULL,
    data date NOT NULL,
    observacao character varying(300),
    cod_categoria integer NOT NULL,
    tipo character varying(1) NOT NULL
);


ALTER TABLE public.lancamento OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 1472 (class 1259 OID 17884)
-- Dependencies: 6
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuarios (
    login character varying(30) NOT NULL,
    senha character varying(15) NOT NULL,
    cod_usuario integer NOT NULL,
    nome character varying(30) NOT NULL,
    administrador boolean
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 1473 (class 1259 OID 17887)
-- Dependencies: 6
-- Name: seq_categoria; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_categoria
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_categoria OWNER TO postgres;

--
-- TOC entry 1762 (class 0 OID 0)
-- Dependencies: 1473
-- Name: seq_categoria; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_categoria', 46, true);


--
-- TOC entry 1474 (class 1259 OID 17889)
-- Dependencies: 6
-- Name: seq_lancamento; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_lancamento
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_lancamento OWNER TO postgres;

--
-- TOC entry 1763 (class 0 OID 0)
-- Dependencies: 1474
-- Name: seq_lancamento; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_lancamento', 1235, true);


--
-- TOC entry 1475 (class 1259 OID 17891)
-- Dependencies: 6
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_usuario
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario OWNER TO postgres;

--
-- TOC entry 1764 (class 0 OID 0)
-- Dependencies: 1475
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_usuario', 4, true);


--
-- TOC entry 1754 (class 0 OID 17878)
-- Dependencies: 1470
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO categoria (cod_categoria, descricao) VALUES (3, 'MERCADO');
INSERT INTO categoria (cod_categoria, descricao) VALUES (4, 'ACADEMIA');
INSERT INTO categoria (cod_categoria, descricao) VALUES (11, 'GERAL');
INSERT INTO categoria (cod_categoria, descricao) VALUES (14, 'PRESENTE');
INSERT INTO categoria (cod_categoria, descricao) VALUES (16, 'MONTANA');
INSERT INTO categoria (cod_categoria, descricao) VALUES (17, 'VIAGEM');
INSERT INTO categoria (cod_categoria, descricao) VALUES (19, 'SALÁRIO');
INSERT INTO categoria (cod_categoria, descricao) VALUES (20, 'MESADA');
INSERT INTO categoria (cod_categoria, descricao) VALUES (22, 'MOTO');
INSERT INTO categoria (cod_categoria, descricao) VALUES (23, 'VALE ALIMENTAÇÃO');
INSERT INTO categoria (cod_categoria, descricao) VALUES (6, 'ROUPAS / CALÇADOS / UTILIDADES');
INSERT INTO categoria (cod_categoria, descricao) VALUES (21, 'SAÚDE');
INSERT INTO categoria (cod_categoria, descricao) VALUES (12, 'RESTAURANTE');
INSERT INTO categoria (cod_categoria, descricao) VALUES (24, 'YOGA');
INSERT INTO categoria (cod_categoria, descricao) VALUES (25, 'LUZ');
INSERT INTO categoria (cod_categoria, descricao) VALUES (26, 'CONDOMINIO');
INSERT INTO categoria (cod_categoria, descricao) VALUES (29, 'BENS DURAVEIS');
INSERT INTO categoria (cod_categoria, descricao) VALUES (28, 'SALAO DE BELEZA');
INSERT INTO categoria (cod_categoria, descricao) VALUES (31, 'PILATES');
INSERT INTO categoria (cod_categoria, descricao) VALUES (18, 'CURSOS / ESTUDOS');
INSERT INTO categoria (cod_categoria, descricao) VALUES (32, 'INTERNET');
INSERT INTO categoria (cod_categoria, descricao) VALUES (33, 'TELEFONE');
INSERT INTO categoria (cod_categoria, descricao) VALUES (34, 'DENTISTA');
INSERT INTO categoria (cod_categoria, descricao) VALUES (35, 'FARMACIA');
INSERT INTO categoria (cod_categoria, descricao) VALUES (36, 'PRODUTOS PARA O SALAO');
INSERT INTO categoria (cod_categoria, descricao) VALUES (37, 'VIDEO LOCADORA');
INSERT INTO categoria (cod_categoria, descricao) VALUES (38, 'FORMATURA');
INSERT INTO categoria (cod_categoria, descricao) VALUES (39, 'APARTAMENTO');
INSERT INTO categoria (cod_categoria, descricao) VALUES (40, 'COMBUSTÍVEL MOTO');
INSERT INTO categoria (cod_categoria, descricao) VALUES (2, 'COMBUSTÍVEL CARRO');
INSERT INTO categoria (cod_categoria, descricao) VALUES (8, 'DIVERSÃO');
INSERT INTO categoria (cod_categoria, descricao) VALUES (41, 'ESTACIONAMENTO');
INSERT INTO categoria (cod_categoria, descricao) VALUES (42, 'ALUGUEL');
INSERT INTO categoria (cod_categoria, descricao) VALUES (43, 'ONIBUS');
INSERT INTO categoria (cod_categoria, descricao) VALUES (44, 'SALÁRIO FABIANE');
INSERT INTO categoria (cod_categoria, descricao) VALUES (45, 'ANUIDADE CRC');
INSERT INTO categoria (cod_categoria, descricao) VALUES (46, 'CORTE DE CABELO');


--
-- TOC entry 1756 (class 0 OID 17884)
-- Dependencies: 1472
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1745 (class 2606 OID 17894)
-- Dependencies: 1471 1471
-- Name: lancamento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lancamento
    ADD CONSTRAINT lancamento_pk PRIMARY KEY (cod_lancamento);


--
-- TOC entry 1743 (class 2606 OID 17896)
-- Dependencies: 1470 1470
-- Name: ttipo_dispesa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT ttipo_dispesa_pkey PRIMARY KEY (cod_categoria);


--
-- TOC entry 1747 (class 2606 OID 17898)
-- Dependencies: 1472 1472
-- Name: usuarios_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_login_key UNIQUE (login);


--
-- TOC entry 1749 (class 2606 OID 17900)
-- Dependencies: 1472 1472
-- Name: usuarios_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_nome_key UNIQUE (nome);


--
-- TOC entry 1751 (class 2606 OID 17902)
-- Dependencies: 1472 1472
-- Name: usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (cod_usuario);


--
-- TOC entry 1752 (class 2606 OID 17903)
-- Dependencies: 1470 1471 1742
-- Name: desp_tipo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lancamento
    ADD CONSTRAINT desp_tipo_fk FOREIGN KEY (cod_categoria) REFERENCES categoria(cod_categoria);


--
-- TOC entry 1753 (class 2606 OID 17908)
-- Dependencies: 1471 1470 1742
-- Name: lancamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lancamento
    ADD CONSTRAINT lancamento_fk FOREIGN KEY (cod_categoria) REFERENCES categoria(cod_categoria);


--
-- TOC entry 1761 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-04-13 20:25:36

--
-- PostgreSQL database dump complete
--

