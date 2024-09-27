--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO postgres;

\connect number_guess

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


CREATE TABLE public.users (
    user_id SERIAL NOT NULL PRIMARY KEY,
    name character varying(22) NOT NULL 
);

ALTER TABLE public.users OWNER TO freecodecamp;

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uq_name UNIQUE (name);








CREATE TABLE public.games (
  game_id SERIAL NOT NULL PRIMARY KEY,
  secret_number integer NOT NULL
);

ALTER TABLE public.games OWNER TO freecodecamp;





CREATE TABLE public.usergames (
  user_game_id SERIAL NOT NULL PRIMARY KEY,
  game_id integer NOT NULL,
  user_id integer NOT NULL
);

ALTER TABLE public.usergames OWNER TO freecodecamp;




ALTER TABLE ONLY public.usergames
    ADD CONSTRAINT fk_game_id FOREIGN KEY (game_id) REFERENCES public.games(game_id);
ALTER TABLE ONLY public.usergames
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);



