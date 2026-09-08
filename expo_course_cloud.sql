--
-- PostgreSQL database dump
--

\restrict gZQPvmrbNiZdPxOzMtmfahyuxZfggZcim2mbvUZsd9y5gbJ9nEIjdokuGGncFt1

-- Dumped from database version 18.4 (Postgres.app)
-- Dumped by pg_dump version 18.4 (Postgres.app)

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

ALTER TABLE IF EXISTS ONLY public.user_progress DROP CONSTRAINT IF EXISTS fkrt37sneeps21829cuqetjm5ye;
ALTER TABLE IF EXISTS ONLY public.quiz_answers DROP CONSTRAINT IF EXISTS fkqw4bm59asqarvnqso6coafn48;
ALTER TABLE IF EXISTS ONLY public.quiz_attempts DROP CONSTRAINT IF EXISTS fkpj4a9hw0iv1mo1ut6rppg594u;
ALTER TABLE IF EXISTS ONLY public.user_progress DROP CONSTRAINT IF EXISTS fkk20r0wgq69ilv4py005filedb;
ALTER TABLE IF EXISTS ONLY public.lessons DROP CONSTRAINT IF EXISTS fkgt4502q9pklwr02uqh3qnrppi;
ALTER TABLE IF EXISTS ONLY public.exercises DROP CONSTRAINT IF EXISTS fkes9e0n86cjfb0l6349clxvxc1;
ALTER TABLE IF EXISTS ONLY public.quiz_answers DROP CONSTRAINT IF EXISTS fkb69mwpkm3kehim0klscpmmkc1;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email_key;
ALTER TABLE IF EXISTS ONLY public.user_progress DROP CONSTRAINT IF EXISTS user_progress_user_id_lesson_id_key;
ALTER TABLE IF EXISTS ONLY public.user_progress DROP CONSTRAINT IF EXISTS user_progress_pkey;
ALTER TABLE IF EXISTS ONLY public.user_progress DROP CONSTRAINT IF EXISTS uk8sschjnhw7q49ml9th0urvo4b;
ALTER TABLE IF EXISTS ONLY public.sections DROP CONSTRAINT IF EXISTS sections_pkey;
ALTER TABLE IF EXISTS ONLY public.quiz_questions DROP CONSTRAINT IF EXISTS quiz_questions_pkey;
ALTER TABLE IF EXISTS ONLY public.quiz_attempts DROP CONSTRAINT IF EXISTS quiz_attempts_pkey;
ALTER TABLE IF EXISTS ONLY public.quiz_answers DROP CONSTRAINT IF EXISTS quiz_answers_pkey;
ALTER TABLE IF EXISTS ONLY public.lessons DROP CONSTRAINT IF EXISTS lessons_pkey;
ALTER TABLE IF EXISTS ONLY public.exercises DROP CONSTRAINT IF EXISTS exercises_pkey;
ALTER TABLE IF EXISTS ONLY public.backup_sections DROP CONSTRAINT IF EXISTS backup_sections_pkey;
ALTER TABLE IF EXISTS ONLY public.backup_quiz_questions DROP CONSTRAINT IF EXISTS backup_quiz_questions_pkey;
ALTER TABLE IF EXISTS ONLY public.backup_lessons DROP CONSTRAINT IF EXISTS backup_lessons_pkey;
ALTER TABLE IF EXISTS ONLY public.backup_exercises DROP CONSTRAINT IF EXISTS backup_exercises_pkey;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.user_progress;
DROP TABLE IF EXISTS public.sections;
DROP TABLE IF EXISTS public.quiz_questions;
DROP TABLE IF EXISTS public.quiz_attempts;
DROP TABLE IF EXISTS public.quiz_answers;
DROP TABLE IF EXISTS public.lessons;
DROP TABLE IF EXISTS public.exercises;
DROP TABLE IF EXISTS public.backup_sections;
DROP TABLE IF EXISTS public.backup_quiz_questions;
DROP TABLE IF EXISTS public.backup_lessons;
DROP TABLE IF EXISTS public.backup_exercises;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: backup_exercises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.backup_exercises (
    id bigint NOT NULL,
    lesson_id bigint NOT NULL,
    prompt text NOT NULL,
    optiona text NOT NULL,
    optionb text NOT NULL,
    optionc text NOT NULL,
    optiond text NOT NULL,
    correct_answer character varying(1) NOT NULL,
    feedback_correct text,
    feedback_wrong text,
    sort_order integer NOT NULL
);


--
-- Name: backup_lessons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.backup_lessons (
    id bigint NOT NULL,
    section_id bigint,
    title character varying(255) NOT NULL,
    content text,
    image_path character varying(255),
    sort_order integer NOT NULL,
    scenario_title character varying(255),
    scenario_description text,
    scenario_complete_positive text,
    scenario_complete_negative text
);


--
-- Name: backup_quiz_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.backup_quiz_questions (
    id bigint NOT NULL,
    question_text text NOT NULL,
    optiona character varying(255) NOT NULL,
    optionb character varying(255) NOT NULL,
    optionc character varying(255) NOT NULL,
    optiond character varying(255),
    correct_answer character varying(1) NOT NULL,
    sort_order integer NOT NULL
);


--
-- Name: backup_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.backup_sections (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    sort_order integer NOT NULL
);


--
-- Name: exercises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercises (
    correct_answer character varying(1) NOT NULL,
    sort_order integer NOT NULL,
    id bigint NOT NULL,
    lesson_id bigint NOT NULL,
    feedback_correct text,
    feedback_wrong text,
    optiona text NOT NULL,
    optionb text NOT NULL,
    optionc text NOT NULL,
    optiond text NOT NULL,
    prompt text NOT NULL
);


--
-- Name: exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.exercises ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.exercises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lessons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lessons (
    sort_order integer NOT NULL,
    id bigint NOT NULL,
    section_id bigint,
    content text,
    image_path character varying(255),
    scenario_description text,
    scenario_title character varying(255),
    title character varying(255) NOT NULL,
    scenario_complete_negative text,
    scenario_complete_positive text
);


--
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.lessons ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: quiz_answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_answers (
    correct boolean NOT NULL,
    selected_answer character varying(1),
    attempt_id bigint NOT NULL,
    id bigint NOT NULL,
    question_id bigint NOT NULL
);


--
-- Name: quiz_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.quiz_answers ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.quiz_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: quiz_attempts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_attempts (
    passed boolean NOT NULL,
    percentage double precision NOT NULL,
    score integer NOT NULL,
    total_questions integer NOT NULL,
    attempted_at timestamp(6) without time zone,
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    certificate_code character varying(255),
    certificate_pdf_url character varying(255)
);


--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.quiz_attempts ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.quiz_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: quiz_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_questions (
    correct_answer character varying(1) NOT NULL,
    sort_order integer NOT NULL,
    id bigint NOT NULL,
    optiona character varying(255) NOT NULL,
    optionb character varying(255) NOT NULL,
    optionc character varying(255) NOT NULL,
    optiond character varying(255),
    question_text text NOT NULL
);


--
-- Name: quiz_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.quiz_questions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.quiz_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sections (
    sort_order integer NOT NULL,
    id bigint NOT NULL,
    description character varying(255),
    title character varying(255) NOT NULL
);


--
-- Name: sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.sections ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_progress; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_progress (
    completed boolean NOT NULL,
    completed_at timestamp(6) without time zone,
    id bigint NOT NULL,
    lesson_id bigint NOT NULL,
    user_id bigint NOT NULL
);


