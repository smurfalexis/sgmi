--
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3
-- Dumped by pg_dump version 14.3

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

DROP DATABASE flatiron_mod3_development;
--
-- Name: flatiron_mod3_development; Type: DATABASE; Schema: -; Owner: ramihajji
--

CREATE DATABASE flatiron_mod3_development WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';


ALTER DATABASE flatiron_mod3_development OWNER TO ramihajji;

\connect flatiron_mod3_development

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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: ramihajji
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO ramihajji;

--
-- Name: collections; Type: TABLE; Schema: public; Owner: ramihajji
--

CREATE TABLE public.collections (
    id bigint NOT NULL,
    name character varying,
    floor_price jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    category character varying,
    description text,
    symbol character varying,
    discord character varying,
    twitter character varying,
    website character varying,
    volume double precision,
    listings integer,
    supply integer,
    owner integer,
    image character varying,
    volume24 double precision
);


ALTER TABLE public.collections OWNER TO ramihajji;

--
-- Name: collections_id_seq; Type: SEQUENCE; Schema: public; Owner: ramihajji
--

CREATE SEQUENCE public.collections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collections_id_seq OWNER TO ramihajji;

--
-- Name: collections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ramihajji
--

ALTER SEQUENCE public.collections_id_seq OWNED BY public.collections.id;


--
-- Name: nfts; Type: TABLE; Schema: public; Owner: ramihajji
--

CREATE TABLE public.nfts (
    id bigint NOT NULL,
    name character varying,
    price double precision,
    image character varying,
    rarity character varying,
    wallet_id bigint NOT NULL,
    collection_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    purchase_date date,
    mint_address character varying
);


ALTER TABLE public.nfts OWNER TO ramihajji;

--
-- Name: nfts_id_seq; Type: SEQUENCE; Schema: public; Owner: ramihajji
--

CREATE SEQUENCE public.nfts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nfts_id_seq OWNER TO ramihajji;

--
-- Name: nfts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ramihajji
--

ALTER SEQUENCE public.nfts_id_seq OWNED BY public.nfts.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: ramihajji
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO ramihajji;

--
-- Name: solana_timestamps; Type: TABLE; Schema: public; Owner: ramihajji
--

CREATE TABLE public.solana_timestamps (
    id bigint NOT NULL,
    date date,
    price double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solana_timestamps OWNER TO ramihajji;

--
-- Name: solana_timestamps_id_seq; Type: SEQUENCE; Schema: public; Owner: ramihajji
--

CREATE SEQUENCE public.solana_timestamps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solana_timestamps_id_seq OWNER TO ramihajji;

--
-- Name: solana_timestamps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ramihajji
--

ALTER SEQUENCE public.solana_timestamps_id_seq OWNED BY public.solana_timestamps.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: ramihajji
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    first_name character varying,
    last_name character varying
);


ALTER TABLE public.users OWNER TO ramihajji;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: ramihajji
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO ramihajji;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ramihajji
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: wallets; Type: TABLE; Schema: public; Owner: ramihajji
--

