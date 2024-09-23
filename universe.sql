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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    distance_to_earth_ly integer,
    discovered integer,
    discovered_by character varying(30)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30),
    distance_to_nearest_planet_km numeric(18,10),
    primary_atomic_composition text,
    planet_id integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30),
    number_of_moons integer,
    has_moon boolean,
    star_id integer NOT NULL
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: planets_with_moons; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planets_with_moons (
    planets_with_moons_id integer NOT NULL,
    name character varying(30) NOT NULL,
    yup integer NOT NULL,
    planet_id integer,
    moon_id integer
);


ALTER TABLE public.planets_with_moons OWNER TO freecodecamp;

--
-- Name: planets_with_moons_pwm_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planets_with_moons_pwm_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planets_with_moons_pwm_id_seq OWNER TO freecodecamp;

--
-- Name: planets_with_moons_pwm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planets_with_moons_pwm_id_seq OWNED BY public.planets_with_moons.planets_with_moons_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30),
    is_dwarf boolean,
    galaxy_id integer NOT NULL,
    is_dead boolean
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: planets_with_moons planets_with_moons_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planets_with_moons ALTER COLUMN planets_with_moons_id SET DEFAULT nextval('public.planets_with_moons_pwm_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 0, 0, 'Bone');
INSERT INTO public.galaxy VALUES (2, 'LMC', 0, 0, 'Bone');
INSERT INTO public.galaxy VALUES (3, 'Andromeda', 0, 0, 'Bone');
INSERT INTO public.galaxy VALUES (4, 'Cigar', 0, 0, 'Bone');
INSERT INTO public.galaxy VALUES (5, 'Pinwheel', 0, 0, 'Bone');
INSERT INTO public.galaxy VALUES (6, 'Sombrero', 0, 0, 'Bone');
INSERT INTO public.galaxy VALUES (7, 'Whirlpool', 0, 0, 'Bone');
INSERT INTO public.galaxy VALUES (8, 'NGC', 0, 0, 'Bone');
INSERT INTO public.galaxy VALUES (9, 'Tadpole', 0, 0, 'Bone');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'M1', 1.0000000000, 'N12', 1);
INSERT INTO public.moon VALUES (2, 'M2', 1.0000000000, 'N12', 2);
INSERT INTO public.moon VALUES (3, 'M3', 1.0000000000, 'N12', 3);
INSERT INTO public.moon VALUES (4, 'M4', 1.0000000000, 'N12', 4);
INSERT INTO public.moon VALUES (5, 'M5', 1.0000000000, 'N12', 5);
INSERT INTO public.moon VALUES (6, 'M6', 1.0000000000, 'N12', 6);
INSERT INTO public.moon VALUES (7, 'M7', 1.0000000000, 'N12', 7);
INSERT INTO public.moon VALUES (8, 'M8', 1.0000000000, 'N12', 8);
INSERT INTO public.moon VALUES (9, 'M9', 1.0000000000, 'N12', 9);
INSERT INTO public.moon VALUES (10, 'M10', 1.0000000000, 'N12', 10);
INSERT INTO public.moon VALUES (11, 'M11', 1.0000000000, 'N12', 11);
INSERT INTO public.moon VALUES (12, 'M12', 1.0000000000, 'N12', 12);
INSERT INTO public.moon VALUES (13, 'M13', 1.0000000000, 'N12', 13);
INSERT INTO public.moon VALUES (14, 'M14', 1.0000000000, 'N12', 1);
INSERT INTO public.moon VALUES (15, 'M15', 1.0000000000, 'N12', 2);
INSERT INTO public.moon VALUES (16, 'M16', 1.0000000000, 'N12', 3);
INSERT INTO public.moon VALUES (17, 'M17', 1.0000000000, 'N12', 4);
INSERT INTO public.moon VALUES (18, 'M18', 1.0000000000, 'N12', 5);
INSERT INTO public.moon VALUES (19, 'M19', 1.0000000000, 'N12', 6);
INSERT INTO public.moon VALUES (20, 'M20', 1.0000000000, 'N12', 7);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 1, true, 1);
INSERT INTO public.planet VALUES (2, 'Mars', 1, true, 1);
INSERT INTO public.planet VALUES (3, 'Venus', 2, true, 1);
INSERT INTO public.planet VALUES (4, 'Saturn', 5, true, 1);
INSERT INTO public.planet VALUES (5, 'Jupiter', 3, true, 1);
INSERT INTO public.planet VALUES (6, 'Pluto', 1, true, 1);
INSERT INTO public.planet VALUES (7, 'Mercury', 1, true, 1);
INSERT INTO public.planet VALUES (8, 'Uranus', 1, true, 1);
INSERT INTO public.planet VALUES (9, 'Neptune', 1, true, 1);
INSERT INTO public.planet VALUES (10, 'X190', 1, true, 1);
INSERT INTO public.planet VALUES (11, 'X120', 1, true, 1);
INSERT INTO public.planet VALUES (12, 'X304', 1, true, 1);
INSERT INTO public.planet VALUES (13, 'GG', 1, true, 1);


--
-- Data for Name: planets_with_moons; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planets_with_moons VALUES (1, 'slemForbindelse', 1, 1, 2);
INSERT INTO public.planets_with_moons VALUES (2, 'dårligforbindelse', 1, 2, 3);
INSERT INTO public.planets_with_moons VALUES (3, 'dårligforbindelse', 1, 3, 4);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'LMC', false, 1, false);
INSERT INTO public.star VALUES (2, 'Lynx', false, 1, false);
INSERT INTO public.star VALUES (3, 'Eridanus', false, 1, false);
INSERT INTO public.star VALUES (4, 'Cassiopeia', false, 1, false);
INSERT INTO public.star VALUES (5, 'Scorpius', false, 1, false);
INSERT INTO public.star VALUES (6, 'Crux', false, 1, false);
INSERT INTO public.star VALUES (7, 'Cancer', false, 1, false);
INSERT INTO public.star VALUES (8, 'Leo', false, 1, false);
INSERT INTO public.star VALUES (9, 'Canis major', false, 1, false);
INSERT INTO public.star VALUES (10, 'Taurus', false, 1, false);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 9, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 13, true);


--
-- Name: planets_with_moons_pwm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planets_with_moons_pwm_id_seq', 3, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 10, true);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: planets_with_moons planets_with_moons_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planets_with_moons
    ADD CONSTRAINT planets_with_moons_pkey PRIMARY KEY (planets_with_moons_id);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy unique_galaxy_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT unique_galaxy_id UNIQUE (galaxy_id);


--
-- Name: moon unqiue_moon_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT unqiue_moon_id UNIQUE (moon_id);


--
-- Name: planet unqiue_planet_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT unqiue_planet_id UNIQUE (planet_id);


--
-- Name: planets_with_moons unqiue_planets_with_moons_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planets_with_moons
    ADD CONSTRAINT unqiue_planets_with_moons_id UNIQUE (planets_with_moons_id);


--
-- Name: star unqiue_star_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT unqiue_star_id UNIQUE (star_id);


--
-- Name: star fk_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: planets_with_moons fk_moon; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planets_with_moons
    ADD CONSTRAINT fk_moon FOREIGN KEY (moon_id) REFERENCES public.moon(moon_id);


--
-- Name: moon fk_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planets_with_moons fk_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planets_with_moons
    ADD CONSTRAINT fk_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- PostgreSQL database dump complete
--