--
-- Name: user_progress_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.user_progress ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.user_progress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    enabled boolean NOT NULL,
    created_at timestamp(6) without time zone,
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['USER'::character varying, 'ADMIN'::character varying])::text[])))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: backup_exercises; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.backup_exercises (id, lesson_id, prompt, optiona, optionb, optionc, optiond, correct_answer, feedback_correct, feedback_wrong, sort_order) FROM stdin;
5	3	Tek ste primetili da akreditacija nije kod vas. Šta je prvi razuman potez?	Nastavljate kretanje i nadate se da će se kasnije pojaviti.	Sklanjate se iz zone bez ikakve prijave.	Odmah proveravate poslednje mesto gde je mogla da bude i o tome obaveštavate ovlašćeno lice.	Pozajmljujete tuđu akreditaciju dok ne pronađete svoju.	C	Tačno. Brza provera i trenutna prijava smanjuju mogućnost daljeg rizika i olakšavaju postupanje.	To nije dozvoljeno. Napustiti zonu može biti potrebno, ali prijava mora ići odmah, bez čekanja i bez prikrivanja događaja. Gubitak treba odmah shvatiti ozbiljno. Akreditacija je lična i ne sme se ustupati drugoj osobi.	1
12	4	Dobijaš uputstvo da ostaneš na mestu do provere. Kako reaguješ?	Ostaješ gde si i čekaš dalja uputstva. 	Odlaziš jer smatraš da je situacija već rešena. 	Pitaš više ljudi istovremeno šta da radiš. 	Krećeš se ka drugom delu objekta da nadoknadiš izgubljeno vreme. 	A	Tačno! Poštovanje uputstva je završni korak bezbednog postupanja nakon greške.	Netačno! Ne pratiš dobijeno uputstvo, što može da stvori novi bezbednosni problem.	4
7	3	Član tima vas pita da li može da koristi vašu akreditaciju samo za kratki prolaz. Kako odgovarate?	 Kažete da može ako se brzo vrati. 	 Odbijate i objašnjavate da svako koristi samo svoju akreditaciju. 	 Dajete mu akreditaciju, ali tražite da je vrati odmah posle prolaza. 	 Tražite od njega da ide uz vas bez akreditacije.	B	Tačno. Jasno odbijanje smanjuje rizik od zloupotrebe i štiti vas od posledica.	To nije dozvoljeno, čak ni privremeno. Akreditacija je lična i ne sme se deliti i niko ne sme da se kreće bez akreditacije.	3
6	3	Nađete tuđu akreditaciju na podu u prolazu. Kako postupate?	 Stavljate je u svoj džep da je ne bi neko zgazio. 	 Predajete je službi zaduženoj za kontrolu ili osobi koju je organizator odredio. 	 Čuvate je kod sebe do kraja dana bez prijave. 	 Fotografišete je i objavljujete da biste pronašli vlasnika. 	B	Tačno! Predaja ovlašćenom licu je najbezbedniji i najispravniji postupak.	Netačno! Akreditaciju treba predati ovlašćenom licu po propisanom postupku.	2
8	3	Akreditacija vam je oštećena i više nije čitljiva. Šta je najbolje da uradite?	Odmah prijavljujete oštećenje i pratite zvanično uputstvo za zamenu. 	Zadržavate je kao rezervu i uzimate tuđu za ulazak. 	Nastavljate da je koristite dok se ne raspadne potpuno.	Sami prelepite ili prepravite podatke da ponovo bude čitljiva. 	A	Tačno! Prijava i zamena po proceduri su ispravan i bezbedan korak.	Netačno! Tuđa akreditacija se ne sme koristiti. Nečitljivi podaci otežavaju proveru i mogu dovesti do odbijanja pristupa ili drugih posledica. Samostalno menjanje akreditacije nije dozvoljeno i može stvoriti dodatni problem.	4
9	4	Primećuješ oznaku zone koja ne odgovara tvom ovlašćenju. Šta radiš prvo?	Nastavljaš dalje dok ne vidiš da li te neko zaustavlja. 	Zaustavljaš se i proveravaš gde si, bez daljeg ulaska. 	Čekaš da neko drugi preuzme odgovornost. 	Sklanjaš akreditaciju da ne privlači pažnju. 	B	Tačno! Mirno zaustavljanje je najbezbedniji prvi potez i omogućava brzu proveru pristupa.	Netačno! To povećava rizik od neovlašćenog kretanja. Prvi korak je da se odmah zaustaviš. Pasivno čekanje nije dovoljno. Potrebno je i aktivno prijavljivanje situacije.	1
10	4	Sada vidiš najbliži izlazni pravac i osobu koja može da ti pomogne. Kako postupaš?	Brzo odlaziš bez ikakvog obaveštavanja da ne usporavaš rad. 	Zadržavaš se da sam proceniš da li ipak smeš da ostaneš. 	Ulaziš dublje da bi pronašao bolji izlaz bez pitanja. 	Mirno se povlačiš dozvoljenim putem i obaveštavaš ovlašćeno lice. 	D	Tačno! Bezbedno povlačenje i kratka prijava su najvažniji koraci u ovoj situaciji.	Netačno! Bezbedno povlačenje i kratka prijava su najvažniji koraci u ovoj situaciji.	2
11	4	Ovlašćeno lice traži da objasniš šta se dogodilo. Koji odgovor je najprimereniji?	Kažeš tačno gde si bio i da si greškom ušao u pogrešnu zonu. 	Minimizuješ događaj da ne bi delovao neiskusno. 	Izbegavaš odgovor dok sam ne pronađeš izlaz. 	Kažeš da nisi siguran i prepuštaš drugima da objasne umesto tebe. 	A	Tačno! Kratak, jasan i iskren opis događaja olakšava dalje postupanje.	Netačno! Umanjivanje događaja ili izbegavanje davanja informacija može odložiti pravilnu reakciju. Važnije je tačno prijaviti šta se desilo.	3
13	5	Šta je najtačniji početni opis onoga što vidiš?	Osoba sigurno nešto pokušava da sakrije. 	Osoba deluje kao da pripada timu obezbeđenja. 	Osoba stoji duže vreme u prolazu i osvrće se oko sebe. 	Osoba je verovatno zabrinuta i ne zna kuda da ide. 	C	Tačno! To je činjeničan opis bez tumačenja motiva. Takav opis je najbolja osnova za dalju prijavu.	Netačno! To je zaključak bez potvrde. Pretpostavka može odvesti prijavu u pogrešnom smeru.	1
15	5	Nadležna osoba traži kratak opis situacije. Šta uključuješ?	Priču koju si čuo od drugih, uz dodatne komentare. 	Svoj utisak da je osoba bila neprijatna i verovatno opasna. 	Tačno mesto, vreme, šta je viđeno i da li je situacija i dalje prisutna. 	Ime osobe, iako ga nisi proverio. 	C	Tačno! Odlično. Kratak, jasan i proverljiv opis pomaže nadležnima da brzo procene sledeći korak.	Netačno! To povećava buku u komunikaciji i može izobličiti događaj. Drži se onoga što znaš iz prve ruke. Lični utisak nije dovoljan. U prijavi su važni činjenice i vremenski okvir.	3
25	8	Kolega traži plan rasporeda i lozinku, a vi niste sigurni da ima pravo da ih dobije. Šta radite prvo?	 Podelite informacije odmah da ne usporite smenu. 	 Tražite da pokaže akreditaciju i proverite kroz odobreni kanal kome je podatak potreban. 	 Kažete mu da pita nekog drugog, a vi nastavite posao. 	 Ignorišete zahtev i odlazite bez odgovora. 	B	Tačno! Prvo se proverava potreba i ovlašćenje, pa tek onda odlučuje o pristupu.	Netačno! To stvara nepotreban rizik. Ako ovlašćenje nije jasno, podatak se ne deli na brzinu. Ako niste dali podatke, što je dobro, ali zahtev ostaje nerešen. Bolje je mirno objasniti da je potrebna provera.	1
14	5	Kasnije čuješ priču da je ta osoba „sigurno sumnjiva“ jer izgleda drugačije od ostalih. Kako treba da postupiš?	Proceni osobu po izgledu i pretpostavi nameru. 	Prihvati priču ako je izgovorena samouvereno. 	Prenesi priču dalje jer više ljudi treba da zna. 	Zaustavi širenje priče i vrati razgovor na proverljive činjenice. 	D	Tačno! To smanjuje rizik od pogrešne procene i nepoštenog profilisanja. Zadržavaš fokus na onome što može da se potvrdi.	Netačno! Samouveren ton nije dokaz. Potrebna je provera, ne utisak. To vodi ka profilisanju, a ne ka bezbednosnoj proceni. Namera se ne zaključuje po ličnim karakteristikama.	2
16	5	Dobijaš uputstvo da ostaneš miran i nastaviš svoj redovan zadatak dok nadležni proveravaju prijavu. Kako je to najispravnije tumačiti?	To znači da ne treba ništa da uradiš, čak ni ako se pojavi nova činjenica. 	 To zTo znači da pratiš situaciju, ostaješ dostupan i prosleđuješ nove činjenice ako ih uočiš. 	To znači da si ti sada odgovoran da ispituješ osobu. 	To znači da treba da zadržiš osobu do dolaska nadležnih. 	B	Tačno! Ostaješ smiren, postupaš po uputstvu i doprinosiš proveri bez preuzimanja tuđe uloge.	Netačno! Možeš ostati miran i pratiti uputstva, ali novu, proverljivu informaciju i dalje treba proslediti kroz proceduru. Ne preuzimaš ulogu obezbeđenja ili policije. Tvoja uloga ostaje prijava i saradnja kroz proceduru.	4
17	6	Primećuješ osobu koja se zadržava kod čitača kartica i nekoliko puta gleda u kameru iznad vrata. Šta prvo radiš?	Odmah zaključuješ da priprema problem i komentarišeš to drugima. 	Ignorišeš ponašanje jer nemaš potpun dokaz. 	Mirno zabeležiš vreme, mesto i konkretno ponašanje. 	Priđeš i tražiš objašnjenje pred svima. 	C	Tačno! Ovo je najbolja osnova za jasnu i proverljivu prijavu.	Netačno! Ne moraš imati dokaz da bi prijavio zabrinjavajuće opažanje. Dovoljno je da preneseš činjenice. Korisnije je ostati pri onome što je stvarno viđeno. Nepoželjno je nepotrebno da eskalirati situaciju. Bolje je prvo zabeležiti činjenice i prijaviti po proceduri.	1
18	6	Sada vidiš da osoba fotografiše tehnički ulaz telefonom. Kako formulišeš prijavu?	 „Nešto nije u redu sa tom osobom.“ 	 „Deluje mi sumnjivo, verovatno ima lošu nameru.“ 	 „U 14:20 kod bočnog tehničkog ulaza osoba je fotografisala vrata i kameru.“ 	 „Osoba je snimala ulaz, možda radi za nekoga.“ 	C	Tačno! Ovo je precizno i upotrebljivo. Navodi šta je viđeno, kada i gde.	Netačno! Poruka je suviše neodređena ili ima nepotrebne pretposavke. Bolje je dodati konkretne radnje i lokaciju.	2
19	6	Osoba pokušava da prođe iza druge osobe bez provere. Kako postupaš?	 Vičeš na osobu da svi čuju šta radi. 	 Na miran način skrećeš pažnju nadležnom licu kroz predviđeni kanal. 	 Okrećeš glavu, jer kontrola nije tvoj posao. 	 Fizički je zaustavljaš i zadržavaš dok ne stigne obezbeđenje. 	B	Tačno! Tako ostaješ u svojoj ulozi i omogućavaš pravovremeno reagovanje.	Netačno! Ovo može privući pažnju, ali i nepotrebno poremetiti okruženje. Smiren prijavni kanal je bolji izbor.	3
20	6	Nakon prijave, šta je najkorisnije sačuvati za kasniji razgovor?	 Vreme, lokacija, opis radnji i kome si prijavio. 	 Glasine koje si čuo od drugih lica u prolazu. 	 Fotografiju osobe koju si napravio bez potrebe. 	 Samo svoje mišljenje o tome ko je ta osoba. 	A	Tačno! To su elementi koji pomažu da prijava bude proverljiva i korisna.	Netačno! Glasine lako zbunjuju i slabe kvalitet prijave. Drži se sopstvenog opažanja. Ako je snimanje dozvoljeno i po proceduri, slika može pomoći, ali samo ako je relevantno i pravilno prosleđeno. Uvek su ključne činjenice i procedura.	4
22	7	Osoba kaže da je „samo sa tobom“ i nastavlja da korača ka vratima. Kako odgovaraš?	 Kažeš da nije tvoja odgovornost i nastavljaš dalje. 	 Podižeš glas da svi čuju situaciju. 	 Ulaziš u raspravu o tome ko je u pravu. 	 Kažeš: „Molim vas, stanite ovde i pokažite akreditaciju.“ 	D	Tačno! Odlično. Rečenica je mirna, jasna i usmerava osobu na proceduru bez rasprave.	Netačno! Rasprava povećava rizik i odvlači pažnju od kontrole prolaza. Okretanje glave ne zaustavlja pokušaj prolaza. Potrebna je jasna, profesionalna intervencija.	2
21	7	Prošao si kroz vrata i vidiš da se neko približava tik iza tebe dok se vrata još zatvaraju. Šta radiš prvo?	 Okrećeš se i mirno tražiš da osoba sačeka proveru ili pokaže akreditaciju. 	 Pitaš druge ljude da procene da li osoba izgleda sumnjivo. 	 Fizički zadržavaš osobu dok ne stigne obezbeđenje. 	 Odmah se pomeriš dalje i ignorišeš situaciju. 	A	Tačno! Kratka i jasna rečenica zaustavlja pokušaj prolaza bez podizanja tenzije.	Netačno! Ne koristiti fizički kontakt osim ako zvanična procedura izričito ne nalaže drugačije. Bezbedan je miran, verbalan odgovor. Dobro je ne reagovati impulsivno, ali procena ne treba da se oslanja na utisak drugih. Fokus je na konkretnom pokušaju prolaza.	1
23	7	Osoba nema odgovarajuću akreditaciju i ne zaustavlja se. Šta je najbezbedniji sledeći korak?	 Puštaš je da prođe, pa prijavljuješ kasnije. 	 Pokušavaš sam da joj objasniš pravila dok ne promeni mišljenje. 	 Snimaš osobu i pratiš je bez obaveštavanja ikoga. 	 Zatvaraš vrata i odmah prijavljuješ događaj obezbeđenju. 	A	Tačno! Zatvaranje prolaza i prijava su najbezbedniji odgovor kada ovlašćenje nije potvrđeno.	Netačno! Dug razgovor nije potreban ako osoba nema ovlašćenje. Važno je preći na prijavu i pozvati pomoć. Kasna prijava umanjuje mogućnost da se situacija odmah kontroliše.	3
24	7	Obezbeđenje stiže i traži kratak opis događaja. Šta treba da kažeš?	 Kažeš da je osoba sigurno imala lošu nameru. 	 Navodiš tačno vreme, mesto i šta si video, bez pretpostavki o nameri. 	 Daješ samo svoje mišljenje o tome zašto je osoba to uradila.	 Prepričavaš sve redom, ali bez ključnih detalja o vratima i prolazu. 	B	Tačno! Odlično. Konkretne činjenice pomažu ovlašćenim službama da procene situaciju.	Netačno! Ne treba pretpostavljati nameru. Prijavljuju se činjenice, ne etikete. Mišljenje nije dovoljno korisno. Prijava treba da sadrži konkretne radnje i okolnosti.	4
26	8	Dok razgovarate, primećujete da plan ostaje otvoren na stolu i vidljiv drugima. Kako postupate?	 Odmah sklonite dokument na sigurno mesto ili ga okrenete van pogleda i nastavite razgovor diskretno. 	 Pozovete više ljudi da pomognu da svi čuju o čemu se radi. 	 Fotografišete plan svojim telefonom za kasnije, da ga ne zaboravite. 	 Sačekate da završite razgovor pa tek onda sklonite papir. 	A	Tačno! Prvo štitite informacije, zatim rešavate razgovor bez izlaganja sadržaja.	Netačno! Osetljiv sadržaj ne sme da ostane izložen predugo. Prvo obezbedite dokument, pa nastavite razgovor. Ne širiti informaciju bez potrebe. Osetljivi podaci ne treba da postanu zajednička tema.	2
27	8	Kolega kaže da mu lozinka treba samo „na minut“ i da je bezopasno da je podelite usmeno. Šta je najbezbedniji odgovor?	 Dajte mu lozinku i zamolite ga da je odmah promeni posle upotrebe. 	 Odbijte da je saopštite i uputite ga na odobren način pristupa ili nadležnu osobu. 	 Napišete lozinku na papir i date mu da je odnese. 	 Kažete da ćete je poslati kasnije, kada budete imali vremena. 	B	Tačno! Zadržavate poverljivost i istovremeno usmeravate osobu na ispravan postupak.	Netačno! I kratko deljenje stvara izlaganje podataka. Lozinke se ne prenose usmeno ni pissmeno bez ovlašćenog postupka.	3
28	8	Kasnije primećujete da je osetljivi dokument ostao na radnom mestu i da niko ne zna ko ga je uzeo. Šta radite?	 Pitate sve prisutne da li su ga videli i pokušate sami da otkrijete ko je odgovoran. 	 Sačekate da se pojavi vlasnik dokumenta, jer možda je samo zaboravljen. 	 Objavite na grupnom četu da je neko verovatno uzeo dokument. 	 Prijavite događaj po proceduri i navedete šta tačno nedostaje, gde je poslednji put viđen i kada ste ga primetili. 	D	Tačno! Prijavljuju se činjenice, vreme i okolnosti, bez pretpostavki o nameri.	Netačno! Ne treba širiti neproverene tvrdnje i može pogoršati situaciju. Prijava ide kroz zvaničan kanal. Kašnjenje otežava zaštitu podataka. Gubitak ili neovlašćeno otkrivanje prijavljuje se odmah.	4
29	10	Primetio si paket koji nije pod nadzorom. Šta je prvi bezbedan potez?	 Pozovi prolaznike da se okupe i pogledaju predmet. 	 Zaustavi se, pogledaj okolinu i zadrži udaljenost. 	 Dodirni paket da bi proverio da li je težak. 	 Priđi bliže da vidiš o kakvom je paketu reč. 	B	Tačno! Prvi korak je da posmatraš bez približavanja i da ostaneš dovoljno daleko da ne ugroziš sebe ili druge.	Netačno! To je loš izbor. Ne treba dodirivati predmet. Svaki fizički kontakt je van protokola. Ne treba stvarati nepotrebnu gužvu. Cilj je da se prostor smiri, ne da se okuplja više ljudi.	1
33	11	Ljudi i dalje staju da pogledaju predmet. Kako ih usmeravaš?	 Tiho ostaješ pored predmeta da ga čuvaš. 	 Kažeš svima da mogu da priđu ako ništa ne dodiruju. 	 Smireno tražiš da se udalje i usmeravaš ih ka alternativnom prolazu. 	 Glasno upozoravaš da svi trče u suprotnom pravcu. 	C	Tačno! Kratak, smiren i jasan uput smanjuje gužvu i čuva prostor.	Netačno! Ne ostaje se uz predmet. Tvoja bezbednost i razdaljina su važnije. Panika otežava kontrolu prostora. Potreban je smiren i jasan ton.	2
30	10	Sada vidiš da predmet stoji uz prolaz i nema vlasnika na vidiku. Šta treba da uradiš?	 Ignoriši predmet ako nema neposredne gužve. 	 Proceni samo šta je spolja vidljivo i zabeleži okolnosti. 	 Otvoreno saopšti da je predmet opasan i izazovi uzbunu.	 Pomeraj predmet na sigurnije mesto dalje od prolaza. 	B	Tačno! Zadržavaš se na vidljivim činjenicama, bez nagađanja i bez otvaranja ili pomeranja.	Netačno! Ne pomeraj predmet. Mesto i položaj mogu biti važni za dalji postupak. Ne izazivaj paniku. Prijava treba da bude mirna, tačna i kroz propisani kanal. Sumnjiv ili napušten predmet se prijavljuje odmah, čak i kada nema gužve.	2
31	10	Treba da pošalješ prijavu operativnom centru. Koje informacije su najkorisnije?	 Lokacija, opis predmeta, vreme zapažanja i vidljive okolnosti. 	 Pretpostavka kome predmet pripada i šta je unutra. 	 Samo da postoji paket i da si zabrinut. 	 Tražiš od prolaznika da potvrde tvoju sumnju. 	A	Tačno! To su informacije koje pomažu operativnom centru da proceni situaciju i da dalje uputstvo.	Netačno! Potrebne su konkretne, proverljive činjenice. Bolje je da se oslanjaš na sopstveno opažanje i propisanu prijavu, a ne na neproverena mišljenja drugih.	3
32	11	Primetio si ostavljen paket i nekoliko ljudi se približava. Šta radiš prvo?	 Odmah uzimaš paket i nosiš ga do obezbeđenja. 	 Priđeš da pogledaš šta je unutra. 	 Povučeš se na bezbednu razdaljinu i kratko proceniš okolinu. 	 Zoveš nekoliko kolega da priđu i pogledaju. 	C	Tačno! Prvo se stvara bezbedna udaljenost i zadržava pregled prostora.	Netačno! To nije pravilno. Predmet se ne pomera i ne preuzima se njegova kontrola. Ne prilazi se i ne vrši se pregled, jer se tako povećava rizik. Ne treba okupljati ljude oko predmeta. Udaljavanje je sigurniji prvi korak.	1
34	11	Nadređeni traži najkorisnije informacije. Šta prenosiš?	 Svoje mišljenje ko bi mogao da je ostavio predmet. 	 Pretpostavku da se verovatno radi o opasnom predmetu. 	 Tačnu lokaciju, izgled predmeta, broj ljudi u blizini i šta se promenilo. 	 Samo to da postoji problem, bez detalja. 	C	Tačno! Odlično. To su konkretne informacije koje pomažu daljem postupanju.	Netačno! Pretpostavljanje nije potrebno i može da odvede pažnju od važnih činjenica. Prenos informacije je dobar početak, ali bez detalja nadležni teže procenjuju situaciju.	3
35	11	Dok čekaš dolazak nadležnih, jedan prolaznik insistira da proveri paket. Kako reaguješ?	 Ulaziš u raspravu da bi dokazao da znaš više. 	 Dopuštaš mu da priđe, ako obeća da neće dirati predmet. 	 Kažeš mu da sačekaš trenutak i ostavljaš ga bez uputstva. 	 Smireno ga zaustavljaš i upućuješ dalje od zone, pa ostaješ dostupan za nove informacije. 	D	Tačno! Time štitiš osobu, prostor i sopstvenu ulogu.	Netačno! Rasprava ne pomaže. Kratak i profesionalan odgovor je efikasniji. Bolje je da ostaneš u kontaktu, ali treba dati jasan pravac i udaljiti osobu od mesta događaja. Pristup se ne dozvoljava bez potrebe, jer rizik ostaje isti.	4
39	12	Pre nego što završite, treba da kažete da li je neko već reagovao. Koja dopuna je najkorisnija?	 Obezbeđenje je obavešteno, prostor je označen i ljudi su usmereni na drugi prolaz. 	 Niko nije ništa uradio. 	 Neko je verovatno video isto, pa će prijaviti. 	 Udaljio sam se i čekam uputstva. 	A	Tačno! Odlično. Time se vidi šta je već preduzeto i smanjuje se rizik od ponavljanja istih radnji.	Netačno! Ne oslanjajte se na pretpostavku da će neko drugi prijaviti. Potrebna je potvrđena i konkretna informacija. Potrebno je više od ličnog položaja. Prijava treba da kaže šta je urađeno u vezi sa samim događajem.	4
37	12	Operativni centar traži da opišete događaj što kraće. Koja poruka je najkorisnija?	 Pitajte nekog drugog da vam objasni pre nego što prijavite. 	 Nešto sumnjivo je tu negde, možda je problem. 	 Ne znam tačno šta je, ali možda je opasno. 	 Ja sam kod ulaza 3 i vidim ostavljen crni kofer pored desne strane prolaza, trenutno niko nije u kontaktu s njim. 	D	Tačno! Ovo je jasno, konkretno i lako za dalje postupanje. Sadrži ko, šta i gde.	Netačno! Prijava treba da bude odmah, uz ono što ste lično uočili. Dodatna provera ne sme da odlaže obaveštavanje. Dobro je ako prijavljujete neizvesnost, ali nedostaju precizna lokacija i opis situacije. Prijava mora da sadrži činjenice, a ne utisak.	2
36	12	Uočavate da je jedan kofer ostavljen pored prolaza i niko ga ne uzima. Šta prvo radite?	 Objavljujete informaciju svima u grupi da se sklone. 	 Odmah prijavljujete operativnom centru obezbeđenja i navodite lokaciju. 	 Diskretno ga posmatrate i nastavljate kretanje. 	 Priđete koferu da proverite šta je unutra. 	B	Tačno! To je pravi prvi korak. Operativni centar može da uputi dalji postupak i po potrebi uključi druge službe.	Netačno! Upozorenje ljudima u neposrednoj blizini može biti korisno ako postoji rizik, ali paralelno treba i zvanična prijava kroz predviđeni kanal. Samo posmatranje nije dovoljno kada postoji bezbednosni rizik. Potrebna je prijava, zajedno sa tačnom lokacijom. Ne prilazite nepoznatom predmetu i ne pokušavajte da ga otvarate ili pomerate. Prijavite ga odmah kroz zvanični kanal.	1
38	12	Dobijate pitanje da li treba kontaktirati MUP. Kako postupate?	 Prvo obaveštavate prijatelja u blizini, pa kasnije proveravate šta dalje. 	 Navodite da prijavu preuzima operativni centar, a MUP se uključuje kada je to propisano ili potrebno prema proceduri. 	 Samostalno odlučujete da MUP nije potreban i ne prijavljujete dalje. 	 Kažete samo da je situacija pod kontrolom i završavate poziv. 	B	Tačno! Tako pokazujete da poštujete zvanični tok i da ne preuzimate odluke koje pripadaju proceduri i nadležnim službama.	Netačno! Ne donosite takvu odluku sami ako procedura ili okolnosti traže drugi kanal. Pratite propisani tok prijave i uputstva koja dobijete. Važno je ne umanjivati značaj događaja. Ako kanal ili organ treba da se uključi, to mora biti jasno navedeno.	3
40	13	Čuješ kolegu kako kaže da 'verovatno nije ništa', a zatim preko razglasa stiže nalog za evakuaciju. Šta radiš prvo?	 Pratim zvaničnu objavu i odmah krećem ka bezbednom izlazu. 	 Pitam kolegu šta misli i čekam još malo. 	 Vraćam se da pokupim stvari pre izlaska. 	 Odlazim do najbližeg izlaza, ali se usput zadržavam da zovem druge. 	A	Tačno! U vanrednoj situaciji zvanično uputstvo ima prednost nad neformalnim komentarima, jer smanjuje zastoje i zabunu.	Netačno! Kada stigne zvaničan nalog, vreme se koristi za izlazak, ne za proveravanje glasina. Tokom evakuacije lične stvari nisu prioritet, a vraćanje povećava rizik i usporava druge. Dobro je ako krećeš ka izlazu, ali zadržavanje može da uspori tok evakuacije. Bolje je pratiti pravac i kretati se bez zaustavljanja.	1
41	13	Na putu vidiš osobu koja je zbunjena i ne zna gde je izlaz. Šta je najbolji sledeći korak?	 Ignorišem je, jer svako mora sam da se snađe. 	 Zaustavljam se dugo da joj detaljno objašnjavam sve mogućnosti. 	 Pokazujem pravac i kratko je usmeravam ka najbližem bezbednom izlazu. 	 Vraćam se suprotno od toka da je povedem drugim putem bez provere. 	C	Tačno! Ispravno. Kratka pomoć je korisna kada ne ugrožava tvoje i tuđe kretanje.	Netačno! Kretanje ipak mora da ostane bezbedno i uređeno. Kratka pomoć je poželjna ako je možeš pružiti bez zastoja. Uvek prati označen ili naložen bezbedan pravac, ne improvizuj.	2
42	13	Stigao si napolje i vidiš poznato mesto blizu zone, pa ti deluje da bi bilo brzo da se vratiš po akreditaciju ili telefon. Šta biraš?	 Vraćam se nakratko, jer je to blizu i brzo ću izaći. 	 Ulazim u zonu da proverim da li je evakuacija stvarno završena. 	 Idem na odobreno zborno mesto i čekam dalje uputstvo. 	 Ostajem gde jesam dok ne dobijem ličnu potvrdu od prijatelja da je sve u redu. 	C	Tačno! Zborno mesto je mesto za provere i dalje instrukcije, ne za povratak u zonu.	Netačno! Ne treba se vraćati. Povratak u zonu je dozvoljen tek kada nadležni potvrde da je bezbedno. Ponovni ulazak bez zvanične dozvole može da ugrozi tebe i druge. Bolje je da ostaneš van zone, ali potvrda mora doći zvaničnim kanalom, ne od prijatelja.	3
43	13	Na zbornom mestu čuješ različite priče o tome šta se dogodilo. Kako se ponašaš?	 Širim ono što sam čuo od drugih da bi svi znali više. 	 Pozivam kolege da se vrate u zonu sa mnom, jer deluje bezbedno. 	 Pratim dalja uputstva ovlašćenih lica i ostajem miran. 	 Napustim zborno mesto odmah čim mi deluje da je situacija prošla. 	C	Tačno! Odlično. Na zbornom mestu se čeka zvanična potvrda, bez širenja glasina ili samostalnih zaključaka.	Netačno! Širenje neprovrenih informacija pojačava dezinformacije. U vanrednoj situaciji ostaje se pri proverenim informacijama. Povratak nije dozvoljen bez zvanične potvrde. Najbezbednije je ostati na odobrenom mestu i čekati instrukcije. Ne treba odlaziti bez potvrde. Dalji koraci dolaze od nadležnih lica.	4
47	14	Situacija se smiruje, a od vas se traži kratko usmeno objašnjenje onoga što ste videli. Kako završavate razgovor?	 Kažete da više ništa nećete reći ni ako vas ponovo pitaju. 	 Dajete uredan, kratak pregled činjenica i ostajete dostupni za dodatna pitanja. 	 Produžavate razgovor da biste objasnili celu svoju verziju događaja do detalja. 	 Dodajete lične pretpostavke o motivu i krivici. 	B	Tačno! To je najbolji završetak. Kratko, jasno i bez nepotrebnih dodataka.	Netačno! Zatvaranje komunikacije nije dobro kada službena lica traže razjašnjenje. Saradnja podrazumeva dostupnost za dodatna pitanja. Detalji mogu biti korisni, ali preopširan govor otežava rad službenih lica. Najbolje je biti sažet i precizan. Motivi i zaključci bez osnova nisu od pomoći. Ostajte na onome što ste neposredno uočili.	4
45	14	Službeno lice traži da ostanete dostupni dok se obavlja provera. Kako postupate?	 Tražite od drugih ljudi da ostanu uz vas i komentarišu situaciju. 	 Odlazite da obavite svoj planirani posao i javite se kasnije. 	 Počinjete da objašnjavate svoj stav i tražite da vam se garantuje odgovor odmah. 	 Ostajete dostupni i pratite dalja uputstva, bez ulaska u raspravu. 	D	Tačno! Tako pokazujete saradnju i poštovanje nadležnosti, što je upravo potrebno u takvom trenutku.	Netačno! Bolje je nego širenje informacija, ali i dalje može stvarati gužvu. Najpraktičnije je mirno sačekati dalje uputstvo. Odlazak može omesti proveru i otežati koordinaciju. Najpre ispoštujte uputstvo koje ste dobili. U incidentu je važnija operativna jasnoća od rasprave. Ne opterećujte službeno lice dodatnim zahtevima.	2
44	14	Službeno lice vas pita šta ste tačno videli pre nekoliko minuta. Šta radite prvo?	 Kažete samo ono što ste lično uočili, bez nagađanja. 	 Ukratko odbijete da odgovorite i kažete da nije vaš posao. 	 Prvo pitate druge prisutne da li se slažu sa vašim utiskom. 	 Prepričate sve što ste čuli od drugih, pa i ono što niste proverili. 	A	Tačno! To je najbolji pristup. Činjenice pomažu službenim licima da procene situaciju bez šuma i pretpostavki.	Netačno! Bolje je da ne spekulišete, ali potpuna odbijenica nije korisna. Kratke, tačne činjenice su pravi doprinos. Važno je govoriti iz sopstvenog neposrednog opažanja. Neproverene informacije nisu pouzdane i mogu otežati postupanje.	1
46	14	Tokom razgovora saznajete poverljiv detalj o lokaciji i proceduri. Šta je najispravnije?	 Zapamtite detalj i kasnije ga prepričajte u neformalnom razgovoru. 	 Odmah podelite detalj sa kolegama da bi svi znali šta se dešava. 	 Objavite informaciju na telefonu da biste je sačuvali za sebe. 	 Saopštite ga samo ako vas službeno lice izričito pita i to je relevantno za postupanje. 	D	Tačno! Prenosi se samo ono što je traženo i relevantno, bez širenja van tog okvira.	Netačno! Neformalno prepričavanje nije prihvatljivo. Informacije se koriste samo kroz zvanične kanale i po potrebi. Poverljive informacije se ne prosleđuju neovlašćeno. Deljenje može ugroziti postupanje i bezbednost. Bilježenje može biti korisno ako je dozvoljeno, ali sadržaj i dalje ne sme da se deli dalje niti da ugrozi poverljivost.	3
49	15	Operativni centar traži kratak opis situacije. Šta je najkorisnije da kažeš?	 Daješ dugačko objašnjenje o tome ko je možda ostavio predmet i zašto misliš da je bezazlen. 	 Navodiš ko zove, gde se nalaziš, šta je uočeno i ima li ljudi u blizini. 	 Prenosiš samo da je 'nešto sumnjivo' i prekidaš vezu. 	 Tražiš da ti odmah kažu da li je predmet opasan, pre nego što kažeš gde je. 	B	Tačno! To je jasna i korisna dojava. Kratke činjenice pomažu službama da procene prioritet i sledeće korake.	Netačno! Dodatne pretpostavke mogu odvući pažnju od suštine. Bolje je držati se onoga što si stvarno video ili čuo. Službama trebaju činjenice koje mogu brzo da provere. Prvo dostavi informacije koje si sigurno uočio. Procenu opasnosti rade nadležne službe.	2
51	15	Stiglo je službeno uputstvo da se prostor napusti određenim izlazom. Šta radiš?	 Zadržavaš se da bi ostalim osobama objasnio šta misliš da se dešava. 	 Ignorišeš uputstvo dok ne vidiš da drugi kreću prvi. 	 Napravljaš prečicu kroz zabranjeni prolaz da bi brže izašao. 	 Pomažeš drugima da krenu ka odobrenom izlazu i ostaješ miran tokom kretanja. 	D	Tačno! Ovo je najbolji izbor. Pratiš zvanično uputstvo i doprinosiš urednoj evakuaciji. Bolje je da posmatraš, ali ne treba čekati tuđe ponašanje kao zamenu za zvanično uputstvo. 	Netačno! Objašnjavanje pretpostavki usporava kretanje. U kriznoj situaciji važnije je slediti uputstva nego nagađati. Koristi se samo odobreni izlaz. Prečice mogu ugroziti i tebe i druge.	4
50	15	Dok čekaš dalje uputstvo, nekoliko ljudi želi da ostane bliže mestu događaja. Kako postupaš?	 Tražiš od njih da se udalje i da prate uputstva obezbeđenja, bez rasprave. 	 Pozivaš ih da formiraju krug oko mesta kako bi svi bolje videli šta se dešava. 	 Dopuštaš im da ostanu ako obećaju da neće prilaziti predmetu. 	 Samostalno određuješ ko sme da ostane, a ko da ide. 	A	Tačno! Ispravno. Smanjuješ gužvu i pomažeš da službe imaju prostor za rad.	Netačno! Dobo je ako pokušavaš da utišaš radoznalost. Ipak, udaljavanje je ispravniji izbor. Čak i pasivno prisustvo može ometati procenu i kretanje službi. 	3
48	15	Primetio si napušten predmet pored prolaza. Šta radiš prvo?	 Zadržavaš prolaz i samostalno organizuješ kontrolu prostora dok ne stigne neko iz službi. 	 Prilaziš da proveriš šta je unutra, da bi brže procenio rizik. 	 Objavljuješ upozorenje svima oko sebe i tražiš da odmah napuste zonu bez daljih uputstava. 	 Obaveštavaš operativni centar obezbeđenja kroz zvaničan kanal i ostaješ na bezbednoj udaljenosti. 	D	Tačno! Ovo je ispravan početak. Prijava i udaljavanje omogućavaju službama da preuzmu procenu bez dodatnog izlaganja riziku.	Netačno! Ne preuzimaj ovlašćenja obezbeđenja. Tvoja uloga je prijava i saradnja, ne samostalno upravljanje prostorom. Ne dira se predmet niti se samostalno procenjuje sadržaj iz neposredne blizine. Dobro je ako želiš da smanjiš izloženost, ali bez zvaničnog kanala i jasnog uputstva možeš izazvati zabunu.	1
\.


