--
-- PostgreSQL database dump
--

\restrict 1jAzGlQQbAIzcELCuPxm4m7nxqs4LIFxNhM8HfwwDHhqDIoSFdVTVcqEYxGR7ri

-- Dumped from database version 16.15
-- Dumped by pg_dump version 16.15

-- Started on 2026-10-18 15:30:40

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 228 (class 1259 OID 16519)
-- Name: Users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Users" (
    id integer NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 16400)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    surname character varying(50) NOT NULL,
    role character varying(50) NOT NULL,
    login character varying(50) NOT NULL,
    password character varying(255) NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: Users _id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Users _id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4867 (class 0 OID 0)
-- Dependencies: 215
-- Name: Users _id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Users _id_seq" OWNED BY public.users.id;


--
-- TOC entry 227 (class 1259 OID 16518)
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4868 (class 0 OID 0)
-- Dependencies: 227
-- Name: Users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Users_id_seq" OWNED BY public."Users".id;


--
-- TOC entry 226 (class 1259 OID 16510)
-- Name: Userses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Userses" (
    id integer NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16509)
-- Name: Userses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Userses_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4869 (class 0 OID 0)
-- Dependencies: 225
-- Name: Userses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Userses_id_seq" OWNED BY public."Userses".id;


--
-- TOC entry 218 (class 1259 OID 16409)
-- Name: cabinets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cabinets (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    id_user integer NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 16408)
-- Name: cabinets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cabinets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4870 (class 0 OID 0)
-- Dependencies: 217
-- Name: cabinets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cabinets_id_seq OWNED BY public.cabinets.id;


--
-- TOC entry 230 (class 1259 OID 16528)
-- Name: equipment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.equipment (
    id integer NOT NULL,
    type character varying NOT NULL,
    status character varying NOT NULL,
    cabinet_id integer NOT NULL,
    inv_number character varying NOT NULL,
    name character varying NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 16527)
-- Name: equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.equipment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4871 (class 0 OID 0)
-- Dependencies: 229
-- Name: equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.equipment_id_seq OWNED BY public.equipment.id;


--
-- TOC entry 220 (class 1259 OID 16416)
-- Name: equpment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.equpment (
    id integer NOT NULL,
    type character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    cabinets_id integer NOT NULL,
    inv_number character varying(50) NOT NULL,
    name character varying(100) NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 16415)
-- Name: equpment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.equpment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 219
-- Name: equpment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.equpment_id_seq OWNED BY public.equpment.id;


--
-- TOC entry 222 (class 1259 OID 16423)
-- Name: movement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.movement (
    id integer NOT NULL,
    cabinet_from integer NOT NULL,
    cabinet_to integer NOT NULL,
    equpment_id integer NOT NULL,
    movet_at date NOT NULL,
    user_id integer NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 16422)
-- Name: mvement_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mvement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4873 (class 0 OID 0)
-- Dependencies: 221
-- Name: mvement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mvement_id_seq OWNED BY public.movement.id;


--
-- TOC entry 224 (class 1259 OID 16430)
-- Name: write_offs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.write_offs (
    id integer NOT NULL,
    equpment_id integer NOT NULL,
    users_id integer NOT NULL,
    reason character varying(255) NOT NULL,
    cteatet_at date NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 16429)
-- Name: write_offs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.write_offs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4874 (class 0 OID 0)
-- Dependencies: 223
-- Name: write_offs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.write_offs_id_seq OWNED BY public.write_offs.id;


--
-- TOC entry 4675 (class 2604 OID 16522)
-- Name: Users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Users" ALTER COLUMN id SET DEFAULT nextval('public."Users_id_seq"'::regclass);


--
-- TOC entry 4674 (class 2604 OID 16513)
-- Name: Userses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Userses" ALTER COLUMN id SET DEFAULT nextval('public."Userses_id_seq"'::regclass);


--
-- TOC entry 4670 (class 2604 OID 16412)
-- Name: cabinets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cabinets ALTER COLUMN id SET DEFAULT nextval('public.cabinets_id_seq'::regclass);


--
-- TOC entry 4676 (class 2604 OID 16531)
-- Name: equipment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment ALTER COLUMN id SET DEFAULT nextval('public.equipment_id_seq'::regclass);


--
-- TOC entry 4671 (class 2604 OID 16419)
-- Name: equpment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equpment ALTER COLUMN id SET DEFAULT nextval('public.equpment_id_seq'::regclass);


--
-- TOC entry 4672 (class 2604 OID 16426)
-- Name: movement id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movement ALTER COLUMN id SET DEFAULT nextval('public.mvement_id_seq'::regclass);


--
-- TOC entry 4669 (class 2604 OID 16403)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public."Users _id_seq"'::regclass);


--
-- TOC entry 4673 (class 2604 OID 16433)
-- Name: write_offs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.write_offs ALTER COLUMN id SET DEFAULT nextval('public.write_offs_id_seq'::regclass);


--
-- TOC entry 4859 (class 0 OID 16519)
-- Dependencies: 228
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Users" (id, username, password) FROM stdin;
\.


--
-- TOC entry 4857 (class 0 OID 16510)
-- Dependencies: 226
-- Data for Name: Userses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Userses" (id, username, password) FROM stdin;
\.


--
-- TOC entry 4849 (class 0 OID 16409)
-- Dependencies: 218
-- Data for Name: cabinets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cabinets (id, name, id_user) FROM stdin;
1	202	1
2	12	1
\.