CREATE TABLE public.wallets (
    id bigint NOT NULL,
    wallet_key character varying,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.wallets OWNER TO ramihajji;

--
-- Name: wallets_id_seq; Type: SEQUENCE; Schema: public; Owner: ramihajji
--

CREATE SEQUENCE public.wallets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wallets_id_seq OWNER TO ramihajji;

--
-- Name: wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ramihajji
--

ALTER SEQUENCE public.wallets_id_seq OWNED BY public.wallets.id;


--
-- Name: watchlist_items; Type: TABLE; Schema: public; Owner: ramihajji
--

CREATE TABLE public.watchlist_items (
    id bigint NOT NULL,
    watchlist_id bigint,
    collection_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.watchlist_items OWNER TO ramihajji;

--
-- Name: watchlist_items_id_seq; Type: SEQUENCE; Schema: public; Owner: ramihajji
--

CREATE SEQUENCE public.watchlist_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.watchlist_items_id_seq OWNER TO ramihajji;

--
-- Name: watchlist_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ramihajji
--

ALTER SEQUENCE public.watchlist_items_id_seq OWNED BY public.watchlist_items.id;


--
-- Name: watchlists; Type: TABLE; Schema: public; Owner: ramihajji
--

CREATE TABLE public.watchlists (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.watchlists OWNER TO ramihajji;

--
-- Name: watchlists_id_seq; Type: SEQUENCE; Schema: public; Owner: ramihajji
--

CREATE SEQUENCE public.watchlists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.watchlists_id_seq OWNER TO ramihajji;

--
-- Name: watchlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ramihajji
--

ALTER SEQUENCE public.watchlists_id_seq OWNED BY public.watchlists.id;


--
-- Name: collections id; Type: DEFAULT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.collections ALTER COLUMN id SET DEFAULT nextval('public.collections_id_seq'::regclass);


--
-- Name: nfts id; Type: DEFAULT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.nfts ALTER COLUMN id SET DEFAULT nextval('public.nfts_id_seq'::regclass);


--
-- Name: solana_timestamps id; Type: DEFAULT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.solana_timestamps ALTER COLUMN id SET DEFAULT nextval('public.solana_timestamps_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: wallets id; Type: DEFAULT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.wallets ALTER COLUMN id SET DEFAULT nextval('public.wallets_id_seq'::regclass);


--
-- Name: watchlist_items id; Type: DEFAULT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.watchlist_items ALTER COLUMN id SET DEFAULT nextval('public.watchlist_items_id_seq'::regclass);


--
-- Name: watchlists id; Type: DEFAULT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.watchlists ALTER COLUMN id SET DEFAULT nextval('public.watchlists_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: ramihajji
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
\.
COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM '$$PATH$$/3650.dat';

--
-- Data for Name: collections; Type: TABLE DATA; Schema: public; Owner: ramihajji
--

COPY public.collections (id, name, floor_price, created_at, updated_at, category, description, symbol, discord, twitter, website, volume, listings, supply, owner, image, volume24) FROM stdin;
\.
COPY public.collections (id, name, floor_price, created_at, updated_at, category, description, symbol, discord, twitter, website, volume, listings, supply, owner, image, volume24) FROM '$$PATH$$/3654.dat';

--
-- Data for Name: nfts; Type: TABLE DATA; Schema: public; Owner: ramihajji
--

COPY public.nfts (id, name, price, image, rarity, wallet_id, collection_id, created_at, updated_at, purchase_date, mint_address) FROM stdin;
\.
COPY public.nfts (id, name, price, image, rarity, wallet_id, collection_id, created_at, updated_at, purchase_date, mint_address) FROM '$$PATH$$/3662.dat';

--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: ramihajji
--

COPY public.schema_migrations (version) FROM stdin;
\.
COPY public.schema_migrations (version) FROM '$$PATH$$/3649.dat';

--
-- Data for Name: solana_timestamps; Type: TABLE DATA; Schema: public; Owner: ramihajji
--

COPY public.solana_timestamps (id, date, price, created_at, updated_at) FROM stdin;
\.
COPY public.solana_timestamps (id, date, price, created_at, updated_at) FROM '$$PATH$$/3660.dat';

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ramihajji
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, first_name, last_name) FROM stdin;
\.
COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, first_name, last_name) FROM '$$PATH$$/3652.dat';

--
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: ramihajji
--

COPY public.wallets (id, wallet_key, user_id, created_at, updated_at) FROM stdin;
\.
COPY public.wallets (id, wallet_key, user_id, created_at, updated_at) FROM '$$PATH$$/3656.dat';

--
-- Data for Name: watchlist_items; Type: TABLE DATA; Schema: public; Owner: ramihajji
--

COPY public.watchlist_items (id, watchlist_id, collection_id, created_at, updated_at) FROM stdin;
\.
COPY public.watchlist_items (id, watchlist_id, collection_id, created_at, updated_at) FROM '$$PATH$$/3664.dat';

--
-- Data for Name: watchlists; Type: TABLE DATA; Schema: public; Owner: ramihajji
--

COPY public.watchlists (id, user_id, created_at, updated_at) FROM stdin;
\.
COPY public.watchlists (id, user_id, created_at, updated_at) FROM '$$PATH$$/3658.dat';

--
-- Name: collections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ramihajji
--

SELECT pg_catalog.setval('public.collections_id_seq', 644, true);


--
-- Name: nfts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ramihajji
--

SELECT pg_catalog.setval('public.nfts_id_seq', 71, true);


--
-- Name: solana_timestamps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ramihajji
--

SELECT pg_catalog.setval('public.solana_timestamps_id_seq', 784, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ramihajji
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


--
-- Name: wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ramihajji
--

SELECT pg_catalog.setval('public.wallets_id_seq', 10, true);


--
-- Name: watchlist_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ramihajji
--

SELECT pg_catalog.setval('public.watchlist_items_id_seq', 1, false);


--
-- Name: watchlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ramihajji
--

SELECT pg_catalog.setval('public.watchlists_id_seq', 9, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: collections collections_pkey; Type: CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (id);


--
-- Name: nfts nfts_pkey; Type: CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.nfts
    ADD CONSTRAINT nfts_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: solana_timestamps solana_timestamps_pkey; Type: CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.solana_timestamps
    ADD CONSTRAINT solana_timestamps_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- Name: watchlist_items watchlist_items_pkey; Type: CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.watchlist_items
    ADD CONSTRAINT watchlist_items_pkey PRIMARY KEY (id);


--
-- Name: watchlists watchlists_pkey; Type: CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.watchlists
    ADD CONSTRAINT watchlists_pkey PRIMARY KEY (id);


--
-- Name: index_nfts_on_collection_id; Type: INDEX; Schema: public; Owner: ramihajji
--

CREATE INDEX index_nfts_on_collection_id ON public.nfts USING btree (collection_id);


--
-- Name: index_nfts_on_wallet_id; Type: INDEX; Schema: public; Owner: ramihajji
--

CREATE INDEX index_nfts_on_wallet_id ON public.nfts USING btree (wallet_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: ramihajji
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: ramihajji
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_wallets_on_user_id; Type: INDEX; Schema: public; Owner: ramihajji
--

CREATE INDEX index_wallets_on_user_id ON public.wallets USING btree (user_id);


--
-- Name: index_watchlist_items_on_collection_id; Type: INDEX; Schema: public; Owner: ramihajji
--

CREATE INDEX index_watchlist_items_on_collection_id ON public.watchlist_items USING btree (collection_id);


--
-- Name: index_watchlist_items_on_watchlist_id; Type: INDEX; Schema: public; Owner: ramihajji
--

CREATE INDEX index_watchlist_items_on_watchlist_id ON public.watchlist_items USING btree (watchlist_id);


--
-- Name: index_watchlists_on_user_id; Type: INDEX; Schema: public; Owner: ramihajji
--

CREATE INDEX index_watchlists_on_user_id ON public.watchlists USING btree (user_id);


--
-- Name: watchlists fk_rails_0dc1a4cbcb; Type: FK CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.watchlists
    ADD CONSTRAINT fk_rails_0dc1a4cbcb FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: wallets fk_rails_732f6628c4; Type: FK CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT fk_rails_732f6628c4 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: nfts fk_rails_9ab0d824b0; Type: FK CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.nfts
    ADD CONSTRAINT fk_rails_9ab0d824b0 FOREIGN KEY (wallet_id) REFERENCES public.wallets(id);


--
-- Name: nfts fk_rails_cf93ccf032; Type: FK CONSTRAINT; Schema: public; Owner: ramihajji
--

ALTER TABLE ONLY public.nfts
    ADD CONSTRAINT fk_rails_cf93ccf032 FOREIGN KEY (collection_id) REFERENCES public.collections(id);


--
-- PostgreSQL database dump complete
--