--
-- Data for Name: backup_lessons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.backup_lessons (id, section_id, title, content, image_path, sort_order, scenario_title, scenario_description, scenario_complete_positive, scenario_complete_negative) FROM stdin;
1	1	Dobrodošli	<p><b>Siguran rad u restriktivnim zonama</b><br>Dobrodošli na obuku Bezbednost u restriktivnim zonama Expo 2027, namenjenu akreditovanim licima koja ulaze u restriktivne prostore bez prethodnog bezbednosnog znanja. </p><p>Kroz jasna i praktična pravila naučićete šta znači vaša pravna odgovornost, kako se pravilno nosi i čuva akreditacija, po kom principu se krećete samo kroz odobrene zone, kako da prepoznate indikatore bezbednosnog rizika i zaštitite osetljive informacije, kao i kako da primenite protokol Vidi, prepoznaj, prijavi za sumnjive ili napuštene predmete bez ugrožavanja sebe i drugih. </p><p>Na kraju ćete uvežbati osnovne korake komunikacije, evakuacije i saradnje tokom požara, dojave o bombi i drugih vanrednih situacija, oslanjajući se na važeće propise Republike Srbije i zvanične procedure organizatora.</p><p><br></p><p><h4>Šta ćete naučiti</h4><p><br></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/49709f66-9a31-4170-b56d-9638fa353ede_image.png" alt="slika"><br></p><br><p>Ova znanja će vas pripremiti da se suočite sa izazovima u restriktivnim zonama i osigurate bezbednost svih uključenih. Hvala vam što ste deo ovog važnog procesa!</p>\r\n</p>	\N	1	\N	\N	\N	\N
5	3	Kultura zajedničke bezbednosti	<p>Kada više akreditovanih lica deli isti prostor, bezbednost zavisi od sitnih, doslednih postupaka. Dobar primer je ako primetiš nešto neobično, proveriš šta si zaista video i čuo i proslediš informaciju kroz odgovarajući kanal, bez nagađanja i bez samoinicijativnog „rešavanja" situacije.</p>\r\n\r\n<h4>Šta podrazumeva kultura i svest bezbednosti</h4>\r\n<ul>\r\n    <li><strong>Posmatraj činjenice:</strong> šta si stvarno video, čuo i potvrdio.</li>\r\n    <li><strong>Čuvaj diskreciju:</strong> informacije deli samo sa ovlašćenim licima.</li>\r\n    <li><strong>Prijavi kroz proceduru:</strong> svaki rizik prijavi nadležnima, ne širi glasine.</li>\r\n    <li><strong>Poštuj granice uloge:</strong> akreditovano lice doprinosi zaštiti lokacije, ali ne menja obezbeđenje ni policiju.</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/0f91dc9c-a89f-474c-bd06-dc19fa0eb8f4_image.png" alt="slika"><br></p><ul>\r\n</ul><br>	\N	1	Opažanje ili pretpostavka	Nalaziš se u prolazu ka restriktivnoj zoni i primećuješ osobu koja stoji duže nego što se očekuje, gledajući oko sebe. Nema drugih potvrđenih znakova problema, ali ti deluje neuobičajeno. Treba da proceniš šta je činjenica, a šta je samo utisak, i da izabereš sledeći korak.	Vrlo dobro razlikuješ opažanje od zaključivanja i čuvaš profesionalnu granicu uloge. Takav pristup jača zajedničku bezbednost i pomaže da nadležni brzo dobiju tačne informacije.	Potrebno je još vežbe u razlikovanju činjenica od pretpostavki. Fokusiraj se na ono što možeš jasno da vidiš, čuješ ili potvrdiš, i prijavljuj kroz nadležni kanal bez dodavanja ličnih tumačenja.
4	2	Zone kretanja i prijava nepravilnosti	<h3>Kretanje samo kroz ovlašćene zone</h3>\r\n<p>Akreditacija ne znači slobodan prolaz svuda, već pristup tačno određenim zonama. Zato je važno da u svakom trenutku znate gde smete da budete, kako to proveravate i šta radite ako primetite da ste ušli u pogrešan prostor. Brza i mirna reakcija je deo profesionalnog ponašanja, ne znak problema.</p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/d9979211-2151-4618-950d-676dba3bb1dd_image.png" alt="slika"><br></p>\r\n\r\n<h4>Zone kretanja na lokaciji Expo 2027</h4>\r\n<ul>\r\n    <li><strong>1. Javna zona</strong> — otvorena za sve posetioce</li>\r\n    <li><strong>2. Kontrolisana zona</strong> — pristup samo akreditovanim licima</li>\r\n    <li><strong>3. Restriktivna zona</strong> — pristup samo ovlašćenim licima</li>\r\n</ul>\r\n\r\n<div class="alert alert-warning">\r\n    <strong>Kretanje je dozvoljeno isključivo kroz označene i odobrene prolaze. Poštujte pravila i uputstva službenih lica na terenu.</strong>\r\n</div>\r\n\r\n<table class="table">\r\n    <thead><tr><th>Situacija</th><th>Šta uraditi</th></tr></thead>\r\n    <tbody>\r\n        <tr><td>Na oznaci vidiš da zona nije u tvom opsegu pristupa</td><td>Zaustavi se i ne ulazi dalje. Proveri akreditaciju i smernice za kretanje.</td></tr>\r\n        <tr><td>Nisi siguran da li je pristup odobren</td><td>Zadrži se na mestu i pitaj ovlašćeno lice ili obezbeđenje pre ulaska.</td></tr>\r\n        <tr><td>Shvatio si da si ušao u neodobrenu zonu</td><td>Odmah se bezbedno povuci istim ili najbližim dozvoljenim putem i prijavi grešku.</td></tr>\r\n        <tr><td>Akreditacija ne odgovara ulazu ili prostoru</td><td>Ne pokušavaj da nastaviš kretanje dok se ne dobije jasno uputstvo.</td></tr>\r\n    </tbody>\r\n</table>\r\n\r\n<h4>Koraci bezbednog izlaska nakon pogrešnog ulaska</h4>\r\n<ol>\r\n    <li><strong>Stani odmah.</strong> Nemoj da nastavljaš kretanje, ne preusmeravaj se nasumično i ne pokušavaj da „brzo prođeš" kroz zonu. Kratko zaustavljanje smanjuje rizik od daljeg ulaska u prostor za koji nemaš ovlašćenje.</li>\r\n    <li><strong>Orijentiši se i povuci se bezbedno.</strong>&nbsp; Vrati se najbližim dozvoljenim putem ili po uputstvu koje vidiš na lokaciji. Ako si u blizini ljudi ili opreme, kreći se mirno i bez zadržavanja.</li>\r\n    <li><strong>Obavesti ovlašćeno lice.</strong>&nbsp; Prijavi da si greškom ušao u neodobrenu zonu i reci gde si trenutno, bez ulepšavanja ili skrivanja informacije. Kratka i tačna prijava pomaže da se situacija odmah razjasni.</li>\r\n    <li><strong>Postupi po dobijenom uputstvu.</strong> Možeš dobiti nalog da ostaneš na mestu, da se vratiš drugim putem ili da se javiš nadležnoj službi. Najvažnije je da ne donosiš sopstvenu procenu umesto zvaničnog uputstva.</li></ol><p>Donosi odluke kroz 4 poteza i izaberi odgovor koji najbolje pokazuje bezbedno i odgovorno postupanje.</p><ol>\r\n</ol>\r\n	\N	3	Pogrešan ulazak	Krećeš se kroz objekat sa akreditacijom i u jednom trenutku shvataš da si u prostoru za koji nemaš ovlašćenje. U blizini su druge osobe i označeni prolazi, a treba da reaguješ mirno i profesionalno. Tvoja odluka sada utiče na bezbednost, tok kretanja i način prijave događaja.	Vrlo dobro prepoznaješ šta znači odgovorno kretanje u ovlašćenim zonama. Nastavi da vežbaš brzu proveru pristupa i disciplinovano postupanje po uputstvu, jer su to ključne navike na lokaciji.	Potreban je oprezniji pristup. Ponovo prouči razliku između zaustavljanja, prijave i postupanja po uputstvu, pa se usredsredi na to da ne ulaziš dalje kada nisi siguran u ovlašćenje.
16	5	Završni kviz	<div class="alert alert-info">\r\n    <h4>Testirajte svoje znanje</h4>\r\n    <p>Nakon što ste prošli sve lekcije, vreme je za završni test. Potrebno je najmanje 9 tačnih odgovora od 10 pitanja (90%) za uspešno polaganje.</p>\r\n    <p>Ukoliko ne položite test, možete ga ponovo polagati.</p>\r\n</div><br>	\N	5	\N	\N	\N	\N
9	4	Zabranjeni predmeti i izvori rizika	<h3>Zabranjeni predmeti</h3>\r\n<p>Po ulasku u restriktivnu zonu, važno je da znate da se ne procenjuje samo <strong>šta je predmet</strong>, već <strong>da li je njegovo unošenje dozvoljeno</strong>. Neki predmeti su u praksi uvek problematični, kao što su oružje, eksplozivne i zapaljive materije, dok su za dronove i sličnu bespilotnu opremu, odlučujući posebna dozvola i zvanična pravila. Najsigurniji pristup je da se oslonite na važeće propise, uputstva organizatora i nalog nadležne službe.</p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/1981b79d-d00d-4495-9a70-5b2e5af86e60_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/0fd8d68e-53db-487c-8b46-b020e3a21441_image.png" alt="slika"><br></p>\r\n\r\n<table class="table">\r\n    <thead><tr><th>Kategorija</th><th>Rizik</th><th>Očekivana prijava</th></tr></thead>\r\n    <tbody>\r\n        <tr><td>Vatreno i drugo oružje</td><td>Visok bezbednosni rizik i stroga kontrola pristupa</td><td>Odmah obavestiti nadležnu službu i postupiti po uputstvu</td></tr>\r\n        <tr><td>Eksplozivne materije i sredstva</td><td>Ozbiljna opasnost za ljude, objekte i opremu</td><td>Bez zadržavanja, prijava obezbeđenju ili ovlašćenom licu</td></tr>\r\n        <tr><td>Zapaljive i lako zapaljive materije</td><td>Povećan rizik od požara i širenja incidenta</td><td>Prijava pre unošenja ili pri uočavanju u zoni</td></tr>\r\n        <tr><td>Dronovi i slična bespilotna oprema</td><td>Moguće narušavanje zaštite prostora i privatnosti</td><td>Prijava nadležnoj službi po uočavanju u zoni, radi provere dozvole</td></tr>\r\n    </tbody>\r\n</table>\r\n\r\n<div class="alert alert-danger">\r\n    <strong>Konačnu odluku donose važeći propisi, pravila organizatora i nadležna služba.</strong><br>\r\n    Nadležna služba zadržava pravo provere i privremenog ili trajnog oduzimanja predmeta koji nisu dozvoljeni u restriktivnoj zoni.</div>	\N	1	\N	\N	\N	\N
6	3	Prepoznavanje unutrašnjih pretnji	<h3><br></h3>\r\n<p>U restriktivnoj zoni najviše vredi mirno, precizno opažanje. Ne prijavljuje se „utisak" o nečijoj nameri, već konkretna radnja koja odstupa od uobičajenog ponašanja ili odobrenog kretanja.</p>\r\n\r\n<h4>Na šta se obraća pažnja</h4>\r\n<ul>\r\n    <li><b>Osmatranje sistema obezbeđenja</b>: zadržavanje kod kamera, čitača kartica, vrata ili kontrolnih punktova bez jasnog razloga.</li>\r\n    <li><b>Fotografisanje tehničkih ulaza i osetljivih tačaka</b>: snimanja mesta koja nisu namenjena javnosti.</li>\r\n    <li><b>Pokušaj prolaska bez provere</b>: ulazak za drugim licima, zaobilaženje kontrole ili insistiranje na prolazu van procedure.</li>\r\n</ul>\r\n<p>Bezbednosno korisno pitanje nije „ko je ta osoba?", nego „šta ta osoba radi, gde se nalazi i da li to odgovara pravilima kretanja i pristupa". Tako se izbegavaju glasine i pretpostavke.</p>\r\n\r\n<p>\r\n    </p><p></p><p><br></p><p><img style="max-width: 100%; cursor: pointer; width: 506.879px; height: 277.15px;" src="/uploads/85a4fe1d-83c1-4c32-b87b-6918cba2965d_image.png" alt="slika"><img style="max-width: 100%; cursor: pointer; width: 522.117px; height: 285.482px;" src="/uploads/562245ee-1e76-4b59-9a04-f725d6aef758_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer; width: 509px; height: 278.31px;" src="/uploads/0e934e09-ad26-4242-a7a0-c4d2d7c5bd83_image.png" alt="slika"><img style="max-width: 100%; cursor: pointer; width: 522px; height: 285.418px;" src="/uploads/baac4383-2e2b-428f-9dcd-d25a14ec03df_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer; width: 509px; height: 278.31px;" src="/uploads/96032a78-3ab4-409e-8758-20c97b52fe80_image.png" alt="slika"><img style="max-width: 100%; cursor: pointer; width: 528.094px; height: 288.75px;" src="/uploads/1cca7da1-07d5-4c72-881d-33b67017a653_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer; width: 508.433px; height: 278px;" src="/uploads/cd0a7164-dd3e-4dd4-8dfd-a2624e92107f_image.png" alt="slika"><img style="max-width: 100%; cursor: pointer; width: 523.979px; height: 286.5px;" src="/uploads/879fa787-3d77-4441-8161-e49906486bae_image.png" alt="slika"></p><p><br></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/79c1b6e8-2177-4982-9291-e6794809f177_image.png" alt="slika"><br></p><p><br></p><p>Na bočnom tehničkom ulazu, akreditovano lice u prolazu zastaje nekoliko puta, gleda u kameru i vrata, zatim pravi dve fotografije mobilnim telefonom. </p><p>Posle toga pokušava da uđe iza druge osobe bez zaustavljanja kod provere. </p><p>Službeno lice u blizini primećuje ponašanje, pamti vreme, lokaciju i osnovni opis radnji, pa prijavljuje nadležnoj službi kroz predviđeni kanal.<br>Ovakav pristup je važan zato što ne oslanja prijavu na pretpostavku o motivu. </p><p>Prijava ostaje jasna, proverljiva i korisna za dalje postupanje.</p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/5086b6a9-8d60-40e9-886e-0f3dc754106a_image.png" alt="slika"><br></p><p><br></p><table class="table"><thead><tr><th>Opažanje</th><th>Mogući rizik</th><th>Bezbedna reakcija</th></tr></thead>\r\n    <tbody>\r\n        <tr><td>Dugotrajno zadržavanje kod čitača kartica ili vrata</td><td>Prikupljanje informacija o pristupu ili testiranje reakcije osoblja</td><td>Zapamti mesto, vreme i opis radnje, pa prijavi po proceduri.</td></tr>\r\n        <tr><td>Fotografisanje tehničkog ulaza, ograde ili kontrolne tačke</td><td>Neovlašćeno beleženje osetljivih detalja</td><td>Ne ulazi u raspravu, zabeleži okolnosti i obavesti nadležno lice.</td></tr>\r\n        <tr><td>Ulazak za drugom osobom bez provere</td><td>Neovlašćen prolaz u zaštićenu zonu</td><td>Ne sprečavaj fizički, ali odmah prijavi posmatranu situaciju.</td></tr>\r\n    </tbody>\r\n</table>\r\n	\N	2	Prijava sumnjivog ponašanja	U blizini tehničkog ulaza primećuješ ponašanje koje odstupa od uobičajenog kretanja. Tvoja uloga je da proceniš šta je najkorisnije prijaviti i kako to uraditi profesionalno, bez nagađanja o nameri osobe.	Odlično razlikuješ opažanje od zaključka i znaš kada treba mirno prijaviti ponašanje. Takav pristup čuva bezbednosnu kulturu i pomaže nadležnima da reaguju brzo i tačno.	Vredi ponovo vežbati razliku između činjenice i pretpostavke. Usmeri se na to da prijava sadrži šta je tačno viđeno, gde i kada, bez komentara o nameri ili ličnosti.
13	5	Evakuacija restriktivnih zona	<h3><br></h3>\r\n<p>U vanrednoj situaciji pretpostavlja se da će se pratiti samo zvanično uputstvo i da se prostor napusti mirno, bez zadržavanja. Kod požara, dojave o bombi ili drugog neposrednog rizika cilj je isti: zaštititi život kroz brz, organizovan izlazak i dolazak na zbornom mestu. Neformalna obaveštavanja, glasine i samoinicijativno vraćanje u zonu mogu da uspore postupanje i povećaju rizik.</p>\r\n\r\n<h4>Postupak evakuacije</h4>\r\n<ul>\r\n    <li><strong>Zvaničan kanal je uvek merilo:</strong> obezbeđenje, organizator i druga nadležna lica daju uputstva koja se prate odmah.</li>\r\n    <li><strong>Kretanje mora biti kontrolisano:</strong> koriste se bezbedni izlazi koji su označeni i koji su navedeni u uputstvu.</li>\r\n    <li><strong>Pomoć drugima je važna, ali samo kada je bezbedno:</strong> ako je neko usporen, zgrčen ili otežano pokretan, pruži se podrška bez pravljenja gužve i bez vraćanja unazad.</li>\r\n    <li><strong>Povratak nije dozvoljen:</strong> u zonu se ne ulazi ponovo dok nadležni izričito ne potvrde da je bezbedno.</li>\r\n</ul>\r\n\r\n<h4>Koraci evakuacije</h4>\r\n<ol>\r\n    <li><strong>Prekini šta radiš i poslušaj zvanično uputstvo.</strong> Ako se oglasi alarm, čuje se najava ili dobiješ nalog za evakuaciju, odmah prekini aktivnost i usmeri pažnju na najbližu informaciju. Ne oslanjaj se na prepričavanje drugih lica.</li>\r\n    <li><strong>Kreni prema najbližem bezbednom izlazu.</strong> Prati označene pravce kretanja ili direktno uputstvo ovlašćenog lica. Ne koristi prečice, ne ulazi u zatvorene delove i ne zadržavaj se da proveravaš situaciju.</li>\r\n    <li><strong>Ostani miran i kreni se uredno.</strong> Zadrži razmak, ne trči i ne pravi gužvu. Ako su ti potrebni kratki usmeravajući signali ili potvrda pravca, traži ih od obezbeđenja ili drugog ovlašćenog lica.</li>\r\n    <li><strong>Pomozi drugima samo ako to možeš bez rizika.</strong> Ako neko ima poteškoće da se kreće, pruži kratku i jasnu pomoć, ali ne ugrožavaj sebe niti usporavaj tok evakuacije. Prioritet je da svi izađu bez dodatnog zastoja.</li>\r\n    <li><strong>Stigni na odobreno zborno mesto i ostani tamo.</strong> Nakon izlaska, prijavi prema proceduri i sačekaj dalje uputstvo. Ne vraćaj se po lične stvari i ne ulazi ponovo u zonu dok ne dobiješ zvaničnu dozvolu.</li></ol><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/4628a065-6fe8-4acf-9b11-de368d97d17c_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/7b3018d0-1bd5-421b-969a-4c210d60fd4b_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/5afef7f7-4614-4e03-b38c-bf9140c2670e_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/37fa63e8-deee-4bc5-9aa5-371a5b5384e7_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/0ef1dddc-1a82-4aff-bc52-0f07c05769f2_image.png" alt="slika"><br></p><ol>\r\n</ol>\r\n	\N	2	Neočekivane poruke pri evakuaciji	Nalaziš se u restriktivnoj zoni kada se istovremeno čuju neformalno dobacivanje kolega i zvanična najava preko sistema razglasa. Ti si odgovorno akreditovano lice i moraš brzo da proceniš kojoj poruci daješ prednost i kako se krećeš dalje. Važno je da ostaneš pribran, jer svako zadržavanje ili samostalno tumačenje može da uspori bezbedan izlazak.	Vrlo dobro razlikuješ bezbedno postupanje tokom evakuacije. Nastavi da se oslanjaš na zvanične kanale, uredno kretanje i dolazak na odobreno zborno mesto bez samoinicijativnog vraćanja.	Potrebno je dodatno uvežbavanje osnovnog evakuacionog ponašanja. Najvažnije je da se odmah prati zvanično uputstvo, da se ne vraća u zonu i da se ostaje na odobrenom zbornom mestu.
2	2	Odgovornost u restriktivnim zonama	<p>Akreditacija u restriktivnoj zoni nije samo dozvola za ulazak, već i obaveza da se poštuju propisana pravila kretanja, ponašanja i prijavljivanja nepravilnosti. </p><p>Odgovornost se ne zasniva na jednom dokumentu, već na spoju važećih propisa, internih procedura organizatora i uputstava privatnog obezbeđenja na lokaciji. </p><p>Kada se ta pravila usklade, pristup ostaje bezbedan za sve prisutne.</p><p><b>Šta nosi odgovornost</b></p><ul><li><b>Akreditovano lice</b> odgovara za to kako koristi akreditaciju, gde se kreće i da li prati odobrene procedure.</li><li><b>Privatno obezbeđenje</b> sprovodi kontrolu pristupa, daje uputstva i reaguje u skladu sa ovlašćenjima na lokaciji.</li><li><b>Nadležni državni organi</b>&nbsp;postupaju kada je potrebno primeniti zakonska ovlašćenja, inspekcijski nadzor ili druge formalne mere.<br><br></li></ul><p>Važno je zapamtiti jednu praktičnu stvar: uvek se primenjuju važeći tekstovi propisa i zvanične procedure, a ne neformalni dogovori, pretpostavke ili informacije iz druge ruke.</p><p><br></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/7e8a0fad-7dc6-42b9-ac60-e8da0a7065dc_image.png" alt="slika"></p><p><br></p><p><b>Akreditovano lice<br></b><img style="max-width: 100%; cursor: pointer;" src="/uploads/c5a4e2fd-0e4f-4230-a2d3-9dc6e99c05c9_Screen_Shot_2026-09-07_at_18.24.43.png" alt="slika"><b>Privatno obezbeđenje</b><img style="max-width: 100%; cursor: pointer;" src="/uploads/86161323-f3e8-437b-846d-41e849ac7d6f_Screen_Shot_2026-09-07_at_18.23.47.png" alt="slika"><b>Nadležni organi</b><img style="max-width: 100%; cursor: pointer;" src="/uploads/2162d4f2-73cb-4031-ab94-4925a0afcfd7_Screen_Shot_2026-09-07_at_18.24.01.png" alt="slika"><b><br></b></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/af5dc95b-b01c-4082-b4cc-f2da3745b8a7_image.png" alt="slika"><b><br></b></p><p><b><br></b></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/2ae2b240-ea77-47e6-98bc-610f919b642e_image.png" alt="slika"><b><br></b></p><p><b><br></b></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/736881bf-bf70-43e2-8df2-30c3998221ae_image.png" alt="slika"><b><br></b></p><p><b><br></b></p><p><b><br></b></p><p><b><br></b></p>	\N	1	test1	t1	Odlično poznaješ postupke u restriktivnoj zoni. Sjajno odgovoreno!	Nedovoljno. Ponovi lekciju o pravima i dužnostima u restriktivnoj zoni.
17	6	Ključne lekcije	<h3>Čestitke na završetku kursa!</h3>\r\n<p>Poštovani,</p>\r\n<p>Čestitamo vam na uspešnom završetku kursa „Bezbednost u restriktivnim zonama — Expo 2027"! Kao akreditovana lica bez prethodnog bezbednosnog znanja koja pristupaju restriktivnim zonama, svesni smo koliko je važno imati čvrstu osnovu i pripremljen pristup za ovu izazovnu situaciju.</p>&nbsp;<h4>Ciljevi kursa:</h4>\r\n<ul>\r\n    <li><strong>Objasnite pravnu odgovornost</strong> akreditovanog lica prema pravilima privatnog obezbeđenja, zaštite kritične infrastrukture i internim procedurama Expo 2027.</li>\r\n    <li><strong>Pravilno nosite, čuvate i koristite akreditaciju</strong> da se krećete samo kroz odobrene zone.</li>\r\n    <li><strong>Prepoznate indikatore sumnjivog ponašanja</strong> i zaštitite osetljive informacije.</li>\r\n    <li><strong>Primetite i reagujete</strong> primenjujući protokol „Vidi, prepoznaj, prijavi" za sumnjiv ili napušten predmet bez ugrožavanja sebe i drugih.</li>\r\n    <li><strong>Pravilno komunicirate bezbednosni rizik</strong> i postupate tokom evakuacije, požara, dojave o bombi ili drugog incidenta.</li>\r\n</ul>\r\n<p>Ova znanja će vas pripremiti da se suočite sa izazovima u restriktivnim zonama i osigurate bezbednost svih uključenih. Hvala vam što ste deo ovog važnog procesa!</p>\r\n	\N	1	\N	\N	\N	\N
3	2	Pravilna upotreba akreditacije	<p>Akreditacija nije samo pristupnica, već i dokaz da ste ovlašćeni da boravite u određenoj zoni i da se pridržavate pravila lokacije. </p><p>Zato je važno da bude stalno vidljiva, čuvana od oštećenja i dostupna za proveru kada je to potrebno. </p><p>Neuredno nošenje, skrivanje ili ustupanje drugoj osobi može stvoriti bezbednosni rizik i dovesti do posledica po vas i po organizaciju.</p><p><b>Šta se očekuje u praksi</b></p><ul><li>Nosite akreditaciju onako kako je propisano internim pravilima organizatora.</li><li>Proveravajte da li je čitljiva, neoštećena i pod vašim neposrednim nadzorom.</li><li>Reagujte odmah ako je izgubite, oštetite ili primetite da je neko drugi pokušao da je koristi.</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/ddab1846-6e03-414e-9d24-b0dc0b0293a8_image.png" alt="slika"></p><p>Pažljivo posmatrajte gde se akreditacija nalazi na telu i kako je razlika između pravilnog i nepravilnog nošenja prikazana u istoj slici.</p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/f280e003-67c9-4ac5-9f05-cc2a3c25f006_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/07893b7f-969b-4569-9757-99433e933d4b_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/dc2fcf2e-cfa6-474a-8701-922290d8f933_image.png" alt="slika"><br></p><p>Donosite odluke kroz 4 koraka u situaciji sa izgubljenom ili pronađenom tuđom akreditacijom u sekciji sa vežbama.</p><p><br></p>	\N	2	Gubitak akreditacije na lokaciji	Nalazite se u restriktivnoj zoni i primećujete da akreditacija više nije kod vas. U blizini su drugi posetioci, a vi treba da postupite brzo, mirno i bez stvaranja dodatnog rizika. Vaš izbor pokazuje da li razumete pravila čuvanja, prijave i zabrane ustupanja akreditacije.	Odlično razumete postupanje sa akreditacijom. Vidljivost, lična upotreba i pravovremena prijava su vam jasni, što je ključ za bezbedan i profesionalan boravak u restriktivnoj zoni.	Potrebno je još uvežbavanja. Fokusirajte se na tri osnovna pravila: akreditacija mora biti vidljiva, lična i pod vašim nadzorom, a svaki gubitak, oštećenje ili sumnja na zloupotrebu traži momentalnu prijavu.
7	3	Sprečavanje neovlašćenog prolaza	<h3><br></h3>\r\n<p>Postoje pravila ulaza u restriktivnu zonu za sva lica koja rade i kreću se u njoj. Najvažnije je da znaš svoje odgovornosti, jer kratka, mirna reakcija često sprečava problem pre nego što postane incident.</p>\r\n\r\n<h4>Šta ovde pratiš</h4>\r\n<ul>\r\n    <li>da li su vrata zaista zatvorena za tobom,</li>\r\n    <li>da koristiš samo svoju akreditaciju,</li>\r\n    <li>da se obraćaš jasno i bez rasprave,</li>\r\n    <li>da pozoveš obezbeđenje kada osoba nema pravo prolaza.</li>\r\n</ul>\r\n<p>Cilj je jednostavan: zadrži svoj prolaz pod kontrolom i ne dozvoli da nepoznata osoba uđe iza tebe bez provere.</p>\r\n\r\n<h4>Koraci za bezbedno sprečavanje neovlašćenog prolaza</h4>\r\n<ol>\r\n    <li><strong>Proveri vrata odmah nakon prolaza.</strong> Ne oslanjaj se na to da će se vrata sama zatvoriti kako treba. Kratak pogled unazad pomaže da primetiš da li je neko krenuo za tobom.</li>\r\n    <li><strong>Koristi samo svoju akreditaciju.</strong> Tvoja bedž/kartica važi samo za tebe i za odobreni prolaz. Ne otvaraj vrata drugoj osobi i ne zadržavaj ih duže nego što je potrebno da prođeš bezbedno.</li>\r\n    <li><strong>Zaustavi pokušaj prolaza mirnim putem.</strong> Dovoljno je kratko i jasno upozorenje, na primer: „Molim vas, pokažite akreditaciju" ili „Sačekajte proveru". Ton treba da bude profesionalan, bez rasprave i bez fizičkog kontakta.</li>\r\n    <li><strong>Ako osoba nema odgovarajuće ovlašćenje, zadrži razmak i pozovi obezbeđenje.</strong> Ne pokušaj da procenjuješ razlog njegovog ponašanja niti da sam rešavaš situaciju. Prijavi šta i gde se desilo i kako je osoba pokušala da prođe.</li>\r\n    <li><strong>Prati dalje uputstvo obezbeđenja ili nadležnog lica.</strong> Kada je rizik prijavljen, tvoja uloga je da ostaneš smiren i omogućiš da ovlašćeno lice preuzme kontrolu. Time štitiš i sebe i druge koji ulaze u zonu.</li></ol><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/f5af8105-999d-4478-a46d-fcdf110b8cb4_image.png" alt="slika"><br></p><p><br></p><ol>\r\n</ol>\r\n	\N	3	Prolaz iza tebe	Nalaziš se na ulazu u restriktivnu zonu tokom užurbanog toka ljudi. Upravo si prošao kroz kontrolisana vrata, a osoba iza tebe pokušava da uđe bez jasne provere. Tvoj zadatak je da zadržiš smirenost, zaštitiš prolaz i reaguješ na način koji je bezbedan i profesionalan.	Vrlo dobro primenjuješ bezbedan i profesionalan odgovor. Znaš da zaustaviš prolaz, koristiš jasnu komunikaciju i prijavljuješ činjenice, što je upravo ponašanje koje štiti kontrolisane zone.	Potrebno je više vežbe u brzom, mirnom zaustavljanju neovlašćenog prolaza. Fokusiraj se na to da prvo zatvoriš prolaz, zatim koristiš jasne reči i odmah uključuješ obezbeđenje.
8	3	Zaštita osetljivih informacija	<h3><br></h3>\r\n<p>Kada radite u restriktivnoj zoni, osetljive informacije nisu samo papir i fajl. To mogu biti lozinke, planovi paviljona, rasporedi, operativne procedure i podaci trećih lica. Najbezbedniji pristup je jednostavan: delite samo ono što je zaista potrebno, i to samo sa osobom koja ima ovlašćenje da to zna.</p>\r\n\r\n<h4>Osnovno pravilo</h4>\r\n<ul>\r\n    <li><b>Manje pristupa, manje rizika.</b></li>\r\n    <li><b>Dokumenti i ekrani ne ostaju bez nadzora.</b></li>\r\n    <li><b>Svako neuobičajeno otkrivanje ili gubitak prijavljuje se odmah.</b></li>\r\n</ul>\r\n\r\n<table class="table">\r\n    <thead><tr><th>Vrsta osetljivih informacija</th><th>Kako ih štititi</th></tr></thead>\r\n    <tbody>\r\n        <tr><td>Lozinke i pristupni podaci</td><td>Ne zapisivati na vidnom mestu, ne deliti porukama ili usmeno pred drugima, koristiti samo odobrene načine čuvanja.</td></tr>\r\n        <tr><td>Planovi paviljona i rasporedi</td><td>Pregledati samo kada su potrebni za posao, ne ostavljati ih na stolu, ekranu ili u zajedničkom prostoru.</td></tr>\r\n        <tr><td>Operativne procedure</td><td>Koristiti ih u skladu sa zadatkom, vratiti na sigurno mesto nakon upotrebe, ne kopirati bez ovlašćenja.</td></tr>\r\n        <tr><td>Podaci trećih lica</td><td>Pristupati samo po potrebi, ne komentarisati ih u prolazu i ne deliti dalje bez jasnog razloga i odobrenja.</td></tr>\r\n    </tbody>\r\n</table>\r\n\r\n<h4>Bezbedno čuvanje i deljenje lozinki</h4>\r\n<ul>\r\n    <li><strong>Lozinka na papiru</strong> — ne ostavljati na vidnom mestu</li>\r\n    <li><strong>Deljenje porukom</strong> — ne slati nesigurnim kanalima</li>\r\n    <li><strong>Usmeno izgovaranje</strong> — samo na sigurnom mestu</li>\r\n    <li><strong>Zaključan pristup</strong> — koristiti zaključane ormare i sefove</li>\r\n</ul>\r\n\r\n<h4>Osetljivi dokumenti</h4>\r\n<ul>\r\n    <li><strong>Planovi paviljona</strong> — pregledajte samo onaj plan koji vam je potreban za zadatak. Kada završite, vratite ga na sigurno mesto i ne ostavljajte ga otvorenog da ga drugi mogu videti.</li>\r\n    <li><strong>Otvoreni ekran</strong> — zaključajte ekran kada se udaljavate, čak i na kratko. Ako na ekranu postoji osetljiv sadržaj, okrenite ga tako da ga ne vide prolaznici.</li>\r\n    <li><strong>Štampani dokumenti</strong> — držite ih pod kontrolom od trenutka preuzimanja do odlaganja. Nepotrebne kopije odmah vratite ili uništite prema proceduri.</li>\r\n    <li><strong>Rasporedi i procedure</strong> — ne čitajte ih naglas u zajedničkom prostoru i ne ostavljate ih na stolovima, pultovima ili vozilima.</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/5a9b3fbe-5cef-4775-a5a4-6da2be37532d_image.png" alt="slika"><br></p><ul>\r\n</ul>\r\n	\N	4	Neovlašćen zahtev za plan		Odlično procenjujete šta je bezbedno, a šta nije, i zadržavate profesionalan ton bez nepotrebnog otkrivanja podataka. Nastavite da primenjujete princip najmanjeg potrebnog pristupa, pažljivo rukovanje ekranima i dokumentima, i pravovremenu prijavu svake sumnjive situacije.	
10	4	Vidi, prepoznaj, prijavi	<h3><br></h3>\r\n<p>U restriktivnoj zoni najvažnije je da prepoznaš šta vidiš i da ne preduzimaš ništa što može da poveća rizik. Kod napuštenog prtljaga ili sumnjivog paketa, cilj nije da proceniš šta je unutra, nego da bezbedno zadržiš distancu, posmatraš samo spoljašnje okolnosti i odmah pokreneš prijavu kroz propisani kanal.</p>\r\n\r\n<h4>Tri koraka ponašanja</h4>\r\n<ul>\r\n    <li><strong>Vidi:</strong> uoči predmet i okolinu bez prilaženja.</li>\r\n    <li><strong>Prepoznaj:</strong> primeti da li je predmet ostavljen bez nadzora, neobično postavljen ili se nalazi na mestu gde ne pripada.</li>\r\n    <li><strong>Prijavi:</strong> prenesi tačne informacije i prepusti dalje postupanje ovlašćenim licima.</li>\r\n</ul>\r\n<p>Ovakav redosled smanjuje mogućnost pogrešne procene i pomaže da se procedura pokrene brzo, mirno i dosledno.</p>\r\n\r\n<h4>Koraci protokola za sumnjiv predmet</h4>\r\n<ol>\r\n    <li><strong>Uočavanje sa bezbedne udaljenosti.</strong> Zastavi se na mestu sa kog jasno vidiš predmet i neposrednu okolinu, bez priilaska i bez pokušaja da ga pomeriš ili otvoriš. Posmatraj samo ono što je vidljivo: gde se predmet nalazi, ko je u blizini i da li izgleda napušteno.</li>\r\n    <li><strong>Proceni okolinu, ne sadržaj.</strong> Pogledaj šta je neuobičajeno, na primer predmet bez vlasnika, ostavljen u prolazu, u blizini ulaza ili u mestu gde predmet ne bi trebao da stoji. Ne nagađaj šta je unutra i ne oslanjaj se na pretpostavke.</li>\r\n    <li><strong>Udalji se i obezbedi prostor.</strong> Možeš se pomeriti i sprečiti nepotrebno zadržavanje ljudi u blizini. Ne izazivaj paniku, ne dodiruj predmet.</li>\r\n    <li><strong>Prijavi kroz propisani kanal.</strong> Prenesi lokaciju, opis predmeta, vreme zapažanja i sve vidljive okolnosti koje mogu pomoći operativnom centru. Nakon prijave, prati dalje uputstvo i budi dostupan ako se od tebe traži dodatno pojašnjenje.</li></ol><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/b6ad1ec5-5fad-4e7a-b60a-57a82e15cbb6_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/c6330648-2c40-414a-ba2b-e28d27ea11a9_image.png" alt="slika"></p><p><br></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/decbb22d-5e97-4f5d-b835-d0e8ef4e1f07_image.png" alt="slika"><br></p><ol>\r\n</ol>\r\n	\N	2	Napušten prdmet kod ulaza	Ti si akreditovano lice koje radi u blizini kontrolisanog ulaza. Primećuješ paket nepoznatog porekla u prolazu gde se obično brzo kreću posetioci i osoblje. Moraš da odlučiš kako da postupiš tako da zaštitiš sebe, druge i tok rada u zoni.	Odlično razumeš protokol i biraš bezbedne odluke pod pritiskom. Nastavi da održavaš isti standard, jer upravo mirno posmatranje i tačna prijava prave razliku u kontroli rizika.	Potrebno je još vežbe u prepoznavanju bezbednog postupka. Vrati se na tri osnove: ostani na udaljenosti, posmatraj samo vidljivo i prijavi kroz propisani kanal bez dodirivanja predmeta.
11	4	Obezbeđivanje restriktivne zone	<br><p>Akreditovano lice ne rešava sumnjiv predmet, već prvenstveno <strong>štiti sebe, druge i prostor</strong> do dolaska privatnog obezbeđenja ili MUP-a. Najvažnije je da se ostane miran, da se ne prilazi bliže nego što je bezbedno i da se ne ulazi u postupke koji uključuju pregled i premeštanje predmeta.</p>&nbsp;<h4>Kako postupiti</h4><p>U ovakvoj situaciji zadatak je jednostavan, ali strogo ograničen:</p><ul>\r\n    <li>udaljiti se na bezbednu razdaljinu,</li>\r\n    <li>sprečiti radoznale prilaze,</li>\r\n    <li>preneti nove, proverljive informacije nadležnima,</li>\r\n    <li>sačekati dalja uputstva.</li>\r\n</ul>\r\n<p>To znači da akreditovano lice ostaje u ulozi prve uočene osobe i svedoka, a ne preuzima ovlašćenja obezbeđenja ili policije.</p>\r\n\r\n<h4>Bezbedno udaljavanje od sumnjivog predmeta</h4>\r\n<ul>\r\n    <li><strong>Ne prilaziti</strong> — održavajte bezbednu udaljenost</li>\r\n    <li><strong>Bezbedna udaljenost</strong> — minimum 5 metara</li>\r\n    <li><strong>Ne prilaziti</strong> — ne pokušavajte da pomjerite predmet</li>\r\n    <li><strong>Čekati uputstva</strong> — sačekajte dolazak nadležnih službi</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/61e7ae17-7a72-4918-8156-3b5a3b555b53_image.png" alt="slika"><br></p><ul>\r\n</ul>\r\n\r\n<h4>Koraci zaštite restriktivne zone</h4>\r\n<ol>\r\n    <li><strong>Povuci se na bezbednu razdaljinu.</strong> Ne zadržavaj se kod predmeta i ne pokušavaj da proceniš njegov sadržaj iz blizine. Kratko zadržavanje je dovoljno da potvrdiš lokaciju i da ne izgubiš pregled prostora.</li>\r\n    <li><strong>Obavesti nadležne propisanim kanalom.</strong> Prenesi tačnu lokaciju, šta je viđeno i da li ima ljudi u blizini. Koristi samo činjenice koje možeš pouzdano da potvrdiš, bez nagađanja.</li>\r\n    <li><strong>Usmeri ljude dalje od mesta događaja.</strong> Smireno zamoli posetioce da se udalje i koristi reči koje ne izazivaju paniku. Cilj je da se prostor rastereti, a ne da se stvara gužva oko predmeta.</li>\r\n    <li><strong>Sačekaj dalja uputstva i ostani dostupan.</strong> Ne diraj predmet, ne premeštaj ga i ne preduzimaj radnje koje pripadaju obezbeđenju ili policiji. Ako se pojave nove informacije, odmah ih prosledi.</li></ol><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/ddae4e97-20e0-45c7-aea3-b1eabd19a05e_image.png" alt="slika"><br></p><p><br></p><ol>\r\n</ol>\r\n	\N	3	Okupljanje oko ostavljenog paketa	Nalaziš se u prolazu između dve kontrolne tačke i primećuješ ostavljen paket uz zid. Nekoliko ljudi već usporava i gleda u pravcu predmeta, a jedan prolaznik pokušava da priđe bliže. Tvoja reakcija treba da zaštiti ljude, održi pregled prostora i omogući da nadležni dobiju tačne informacije.	Odlično razumeš kako se prostor obezbeđuje bez preuzimanja tuđih ovlašćenja. Nastavi da razmišljaš u istom redosledu: bezbedna udaljenost, jasna prijava, kontrolisan pristup i čekanje uputstava.	Potrebno je još vežbe u osnovnom obrascu: udalji se, prijavi, usmeri ljude i ne diraj predmet. Najvažnije je da svaka radnja ostane u granicama tvoje uloge.
12	5	Kanali komunikacije i prijava rizika	<h3>Kanali prijave rizika</h3>\r\n<p>U restriktivnoj zoni, brzina prijave je važna isto koliko i tačnost informacija. Kada nešto deluje neuobičajeno, cilj nije da sami procenite rizik do kraja, već da ga prenesete kroz pravi kanal i bez odlaganja. Jasna dojava pomaže da operativni centar obezbeđenja, a po potrebi i nadležni organi, odmah preuzmu dalji postupak.</p>\r\n\r\n<h4>Šta prijava podrazumeva</h4><ul><p>\r\n    </p><li>da se odmah razume ko prijavljuje</li>\r\n    <li>da se precizno locira gde je događaj</li>\r\n    <li>da se proceni šta se dešava sada</li>\r\n    <li>da se vidi da li postoji neposredna opasnost</li>\r\n    <li>da se zna šta je već učinjeno</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/6e39a7e4-1b54-4371-838a-0cc0637a6e6e_image.png" alt="slika"><br></p><p>\r\n    </p><p></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/498860af-f06e-4730-9a4c-1a6862afa329_image.png" alt="slika"><br></p><table class="table"><thead><tr><th>Vrsta događaja</th><th>Prvi kanal prijave</th><th>Napomena</th></tr></thead>\r\n    <tbody>\r\n        <tr><td>Uobičajeni bezbednosni rizik u zoni</td><td>Operativni centar obezbeđenja</td><td>Koristite zvanični kanal organizatora i pratite uputstva koja dobijete.</td></tr>\r\n        <tr><td>Situacija koja zahteva postupanje nadležnog organa</td><td>MUP, kada je propisano ili potrebno</td><td>Prijava ide prema važećoj proceduri i u koordinaciji sa organizatorom.</td></tr>\r\n        <tr><td>Incident vezan za prolaz, akreditaciju ili internu proceduru</td><td>Zvanični kanal organizatora</td><td>Prijavu usmerite tamo gde se najbrže može proveriti i evidentirati.</td></tr>\r\n        <tr><td>Hitna i nejasna situacija</td><td>Operativni centar obezbeđenja</td><td>U prijavi odmah naglasite hitnost i da li postoji neposredna opasnost.</td></tr>\r\n    </tbody>\r\n</table>\r\n	\N	1	Poziv iz zone ulaza	Vi ste akreditovano lice koje je upravo primetilo neuobičajeno ponašanje u blizini kontrolisanog ulaza. U prostoru ima više ljudi, a važno je da prijava bude kratka, jasna i poslata pravim kanalom. Vaš zadatak je da odlučujete kao osoba koja prvi put prijavljuje bezbednosni rizik, ali želi da to uradi profesionalno i bez greške.	Vrlo dobro. Dojava je jasna, kratka i usmerena na prave informacije. Takav pristup pomaže da se rizik brzo prosledi kroz odgovarajući kanal i da se postupanje ne odlaže.	Potrebno je još vežbe u prepoznavanju pravog kanala i osnovne strukture dojave. Fokusirajte se na činjenice, lokaciju i to da prijava odmah ide kroz zvanični tok.
14	5	Saradnja tokom incidenta	<h3><br></h3>\r\n<p>Kada se u restriktivnoj zoni dogodi incident, najvažnije je da ostanete u svojoj ulozi i postupate po zvaničnim uputstvima. Akreditovano lice ne rešava situaciju samo, već pomaže tako što tačno prenosi ono što je video, čuva informacije i ne ometa službena postupanja.</p>\r\n\r\n<h4>Osnovna pravila saradnje</h4>\r\n<ul>\r\n    <li><strong>Pridržavajte se naredenja </strong>privatnog obezbeđenja, MUP-a i drugih ovlašćenih službi.</li>\r\n    <li><strong>Ne ulazite u raspravu</strong> i ne pokušavajte da preuzmete vođenje postupka.</li>\r\n    <li><strong>Prijavite samo činjenice</strong> koje ste neposredno uočili, bez nagađanja.</li>\r\n    <li><strong>Čuvajte poverljive informacije</strong> i ne delite ih sa drugim licima na licu mesta.</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/f197ed00-d156-4c90-b698-bd6c5d6cc434_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/5ec31783-dd5e-453a-9aa3-faef5e672172_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/cc3d3e5d-77b2-4f11-9ca2-9984ca22450f_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/c36e5807-4aca-4465-bb12-13b786106ea5_image.png" alt="slika"></p><ul>\r\n</ul><p>\r\n    </p><img style="max-width: 100%; cursor: pointer;" src="/uploads/b8413a8e-1c77-41de-a8ef-7b5f3a91b0f1_image.png" alt="slika"><p><br></p><h4>Akreditovano lice — dužnosti</h4><table class="table"><thead><tr><th>Akreditovano lice — dužnosti</th><th>Prepušta službama</th></tr></thead>\r\n    <tbody>\r\n        <tr><td>Prijavljuje ono što je neposredno uočilo.</td><td>Procenu pretnje i donošenje operativnih mera.</td></tr>\r\n        <tr><td>Ostaje mirno i prati uputstva.</td><td>Odlučivanje o zoni, pristupu i daljim koracima.</td></tr>\r\n        <tr><td>Daje tačne činjenice, kratko i jasno.</td><td>Istragu, proveru i službenu komunikaciju.</td></tr>\r\n        <tr><td>Ne širi poverljive informacije.</td><td>Koordinaciju sa drugim nadležnim organima.</td></tr>\r\n    </tbody>\r\n</table><br>	\N	3	Kad službeno lice traži podatke	Nalazite se u restriktivnoj zoni kada vam službeno lice zatraži informacije o događaju koji ste upravo primetili. Od vas se očekuje da pomognete, ali i da ne izađete iz svoje uloge niti da ometate postupanje. Vaša odluka utiče na to da li će informacije biti korisne, tačne i bezbedno prenete.	Odlično razumete kako se ponaša profesionalno i bez zastoja u incidentu. Nastavite da se oslanjate na činjenice, da čuvate poverljive informacije i da službenim licima omogućite nesmetan rad.	Potrebno je još vežbe u tome kada treba govoriti, a kada prepustiti odlučivanje službama. Fokusirajte se na tačne činjenice, kratku komunikaciju i poštovanje uputstava bez nagađanja.
15	5	Integrisana vežba reagovanja	<h3>Redosled reakcija u kriznim situacijama</h3>\r\n<p>Kada se u restriktivnoj zoni pojavi opasnost, najvažnije je da ne reagujete neorganizovano. Pravi redosled je jednostavan; proceni udaljenost, prijavi kroz zvaničan kanal, udalji se iz neposredne blizine i prati uputstva nadležne službe. Cilj je da zaštitiš sebe i druge, bez samostalnog preuzimanja ovlašćenja koja pripadaju obezbeđenju ili policiji.</p>&nbsp;<h4>Šta je prioritet</h4><ul><p>\r\n    </p><li><strong>Život i fizička bezbednost</strong> imaju prednost nad imovinom.</li>\r\n    <li><strong>Jasna prijava</strong> pomaže službama da brzo procene situaciju.</li>\r\n    <li><strong>Mirno povlačenje</strong> smanjuje gužvu i dodatni rizik</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/5674795d-dc23-4352-b04b-1f2c73637c5c_image.png" alt="slika"><br></p><ul><p></p></ul><h4>Koraci u kriznim situacijama</h4><ol>\r\n    <li><strong>Zaustavi se i proceni udaljenost.</strong></li>\r\n    <li><strong>Prijavi kroz zvaničan kanal.</strong></li>\r\n    <li><strong>Udalji se iz neposredne zone.</strong></li>\r\n    <li><strong>Prati naloge obezbeđenja i službi.</strong></li>\r\n    <li><strong>Pomozi drugima samo ako je bezbedno.</strong></li></ol><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/e04ec229-34e1-409f-baae-c7ec6b405367_image.png" alt="slika"><strong><br></strong></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/a93ff738-4c53-4075-96ad-d76c47c04988_image.png" alt="slika"><strong><br></strong></p><p><strong><br></strong></p>	\N	4	Odabir u restriktivnom prolazu	Nalaziš se u restriktivnoj zoni kada uočiš napušten predmet i istovremeno vidiš da se pristupni prolaz koristi neusklađeno sa pravilima. Ti si akreditovana osoba, ne pripadnik obezbeđenja. Tvoj zadatak je da izabereš postupke koji čuvaju bezbednost i poštuju nadležnosti službi.	Odlično razumeš krizni redosled. Prepoznaješ šta treba prijaviti, kada se udaljiti i kako sarađivati bez preuzimanja tuđih ovlašćenja.	Potrebno je još uvežbavanja redosleda reakcije. Fokusiraj se na tri osnove: prijavi kroz zvaničan kanal, udalji se bez odlaganja i prepusti procenu nadležnima.
\.