--
-- TOC entry 4861 (class 0 OID 16528)
-- Dependencies: 230
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.equipment (id, type, status, cabinet_id, inv_number, name) FROM stdin;
\.


--
-- TOC entry 4851 (class 0 OID 16416)
-- Dependencies: 220
-- Data for Name: equpment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.equpment (id, type, status, cabinets_id, inv_number, name) FROM stdin;
2	PC	on work	1	SVO25	OlegProdayGaraj
3	ноутбук	Исправно	1	DZ78	альфа банк
4	диджей установка	Списано	2	HaCH12	Мама нолана
\.


--
-- TOC entry 4853 (class 0 OID 16423)
-- Dependencies: 222
-- Data for Name: movement; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.movement (id, cabinet_from, cabinet_to, equpment_id, movet_at, user_id) FROM stdin;
\.


--
-- TOC entry 4847 (class 0 OID 16400)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, name, surname, role, login, password) FROM stdin;
1	Mango	Mangovski	admin	Mango123	admin
2	deaful	user	user	user123	12345678
\.


--
-- TOC entry 4855 (class 0 OID 16430)
-- Dependencies: 224
-- Data for Name: write_offs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.write_offs (id, equpment_id, users_id, reason, cteatet_at) FROM stdin;
\.


--
-- TOC entry 4875 (class 0 OID 0)
-- Dependencies: 215
-- Name: Users _id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Users _id_seq"', 2, true);


--
-- TOC entry 4876 (class 0 OID 0)
-- Dependencies: 227
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Users_id_seq"', 1, false);


--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 225
-- Name: Userses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Userses_id_seq"', 1, false);


--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 217
-- Name: cabinets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cabinets_id_seq', 5, true);


--
-- TOC entry 4879 (class 0 OID 0)
-- Dependencies: 229
-- Name: equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_id_seq', 1, false);


--
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 219
-- Name: equpment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equpment_id_seq', 4, true);


--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 221
-- Name: mvement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.mvement_id_seq', 1, false);


--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 223
-- Name: write_offs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.write_offs_id_seq', 1, false);


--
-- TOC entry 4678 (class 2606 OID 16405)
-- Name: users Users _pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "Users _pkey" PRIMARY KEY (id);


--
-- TOC entry 4692 (class 2606 OID 16526)
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- TOC entry 4690 (class 2606 OID 16517)
-- Name: Userses Userses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Userses"
    ADD CONSTRAINT "Userses_pkey" PRIMARY KEY (id);


--
-- TOC entry 4682 (class 2606 OID 16446)
-- Name: cabinets cabinets_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cabinets
    ADD CONSTRAINT cabinets_pk PRIMARY KEY (id);


--
-- TOC entry 4694 (class 2606 OID 16535)
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (id);


--
-- TOC entry 4684 (class 2606 OID 16453)
-- Name: equpment equpment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equpment
    ADD CONSTRAINT equpment_pkey PRIMARY KEY (id);


--
-- TOC entry 4686 (class 2606 OID 16428)
-- Name: movement mvement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movement
    ADD CONSTRAINT mvement_pkey PRIMARY KEY (id);


--
-- TOC entry 4680 (class 2606 OID 16407)
-- Name: users users_login_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_unique UNIQUE (login);


--
-- TOC entry 4688 (class 2606 OID 16435)
-- Name: write_offs write_offs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.write_offs
    ADD CONSTRAINT write_offs_pkey PRIMARY KEY (id);


--
-- TOC entry 4697 (class 2606 OID 16454)
-- Name: movement cabinet_from; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movement
    ADD CONSTRAINT cabinet_from FOREIGN KEY (cabinet_from) REFERENCES public.cabinets(id) NOT VALID;


--
-- TOC entry 4698 (class 2606 OID 16459)
-- Name: movement cabinet_to; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movement
    ADD CONSTRAINT cabinet_to FOREIGN KEY (cabinet_to) REFERENCES public.cabinets(id) NOT VALID;


--
-- TOC entry 4695 (class 2606 OID 16436)
-- Name: cabinets cabinet_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cabinets
    ADD CONSTRAINT cabinet_users FOREIGN KEY (id_user) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 4699 (class 2606 OID 16464)
-- Name: movement equpment_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movement
    ADD CONSTRAINT equpment_id FOREIGN KEY (equpment_id) REFERENCES public.equpment(id) NOT VALID;


--
-- TOC entry 4701 (class 2606 OID 16479)
-- Name: write_offs equpments_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.write_offs
    ADD CONSTRAINT equpments_id FOREIGN KEY (equpment_id) REFERENCES public.equpment(id) NOT VALID;


--
-- TOC entry 4696 (class 2606 OID 16447)
-- Name: equpment id_cabinet; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equpment
    ADD CONSTRAINT id_cabinet FOREIGN KEY (cabinets_id) REFERENCES public.cabinets(id) NOT VALID;


--
-- TOC entry 4700 (class 2606 OID 16469)
-- Name: movement user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movement
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 4702 (class 2606 OID 16474)
-- Name: write_offs users_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.write_offs
    ADD CONSTRAINT users_id FOREIGN KEY (users_id) REFERENCES public.users(id) NOT VALID;


-- Completed on 2026-10-18 15:30:40

--
-- PostgreSQL database dump complete
--

\unrestrict 1jAzGlQQbAIzcELCuPxm4m7nxqs4LIFxNhM8HfwwDHhqDIoSFdVTVcqEYxGR7ri