--
-- Data for Name: backup_quiz_questions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.backup_quiz_questions (id, question_text, optiona, optionb, optionc, optiond, correct_answer, sort_order) FROM stdin;
1	Šta treba da uradite ako primetite napuštenu torbu u restriktivnoj zoni?	Otvorite je da proverite sadržaj	Pomerite je na bezbedno mesto	Primenite protokol VIDI-PREPOZNAJ-PRIJAVI i obavestite obezbeđenje	Ignorišete jer verovatno nije opasno	C	1
2	Da li smete da date svoju akreditaciju kolegi da uđe umesto vas?	Da, ako mu verujete	Ne, nikada	Samo uz odobrenje supervizora	Da, ali samo unutar iste zone	B	2
3	Gde smete da se krećete sa svojom akreditacijom?	Svuda unutar Expo kompleksa	Samo kroz zone za koje imate ovlašćenje	Samo u javnim zonama	Gde god vas posao odvede	B	3
4	Koja je prva stvar koju radite kada primetite sumnjiv predmet?	Pozovete policiju direktno	VIDI – primetite i procenite	Pokupite predmet	Fotografišete i objavite na društvenim mrežama	B	4
5	Šta znači 'bezbednosna kultura'?	Samo posao obezbeđenja	Odgovornost svih akreditovanih lica za bezbednost	Pravila za posetioce	Tehnička zaštita objekata	B	5
6	U slučaju dojave o bombi, šta radite?	Trčite ka izlazu bez obzira na uputstva	Pratite uputstva službi i ne ometate ih	Pokušate da pronađete bombu	Ostanete na mestu i čekate	B	6
7	Da li smete da delite informacije o rasporedu službi sa neovlašćenim licima?	Da, ako su prijatelji	Ne	Samo delove informacija	Da, ali usmeno	B	7
8	Šta se dešava ako prekršite pravila restriktivne zone?	Ništa, samo upozorenje	Moguće oduzimanje akreditacije i pravne posledice	Samo novčana kazna	Privremena suspenzija od 1 dana	B	8
9	Kako treba da nosite akreditaciju?	U džepu	Vidljivo na sebi	U torbi	Samo kada vas pitaju	B	9
10	Koji je ispravan redosled protokola za sumnjive predmete?	PRIJAVI – VIDI – PREPOZNAJ	VIDI – PREPOZNAJ – PRIJAVI	PREPOZNAJ – PRIJAVI – VIDI	VIDI – PRIJAVI – PREPOZNAJ	B	10
\.


--
-- Data for Name: backup_sections; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.backup_sections (id, title, description, sort_order) FROM stdin;
1	Uvod	Upoznajte se sa osnovnim konceptima i ciljevima kursa	1
3	Bezbednosna kultura i unutrašnje pretnje	Kultura zajedničke bezbednosti, prepoznavanje pretnji i zaštita informacija	3
4	Sumnjivi predmeti i zabranjena sredstva	Zabranjeni predmeti, protokol VIDI-PREPOZNAJ-PRIJAVI i obezbeđenje zone	4
5	Krizne i vanredne situacije	Kanali prijave, evakuacija, saradnja i integrisana vežba reakcije	5
6	Sažetak	Ključne lekcije i pregled kursa	6
2	Pravni okvir i akreditacija	Odgovornost, pravilna upotreba akreditacije i zone kretanja	2
\.


--
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.exercises (correct_answer, sort_order, id, lesson_id, feedback_correct, feedback_wrong, optiona, optionb, optionc, optiond, prompt) FROM stdin;
C	1	5	3	Tačno. Brza provera i trenutna prijava smanjuju mogućnost daljeg rizika i olakšavaju postupanje.	To nije dozvoljeno. Napustiti zonu može biti potrebno, ali prijava mora ići odmah, bez čekanja i bez prikrivanja događaja. Gubitak treba odmah shvatiti ozbiljno. Akreditacija je lična i ne sme se ustupati drugoj osobi.	Nastavljate kretanje i nadate se da će se kasnije pojaviti.	Sklanjate se iz zone bez ikakve prijave.	Odmah proveravate poslednje mesto gde je mogla da bude i o tome obaveštavate ovlašćeno lice.	Pozajmljujete tuđu akreditaciju dok ne pronađete svoju.	Tek ste primetili da akreditacija nije kod vas. Šta je prvi razuman potez?
A	4	12	4	Tačno! Poštovanje uputstva je završni korak bezbednog postupanja nakon greške.	Netačno! Ne pratiš dobijeno uputstvo, što može da stvori novi bezbednosni problem.	Ostaješ gde si i čekaš dalja uputstva. 	Odlaziš jer smatraš da je situacija već rešena. 	Pitaš više ljudi istovremeno šta da radiš. 	Krećeš se ka drugom delu objekta da nadoknadiš izgubljeno vreme. 	Dobijaš uputstvo da ostaneš na mestu do provere. Kako reaguješ?
B	3	7	3	Tačno. Jasno odbijanje smanjuje rizik od zloupotrebe i štiti vas od posledica.	To nije dozvoljeno, čak ni privremeno. Akreditacija je lična i ne sme se deliti i niko ne sme da se kreće bez akreditacije.	 Kažete da može ako se brzo vrati. 	 Odbijate i objašnjavate da svako koristi samo svoju akreditaciju. 	 Dajete mu akreditaciju, ali tražite da je vrati odmah posle prolaza. 	 Tražite od njega da ide uz vas bez akreditacije.	Član tima vas pita da li može da koristi vašu akreditaciju samo za kratki prolaz. Kako odgovarate?
B	2	6	3	Tačno! Predaja ovlašćenom licu je najbezbedniji i najispravniji postupak.	Netačno! Akreditaciju treba predati ovlašćenom licu po propisanom postupku.	 Stavljate je u svoj džep da je ne bi neko zgazio. 	 Predajete je službi zaduženoj za kontrolu ili osobi koju je organizator odredio. 	 Čuvate je kod sebe do kraja dana bez prijave. 	 Fotografišete je i objavljujete da biste pronašli vlasnika. 	Nađete tuđu akreditaciju na podu u prolazu. Kako postupate?
A	4	8	3	Tačno! Prijava i zamena po proceduri su ispravan i bezbedan korak.	Netačno! Tuđa akreditacija se ne sme koristiti. Nečitljivi podaci otežavaju proveru i mogu dovesti do odbijanja pristupa ili drugih posledica. Samostalno menjanje akreditacije nije dozvoljeno i može stvoriti dodatni problem.	Odmah prijavljujete oštećenje i pratite zvanično uputstvo za zamenu. 	Zadržavate je kao rezervu i uzimate tuđu za ulazak. 	Nastavljate da je koristite dok se ne raspadne potpuno.	Sami prelepite ili prepravite podatke da ponovo bude čitljiva. 	Akreditacija vam je oštećena i više nije čitljiva. Šta je najbolje da uradite?
B	1	9	4	Tačno! Mirno zaustavljanje je najbezbedniji prvi potez i omogućava brzu proveru pristupa.	Netačno! To povećava rizik od neovlašćenog kretanja. Prvi korak je da se odmah zaustaviš. Pasivno čekanje nije dovoljno. Potrebno je i aktivno prijavljivanje situacije.	Nastavljaš dalje dok ne vidiš da li te neko zaustavlja. 	Zaustavljaš se i proveravaš gde si, bez daljeg ulaska. 	Čekaš da neko drugi preuzme odgovornost. 	Sklanjaš akreditaciju da ne privlači pažnju. 	Primećuješ oznaku zone koja ne odgovara tvom ovlašćenju. Šta radiš prvo?
D	2	10	4	Tačno! Bezbedno povlačenje i kratka prijava su najvažniji koraci u ovoj situaciji.	Netačno! Bezbedno povlačenje i kratka prijava su najvažniji koraci u ovoj situaciji.	Brzo odlaziš bez ikakvog obaveštavanja da ne usporavaš rad. 	Zadržavaš se da sam proceniš da li ipak smeš da ostaneš. 	Ulaziš dublje da bi pronašao bolji izlaz bez pitanja. 	Mirno se povlačiš dozvoljenim putem i obaveštavaš ovlašćeno lice. 	Sada vidiš najbliži izlazni pravac i osobu koja može da ti pomogne. Kako postupaš?
A	3	11	4	Tačno! Kratak, jasan i iskren opis događaja olakšava dalje postupanje.	Netačno! Umanjivanje događaja ili izbegavanje davanja informacija može odložiti pravilnu reakciju. Važnije je tačno prijaviti šta se desilo.	Kažeš tačno gde si bio i da si greškom ušao u pogrešnu zonu. 	Minimizuješ događaj da ne bi delovao neiskusno. 	Izbegavaš odgovor dok sam ne pronađeš izlaz. 	Kažeš da nisi siguran i prepuštaš drugima da objasne umesto tebe. 	Ovlašćeno lice traži da objasniš šta se dogodilo. Koji odgovor je najprimereniji?
C	1	13	5	Tačno! To je činjeničan opis bez tumačenja motiva. Takav opis je najbolja osnova za dalju prijavu.	Netačno! To je zaključak bez potvrde. Pretpostavka može odvesti prijavu u pogrešnom smeru.	Osoba sigurno nešto pokušava da sakrije. 	Osoba deluje kao da pripada timu obezbeđenja. 	Osoba stoji duže vreme u prolazu i osvrće se oko sebe. 	Osoba je verovatno zabrinuta i ne zna kuda da ide. 	Šta je najtačniji početni opis onoga što vidiš?
C	3	15	5	Tačno! Odlično. Kratak, jasan i proverljiv opis pomaže nadležnima da brzo procene sledeći korak.	Netačno! To povećava buku u komunikaciji i može izobličiti događaj. Drži se onoga što znaš iz prve ruke. Lični utisak nije dovoljan. U prijavi su važni činjenice i vremenski okvir.	Priču koju si čuo od drugih, uz dodatne komentare. 	Svoj utisak da je osoba bila neprijatna i verovatno opasna. 	Tačno mesto, vreme, šta je viđeno i da li je situacija i dalje prisutna. 	Ime osobe, iako ga nisi proverio. 	Nadležna osoba traži kratak opis situacije. Šta uključuješ?
B	1	25	8	Tačno! Prvo se proverava potreba i ovlašćenje, pa tek onda odlučuje o pristupu.	Netačno! To stvara nepotreban rizik. Ako ovlašćenje nije jasno, podatak se ne deli na brzinu. Ako niste dali podatke, što je dobro, ali zahtev ostaje nerešen. Bolje je mirno objasniti da je potrebna provera.	 Podelite informacije odmah da ne usporite smenu. 	 Tražite da pokaže akreditaciju i proverite kroz odobreni kanal kome je podatak potreban. 	 Kažete mu da pita nekog drugog, a vi nastavite posao. 	 Ignorišete zahtev i odlazite bez odgovora. 	Kolega traži plan rasporeda i lozinku, a vi niste sigurni da ima pravo da ih dobije. Šta radite prvo?
D	2	14	5	Tačno! To smanjuje rizik od pogrešne procene i nepoštenog profilisanja. Zadržavaš fokus na onome što može da se potvrdi.	Netačno! Samouveren ton nije dokaz. Potrebna je provera, ne utisak. To vodi ka profilisanju, a ne ka bezbednosnoj proceni. Namera se ne zaključuje po ličnim karakteristikama.	Proceni osobu po izgledu i pretpostavi nameru. 	Prihvati priču ako je izgovorena samouvereno. 	Prenesi priču dalje jer više ljudi treba da zna. 	Zaustavi širenje priče i vrati razgovor na proverljive činjenice. 	Kasnije čuješ priču da je ta osoba „sigurno sumnjiva“ jer izgleda drugačije od ostalih. Kako treba da postupiš?
B	4	16	5	Tačno! Ostaješ smiren, postupaš po uputstvu i doprinosiš proveri bez preuzimanja tuđe uloge.	Netačno! Možeš ostati miran i pratiti uputstva, ali novu, proverljivu informaciju i dalje treba proslediti kroz proceduru. Ne preuzimaš ulogu obezbeđenja ili policije. Tvoja uloga ostaje prijava i saradnja kroz proceduru.	To znači da ne treba ništa da uradiš, čak ni ako se pojavi nova činjenica. 	 To zTo znači da pratiš situaciju, ostaješ dostupan i prosleđuješ nove činjenice ako ih uočiš. 	To znači da si ti sada odgovoran da ispituješ osobu. 	To znači da treba da zadržiš osobu do dolaska nadležnih. 	Dobijaš uputstvo da ostaneš miran i nastaviš svoj redovan zadatak dok nadležni proveravaju prijavu. Kako je to najispravnije tumačiti?
C	1	17	6	Tačno! Ovo je najbolja osnova za jasnu i proverljivu prijavu.	Netačno! Ne moraš imati dokaz da bi prijavio zabrinjavajuće opažanje. Dovoljno je da preneseš činjenice. Korisnije je ostati pri onome što je stvarno viđeno. Nepoželjno je nepotrebno da eskalirati situaciju. Bolje je prvo zabeležiti činjenice i prijaviti po proceduri.	Odmah zaključuješ da priprema problem i komentarišeš to drugima. 	Ignorišeš ponašanje jer nemaš potpun dokaz. 	Mirno zabeležiš vreme, mesto i konkretno ponašanje. 	Priđeš i tražiš objašnjenje pred svima. 	Primećuješ osobu koja se zadržava kod čitača kartica i nekoliko puta gleda u kameru iznad vrata. Šta prvo radiš?
C	2	18	6	Tačno! Ovo je precizno i upotrebljivo. Navodi šta je viđeno, kada i gde.	Netačno! Poruka je suviše neodređena ili ima nepotrebne pretposavke. Bolje je dodati konkretne radnje i lokaciju.	 „Nešto nije u redu sa tom osobom.“ 	 „Deluje mi sumnjivo, verovatno ima lošu nameru.“ 	 „U 14:20 kod bočnog tehničkog ulaza osoba je fotografisala vrata i kameru.“ 	 „Osoba je snimala ulaz, možda radi za nekoga.“ 	Sada vidiš da osoba fotografiše tehnički ulaz telefonom. Kako formulišeš prijavu?
B	3	19	6	Tačno! Tako ostaješ u svojoj ulozi i omogućavaš pravovremeno reagovanje.	Netačno! Ovo može privući pažnju, ali i nepotrebno poremetiti okruženje. Smiren prijavni kanal je bolji izbor.	 Vičeš na osobu da svi čuju šta radi. 	 Na miran način skrećeš pažnju nadležnom licu kroz predviđeni kanal. 	 Okrećeš glavu, jer kontrola nije tvoj posao. 	 Fizički je zaustavljaš i zadržavaš dok ne stigne obezbeđenje. 	Osoba pokušava da prođe iza druge osobe bez provere. Kako postupaš?
A	4	20	6	Tačno! To su elementi koji pomažu da prijava bude proverljiva i korisna.	Netačno! Glasine lako zbunjuju i slabe kvalitet prijave. Drži se sopstvenog opažanja. Ako je snimanje dozvoljeno i po proceduri, slika može pomoći, ali samo ako je relevantno i pravilno prosleđeno. Uvek su ključne činjenice i procedura.	 Vreme, lokacija, opis radnji i kome si prijavio. 	 Glasine koje si čuo od drugih lica u prolazu. 	 Fotografiju osobe koju si napravio bez potrebe. 	 Samo svoje mišljenje o tome ko je ta osoba. 	Nakon prijave, šta je najkorisnije sačuvati za kasniji razgovor?
D	2	22	7	Tačno! Odlično. Rečenica je mirna, jasna i usmerava osobu na proceduru bez rasprave.	Netačno! Rasprava povećava rizik i odvlači pažnju od kontrole prolaza. Okretanje glave ne zaustavlja pokušaj prolaza. Potrebna je jasna, profesionalna intervencija.	 Kažeš da nije tvoja odgovornost i nastavljaš dalje. 	 Podižeš glas da svi čuju situaciju. 	 Ulaziš u raspravu o tome ko je u pravu. 	 Kažeš: „Molim vas, stanite ovde i pokažite akreditaciju.“ 	Osoba kaže da je „samo sa tobom“ i nastavlja da korača ka vratima. Kako odgovaraš?
A	1	21	7	Tačno! Kratka i jasna rečenica zaustavlja pokušaj prolaza bez podizanja tenzije.	Netačno! Ne koristiti fizički kontakt osim ako zvanična procedura izričito ne nalaže drugačije. Bezbedan je miran, verbalan odgovor. Dobro je ne reagovati impulsivno, ali procena ne treba da se oslanja na utisak drugih. Fokus je na konkretnom pokušaju prolaza.	 Okrećeš se i mirno tražiš da osoba sačeka proveru ili pokaže akreditaciju. 	 Pitaš druge ljude da procene da li osoba izgleda sumnjivo. 	 Fizički zadržavaš osobu dok ne stigne obezbeđenje. 	 Odmah se pomeriš dalje i ignorišeš situaciju. 	Prošao si kroz vrata i vidiš da se neko približava tik iza tebe dok se vrata još zatvaraju. Šta radiš prvo?
A	3	23	7	Tačno! Zatvaranje prolaza i prijava su najbezbedniji odgovor kada ovlašćenje nije potvrđeno.	Netačno! Dug razgovor nije potreban ako osoba nema ovlašćenje. Važno je preći na prijavu i pozvati pomoć. Kasna prijava umanjuje mogućnost da se situacija odmah kontroliše.	 Puštaš je da prođe, pa prijavljuješ kasnije. 	 Pokušavaš sam da joj objasniš pravila dok ne promeni mišljenje. 	 Snimaš osobu i pratiš je bez obaveštavanja ikoga. 	 Zatvaraš vrata i odmah prijavljuješ događaj obezbeđenju. 	Osoba nema odgovarajuću akreditaciju i ne zaustavlja se. Šta je najbezbedniji sledeći korak?
B	4	24	7	Tačno! Odlično. Konkretne činjenice pomažu ovlašćenim službama da procene situaciju.	Netačno! Ne treba pretpostavljati nameru. Prijavljuju se činjenice, ne etikete. Mišljenje nije dovoljno korisno. Prijava treba da sadrži konkretne radnje i okolnosti.	 Kažeš da je osoba sigurno imala lošu nameru. 	 Navodiš tačno vreme, mesto i šta si video, bez pretpostavki o nameri. 	 Daješ samo svoje mišljenje o tome zašto je osoba to uradila.	 Prepričavaš sve redom, ali bez ključnih detalja o vratima i prolazu. 	Obezbeđenje stiže i traži kratak opis događaja. Šta treba da kažeš?
A	2	26	8	Tačno! Prvo štitite informacije, zatim rešavate razgovor bez izlaganja sadržaja.	Netačno! Osetljiv sadržaj ne sme da ostane izložen predugo. Prvo obezbedite dokument, pa nastavite razgovor. Ne širiti informaciju bez potrebe. Osetljivi podaci ne treba da postanu zajednička tema.	 Odmah sklonite dokument na sigurno mesto ili ga okrenete van pogleda i nastavite razgovor diskretno. 	 Pozovete više ljudi da pomognu da svi čuju o čemu se radi. 	 Fotografišete plan svojim telefonom za kasnije, da ga ne zaboravite. 	 Sačekate da završite razgovor pa tek onda sklonite papir. 	Dok razgovarate, primećujete da plan ostaje otvoren na stolu i vidljiv drugima. Kako postupate?
B	3	27	8	Tačno! Zadržavate poverljivost i istovremeno usmeravate osobu na ispravan postupak.	Netačno! I kratko deljenje stvara izlaganje podataka. Lozinke se ne prenose usmeno ni pissmeno bez ovlašćenog postupka.	 Dajte mu lozinku i zamolite ga da je odmah promeni posle upotrebe. 	 Odbijte da je saopštite i uputite ga na odobren način pristupa ili nadležnu osobu. 	 Napišete lozinku na papir i date mu da je odnese. 	 Kažete da ćete je poslati kasnije, kada budete imali vremena. 	Kolega kaže da mu lozinka treba samo „na minut“ i da je bezopasno da je podelite usmeno. Šta je najbezbedniji odgovor?
D	4	28	8	Tačno! Prijavljuju se činjenice, vreme i okolnosti, bez pretpostavki o nameri.	Netačno! Ne treba širiti neproverene tvrdnje i može pogoršati situaciju. Prijava ide kroz zvaničan kanal. Kašnjenje otežava zaštitu podataka. Gubitak ili neovlašćeno otkrivanje prijavljuje se odmah.	 Pitate sve prisutne da li su ga videli i pokušate sami da otkrijete ko je odgovoran. 	 Sačekate da se pojavi vlasnik dokumenta, jer možda je samo zaboravljen. 	 Objavite na grupnom četu da je neko verovatno uzeo dokument. 	 Prijavite događaj po proceduri i navedete šta tačno nedostaje, gde je poslednji put viđen i kada ste ga primetili. 	Kasnije primećujete da je osetljivi dokument ostao na radnom mestu i da niko ne zna ko ga je uzeo. Šta radite?
B	1	29	10	Tačno! Prvi korak je da posmatraš bez približavanja i da ostaneš dovoljno daleko da ne ugroziš sebe ili druge.	Netačno! To je loš izbor. Ne treba dodirivati predmet. Svaki fizički kontakt je van protokola. Ne treba stvarati nepotrebnu gužvu. Cilj je da se prostor smiri, ne da se okuplja više ljudi.	 Pozovi prolaznike da se okupe i pogledaju predmet. 	 Zaustavi se, pogledaj okolinu i zadrži udaljenost. 	 Dodirni paket da bi proverio da li je težak. 	 Priđi bliže da vidiš o kakvom je paketu reč. 	Primetio si paket koji nije pod nadzorom. Šta je prvi bezbedan potez?
C	2	33	11	Tačno! Kratak, smiren i jasan uput smanjuje gužvu i čuva prostor.	Netačno! Ne ostaje se uz predmet. Tvoja bezbednost i razdaljina su važnije. Panika otežava kontrolu prostora. Potreban je smiren i jasan ton.	 Tiho ostaješ pored predmeta da ga čuvaš. 	 Kažeš svima da mogu da priđu ako ništa ne dodiruju. 	 Smireno tražiš da se udalje i usmeravaš ih ka alternativnom prolazu. 	 Glasno upozoravaš da svi trče u suprotnom pravcu. 	Ljudi i dalje staju da pogledaju predmet. Kako ih usmeravaš?
B	2	30	10	Tačno! Zadržavaš se na vidljivim činjenicama, bez nagađanja i bez otvaranja ili pomeranja.	Netačno! Ne pomeraj predmet. Mesto i položaj mogu biti važni za dalji postupak. Ne izazivaj paniku. Prijava treba da bude mirna, tačna i kroz propisani kanal. Sumnjiv ili napušten predmet se prijavljuje odmah, čak i kada nema gužve.	 Ignoriši predmet ako nema neposredne gužve. 	 Proceni samo šta je spolja vidljivo i zabeleži okolnosti. 	 Otvoreno saopšti da je predmet opasan i izazovi uzbunu.	 Pomeraj predmet na sigurnije mesto dalje od prolaza. 	Sada vidiš da predmet stoji uz prolaz i nema vlasnika na vidiku. Šta treba da uradiš?
A	3	31	10	Tačno! To su informacije koje pomažu operativnom centru da proceni situaciju i da dalje uputstvo.	Netačno! Potrebne su konkretne, proverljive činjenice. Bolje je da se oslanjaš na sopstveno opažanje i propisanu prijavu, a ne na neproverena mišljenja drugih.	 Lokacija, opis predmeta, vreme zapažanja i vidljive okolnosti. 	 Pretpostavka kome predmet pripada i šta je unutra. 	 Samo da postoji paket i da si zabrinut. 	 Tražiš od prolaznika da potvrde tvoju sumnju. 	Treba da pošalješ prijavu operativnom centru. Koje informacije su najkorisnije?
C	1	32	11	Tačno! Prvo se stvara bezbedna udaljenost i zadržava pregled prostora.	Netačno! To nije pravilno. Predmet se ne pomera i ne preuzima se njegova kontrola. Ne prilazi se i ne vrši se pregled, jer se tako povećava rizik. Ne treba okupljati ljude oko predmeta. Udaljavanje je sigurniji prvi korak.	 Odmah uzimaš paket i nosiš ga do obezbeđenja. 	 Priđeš da pogledaš šta je unutra. 	 Povučeš se na bezbednu razdaljinu i kratko proceniš okolinu. 	 Zoveš nekoliko kolega da priđu i pogledaju. 	Primetio si ostavljen paket i nekoliko ljudi se približava. Šta radiš prvo?
C	3	34	11	Tačno! Odlično. To su konkretne informacije koje pomažu daljem postupanju.	Netačno! Pretpostavljanje nije potrebno i može da odvede pažnju od važnih činjenica. Prenos informacije je dobar početak, ali bez detalja nadležni teže procenjuju situaciju.	 Svoje mišljenje ko bi mogao da je ostavio predmet. 	 Pretpostavku da se verovatno radi o opasnom predmetu. 	 Tačnu lokaciju, izgled predmeta, broj ljudi u blizini i šta se promenilo. 	 Samo to da postoji problem, bez detalja. 	Nadređeni traži najkorisnije informacije. Šta prenosiš?
D	4	35	11	Tačno! Time štitiš osobu, prostor i sopstvenu ulogu.	Netačno! Rasprava ne pomaže. Kratak i profesionalan odgovor je efikasniji. Bolje je da ostaneš u kontaktu, ali treba dati jasan pravac i udaljiti osobu od mesta događaja. Pristup se ne dozvoljava bez potrebe, jer rizik ostaje isti.	 Ulaziš u raspravu da bi dokazao da znaš više. 	 Dopuštaš mu da priđe, ako obeća da neće dirati predmet. 	 Kažeš mu da sačekaš trenutak i ostavljaš ga bez uputstva. 	 Smireno ga zaustavljaš i upućuješ dalje od zone, pa ostaješ dostupan za nove informacije. 	Dok čekaš dolazak nadležnih, jedan prolaznik insistira da proveri paket. Kako reaguješ?
A	4	39	12	Tačno! Odlično. Time se vidi šta je već preduzeto i smanjuje se rizik od ponavljanja istih radnji.	Netačno! Ne oslanjajte se na pretpostavku da će neko drugi prijaviti. Potrebna je potvrđena i konkretna informacija. Potrebno je više od ličnog položaja. Prijava treba da kaže šta je urađeno u vezi sa samim događajem.	 Obezbeđenje je obavešteno, prostor je označen i ljudi su usmereni na drugi prolaz. 	 Niko nije ništa uradio. 	 Neko je verovatno video isto, pa će prijaviti. 	 Udaljio sam se i čekam uputstva. 	Pre nego što završite, treba da kažete da li je neko već reagovao. Koja dopuna je najkorisnija?
D	2	37	12	Tačno! Ovo je jasno, konkretno i lako za dalje postupanje. Sadrži ko, šta i gde.	Netačno! Prijava treba da bude odmah, uz ono što ste lično uočili. Dodatna provera ne sme da odlaže obaveštavanje. Dobro je ako prijavljujete neizvesnost, ali nedostaju precizna lokacija i opis situacije. Prijava mora da sadrži činjenice, a ne utisak.	 Pitajte nekog drugog da vam objasni pre nego što prijavite. 	 Nešto sumnjivo je tu negde, možda je problem. 	 Ne znam tačno šta je, ali možda je opasno. 	 Ja sam kod ulaza 3 i vidim ostavljen crni kofer pored desne strane prolaza, trenutno niko nije u kontaktu s njim. 	Operativni centar traži da opišete događaj što kraće. Koja poruka je najkorisnija?
B	1	36	12	Tačno! To je pravi prvi korak. Operativni centar može da uputi dalji postupak i po potrebi uključi druge službe.	Netačno! Upozorenje ljudima u neposrednoj blizini može biti korisno ako postoji rizik, ali paralelno treba i zvanična prijava kroz predviđeni kanal. Samo posmatranje nije dovoljno kada postoji bezbednosni rizik. Potrebna je prijava, zajedno sa tačnom lokacijom. Ne prilazite nepoznatom predmetu i ne pokušavajte da ga otvarate ili pomerate. Prijavite ga odmah kroz zvanični kanal.	 Objavljujete informaciju svima u grupi da se sklone. 	 Odmah prijavljujete operativnom centru obezbeđenja i navodite lokaciju. 	 Diskretno ga posmatrate i nastavljate kretanje. 	 Priđete koferu da proverite šta je unutra. 	Uočavate da je jedan kofer ostavljen pored prolaza i niko ga ne uzima. Šta prvo radite?
B	3	38	12	Tačno! Tako pokazujete da poštujete zvanični tok i da ne preuzimate odluke koje pripadaju proceduri i nadležnim službama.	Netačno! Ne donosite takvu odluku sami ako procedura ili okolnosti traže drugi kanal. Pratite propisani tok prijave i uputstva koja dobijete. Važno je ne umanjivati značaj događaja. Ako kanal ili organ treba da se uključi, to mora biti jasno navedeno.	 Prvo obaveštavate prijatelja u blizini, pa kasnije proveravate šta dalje. 	 Navodite da prijavu preuzima operativni centar, a MUP se uključuje kada je to propisano ili potrebno prema proceduri. 	 Samostalno odlučujete da MUP nije potreban i ne prijavljujete dalje. 	 Kažete samo da je situacija pod kontrolom i završavate poziv. 	Dobijate pitanje da li treba kontaktirati MUP. Kako postupate?
A	1	40	13	Tačno! U vanrednoj situaciji zvanično uputstvo ima prednost nad neformalnim komentarima, jer smanjuje zastoje i zabunu.	Netačno! Kada stigne zvaničan nalog, vreme se koristi za izlazak, ne za proveravanje glasina. Tokom evakuacije lične stvari nisu prioritet, a vraćanje povećava rizik i usporava druge. Dobro je ako krećeš ka izlazu, ali zadržavanje može da uspori tok evakuacije. Bolje je pratiti pravac i kretati se bez zaustavljanja.	 Pratim zvaničnu objavu i odmah krećem ka bezbednom izlazu. 	 Pitam kolegu šta misli i čekam još malo. 	 Vraćam se da pokupim stvari pre izlaska. 	 Odlazim do najbližeg izlaza, ali se usput zadržavam da zovem druge. 	Čuješ kolegu kako kaže da 'verovatno nije ništa', a zatim preko razglasa stiže nalog za evakuaciju. Šta radiš prvo?
C	2	41	13	Tačno! Ispravno. Kratka pomoć je korisna kada ne ugrožava tvoje i tuđe kretanje.	Netačno! Kretanje ipak mora da ostane bezbedno i uređeno. Kratka pomoć je poželjna ako je možeš pružiti bez zastoja. Uvek prati označen ili naložen bezbedan pravac, ne improvizuj.	 Ignorišem je, jer svako mora sam da se snađe. 	 Zaustavljam se dugo da joj detaljno objašnjavam sve mogućnosti. 	 Pokazujem pravac i kratko je usmeravam ka najbližem bezbednom izlazu. 	 Vraćam se suprotno od toka da je povedem drugim putem bez provere. 	Na putu vidiš osobu koja je zbunjena i ne zna gde je izlaz. Šta je najbolji sledeći korak?
C	3	42	13	Tačno! Zborno mesto je mesto za provere i dalje instrukcije, ne za povratak u zonu.	Netačno! Ne treba se vraćati. Povratak u zonu je dozvoljen tek kada nadležni potvrde da je bezbedno. Ponovni ulazak bez zvanične dozvole može da ugrozi tebe i druge. Bolje je da ostaneš van zone, ali potvrda mora doći zvaničnim kanalom, ne od prijatelja.	 Vraćam se nakratko, jer je to blizu i brzo ću izaći. 	 Ulazim u zonu da proverim da li je evakuacija stvarno završena. 	 Idem na odobreno zborno mesto i čekam dalje uputstvo. 	 Ostajem gde jesam dok ne dobijem ličnu potvrdu od prijatelja da je sve u redu. 	Stigao si napolje i vidiš poznato mesto blizu zone, pa ti deluje da bi bilo brzo da se vratiš po akreditaciju ili telefon. Šta biraš?
C	4	43	13	Tačno! Odlično. Na zbornom mestu se čeka zvanična potvrda, bez širenja glasina ili samostalnih zaključaka.	Netačno! Širenje neprovrenih informacija pojačava dezinformacije. U vanrednoj situaciji ostaje se pri proverenim informacijama. Povratak nije dozvoljen bez zvanične potvrde. Najbezbednije je ostati na odobrenom mestu i čekati instrukcije. Ne treba odlaziti bez potvrde. Dalji koraci dolaze od nadležnih lica.	 Širim ono što sam čuo od drugih da bi svi znali više. 	 Pozivam kolege da se vrate u zonu sa mnom, jer deluje bezbedno. 	 Pratim dalja uputstva ovlašćenih lica i ostajem miran. 	 Napustim zborno mesto odmah čim mi deluje da je situacija prošla. 	Na zbornom mestu čuješ različite priče o tome šta se dogodilo. Kako se ponašaš?
B	4	47	14	Tačno! To je najbolji završetak. Kratko, jasno i bez nepotrebnih dodataka.	Netačno! Zatvaranje komunikacije nije dobro kada službena lica traže razjašnjenje. Saradnja podrazumeva dostupnost za dodatna pitanja. Detalji mogu biti korisni, ali preopširan govor otežava rad službenih lica. Najbolje je biti sažet i precizan. Motivi i zaključci bez osnova nisu od pomoći. Ostajte na onome što ste neposredno uočili.	 Kažete da više ništa nećete reći ni ako vas ponovo pitaju. 	 Dajete uredan, kratak pregled činjenica i ostajete dostupni za dodatna pitanja. 	 Produžavate razgovor da biste objasnili celu svoju verziju događaja do detalja. 	 Dodajete lične pretpostavke o motivu i krivici. 	Situacija se smiruje, a od vas se traži kratko usmeno objašnjenje onoga što ste videli. Kako završavate razgovor?
D	2	45	14	Tačno! Tako pokazujete saradnju i poštovanje nadležnosti, što je upravo potrebno u takvom trenutku.	Netačno! Bolje je nego širenje informacija, ali i dalje može stvarati gužvu. Najpraktičnije je mirno sačekati dalje uputstvo. Odlazak može omesti proveru i otežati koordinaciju. Najpre ispoštujte uputstvo koje ste dobili. U incidentu je važnija operativna jasnoća od rasprave. Ne opterećujte službeno lice dodatnim zahtevima.	 Tražite od drugih ljudi da ostanu uz vas i komentarišu situaciju. 	 Odlazite da obavite svoj planirani posao i javite se kasnije. 	 Počinjete da objašnjavate svoj stav i tražite da vam se garantuje odgovor odmah. 	 Ostajete dostupni i pratite dalja uputstva, bez ulaska u raspravu. 	Službeno lice traži da ostanete dostupni dok se obavlja provera. Kako postupate?
A	1	44	14	Tačno! To je najbolji pristup. Činjenice pomažu službenim licima da procene situaciju bez šuma i pretpostavki.	Netačno! Bolje je da ne spekulišete, ali potpuna odbijenica nije korisna. Kratke, tačne činjenice su pravi doprinos. Važno je govoriti iz sopstvenog neposrednog opažanja. Neproverene informacije nisu pouzdane i mogu otežati postupanje.	 Kažete samo ono što ste lično uočili, bez nagađanja. 	 Ukratko odbijete da odgovorite i kažete da nije vaš posao. 	 Prvo pitate druge prisutne da li se slažu sa vašim utiskom. 	 Prepričate sve što ste čuli od drugih, pa i ono što niste proverili. 	Službeno lice vas pita šta ste tačno videli pre nekoliko minuta. Šta radite prvo?
D	3	46	14	Tačno! Prenosi se samo ono što je traženo i relevantno, bez širenja van tog okvira.	Netačno! Neformalno prepričavanje nije prihvatljivo. Informacije se koriste samo kroz zvanične kanale i po potrebi. Poverljive informacije se ne prosleđuju neovlašćeno. Deljenje može ugroziti postupanje i bezbednost. Bilježenje može biti korisno ako je dozvoljeno, ali sadržaj i dalje ne sme da se deli dalje niti da ugrozi poverljivost.	 Zapamtite detalj i kasnije ga prepričajte u neformalnom razgovoru. 	 Odmah podelite detalj sa kolegama da bi svi znali šta se dešava. 	 Objavite informaciju na telefonu da biste je sačuvali za sebe. 	 Saopštite ga samo ako vas službeno lice izričito pita i to je relevantno za postupanje. 	Tokom razgovora saznajete poverljiv detalj o lokaciji i proceduri. Šta je najispravnije?
B	2	49	15	Tačno! To je jasna i korisna dojava. Kratke činjenice pomažu službama da procene prioritet i sledeće korake.	Netačno! Dodatne pretpostavke mogu odvući pažnju od suštine. Bolje je držati se onoga što si stvarno video ili čuo. Službama trebaju činjenice koje mogu brzo da provere. Prvo dostavi informacije koje si sigurno uočio. Procenu opasnosti rade nadležne službe.	 Daješ dugačko objašnjenje o tome ko je možda ostavio predmet i zašto misliš da je bezazlen. 	 Navodiš ko zove, gde se nalaziš, šta je uočeno i ima li ljudi u blizini. 	 Prenosiš samo da je 'nešto sumnjivo' i prekidaš vezu. 	 Tražiš da ti odmah kažu da li je predmet opasan, pre nego što kažeš gde je. 	Operativni centar traži kratak opis situacije. Šta je najkorisnije da kažeš?
D	4	51	15	Tačno! Ovo je najbolji izbor. Pratiš zvanično uputstvo i doprinosiš urednoj evakuaciji. Bolje je da posmatraš, ali ne treba čekati tuđe ponašanje kao zamenu za zvanično uputstvo. 	Netačno! Objašnjavanje pretpostavki usporava kretanje. U kriznoj situaciji važnije je slediti uputstva nego nagađati. Koristi se samo odobreni izlaz. Prečice mogu ugroziti i tebe i druge.	 Zadržavaš se da bi ostalim osobama objasnio šta misliš da se dešava. 	 Ignorišeš uputstvo dok ne vidiš da drugi kreću prvi. 	 Napravljaš prečicu kroz zabranjeni prolaz da bi brže izašao. 	 Pomažeš drugima da krenu ka odobrenom izlazu i ostaješ miran tokom kretanja. 	Stiglo je službeno uputstvo da se prostor napusti određenim izlazom. Šta radiš?
A	3	50	15	Tačno! Ispravno. Smanjuješ gužvu i pomažeš da službe imaju prostor za rad.	Netačno! Dobo je ako pokušavaš da utišaš radoznalost. Ipak, udaljavanje je ispravniji izbor. Čak i pasivno prisustvo može ometati procenu i kretanje službi. 	 Tražiš od njih da se udalje i da prate uputstva obezbeđenja, bez rasprave. 	 Pozivaš ih da formiraju krug oko mesta kako bi svi bolje videli šta se dešava. 	 Dopuštaš im da ostanu ako obećaju da neće prilaziti predmetu. 	 Samostalno određuješ ko sme da ostane, a ko da ide. 	Dok čekaš dalje uputstvo, nekoliko ljudi želi da ostane bliže mestu događaja. Kako postupaš?
D	1	48	15	Tačno! Ovo je ispravan početak. Prijava i udaljavanje omogućavaju službama da preuzmu procenu bez dodatnog izlaganja riziku.	Netačno! Ne preuzimaj ovlašćenja obezbeđenja. Tvoja uloga je prijava i saradnja, ne samostalno upravljanje prostorom. Ne dira se predmet niti se samostalno procenjuje sadržaj iz neposredne blizine. Dobro je ako želiš da smanjiš izloženost, ali bez zvaničnog kanala i jasnog uputstva možeš izazvati zabunu.	 Zadržavaš prolaz i samostalno organizuješ kontrolu prostora dok ne stigne neko iz službi. 	 Prilaziš da proveriš šta je unutra, da bi brže procenio rizik. 	 Objavljuješ upozorenje svima oko sebe i tražiš da odmah napuste zonu bez daljih uputstava. 	 Obaveštavaš operativni centar obezbeđenja kroz zvaničan kanal i ostaješ na bezbednoj udaljenosti. 	Primetio si napušten predmet pored prolaza. Šta radiš prvo?
\.


--
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lessons (sort_order, id, section_id, content, image_path, scenario_description, scenario_title, title, scenario_complete_negative, scenario_complete_positive) FROM stdin;
1	1	1	<p><b>Siguran rad u restriktivnim zonama</b><br>Dobrodošli na obuku Bezbednost u restriktivnim zonama Expo 2027, namenjenu akreditovanim licima koja ulaze u restriktivne prostore bez prethodnog bezbednosnog znanja. </p><p>Kroz jasna i praktična pravila naučićete šta znači vaša pravna odgovornost, kako se pravilno nosi i čuva akreditacija, po kom principu se krećete samo kroz odobrene zone, kako da prepoznate indikatore bezbednosnog rizika i zaštitite osetljive informacije, kao i kako da primenite protokol Vidi, prepoznaj, prijavi za sumnjive ili napuštene predmete bez ugrožavanja sebe i drugih. </p><p>Na kraju ćete uvežbati osnovne korake komunikacije, evakuacije i saradnje tokom požara, dojave o bombi i drugih vanrednih situacija, oslanjajući se na važeće propise Republike Srbije i zvanične procedure organizatora.</p><p><br></p><p><h4>Šta ćete naučiti</h4><p><br></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/49709f66-9a31-4170-b56d-9638fa353ede_image.png" alt="slika"><br></p><br><p>Ova znanja će vas pripremiti da se suočite sa izazovima u restriktivnim zonama i osigurate bezbednost svih uključenih. Hvala vam što ste deo ovog važnog procesa!</p>\r\n</p>	\N	\N	\N	Dobrodošli	\N	\N
1	5	3	<p>Kada više akreditovanih lica deli isti prostor, bezbednost zavisi od sitnih, doslednih postupaka. Dobar primer je ako primetiš nešto neobično, proveriš šta si zaista video i čuo i proslediš informaciju kroz odgovarajući kanal, bez nagađanja i bez samoinicijativnog „rešavanja" situacije.</p>\r\n\r\n<h4>Šta podrazumeva kultura i svest bezbednosti</h4>\r\n<ul>\r\n    <li><strong>Posmatraj činjenice:</strong> šta si stvarno video, čuo i potvrdio.</li>\r\n    <li><strong>Čuvaj diskreciju:</strong> informacije deli samo sa ovlašćenim licima.</li>\r\n    <li><strong>Prijavi kroz proceduru:</strong> svaki rizik prijavi nadležnima, ne širi glasine.</li>\r\n    <li><strong>Poštuj granice uloge:</strong> akreditovano lice doprinosi zaštiti lokacije, ali ne menja obezbeđenje ni policiju.</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/0f91dc9c-a89f-474c-bd06-dc19fa0eb8f4_image.png" alt="slika"><br></p><ul>\r\n</ul><br>	\N	Nalaziš se u prolazu ka restriktivnoj zoni i primećuješ osobu koja stoji duže nego što se očekuje, gledajući oko sebe. Nema drugih potvrđenih znakova problema, ali ti deluje neuobičajeno. Treba da proceniš šta je činjenica, a šta je samo utisak, i da izabereš sledeći korak.	Opažanje ili pretpostavka	Kultura zajedničke bezbednosti	Potrebno je još vežbe u razlikovanju činjenica od pretpostavki. Fokusiraj se na ono što možeš jasno da vidiš, čuješ ili potvrdiš, i prijavljuj kroz nadležni kanal bez dodavanja ličnih tumačenja.	Vrlo dobro razlikuješ opažanje od zaključivanja i čuvaš profesionalnu granicu uloge. Takav pristup jača zajedničku bezbednost i pomaže da nadležni brzo dobiju tačne informacije.
3	4	2	<h3>Kretanje samo kroz ovlašćene zone</h3>\r\n<p>Akreditacija ne znači slobodan prolaz svuda, već pristup tačno određenim zonama. Zato je važno da u svakom trenutku znate gde smete da budete, kako to proveravate i šta radite ako primetite da ste ušli u pogrešan prostor. Brza i mirna reakcija je deo profesionalnog ponašanja, ne znak problema.</p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/d9979211-2151-4618-950d-676dba3bb1dd_image.png" alt="slika"><br></p>\r\n\r\n<h4>Zone kretanja na lokaciji Expo 2027</h4>\r\n<ul>\r\n    <li><strong>1. Javna zona</strong> — otvorena za sve posetioce</li>\r\n    <li><strong>2. Kontrolisana zona</strong> — pristup samo akreditovanim licima</li>\r\n    <li><strong>3. Restriktivna zona</strong> — pristup samo ovlašćenim licima</li>\r\n</ul>\r\n\r\n<div class="alert alert-warning">\r\n    <strong>Kretanje je dozvoljeno isključivo kroz označene i odobrene prolaze. Poštujte pravila i uputstva službenih lica na terenu.</strong>\r\n</div>\r\n\r\n<table class="table">\r\n    <thead><tr><th>Situacija</th><th>Šta uraditi</th></tr></thead>\r\n    <tbody>\r\n        <tr><td>Na oznaci vidiš da zona nije u tvom opsegu pristupa</td><td>Zaustavi se i ne ulazi dalje. Proveri akreditaciju i smernice za kretanje.</td></tr>\r\n        <tr><td>Nisi siguran da li je pristup odobren</td><td>Zadrži se na mestu i pitaj ovlašćeno lice ili obezbeđenje pre ulaska.</td></tr>\r\n        <tr><td>Shvatio si da si ušao u neodobrenu zonu</td><td>Odmah se bezbedno povuci istim ili najbližim dozvoljenim putem i prijavi grešku.</td></tr>\r\n        <tr><td>Akreditacija ne odgovara ulazu ili prostoru</td><td>Ne pokušavaj da nastaviš kretanje dok se ne dobije jasno uputstvo.</td></tr>\r\n    </tbody>\r\n</table>\r\n\r\n<h4>Koraci bezbednog izlaska nakon pogrešnog ulaska</h4>\r\n<ol>\r\n    <li><strong>Stani odmah.</strong> Nemoj da nastavljaš kretanje, ne preusmeravaj se nasumično i ne pokušavaj da „brzo prođeš" kroz zonu. Kratko zaustavljanje smanjuje rizik od daljeg ulaska u prostor za koji nemaš ovlašćenje.</li>\r\n    <li><strong>Orijentiši se i povuci se bezbedno.</strong>&nbsp; Vrati se najbližim dozvoljenim putem ili po uputstvu koje vidiš na lokaciji. Ako si u blizini ljudi ili opreme, kreći se mirno i bez zadržavanja.</li>\r\n    <li><strong>Obavesti ovlašćeno lice.</strong>&nbsp; Prijavi da si greškom ušao u neodobrenu zonu i reci gde si trenutno, bez ulepšavanja ili skrivanja informacije. Kratka i tačna prijava pomaže da se situacija odmah razjasni.</li>\r\n    <li><strong>Postupi po dobijenom uputstvu.</strong> Možeš dobiti nalog da ostaneš na mestu, da se vratiš drugim putem ili da se javiš nadležnoj službi. Najvažnije je da ne donosiš sopstvenu procenu umesto zvaničnog uputstva.</li></ol><p>Donosi odluke kroz 4 poteza i izaberi odgovor koji najbolje pokazuje bezbedno i odgovorno postupanje.</p><ol>\r\n</ol>\r\n	\N	Krećeš se kroz objekat sa akreditacijom i u jednom trenutku shvataš da si u prostoru za koji nemaš ovlašćenje. U blizini su druge osobe i označeni prolazi, a treba da reaguješ mirno i profesionalno. Tvoja odluka sada utiče na bezbednost, tok kretanja i način prijave događaja.	Pogrešan ulazak	Zone kretanja i prijava nepravilnosti	Potreban je oprezniji pristup. Ponovo prouči razliku između zaustavljanja, prijave i postupanja po uputstvu, pa se usredsredi na to da ne ulaziš dalje kada nisi siguran u ovlašćenje.	Vrlo dobro prepoznaješ šta znači odgovorno kretanje u ovlašćenim zonama. Nastavi da vežbaš brzu proveru pristupa i disciplinovano postupanje po uputstvu, jer su to ključne navike na lokaciji.
5	16	5	<div class="alert alert-info">\r\n    <h4>Testirajte svoje znanje</h4>\r\n    <p>Nakon što ste prošli sve lekcije, vreme je za završni test. Potrebno je najmanje 9 tačnih odgovora od 10 pitanja (90%) za uspešno polaganje.</p>\r\n    <p>Ukoliko ne položite test, možete ga ponovo polagati.</p>\r\n</div><br>	\N	\N	\N	Završni kviz	\N	\N
1	9	4	<h3>Zabranjeni predmeti</h3>\r\n<p>Po ulasku u restriktivnu zonu, važno je da znate da se ne procenjuje samo <strong>šta je predmet</strong>, već <strong>da li je njegovo unošenje dozvoljeno</strong>. Neki predmeti su u praksi uvek problematični, kao što su oružje, eksplozivne i zapaljive materije, dok su za dronove i sličnu bespilotnu opremu, odlučujući posebna dozvola i zvanična pravila. Najsigurniji pristup je da se oslonite na važeće propise, uputstva organizatora i nalog nadležne službe.</p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/1981b79d-d00d-4495-9a70-5b2e5af86e60_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/0fd8d68e-53db-487c-8b46-b020e3a21441_image.png" alt="slika"><br></p>\r\n\r\n<table class="table">\r\n    <thead><tr><th>Kategorija</th><th>Rizik</th><th>Očekivana prijava</th></tr></thead>\r\n    <tbody>\r\n        <tr><td>Vatreno i drugo oružje</td><td>Visok bezbednosni rizik i stroga kontrola pristupa</td><td>Odmah obavestiti nadležnu službu i postupiti po uputstvu</td></tr>\r\n        <tr><td>Eksplozivne materije i sredstva</td><td>Ozbiljna opasnost za ljude, objekte i opremu</td><td>Bez zadržavanja, prijava obezbeđenju ili ovlašćenom licu</td></tr>\r\n        <tr><td>Zapaljive i lako zapaljive materije</td><td>Povećan rizik od požara i širenja incidenta</td><td>Prijava pre unošenja ili pri uočavanju u zoni</td></tr>\r\n        <tr><td>Dronovi i slična bespilotna oprema</td><td>Moguće narušavanje zaštite prostora i privatnosti</td><td>Prijava nadležnoj službi po uočavanju u zoni, radi provere dozvole</td></tr>\r\n    </tbody>\r\n</table>\r\n\r\n<div class="alert alert-danger">\r\n    <strong>Konačnu odluku donose važeći propisi, pravila organizatora i nadležna služba.</strong><br>\r\n    Nadležna služba zadržava pravo provere i privremenog ili trajnog oduzimanja predmeta koji nisu dozvoljeni u restriktivnoj zoni.</div>	\N	\N	\N	Zabranjeni predmeti i izvori rizika	\N	\N
2	6	3	<h3><br></h3>\r\n<p>U restriktivnoj zoni najviše vredi mirno, precizno opažanje. Ne prijavljuje se „utisak" o nečijoj nameri, već konkretna radnja koja odstupa od uobičajenog ponašanja ili odobrenog kretanja.</p>\r\n\r\n<h4>Na šta se obraća pažnja</h4>\r\n<ul>\r\n    <li><b>Osmatranje sistema obezbeđenja</b>: zadržavanje kod kamera, čitača kartica, vrata ili kontrolnih punktova bez jasnog razloga.</li>\r\n    <li><b>Fotografisanje tehničkih ulaza i osetljivih tačaka</b>: snimanja mesta koja nisu namenjena javnosti.</li>\r\n    <li><b>Pokušaj prolaska bez provere</b>: ulazak za drugim licima, zaobilaženje kontrole ili insistiranje na prolazu van procedure.</li>\r\n</ul>\r\n<p>Bezbednosno korisno pitanje nije „ko je ta osoba?", nego „šta ta osoba radi, gde se nalazi i da li to odgovara pravilima kretanja i pristupa". Tako se izbegavaju glasine i pretpostavke.</p>\r\n\r\n<p>\r\n    </p><p></p><p><br></p><p><img style="max-width: 100%; cursor: pointer; width: 506.879px; height: 277.15px;" src="/uploads/85a4fe1d-83c1-4c32-b87b-6918cba2965d_image.png" alt="slika"><img style="max-width: 100%; cursor: pointer; width: 522.117px; height: 285.482px;" src="/uploads/562245ee-1e76-4b59-9a04-f725d6aef758_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer; width: 509px; height: 278.31px;" src="/uploads/0e934e09-ad26-4242-a7a0-c4d2d7c5bd83_image.png" alt="slika"><img style="max-width: 100%; cursor: pointer; width: 522px; height: 285.418px;" src="/uploads/baac4383-2e2b-428f-9dcd-d25a14ec03df_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer; width: 509px; height: 278.31px;" src="/uploads/96032a78-3ab4-409e-8758-20c97b52fe80_image.png" alt="slika"><img style="max-width: 100%; cursor: pointer; width: 528.094px; height: 288.75px;" src="/uploads/1cca7da1-07d5-4c72-881d-33b67017a653_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer; width: 508.433px; height: 278px;" src="/uploads/cd0a7164-dd3e-4dd4-8dfd-a2624e92107f_image.png" alt="slika"><img style="max-width: 100%; cursor: pointer; width: 523.979px; height: 286.5px;" src="/uploads/879fa787-3d77-4441-8161-e49906486bae_image.png" alt="slika"></p><p><br></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/79c1b6e8-2177-4982-9291-e6794809f177_image.png" alt="slika"><br></p><p><br></p><p>Na bočnom tehničkom ulazu, akreditovano lice u prolazu zastaje nekoliko puta, gleda u kameru i vrata, zatim pravi dve fotografije mobilnim telefonom. </p><p>Posle toga pokušava da uđe iza druge osobe bez zaustavljanja kod provere. </p><p>Službeno lice u blizini primećuje ponašanje, pamti vreme, lokaciju i osnovni opis radnji, pa prijavljuje nadležnoj službi kroz predviđeni kanal.<br>Ovakav pristup je važan zato što ne oslanja prijavu na pretpostavku o motivu. </p><p>Prijava ostaje jasna, proverljiva i korisna za dalje postupanje.</p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/5086b6a9-8d60-40e9-886e-0f3dc754106a_image.png" alt="slika"><br></p><p><br></p><table class="table"><thead><tr><th>Opažanje</th><th>Mogući rizik</th><th>Bezbedna reakcija</th></tr></thead>\r\n    <tbody>\r\n        <tr><td>Dugotrajno zadržavanje kod čitača kartica ili vrata</td><td>Prikupljanje informacija o pristupu ili testiranje reakcije osoblja</td><td>Zapamti mesto, vreme i opis radnje, pa prijavi po proceduri.</td></tr>\r\n        <tr><td>Fotografisanje tehničkog ulaza, ograde ili kontrolne tačke</td><td>Neovlašćeno beleženje osetljivih detalja</td><td>Ne ulazi u raspravu, zabeleži okolnosti i obavesti nadležno lice.</td></tr>\r\n        <tr><td>Ulazak za drugom osobom bez provere</td><td>Neovlašćen prolaz u zaštićenu zonu</td><td>Ne sprečavaj fizički, ali odmah prijavi posmatranu situaciju.</td></tr>\r\n    </tbody>\r\n</table>\r\n	\N	U blizini tehničkog ulaza primećuješ ponašanje koje odstupa od uobičajenog kretanja. Tvoja uloga je da proceniš šta je najkorisnije prijaviti i kako to uraditi profesionalno, bez nagađanja o nameri osobe.	Prijava sumnjivog ponašanja	Prepoznavanje unutrašnjih pretnji	Vredi ponovo vežbati razliku između činjenice i pretpostavke. Usmeri se na to da prijava sadrži šta je tačno viđeno, gde i kada, bez komentara o nameri ili ličnosti.	Odlično razlikuješ opažanje od zaključka i znaš kada treba mirno prijaviti ponašanje. Takav pristup čuva bezbednosnu kulturu i pomaže nadležnima da reaguju brzo i tačno.
2	13	5	<h3><br></h3>\r\n<p>U vanrednoj situaciji pretpostavlja se da će se pratiti samo zvanično uputstvo i da se prostor napusti mirno, bez zadržavanja. Kod požara, dojave o bombi ili drugog neposrednog rizika cilj je isti: zaštititi život kroz brz, organizovan izlazak i dolazak na zbornom mestu. Neformalna obaveštavanja, glasine i samoinicijativno vraćanje u zonu mogu da uspore postupanje i povećaju rizik.</p>\r\n\r\n<h4>Postupak evakuacije</h4>\r\n<ul>\r\n    <li><strong>Zvaničan kanal je uvek merilo:</strong> obezbeđenje, organizator i druga nadležna lica daju uputstva koja se prate odmah.</li>\r\n    <li><strong>Kretanje mora biti kontrolisano:</strong> koriste se bezbedni izlazi koji su označeni i koji su navedeni u uputstvu.</li>\r\n    <li><strong>Pomoć drugima je važna, ali samo kada je bezbedno:</strong> ako je neko usporen, zgrčen ili otežano pokretan, pruži se podrška bez pravljenja gužve i bez vraćanja unazad.</li>\r\n    <li><strong>Povratak nije dozvoljen:</strong> u zonu se ne ulazi ponovo dok nadležni izričito ne potvrde da je bezbedno.</li>\r\n</ul>\r\n\r\n<h4>Koraci evakuacije</h4>\r\n<ol>\r\n    <li><strong>Prekini šta radiš i poslušaj zvanično uputstvo.</strong> Ako se oglasi alarm, čuje se najava ili dobiješ nalog za evakuaciju, odmah prekini aktivnost i usmeri pažnju na najbližu informaciju. Ne oslanjaj se na prepričavanje drugih lica.</li>\r\n    <li><strong>Kreni prema najbližem bezbednom izlazu.</strong> Prati označene pravce kretanja ili direktno uputstvo ovlašćenog lica. Ne koristi prečice, ne ulazi u zatvorene delove i ne zadržavaj se da proveravaš situaciju.</li>\r\n    <li><strong>Ostani miran i kreni se uredno.</strong> Zadrži razmak, ne trči i ne pravi gužvu. Ako su ti potrebni kratki usmeravajući signali ili potvrda pravca, traži ih od obezbeđenja ili drugog ovlašćenog lica.</li>\r\n    <li><strong>Pomozi drugima samo ako to možeš bez rizika.</strong> Ako neko ima poteškoće da se kreće, pruži kratku i jasnu pomoć, ali ne ugrožavaj sebe niti usporavaj tok evakuacije. Prioritet je da svi izađu bez dodatnog zastoja.</li>\r\n    <li><strong>Stigni na odobreno zborno mesto i ostani tamo.</strong> Nakon izlaska, prijavi prema proceduri i sačekaj dalje uputstvo. Ne vraćaj se po lične stvari i ne ulazi ponovo u zonu dok ne dobiješ zvaničnu dozvolu.</li></ol><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/4628a065-6fe8-4acf-9b11-de368d97d17c_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/7b3018d0-1bd5-421b-969a-4c210d60fd4b_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/5afef7f7-4614-4e03-b38c-bf9140c2670e_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/37fa63e8-deee-4bc5-9aa5-371a5b5384e7_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/0ef1dddc-1a82-4aff-bc52-0f07c05769f2_image.png" alt="slika"><br></p><ol>\r\n</ol>\r\n	\N	Nalaziš se u restriktivnoj zoni kada se istovremeno čuju neformalno dobacivanje kolega i zvanična najava preko sistema razglasa. Ti si odgovorno akreditovano lice i moraš brzo da proceniš kojoj poruci daješ prednost i kako se krećeš dalje. Važno je da ostaneš pribran, jer svako zadržavanje ili samostalno tumačenje može da uspori bezbedan izlazak.	Neočekivane poruke pri evakuaciji	Evakuacija restriktivnih zona	Potrebno je dodatno uvežbavanje osnovnog evakuacionog ponašanja. Najvažnije je da se odmah prati zvanično uputstvo, da se ne vraća u zonu i da se ostaje na odobrenom zbornom mestu.	Vrlo dobro razlikuješ bezbedno postupanje tokom evakuacije. Nastavi da se oslanjaš na zvanične kanale, uredno kretanje i dolazak na odobreno zborno mesto bez samoinicijativnog vraćanja.
1	2	2	<p>Akreditacija u restriktivnoj zoni nije samo dozvola za ulazak, već i obaveza da se poštuju propisana pravila kretanja, ponašanja i prijavljivanja nepravilnosti. </p><p>Odgovornost se ne zasniva na jednom dokumentu, već na spoju važećih propisa, internih procedura organizatora i uputstava privatnog obezbeđenja na lokaciji. </p><p>Kada se ta pravila usklade, pristup ostaje bezbedan za sve prisutne.</p><p><b>Šta nosi odgovornost</b></p><ul><li><b>Akreditovano lice</b> odgovara za to kako koristi akreditaciju, gde se kreće i da li prati odobrene procedure.</li><li><b>Privatno obezbeđenje</b> sprovodi kontrolu pristupa, daje uputstva i reaguje u skladu sa ovlašćenjima na lokaciji.</li><li><b>Nadležni državni organi</b>&nbsp;postupaju kada je potrebno primeniti zakonska ovlašćenja, inspekcijski nadzor ili druge formalne mere.<br><br></li></ul><p>Važno je zapamtiti jednu praktičnu stvar: uvek se primenjuju važeći tekstovi propisa i zvanične procedure, a ne neformalni dogovori, pretpostavke ili informacije iz druge ruke.</p><p><br></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/7e8a0fad-7dc6-42b9-ac60-e8da0a7065dc_image.png" alt="slika"></p><p><br></p><p><b>Akreditovano lice<br></b><img style="max-width: 100%; cursor: pointer;" src="/uploads/c5a4e2fd-0e4f-4230-a2d3-9dc6e99c05c9_Screen_Shot_2026-09-07_at_18.24.43.png" alt="slika"><b>Privatno obezbeđenje</b><img style="max-width: 100%; cursor: pointer;" src="/uploads/86161323-f3e8-437b-846d-41e849ac7d6f_Screen_Shot_2026-09-07_at_18.23.47.png" alt="slika"><b>Nadležni organi</b><img style="max-width: 100%; cursor: pointer;" src="/uploads/2162d4f2-73cb-4031-ab94-4925a0afcfd7_Screen_Shot_2026-09-07_at_18.24.01.png" alt="slika"><b><br></b></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/af5dc95b-b01c-4082-b4cc-f2da3745b8a7_image.png" alt="slika"><b><br></b></p><p><b><br></b></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/2ae2b240-ea77-47e6-98bc-610f919b642e_image.png" alt="slika"><b><br></b></p><p><b><br></b></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/736881bf-bf70-43e2-8df2-30c3998221ae_image.png" alt="slika"><b><br></b></p><p><b><br></b></p><p><b><br></b></p><p><b><br></b></p>	\N	t1	test1	Odgovornost u restriktivnim zonama	Nedovoljno. Ponovi lekciju o pravima i dužnostima u restriktivnoj zoni.	Odlično poznaješ postupke u restriktivnoj zoni. Sjajno odgovoreno!
1	17	6	<h3>Čestitke na završetku kursa!</h3>\r\n<p>Poštovani,</p>\r\n<p>Čestitamo vam na uspešnom završetku kursa „Bezbednost u restriktivnim zonama — Expo 2027"! Kao akreditovana lica bez prethodnog bezbednosnog znanja koja pristupaju restriktivnim zonama, svesni smo koliko je važno imati čvrstu osnovu i pripremljen pristup za ovu izazovnu situaciju.</p>&nbsp;<h4>Ciljevi kursa:</h4>\r\n<ul>\r\n    <li><strong>Objasnite pravnu odgovornost</strong> akreditovanog lica prema pravilima privatnog obezbeđenja, zaštite kritične infrastrukture i internim procedurama Expo 2027.</li>\r\n    <li><strong>Pravilno nosite, čuvate i koristite akreditaciju</strong> da se krećete samo kroz odobrene zone.</li>\r\n    <li><strong>Prepoznate indikatore sumnjivog ponašanja</strong> i zaštitite osetljive informacije.</li>\r\n    <li><strong>Primetite i reagujete</strong> primenjujući protokol „Vidi, prepoznaj, prijavi" za sumnjiv ili napušten predmet bez ugrožavanja sebe i drugih.</li>\r\n    <li><strong>Pravilno komunicirate bezbednosni rizik</strong> i postupate tokom evakuacije, požara, dojave o bombi ili drugog incidenta.</li>\r\n</ul>\r\n<p>Ova znanja će vas pripremiti da se suočite sa izazovima u restriktivnim zonama i osigurate bezbednost svih uključenih. Hvala vam što ste deo ovog važnog procesa!</p>\r\n	\N	\N	\N	Ključne lekcije	\N	\N
2	3	2	<p>Akreditacija nije samo pristupnica, već i dokaz da ste ovlašćeni da boravite u određenoj zoni i da se pridržavate pravila lokacije. </p><p>Zato je važno da bude stalno vidljiva, čuvana od oštećenja i dostupna za proveru kada je to potrebno. </p><p>Neuredno nošenje, skrivanje ili ustupanje drugoj osobi može stvoriti bezbednosni rizik i dovesti do posledica po vas i po organizaciju.</p><p><b>Šta se očekuje u praksi</b></p><ul><li>Nosite akreditaciju onako kako je propisano internim pravilima organizatora.</li><li>Proveravajte da li je čitljiva, neoštećena i pod vašim neposrednim nadzorom.</li><li>Reagujte odmah ako je izgubite, oštetite ili primetite da je neko drugi pokušao da je koristi.</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/ddab1846-6e03-414e-9d24-b0dc0b0293a8_image.png" alt="slika"></p><p>Pažljivo posmatrajte gde se akreditacija nalazi na telu i kako je razlika između pravilnog i nepravilnog nošenja prikazana u istoj slici.</p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/f280e003-67c9-4ac5-9f05-cc2a3c25f006_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/07893b7f-969b-4569-9757-99433e933d4b_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/dc2fcf2e-cfa6-474a-8701-922290d8f933_image.png" alt="slika"><br></p><p>Donosite odluke kroz 4 koraka u situaciji sa izgubljenom ili pronađenom tuđom akreditacijom u sekciji sa vežbama.</p><p><br></p>	\N	Nalazite se u restriktivnoj zoni i primećujete da akreditacija više nije kod vas. U blizini su drugi posetioci, a vi treba da postupite brzo, mirno i bez stvaranja dodatnog rizika. Vaš izbor pokazuje da li razumete pravila čuvanja, prijave i zabrane ustupanja akreditacije.	Gubitak akreditacije na lokaciji	Pravilna upotreba akreditacije	Potrebno je još uvežbavanja. Fokusirajte se na tri osnovna pravila: akreditacija mora biti vidljiva, lična i pod vašim nadzorom, a svaki gubitak, oštećenje ili sumnja na zloupotrebu traži momentalnu prijavu.	Odlično razumete postupanje sa akreditacijom. Vidljivost, lična upotreba i pravovremena prijava su vam jasni, što je ključ za bezbedan i profesionalan boravak u restriktivnoj zoni.
3	7	3	<h3><br></h3>\r\n<p>Postoje pravila ulaza u restriktivnu zonu za sva lica koja rade i kreću se u njoj. Najvažnije je da znaš svoje odgovornosti, jer kratka, mirna reakcija često sprečava problem pre nego što postane incident.</p>\r\n\r\n<h4>Šta ovde pratiš</h4>\r\n<ul>\r\n    <li>da li su vrata zaista zatvorena za tobom,</li>\r\n    <li>da koristiš samo svoju akreditaciju,</li>\r\n    <li>da se obraćaš jasno i bez rasprave,</li>\r\n    <li>da pozoveš obezbeđenje kada osoba nema pravo prolaza.</li>\r\n</ul>\r\n<p>Cilj je jednostavan: zadrži svoj prolaz pod kontrolom i ne dozvoli da nepoznata osoba uđe iza tebe bez provere.</p>\r\n\r\n<h4>Koraci za bezbedno sprečavanje neovlašćenog prolaza</h4>\r\n<ol>\r\n    <li><strong>Proveri vrata odmah nakon prolaza.</strong> Ne oslanjaj se na to da će se vrata sama zatvoriti kako treba. Kratak pogled unazad pomaže da primetiš da li je neko krenuo za tobom.</li>\r\n    <li><strong>Koristi samo svoju akreditaciju.</strong> Tvoja bedž/kartica važi samo za tebe i za odobreni prolaz. Ne otvaraj vrata drugoj osobi i ne zadržavaj ih duže nego što je potrebno da prođeš bezbedno.</li>\r\n    <li><strong>Zaustavi pokušaj prolaza mirnim putem.</strong> Dovoljno je kratko i jasno upozorenje, na primer: „Molim vas, pokažite akreditaciju" ili „Sačekajte proveru". Ton treba da bude profesionalan, bez rasprave i bez fizičkog kontakta.</li>\r\n    <li><strong>Ako osoba nema odgovarajuće ovlašćenje, zadrži razmak i pozovi obezbeđenje.</strong> Ne pokušaj da procenjuješ razlog njegovog ponašanja niti da sam rešavaš situaciju. Prijavi šta i gde se desilo i kako je osoba pokušala da prođe.</li>\r\n    <li><strong>Prati dalje uputstvo obezbeđenja ili nadležnog lica.</strong> Kada je rizik prijavljen, tvoja uloga je da ostaneš smiren i omogućiš da ovlašćeno lice preuzme kontrolu. Time štitiš i sebe i druge koji ulaze u zonu.</li></ol><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/f5af8105-999d-4478-a46d-fcdf110b8cb4_image.png" alt="slika"><br></p><p><br></p><ol>\r\n</ol>\r\n	\N	Nalaziš se na ulazu u restriktivnu zonu tokom užurbanog toka ljudi. Upravo si prošao kroz kontrolisana vrata, a osoba iza tebe pokušava da uđe bez jasne provere. Tvoj zadatak je da zadržiš smirenost, zaštitiš prolaz i reaguješ na način koji je bezbedan i profesionalan.	Prolaz iza tebe	Sprečavanje neovlašćenog prolaza	Potrebno je više vežbe u brzom, mirnom zaustavljanju neovlašćenog prolaza. Fokusiraj se na to da prvo zatvoriš prolaz, zatim koristiš jasne reči i odmah uključuješ obezbeđenje.	Vrlo dobro primenjuješ bezbedan i profesionalan odgovor. Znaš da zaustaviš prolaz, koristiš jasnu komunikaciju i prijavljuješ činjenice, što je upravo ponašanje koje štiti kontrolisane zone.
4	8	3	<h3><br></h3>\r\n<p>Kada radite u restriktivnoj zoni, osetljive informacije nisu samo papir i fajl. To mogu biti lozinke, planovi paviljona, rasporedi, operativne procedure i podaci trećih lica. Najbezbedniji pristup je jednostavan: delite samo ono što je zaista potrebno, i to samo sa osobom koja ima ovlašćenje da to zna.</p>\r\n\r\n<h4>Osnovno pravilo</h4>\r\n<ul>\r\n    <li><b>Manje pristupa, manje rizika.</b></li>\r\n    <li><b>Dokumenti i ekrani ne ostaju bez nadzora.</b></li>\r\n    <li><b>Svako neuobičajeno otkrivanje ili gubitak prijavljuje se odmah.</b></li>\r\n</ul>\r\n\r\n<table class="table">\r\n    <thead><tr><th>Vrsta osetljivih informacija</th><th>Kako ih štititi</th></tr></thead>\r\n    <tbody>\r\n        <tr><td>Lozinke i pristupni podaci</td><td>Ne zapisivati na vidnom mestu, ne deliti porukama ili usmeno pred drugima, koristiti samo odobrene načine čuvanja.</td></tr>\r\n        <tr><td>Planovi paviljona i rasporedi</td><td>Pregledati samo kada su potrebni za posao, ne ostavljati ih na stolu, ekranu ili u zajedničkom prostoru.</td></tr>\r\n        <tr><td>Operativne procedure</td><td>Koristiti ih u skladu sa zadatkom, vratiti na sigurno mesto nakon upotrebe, ne kopirati bez ovlašćenja.</td></tr>\r\n        <tr><td>Podaci trećih lica</td><td>Pristupati samo po potrebi, ne komentarisati ih u prolazu i ne deliti dalje bez jasnog razloga i odobrenja.</td></tr>\r\n    </tbody>\r\n</table>\r\n\r\n<h4>Bezbedno čuvanje i deljenje lozinki</h4>\r\n<ul>\r\n    <li><strong>Lozinka na papiru</strong> — ne ostavljati na vidnom mestu</li>\r\n    <li><strong>Deljenje porukom</strong> — ne slati nesigurnim kanalima</li>\r\n    <li><strong>Usmeno izgovaranje</strong> — samo na sigurnom mestu</li>\r\n    <li><strong>Zaključan pristup</strong> — koristiti zaključane ormare i sefove</li>\r\n</ul>\r\n\r\n<h4>Osetljivi dokumenti</h4>\r\n<ul>\r\n    <li><strong>Planovi paviljona</strong> — pregledajte samo onaj plan koji vam je potreban za zadatak. Kada završite, vratite ga na sigurno mesto i ne ostavljajte ga otvorenog da ga drugi mogu videti.</li>\r\n    <li><strong>Otvoreni ekran</strong> — zaključajte ekran kada se udaljavate, čak i na kratko. Ako na ekranu postoji osetljiv sadržaj, okrenite ga tako da ga ne vide prolaznici.</li>\r\n    <li><strong>Štampani dokumenti</strong> — držite ih pod kontrolom od trenutka preuzimanja do odlaganja. Nepotrebne kopije odmah vratite ili uništite prema proceduri.</li>\r\n    <li><strong>Rasporedi i procedure</strong> — ne čitajte ih naglas u zajedničkom prostoru i ne ostavljate ih na stolovima, pultovima ili vozilima.</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/5a9b3fbe-5cef-4775-a5a4-6da2be37532d_image.png" alt="slika"><br></p><ul>\r\n</ul>\r\n	\N		Neovlašćen zahtev za plan	Zaštita osetljivih informacija		Odlično procenjujete šta je bezbedno, a šta nije, i zadržavate profesionalan ton bez nepotrebnog otkrivanja podataka. Nastavite da primenjujete princip najmanjeg potrebnog pristupa, pažljivo rukovanje ekranima i dokumentima, i pravovremenu prijavu svake sumnjive situacije.
2	10	4	<h3><br></h3>\r\n<p>U restriktivnoj zoni najvažnije je da prepoznaš šta vidiš i da ne preduzimaš ništa što može da poveća rizik. Kod napuštenog prtljaga ili sumnjivog paketa, cilj nije da proceniš šta je unutra, nego da bezbedno zadržiš distancu, posmatraš samo spoljašnje okolnosti i odmah pokreneš prijavu kroz propisani kanal.</p>\r\n\r\n<h4>Tri koraka ponašanja</h4>\r\n<ul>\r\n    <li><strong>Vidi:</strong> uoči predmet i okolinu bez prilaženja.</li>\r\n    <li><strong>Prepoznaj:</strong> primeti da li je predmet ostavljen bez nadzora, neobično postavljen ili se nalazi na mestu gde ne pripada.</li>\r\n    <li><strong>Prijavi:</strong> prenesi tačne informacije i prepusti dalje postupanje ovlašćenim licima.</li>\r\n</ul>\r\n<p>Ovakav redosled smanjuje mogućnost pogrešne procene i pomaže da se procedura pokrene brzo, mirno i dosledno.</p>\r\n\r\n<h4>Koraci protokola za sumnjiv predmet</h4>\r\n<ol>\r\n    <li><strong>Uočavanje sa bezbedne udaljenosti.</strong> Zastavi se na mestu sa kog jasno vidiš predmet i neposrednu okolinu, bez priilaska i bez pokušaja da ga pomeriš ili otvoriš. Posmatraj samo ono što je vidljivo: gde se predmet nalazi, ko je u blizini i da li izgleda napušteno.</li>\r\n    <li><strong>Proceni okolinu, ne sadržaj.</strong> Pogledaj šta je neuobičajeno, na primer predmet bez vlasnika, ostavljen u prolazu, u blizini ulaza ili u mestu gde predmet ne bi trebao da stoji. Ne nagađaj šta je unutra i ne oslanjaj se na pretpostavke.</li>\r\n    <li><strong>Udalji se i obezbedi prostor.</strong> Možeš se pomeriti i sprečiti nepotrebno zadržavanje ljudi u blizini. Ne izazivaj paniku, ne dodiruj predmet.</li>\r\n    <li><strong>Prijavi kroz propisani kanal.</strong> Prenesi lokaciju, opis predmeta, vreme zapažanja i sve vidljive okolnosti koje mogu pomoći operativnom centru. Nakon prijave, prati dalje uputstvo i budi dostupan ako se od tebe traži dodatno pojašnjenje.</li></ol><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/b6ad1ec5-5fad-4e7a-b60a-57a82e15cbb6_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/c6330648-2c40-414a-ba2b-e28d27ea11a9_image.png" alt="slika"></p><p><br></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/decbb22d-5e97-4f5d-b835-d0e8ef4e1f07_image.png" alt="slika"><br></p><ol>\r\n</ol>\r\n	\N	Ti si akreditovano lice koje radi u blizini kontrolisanog ulaza. Primećuješ paket nepoznatog porekla u prolazu gde se obično brzo kreću posetioci i osoblje. Moraš da odlučiš kako da postupiš tako da zaštitiš sebe, druge i tok rada u zoni.	Napušten prdmet kod ulaza	Vidi, prepoznaj, prijavi	Potrebno je još vežbe u prepoznavanju bezbednog postupka. Vrati se na tri osnove: ostani na udaljenosti, posmatraj samo vidljivo i prijavi kroz propisani kanal bez dodirivanja predmeta.	Odlično razumeš protokol i biraš bezbedne odluke pod pritiskom. Nastavi da održavaš isti standard, jer upravo mirno posmatranje i tačna prijava prave razliku u kontroli rizika.
3	11	4	<br><p>Akreditovano lice ne rešava sumnjiv predmet, već prvenstveno <strong>štiti sebe, druge i prostor</strong> do dolaska privatnog obezbeđenja ili MUP-a. Najvažnije je da se ostane miran, da se ne prilazi bliže nego što je bezbedno i da se ne ulazi u postupke koji uključuju pregled i premeštanje predmeta.</p>&nbsp;<h4>Kako postupiti</h4><p>U ovakvoj situaciji zadatak je jednostavan, ali strogo ograničen:</p><ul>\r\n    <li>udaljiti se na bezbednu razdaljinu,</li>\r\n    <li>sprečiti radoznale prilaze,</li>\r\n    <li>preneti nove, proverljive informacije nadležnima,</li>\r\n    <li>sačekati dalja uputstva.</li>\r\n</ul>\r\n<p>To znači da akreditovano lice ostaje u ulozi prve uočene osobe i svedoka, a ne preuzima ovlašćenja obezbeđenja ili policije.</p>\r\n\r\n<h4>Bezbedno udaljavanje od sumnjivog predmeta</h4>\r\n<ul>\r\n    <li><strong>Ne prilaziti</strong> — održavajte bezbednu udaljenost</li>\r\n    <li><strong>Bezbedna udaljenost</strong> — minimum 5 metara</li>\r\n    <li><strong>Ne prilaziti</strong> — ne pokušavajte da pomjerite predmet</li>\r\n    <li><strong>Čekati uputstva</strong> — sačekajte dolazak nadležnih službi</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/61e7ae17-7a72-4918-8156-3b5a3b555b53_image.png" alt="slika"><br></p><ul>\r\n</ul>\r\n\r\n<h4>Koraci zaštite restriktivne zone</h4>\r\n<ol>\r\n    <li><strong>Povuci se na bezbednu razdaljinu.</strong> Ne zadržavaj se kod predmeta i ne pokušavaj da proceniš njegov sadržaj iz blizine. Kratko zadržavanje je dovoljno da potvrdiš lokaciju i da ne izgubiš pregled prostora.</li>\r\n    <li><strong>Obavesti nadležne propisanim kanalom.</strong> Prenesi tačnu lokaciju, šta je viđeno i da li ima ljudi u blizini. Koristi samo činjenice koje možeš pouzdano da potvrdiš, bez nagađanja.</li>\r\n    <li><strong>Usmeri ljude dalje od mesta događaja.</strong> Smireno zamoli posetioce da se udalje i koristi reči koje ne izazivaju paniku. Cilj je da se prostor rastereti, a ne da se stvara gužva oko predmeta.</li>\r\n    <li><strong>Sačekaj dalja uputstva i ostani dostupan.</strong> Ne diraj predmet, ne premeštaj ga i ne preduzimaj radnje koje pripadaju obezbeđenju ili policiji. Ako se pojave nove informacije, odmah ih prosledi.</li></ol><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/ddae4e97-20e0-45c7-aea3-b1eabd19a05e_image.png" alt="slika"><br></p><p><br></p><ol>\r\n</ol>\r\n	\N	Nalaziš se u prolazu između dve kontrolne tačke i primećuješ ostavljen paket uz zid. Nekoliko ljudi već usporava i gleda u pravcu predmeta, a jedan prolaznik pokušava da priđe bliže. Tvoja reakcija treba da zaštiti ljude, održi pregled prostora i omogući da nadležni dobiju tačne informacije.	Okupljanje oko ostavljenog paketa	Obezbeđivanje restriktivne zone	Potrebno je još vežbe u osnovnom obrascu: udalji se, prijavi, usmeri ljude i ne diraj predmet. Najvažnije je da svaka radnja ostane u granicama tvoje uloge.	Odlično razumeš kako se prostor obezbeđuje bez preuzimanja tuđih ovlašćenja. Nastavi da razmišljaš u istom redosledu: bezbedna udaljenost, jasna prijava, kontrolisan pristup i čekanje uputstava.
1	12	5	<h3>Kanali prijave rizika</h3>\r\n<p>U restriktivnoj zoni, brzina prijave je važna isto koliko i tačnost informacija. Kada nešto deluje neuobičajeno, cilj nije da sami procenite rizik do kraja, već da ga prenesete kroz pravi kanal i bez odlaganja. Jasna dojava pomaže da operativni centar obezbeđenja, a po potrebi i nadležni organi, odmah preuzmu dalji postupak.</p>\r\n\r\n<h4>Šta prijava podrazumeva</h4><ul><p>\r\n    </p><li>da se odmah razume ko prijavljuje</li>\r\n    <li>da se precizno locira gde je događaj</li>\r\n    <li>da se proceni šta se dešava sada</li>\r\n    <li>da se vidi da li postoji neposredna opasnost</li>\r\n    <li>da se zna šta je već učinjeno</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/6e39a7e4-1b54-4371-838a-0cc0637a6e6e_image.png" alt="slika"><br></p><p>\r\n    </p><p></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/498860af-f06e-4730-9a4c-1a6862afa329_image.png" alt="slika"><br></p><table class="table"><thead><tr><th>Vrsta događaja</th><th>Prvi kanal prijave</th><th>Napomena</th></tr></thead>\r\n    <tbody>\r\n        <tr><td>Uobičajeni bezbednosni rizik u zoni</td><td>Operativni centar obezbeđenja</td><td>Koristite zvanični kanal organizatora i pratite uputstva koja dobijete.</td></tr>\r\n        <tr><td>Situacija koja zahteva postupanje nadležnog organa</td><td>MUP, kada je propisano ili potrebno</td><td>Prijava ide prema važećoj proceduri i u koordinaciji sa organizatorom.</td></tr>\r\n        <tr><td>Incident vezan za prolaz, akreditaciju ili internu proceduru</td><td>Zvanični kanal organizatora</td><td>Prijavu usmerite tamo gde se najbrže može proveriti i evidentirati.</td></tr>\r\n        <tr><td>Hitna i nejasna situacija</td><td>Operativni centar obezbeđenja</td><td>U prijavi odmah naglasite hitnost i da li postoji neposredna opasnost.</td></tr>\r\n    </tbody>\r\n</table>\r\n	\N	Vi ste akreditovano lice koje je upravo primetilo neuobičajeno ponašanje u blizini kontrolisanog ulaza. U prostoru ima više ljudi, a važno je da prijava bude kratka, jasna i poslata pravim kanalom. Vaš zadatak je da odlučujete kao osoba koja prvi put prijavljuje bezbednosni rizik, ali želi da to uradi profesionalno i bez greške.	Poziv iz zone ulaza	Kanali komunikacije i prijava rizika	Potrebno je još vežbe u prepoznavanju pravog kanala i osnovne strukture dojave. Fokusirajte se na činjenice, lokaciju i to da prijava odmah ide kroz zvanični tok.	Vrlo dobro. Dojava je jasna, kratka i usmerena na prave informacije. Takav pristup pomaže da se rizik brzo prosledi kroz odgovarajući kanal i da se postupanje ne odlaže.
3	14	5	<h3><br></h3>\r\n<p>Kada se u restriktivnoj zoni dogodi incident, najvažnije je da ostanete u svojoj ulozi i postupate po zvaničnim uputstvima. Akreditovano lice ne rešava situaciju samo, već pomaže tako što tačno prenosi ono što je video, čuva informacije i ne ometa službena postupanja.</p>\r\n\r\n<h4>Osnovna pravila saradnje</h4>\r\n<ul>\r\n    <li><strong>Pridržavajte se naredenja </strong>privatnog obezbeđenja, MUP-a i drugih ovlašćenih službi.</li>\r\n    <li><strong>Ne ulazite u raspravu</strong> i ne pokušavajte da preuzmete vođenje postupka.</li>\r\n    <li><strong>Prijavite samo činjenice</strong> koje ste neposredno uočili, bez nagađanja.</li>\r\n    <li><strong>Čuvajte poverljive informacije</strong> i ne delite ih sa drugim licima na licu mesta.</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/f197ed00-d156-4c90-b698-bd6c5d6cc434_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/5ec31783-dd5e-453a-9aa3-faef5e672172_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/cc3d3e5d-77b2-4f11-9ca2-9984ca22450f_image.png" alt="slika"></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/c36e5807-4aca-4465-bb12-13b786106ea5_image.png" alt="slika"></p><ul>\r\n</ul><p>\r\n    </p><img style="max-width: 100%; cursor: pointer;" src="/uploads/b8413a8e-1c77-41de-a8ef-7b5f3a91b0f1_image.png" alt="slika"><p><br></p><h4>Akreditovano lice — dužnosti</h4><table class="table"><thead><tr><th>Akreditovano lice — dužnosti</th><th>Prepušta službama</th></tr></thead>\r\n    <tbody>\r\n        <tr><td>Prijavljuje ono što je neposredno uočilo.</td><td>Procenu pretnje i donošenje operativnih mera.</td></tr>\r\n        <tr><td>Ostaje mirno i prati uputstva.</td><td>Odlučivanje o zoni, pristupu i daljim koracima.</td></tr>\r\n        <tr><td>Daje tačne činjenice, kratko i jasno.</td><td>Istragu, proveru i službenu komunikaciju.</td></tr>\r\n        <tr><td>Ne širi poverljive informacije.</td><td>Koordinaciju sa drugim nadležnim organima.</td></tr>\r\n    </tbody>\r\n</table><br>	\N	Nalazite se u restriktivnoj zoni kada vam službeno lice zatraži informacije o događaju koji ste upravo primetili. Od vas se očekuje da pomognete, ali i da ne izađete iz svoje uloge niti da ometate postupanje. Vaša odluka utiče na to da li će informacije biti korisne, tačne i bezbedno prenete.	Kad službeno lice traži podatke	Saradnja tokom incidenta	Potrebno je još vežbe u tome kada treba govoriti, a kada prepustiti odlučivanje službama. Fokusirajte se na tačne činjenice, kratku komunikaciju i poštovanje uputstava bez nagađanja.	Odlično razumete kako se ponaša profesionalno i bez zastoja u incidentu. Nastavite da se oslanjate na činjenice, da čuvate poverljive informacije i da službenim licima omogućite nesmetan rad.
4	15	5	<h3>Redosled reakcija u kriznim situacijama</h3>\r\n<p>Kada se u restriktivnoj zoni pojavi opasnost, najvažnije je da ne reagujete neorganizovano. Pravi redosled je jednostavan; proceni udaljenost, prijavi kroz zvaničan kanal, udalji se iz neposredne blizine i prati uputstva nadležne službe. Cilj je da zaštitiš sebe i druge, bez samostalnog preuzimanja ovlašćenja koja pripadaju obezbeđenju ili policiji.</p>&nbsp;<h4>Šta je prioritet</h4><ul><p>\r\n    </p><li><strong>Život i fizička bezbednost</strong> imaju prednost nad imovinom.</li>\r\n    <li><strong>Jasna prijava</strong> pomaže službama da brzo procene situaciju.</li>\r\n    <li><strong>Mirno povlačenje</strong> smanjuje gužvu i dodatni rizik</li></ul><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/5674795d-dc23-4352-b04b-1f2c73637c5c_image.png" alt="slika"><br></p><ul><p></p></ul><h4>Koraci u kriznim situacijama</h4><ol>\r\n    <li><strong>Zaustavi se i proceni udaljenost.</strong></li>\r\n    <li><strong>Prijavi kroz zvaničan kanal.</strong></li>\r\n    <li><strong>Udalji se iz neposredne zone.</strong></li>\r\n    <li><strong>Prati naloge obezbeđenja i službi.</strong></li>\r\n    <li><strong>Pomozi drugima samo ako je bezbedno.</strong></li></ol><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/e04ec229-34e1-409f-baae-c7ec6b405367_image.png" alt="slika"><strong><br></strong></p><p><img style="max-width: 100%; cursor: pointer;" src="/uploads/a93ff738-4c53-4075-96ad-d76c47c04988_image.png" alt="slika"><strong><br></strong></p><p><strong><br></strong></p>	\N	Nalaziš se u restriktivnoj zoni kada uočiš napušten predmet i istovremeno vidiš da se pristupni prolaz koristi neusklađeno sa pravilima. Ti si akreditovana osoba, ne pripadnik obezbeđenja. Tvoj zadatak je da izabereš postupke koji čuvaju bezbednost i poštuju nadležnosti službi.	Odabir u restriktivnom prolazu	Integrisana vežba reagovanja	Potrebno je još uvežbavanja redosleda reakcije. Fokusiraj se na tri osnove: prijavi kroz zvaničan kanal, udalji se bez odlaganja i prepusti procenu nadležnima.	Odlično razumeš krizni redosled. Prepoznaješ šta treba prijaviti, kada se udaljiti i kako sarađivati bez preuzimanja tuđih ovlašćenja.
\.


--
-- Data for Name: quiz_answers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quiz_answers (correct, selected_answer, attempt_id, id, question_id) FROM stdin;
\.


--
-- Data for Name: quiz_attempts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quiz_attempts (passed, percentage, score, total_questions, attempted_at, id, user_id, certificate_code, certificate_pdf_url) FROM stdin;
\.


--
-- Data for Name: quiz_questions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quiz_questions (correct_answer, sort_order, id, optiona, optionb, optionc, optiond, question_text) FROM stdin;
C	1	1	Otvorite je da proverite sadržaj	Pomerite je na bezbedno mesto	Primenite protokol VIDI-PREPOZNAJ-PRIJAVI i obavestite obezbeđenje	Ignorišete jer verovatno nije opasno	Šta treba da uradite ako primetite napuštenu torbu u restriktivnoj zoni?
B	2	2	Da, ako mu verujete	Ne, nikada	Samo uz odobrenje supervizora	Da, ali samo unutar iste zone	Da li smete da date svoju akreditaciju kolegi da uđe umesto vas?
B	3	3	Svuda unutar Expo kompleksa	Samo kroz zone za koje imate ovlašćenje	Samo u javnim zonama	Gde god vas posao odvede	Gde smete da se krećete sa svojom akreditacijom?
B	4	4	Pozovete policiju direktno	VIDI – primetite i procenite	Pokupite predmet	Fotografišete i objavite na društvenim mrežama	Koja je prva stvar koju radite kada primetite sumnjiv predmet?
B	5	5	Samo posao obezbeđenja	Odgovornost svih akreditovanih lica za bezbednost	Pravila za posetioce	Tehnička zaštita objekata	Šta znači 'bezbednosna kultura'?
B	6	6	Trčite ka izlazu bez obzira na uputstva	Pratite uputstva službi i ne ometate ih	Pokušate da pronađete bombu	Ostanete na mestu i čekate	U slučaju dojave o bombi, šta radite?
B	7	7	Da, ako su prijatelji	Ne	Samo delove informacija	Da, ali usmeno	Da li smete da delite informacije o rasporedu službi sa neovlašćenim licima?
B	8	8	Ništa, samo upozorenje	Moguće oduzimanje akreditacije i pravne posledice	Samo novčana kazna	Privremena suspenzija od 1 dana	Šta se dešava ako prekršite pravila restriktivne zone?
B	9	9	U džepu	Vidljivo na sebi	U torbi	Samo kada vas pitaju	Kako treba da nosite akreditaciju?
B	10	10	PRIJAVI – VIDI – PREPOZNAJ	VIDI – PREPOZNAJ – PRIJAVI	PREPOZNAJ – PRIJAVI – VIDI	VIDI – PRIJAVI – PREPOZNAJ	Koji je ispravan redosled protokola za sumnjive predmete?
\.


--
-- Data for Name: sections; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sections (sort_order, id, description, title) FROM stdin;
1	1	Upoznajte se sa osnovnim konceptima i ciljevima kursa	Uvod
3	3	Kultura zajedničke bezbednosti, prepoznavanje pretnji i zaštita informacija	Bezbednosna kultura i unutrašnje pretnje
4	4	Zabranjeni predmeti, protokol VIDI-PREPOZNAJ-PRIJAVI i obezbeđenje zone	Sumnjivi predmeti i zabranjena sredstva
5	5	Kanali prijave, evakuacija, saradnja i integrisana vežba reakcije	Krizne i vanredne situacije
6	6	Ključne lekcije i pregled kursa	Sažetak
2	2	Odgovornost, pravilna upotreba akreditacije i zone kretanja	Pravni okvir i akreditacija
\.


--
-- Data for Name: user_progress; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_progress (completed, completed_at, id, lesson_id, user_id) FROM stdin;
t	2026-09-07 18:43:32.199342	19	1	1
t	2026-09-07 18:52:15.312355	20	2	1
t	2026-09-07 18:52:50.404155	21	3	1
t	2026-09-07 20:25:05.826958	22	5	1
t	2026-09-07 21:08:04.186378	23	4	1
t	2026-09-07 21:08:15.129467	24	6	1
t	2026-09-08 09:39:02.991651	25	7	1
t	2026-09-08 09:39:32.044572	26	8	1
t	2026-09-08 09:40:22.132815	27	9	1
t	2026-09-08 11:10:19.491891	28	14	1
t	2026-09-08 11:46:35.114059	29	16	1
t	2026-09-08 11:46:43.422124	30	17	1
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (enabled, created_at, id, email, first_name, last_name, password, role) FROM stdin;
t	\N	1	admin@expo.rs	Ana	Ašković	$2a$10$7YRT725K2vJYLDZqNQqfM.OGpCj8vRzWIEESutpwDTd4eSHVd1TK2	ADMIN
t	\N	2	user@expo.rs	Marko	Marković	$2a$10$TzTCvkoG1zyzdxpFCE6Wq.Iz3pNiwd621ZnqTPGFnDy.58.n3fJUu	USER
\.


--
-- Name: exercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.exercises_id_seq', 51, true);


--
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lessons_id_seq', 17, true);


--
-- Name: quiz_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_answers_id_seq', 1, false);


--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_attempts_id_seq', 1, true);


--
-- Name: quiz_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_questions_id_seq', 10, true);


--
-- Name: sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sections_id_seq', 7, true);


--
-- Name: user_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_progress_id_seq', 30, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: backup_exercises backup_exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.backup_exercises
    ADD CONSTRAINT backup_exercises_pkey PRIMARY KEY (id);


--
-- Name: backup_lessons backup_lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.backup_lessons
    ADD CONSTRAINT backup_lessons_pkey PRIMARY KEY (id);


--
-- Name: backup_quiz_questions backup_quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.backup_quiz_questions
    ADD CONSTRAINT backup_quiz_questions_pkey PRIMARY KEY (id);


--
-- Name: backup_sections backup_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.backup_sections
    ADD CONSTRAINT backup_sections_pkey PRIMARY KEY (id);


--
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (id);


--
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: quiz_answers quiz_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_answers
    ADD CONSTRAINT quiz_answers_pkey PRIMARY KEY (id);


--
-- Name: quiz_attempts quiz_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT quiz_attempts_pkey PRIMARY KEY (id);


--
-- Name: quiz_questions quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_pkey PRIMARY KEY (id);


--
-- Name: sections sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: user_progress uk8sschjnhw7q49ml9th0urvo4b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_progress
    ADD CONSTRAINT uk8sschjnhw7q49ml9th0urvo4b UNIQUE (user_id, lesson_id);


--
-- Name: user_progress user_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_progress
    ADD CONSTRAINT user_progress_pkey PRIMARY KEY (id);


--
-- Name: user_progress user_progress_user_id_lesson_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_progress
    ADD CONSTRAINT user_progress_user_id_lesson_id_key UNIQUE (user_id, lesson_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: quiz_answers fkb69mwpkm3kehim0klscpmmkc1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_answers
    ADD CONSTRAINT fkb69mwpkm3kehim0klscpmmkc1 FOREIGN KEY (question_id) REFERENCES public.quiz_questions(id);


--
-- Name: exercises fkes9e0n86cjfb0l6349clxvxc1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT fkes9e0n86cjfb0l6349clxvxc1 FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: lessons fkgt4502q9pklwr02uqh3qnrppi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT fkgt4502q9pklwr02uqh3qnrppi FOREIGN KEY (section_id) REFERENCES public.sections(id);


--
-- Name: user_progress fkk20r0wgq69ilv4py005filedb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_progress
    ADD CONSTRAINT fkk20r0wgq69ilv4py005filedb FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: quiz_attempts fkpj4a9hw0iv1mo1ut6rppg594u; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT fkpj4a9hw0iv1mo1ut6rppg594u FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: quiz_answers fkqw4bm59asqarvnqso6coafn48; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_answers
    ADD CONSTRAINT fkqw4bm59asqarvnqso6coafn48 FOREIGN KEY (attempt_id) REFERENCES public.quiz_attempts(id);


--
-- Name: user_progress fkrt37sneeps21829cuqetjm5ye; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_progress
    ADD CONSTRAINT fkrt37sneeps21829cuqetjm5ye FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict gZQPvmrbNiZdPxOzMtmfahyuxZfggZcim2mbvUZsd9y5gbJ9nEIjdokuGGncFt1

