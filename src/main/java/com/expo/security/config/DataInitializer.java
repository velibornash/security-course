package com.expo.security.config;

import com.expo.security.model.*;
import com.expo.security.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final SectionRepository sectionRepository;
    private final LessonRepository lessonRepository;
    private final QuizQuestionRepository questionRepository;
    private final ExerciseRepository exerciseRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        if (userRepository.count() == 0) {
            userRepository.save(User.builder()
                    .firstName("Ana")
                    .lastName("Ašković")
                    .email("admin@expo.rs")
                    .password(passwordEncoder.encode("admin123"))
                    .role(Role.ADMIN)
                    .enabled(true)
                    .build());

            userRepository.save(User.builder()
                    .firstName("Marko")
                    .lastName("Marković")
                    .email("user@expo.rs")
                    .password(passwordEncoder.encode("user123"))
                    .role(Role.USER)
                    .enabled(true)
                    .build());
        }

        if (lessonRepository.count() > 0) {
            return;
        }

        if (exerciseRepository.count() == 0) {
            initExercises();
        }

        // ===== 1. UVOD =====
        Section s1 = sectionRepository.save(Section.builder()
                .title("Uvod")
                .description("Upoznajte se sa osnovnim konceptima i ciljevima kursa")
                .sortOrder(1)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Dobrodošli")
                .content("""
                        <h3>Čestitke na upisu u kurs!</h3>
                        <p>Čestitamo vam na uspešnom upisu u kurs <strong>Bezbednost u restriktivnim zonama — Expo 2027</strong>! Kao akreditovana lica bez prethodnog bezbednosnog znanja koja pristupaju restriktivnim zonama, svesni smo koliko je važno imati čvrstu osnovu i pripremljeni pristup za ovu izazovnu situaciju.</p>
                        <p>Ovaj kurs je profesionalna uvodna obuka koja obuhvata važne aspekte pravne odgovornosti, sistema akreditovanja, bezbednosne kulture, prepoznavanja sumnjivih predmeta i postupanja u kriznim situacijama, oslanjajući se na važeće propise Republike Srbije i zvanične procedure organizatora Expo 2027.</p>

                        <h4>Ciljevi kursa:</h4>
                        <p>Nakon završetka ovog kursa, trebalo bi da budete u mogućnosti da:</p>
                        <ul>
                            <li><strong>Objasnite pravnu odgovornost</strong> akreditovanog lica prema pravilima privatnog obezbeđenja, zaštite kritične infrastrukture i internim procedurama Expo 2027.</li>
                            <li><strong>Pravilno nosite, čuvate i koristite akreditaciju</strong> da se krećete samo kroz odobrene zone.</li>
                            <li><strong>Prepoznate indikatore sumnjivog ponašanja</strong> i zaštitite osetljive informacije.</li>
                            <li><strong>Primetite i reagujete</strong> primenjujući protokol „Vidi, prepoznaj, prijavi" za sumnjiv ili napušten predmet bez ugrožavanja sebe i drugih.</li>
                            <li><strong>Pravilno komunicirate bezbednosni rizik</strong> i postupate tokom evakuacije, požara, dojave o bombi ili drugog incidenta.</li>
                        </ul>
                        <p>Ova znanja će vas pripremiti da se suočite sa izazovima u restriktivnim zonama i osigurate bezbednost svih uključenih. Hvala vam što ste deo ovog važnog procesa!</p>
                        """)
                .sortOrder(1)
                .section(s1)
                .build());

        // ===== 2. PRAVNI OKVIR I AKREDITACIJA =====
        Section s2 = sectionRepository.save(Section.builder()
                .title("Pravni okvir i akreditovanje")
                .description("Odgovornost, pravilna upotreba akreditacije i zone kretanja")
                .sortOrder(2)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Odgovornost u restriktivnoj zoni")
                .content("""
                        <p>Kao akreditovano lice u restriktivnoj zoni, vi nosite odgovornost koja se ogleda u nekoliko ključnih aspekata:</p>

                        <h4>Pravna odgovornost</h4>
                        <ul>
                            <li>Pravilima privatnog obezbeđenja</li>
                            <li>Zakonima o zaštiti kritične infrastrukture</li>
                            <li>Internim procedurama Expo 2027</li>
                        </ul>
                        <p>Nepridržavanje pravila može dovesti do oduzimanja akreditacije i pravnih posledica.</p>

                        <h4>Šta se od vas očekuje</h4>
                        <ul>
                            <li>Poznajete i poštujete sva pravila i procedure</li>
                            <li>Nosite akreditaciju vidljivo i čuvate je</li>
                            <li>Krećete se samo kroz zone za koje imate ovlašćenje</li>
                            <li>Prijavite svaku nepravilnost ili sumnjivo ponašanje</li>
                            <li>Sarađujete sa nadležnim službama</li>
                        </ul>
                        """)
                .sortOrder(1)
                .section(s2)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Pravilna upotreba akreditacije")
                .content("""
                        <h3>Nosite akreditaciju pravilno</h3>

                        <h4>PRAVILNO:</h4>
                        <ul>
                            <li><strong>Vidljivo</strong> — uvek okrenuto napred</li>
                            <li><strong>Ne prekrivati</strong> — akreditacija mora biti potpuno vidljiva</li>
                            <li><strong>Čuvati kod sebe</strong> — nosite je na telu tokom celog boravka</li>
                        </ul>

                        <h4>NEDOZVOLJENO:</h4>
                        <ul>
                            <li><strong>Ne prekrivati</strong> — akreditacija ne sme biti prekrivena odećom ili drugim predmetima</li>
                            <li><strong>U džepu</strong> — akreditacija ne sme biti u džepu, torbi ili skrivena</li>
                            <li><strong>Loše čuvano</strong> — akreditacija mora biti okrenuta napred i na dohvatu ruke</li>
                        </ul>

                        <div class="alert alert-info">
                            <strong>Akreditacija mora biti vidljiva, dostupna i na dohvatu ruke!</strong>
                        </div>

                        <h4>Provera na ulazu</h4>
                        <p>Budite spremni da pokažete svoju akreditaciju na zahtev ovlašćenog lica. Vaša bezbednost počinje pravilnim nošenjem akreditacije.</p>

                        <table class="table">
                            <thead><tr><th>Dozvoljeno</th><th>Nedozvoljeno</th><th>Zašto je važno</th></tr></thead>
                            <tbody>
                                <tr><td>Nosite akreditaciju vidljivo i kod sebe tokom boravka u zoni.</td><td>Skrivanje akreditacije ispod odeće ili u torbi tokom kontrole.</td><td>Olakšava brzu proveru identiteta i nivoa pristupa.</td></tr>
                                <tr><td>Čuvate je tako da ne može lako da se ošteti ili izgubi.</td><td>Ostavljanje akreditacije bez nadzora ili pozajmljivanje drugoj osobi.</td><td>Smanjuje rizik od zloupotrebe i neovlašćenog ulaska.</td></tr>
                                <tr><td>Odmah prijavljujete gubitak, oštećenje ili sumnju na zloupotrebu.</td><td>Ćutite i nastavite da je koristite iako nije ispravna.</td><td>Brza prijava ograničava bezbednosne i disciplinske posledice.</td></tr>
                            </tbody>
                        </table>
                        """)
                .sortOrder(2)
                .section(s2)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Zone kretanja i prijava nepravilnosti")
                .content("""
                        <h3>Kretanje samo kroz ovlašćene zone</h3>
                        <p>Akreditacija ne znači slobodan prolaz svuda, već pristup tačno određenim zonama. Zato je važno da u svakom trenutku znate gde smete da budete, kako to proveravate i šta radite ako primetite da ste ušli u pogrešan prostor. Brza i mirna reakcija je deo profesionalnog ponašanja, ne znak problema.</p>

                        <h4>Zone kretanja na lokaciji Expo 2027</h4>
                        <ul>
                            <li><strong>1. Javna zona</strong> — otvorena za sve posetioce</li>
                            <li><strong>2. Kontrolisana zona</strong> — pristup samo akreditovanim licima</li>
                            <li><strong>3. Restriktivna zona</strong> — pristup samo ovlašćenim licima</li>
                        </ul>

                        <div class="alert alert-warning">
                            <strong>Kretanje je dozvoljeno isključivo kroz označene i odobrene prolaze. Poštujte pravila i uputstva službenih lica na terenu.</strong>
                        </div>

                        <table class="table">
                            <thead><tr><th>Situacija</th><th>Šta uraditi</th></tr></thead>
                            <tbody>
                                <tr><td>Na označenoj zoni vidiš da zona nije u tvom opsegu pristupa</td><td>Zaustavi se i ne ulazi dalje. Proveri akreditaciju i smernice za kretanje.</td></tr>
                                <tr><td>Nisi siguran da li je pristup odobren</td><td>Zadrži se na mestu i pitaj ovlašćeno lice ili obezbeđenje pre ulaska.</td></tr>
                                <tr><td>Shvatio si da si ušao u neodobrenu zonu</td><td>Odmah se bezbedno povuci istim ili najbližim dozvoljenim putem i prijavi grešku.</td></tr>
                                <tr><td>Akreditacija ne odgovara ulazu ili prostoru</td><td>Ne pokušavaj da nastaviš kretanje dok se ne dobije jasno uputstvo.</td></tr>
                            </tbody>
                        </table>

                        <h4>Koraci bezbednog ulaska nakon pogrešnog ulaska</h4>
                        <ol>
                            <li><strong>Stani odmah.</strong> Nemoj da nastavljaš kretanje, ne preusmeravaj se nasumično i ne pokušavaj da „brzo prođeš" kroz zonu.</li>
                            <li><strong>Orijentiši se i povuci se bezbedno.</strong> Vrati se najbližim dozvoljenim putem ili po uputstvu koje vidiš na lokaciji.</li>
                            <li><strong>Obavesti ovlašćeno lice.</strong> Prijavi da si greškom ušao u neodobrenu zonu i reci gde se trenutno nalaziš.</li>
                            <li><strong>Postupi po dobijenom uputstvu.</strong> Možeš dobiti nalog da ostaneš na mestu, da se vratiš drugim putem ili da se javiš nadležnoj službi.</li>
                        </ol>
                        """)
                .sortOrder(3)
                .section(s2)
                .build());

        // ===== 3. BEZBEDNOSNA KULTURA =====
        Section s3 = sectionRepository.save(Section.builder()
                .title("Bezbednosna kultura i unutrašnje pretnje")
                .description("Kultura zajedničke bezbednosti, prepoznavanje pretnji i zaštita informacija")
                .sortOrder(3)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Kultura zajedničke bezbednosti")
                .content("""
                        <p>Kada više akreditovanih lica deli isti prostor, bezbednost zavisi od sitnih, doslednih postupaka. Dobar primer je ako primetiš nešto neobično, proveriš šta si zaista video i čuo i proslediš informaciju kroz odgovarajući kanal, bez nagađanja i bez samoinicijativnog „rešavanja" situacije.</p>

                        <h4>Šta podrazumeva kultura i svest bezbednosti</h4>
                        <ul>
                            <li><strong>Posmatraj činjenice:</strong> šta si stvarno video, čuo i potvrdio.</li>
                            <li><strong>Čuvaj diskreciju:</strong> informacije deli samo sa ovlašćenim licima.</li>
                            <li><strong>Prijavi kroz proceduru:</strong> svaki rizik prijavi nadležnima, ne širi glasine.</li>
                            <li><strong>Poštuj granice uloge:</strong> akreditovano lice doprinosi zaštiti lokacije, ali ne menja obezbeđenje ni policiju.</li>
                        </ul>

                        <h4>Prijavljivanje bez nagađanja</h4>
                        <p>Zapažanja prenosite nadležnima koristeći isključivo činjenice. Razlika između „video sam otvorena vrata", „neko nešto sumnjivo radi" menja kvalitet prijave.</p>

                        <h4>Diskrecija je deo posla</h4>
                        <p>Ne delite raspored, propusnice, kretanje ili druge osetljive informacije sa osobama koje ne trebaju znati. Kratka i lična komunikacija smanjuje rizik od grešaka.</p>

                        <h4>Prijavljuje se nadležnima</h4>
                        <p>Kada nešto deluje neuobičajeno, tvoja uloga je da prijaviš, a ne da ispituješ, zadržavaš ili procenjuješ po izgledu. Pravovremena prijava pomaže da se brzo provere stvarna situacija.</p>
                        """)
                .sortOrder(1)
                .section(s3)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Prepoznavanje unutrašnjih pretnji")
                .content("""
                        <h3>Prepoznavanje unutrašnjih pretnji</h3>
                        <p>U restriktivnoj zoni najviše vredi mirno, precizno opažanje. Ne prijavljuje se „utisak" o nečijoj nameri, već konkretna radnja koja odstupa od uobičajenog ponašanja ili odobrenog kretanja.</p>

                        <h4>Na šta se obraća pažnja</h4>
                        <ul>
                            <li>Osmatranje sistema obezbeđenja: zadržavanje kod kamera, čitača kartica, vrata ili kontrolnih punktova bez jasnog razloga.</li>
                            <li>Fotografisanje tehničkih ulaza i osetljivih tačaka: snimanja mesta koja nisu namenjena javnosti.</li>
                            <li>Pokušaj prolaska bez provere: ulazak za drugim licima, zaobilaženje kontrole ili insistiranje na prolazu van procedure.</li>
                        </ul>
                        <p>Bezbednosno korisno pitanje nije „ko je ta osoba?", nego „šta ta osoba radi, gde se nalazi i da li to odgovara pravilima kretanja i pristupa". Tako se izbegavaju glasine i pretpostavke.</p>

                        <table class="table">
                            <thead><tr><th>Opažanje</th><th>Mogući rizik</th><th>Bezbedna reakcija</th></tr></thead>
                            <tbody>
                                <tr><td>Dugotrajno zadržavanje kod čitača kartica ili vrata</td><td>Prikupljanje informacija o pristupu ili testiranje reakcije osoblja</td><td>Zapamti mesto, vreme i opis radnje, pa prijavi po proceduri.</td></tr>
                                <tr><td>Fotografisanje tehničkog ulaza, ograde ili kontrolne tačke</td><td>Neovlašćeno beleženje osetljivih detalja</td><td>Ne ulazi u raspravu, zabeleži okolnosti i obavesti nadležno lice.</td></tr>
                                <tr><td>Ulazak za drugom osobom bez provere</td><td>Neovlašćen prolaz u zaštićenu zonu</td><td>Ne sprečavaj fizički, ali odmah prijavi posmatranu situaciju.</td></tr>
                            </tbody>
                        </table>
                        """)
                .sortOrder(2)
                .section(s3)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Sprečavanje neovlašćenog prolaza")
                .content("""
                        <h3>Sprečavanje neovlašćenog prolaza</h3>
                        <p>Postoje pravila ulaza u restriktivnu zonu za sva lica koja rade i kreću se u njoj. Najvažnije je da znaš svoje odgovornosti, jer kratka, mirna reakcija često sprečava problem pre nego što postane incident.</p>

                        <h4>Šta ovde pratiš</h4>
                        <ul>
                            <li>da li su vrata zaista zatvorena za tobom,</li>
                            <li>da koristiš samo svoju akreditaciju,</li>
                            <li>da se obraćaš jasno i bez rasprave,</li>
                            <li>da pozoveš obezbeđenje kada osoba nema pravo prolaza.</li>
                        </ul>
                        <p>Cilj je jednostavan: zadrži svoj prolaz pod kontrolom i ne dozvoli da nepoznata osoba uđe iza tebe bez provere.</p>

                        <h4>Koraci za bezbedno sprečavanje neovlašćenog prolaza</h4>
                        <ol>
                            <li><strong>Proveri vrata odmah nakon prolaza.</strong> Ne oslanjaj se na to da će se vrata sama zatvoriti kako treba. Kratak pogled unazad pomaže da primetiš da li je neko krenuo za tobom.</li>
                            <li><strong>Koristi samo svoju akreditaciju.</strong> Tvoja bedž/kartica važi samo za tebe i za odobreni prolaz. Ne otvaraj vrata drugoj osobi i ne zadržavaj ih duže nego što je potrebno da prođeš bezbedno.</li>
                            <li><strong>Zaustavi pokušaj prolaza mirnim putem.</strong> Dovoljno je kratko i jasno upozorenje, na primer: „Molim vas, pokažite akreditaciju" ili „Sačekajte proveru". Ton treba da bude profesionalan, bez rasprave i bez fizičkog kontakta.</li>
                            <li><strong>Ako osoba nema odgovarajuće ovlašćenje, zadrži razmak i pozovi obezbeđenje.</strong> Ne pokušaj da procenjuješ razlog njegovog ponašanja niti da sam rešavaš situaciju. Prijavi šta i gde se desilo i kako je osoba pokušala da prođe.</li>
                            <li><strong>Prati dalje uputstvo obezbeđenja ili nadležnog lica.</strong> Kada je rizik prijavljen, tvoja uloga je da ostaneš smiren i omogućiš da ovlašćeno lice preuzme kontrolu.</li>
                        </ol>
                        """)
                .sortOrder(3)
                .section(s3)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Zaštita osetljivih informacija")
                .content("""
                        <h3>Zaštita osetljivih informacija</h3>
                        <p>Kada radite u restriktivnoj zoni, osetljive informacije nisu samo papir i fajl. To mogu biti lozinke, planovi paviljona, rasporedi, operativne procedure i podaci trećih lica. Najbezbedniji pristup je jednostavan: delite samo ono što je zaista potrebno, i to samo sa osobom koja ima ovlašćenje da to zna.</p>

                        <h4>Osnovno pravilo</h4>
                        <ul>
                            <li>Manje pristupa, manje rizika.</li>
                            <li>Dokumenti i ekrani ne ostaju bez nadzora.</li>
                            <li>Svako neuobičajeno otkrivanje ili gubitak prijavljuje se odmah.</li>
                        </ul>

                        <table class="table">
                            <thead><tr><th>Vrsta osetljivih informacija</th><th>Kako ih štititi</th></tr></thead>
                            <tbody>
                                <tr><td>Lozinke i pristupni podaci</td><td>Ne zapisivati na vidnom mestu, ne deliti porukama ili usmeno pred drugima, koristiti samo odobrene načine čuvanja.</td></tr>
                                <tr><td>Planovi paviljona i rasporedi</td><td>Pregledati samo kada su potrebni za posao, ne ostavljati ih na stolu, ekranu ili u zajedničkom prostoru.</td></tr>
                                <tr><td>Operativne procedure</td><td>Koristiti ih u skladu sa zadatkom, vratiti na sigurno mesto nakon upotrebe, ne kopirati bez ovlašćenja.</td></tr>
                                <tr><td>Podaci trećih lica</td><td>Pristupati samo po potrebi, ne komentarisati ih u prolazu i ne deliti dalje bez jasnog razloga i odobrenja.</td></tr>
                            </tbody>
                        </table>

                        <h4>Bezbedno čuvanje i deljenje lozinki</h4>
                        <ul>
                            <li><strong>Lozinka na papiru</strong> — ne ostavljati na vidnom mestu</li>
                            <li><strong>Deljenje porukom</strong> — ne slati nesigurnim kanalima</li>
                            <li><strong>Usmeno izgovaranje</strong> — samo na sigurnom mestu</li>
                            <li><strong>Zaključan pristup</strong> — koristiti zaključane ormare i sefove</li>
                        </ul>

                        <h4>Osetljivi dokumenti</h4>
                        <ul>
                            <li><strong>Planovi paviljona</strong> — pregledajte samo onaj plan koji vam je potreban za zadatak. Kada završite, vratite ga na sigurno mesto i ne ostavljajte ga otvorenog da ga drugi mogu videti.</li>
                            <li><strong>Otvoreni ekran</strong> — zaključajte ekran kada se udaljavate, čak i na kratko. Ako na ekranu postoji osetljiv sadržaj, okrenite ga tako da ga ne vide prolaznici.</li>
                            <li><strong>Štampani dokumenti</strong> — držite ih pod kontrolom od trenutka preuzimanja do odlaganja. Nepotrebne kopije odmah vratite ili uništite prema proceduri.</li>
                            <li><strong>Rasporedi i procedure</strong> — ne čitajte ih naglas u zajedničkom prostoru i ne ostavljate ih na stolovima, pultovima ili vozilima.</li>
                        </ul>
                        """)
                .sortOrder(4)
                .section(s3)
                .build());

        // ===== 4. SUMNJIVI PREDMETI =====
        Section s4 = sectionRepository.save(Section.builder()
                .title("Sumnjivi predmeti i zabranjena sredstva")
                .description("Zabranjeni predmeti, protokol VIDI-PREPOZNAJ-PRIJAVI i obezbeđenje zone")
                .sortOrder(4)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Zabranjeni predmeti i izvori rizika")
                .content("""
                        <h3>Zabranjeni predmeti</h3>
                        <p>Po ulasku u restriktivnu zonu, važno je da znate da se ne procenjuje samo <strong>šta je predmet</strong>, već <strong>da li je njegovo unošenje dozvoljeno</strong>. Neki predmeti su u praksi uvek problematični, kao što su oružje, eksplozivne i zapaljive materije, dok su za dronove i sličnu bespilotnu opremu odlučujući posebna dozvola i zvanična pravila.</p>

                        <table class="table">
                            <thead><tr><th>Kategorija</th><th>Rizik</th><th>Očekivana prijava</th></tr></thead>
                            <tbody>
                                <tr><td>Vatreno i drugo oružje</td><td>Visok bezbednosni rizik i stroga kontrola pristupa</td><td>Odmah obavestiti nadležnu službu i postupiti po uputstvu</td></tr>
                                <tr><td>Eksplozivne materije i sredstva</td><td>Ozbiljna opasnost za ljude, objekte i opremu</td><td>Bez zadržavanja, prijava obezbeđenju ili ovlašćenom licu</td></tr>
                                <tr><td>Zapaljive i lako zapaljive materije</td><td>Povećan rizik od požara i širenja incidenta</td><td>Prijava pre unošenja ili pri uočavanju u zoni</td></tr>
                                <tr><td>Dronovi i slična bespilotna oprema</td><td>Moguće narušavanje zaštite prostora i privatnosti</td><td>Prijava nadležnoj službi po uočavanju u zoni, radi provere dozvole</td></tr>
                            </tbody>
                        </table>

                        <div class="alert alert-danger">
                            <strong>Konačnu odluku donose važeći propisi, pravila organizatora i nadležna služba.</strong><br>
                            Nadležna služba zadržava pravo provere i privremenog ili trajnog oduzimanja predmeta koji nisu dozvoljeni u restriktivnoj zoni.
                        </div>

                        <div class="alert alert-success">
                            <strong>Bezbednost je zajednička odgovornost. Hvala na saradnji!</strong>
                        </div>
                        """)
                .sortOrder(1)
                .section(s4)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Vidi, prepoznaj, prijavi")
                .content("""
                        <h3>Vidi, prepoznaj, prijavi</h3>
                        <p>U restriktivnoj zoni najvažnije je da prepoznaš šta vidiš i da ne preduzimaš ništa što može da poveća rizik. Kod napuštenog prtljaga ili sumnjivog paketa, cilj nije da proceniš šta je unutra, nego da bezbedno zadržiš distancu, posmatraš samo spoljašnje okolnosti i odmah pokreneš prijavu kroz propisani kanal.</p>

                        <h4>Tri koraka ponašanja</h4>
                        <ul>
                            <li><strong>Vidi:</strong> uoči predmet i okolinu bez prilaženja.</li>
                            <li><strong>Prepoznaj:</strong> primeti da li je predmet ostavljen bez nadzora, neobično postavljen ili se nalazi na mestu gde ne pripada.</li>
                            <li><strong>Prijavi:</strong> prenesi tačne informacije i prepusti dalje postupanje ovlašćenim licima.</li>
                        </ul>
                        <p>Ovakav redosled smanjuje mogućnost pogrešne procene i pomaže da se procedura pokrene brzo, mirno i dosledno.</p>

                        <h4>Koraci protokola za sumnjiv predmet</h4>
                        <ol>
                            <li><strong>Uočavanje sa bezbedne udaljenosti.</strong> Zastavi se na mestu sa kog jasno vidiš predmet i neposrednu okolinu, bez priilaska i bez pokušaja da ga pomeriš ili otvoriš. Posmatraj samo ono što je vidljivo: gde se predmet nalazi, ko je u blizini i da li izgleda napušteno.</li>
                            <li><strong>Proceni okolinu, ne sadržaj.</strong> Pogledaj šta je neuobičajeno, na primer predmet bez vlasnika, ostavljen u prolazu, u blizini ulaza ili u mestu gde predmet ne bi trebao da stoji. Ne nagađaj šta je unutra i ne oslanjaj se na pretpostavke.</li>
                            <li><strong>Udalji se i obezbedi prostor.</strong> Možeš se pomeriti i sprečiti nepotrebno zadržavanje ljudi u blizini. Ne izazivaj paniku, ne dodiruj predmet.</li>
                            <li><strong>Prijavi kroz propisani kanal.</strong> Prenesi lokaciju, opis predmeta, vreme zapažanja i sve vidljive okolnosti koje mogu pomoći operativnom centru. Nakon prijave, prati dalje uputstvo i budi dostupan ako se od tebe traži dodatno pojašnjenje.</li>
                        </ol>
                        """)
                .sortOrder(2)
                .section(s4)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Obezbeđivanje restriktivne zone")
                .content("""
                        <h3>Obezbeđivanje restriktivne zone</h3>
                        <p>Akreditovano lice ne rešava sumnjiv predmet, već prvenstveno <strong>štiti sebe, druge i prostor</strong> do dolaska privatnog obezbeđenja ili MUP-a. Najvažnije je da se ostane miran, da se ne prilazi bliže nego što je bezbedno i da se ne ulazi u postupke koji uključuju pregled i premeštanje predmeta.</p>

                        <img src="/uploads/manInBlacHandRaised.jpg" class="img-fluid rounded mb-3" alt="Bezbednosno lice - zaustavi i prijavi">

                        <h4>Kako postupiti</h4>
                        <ul>
                            <li>udaljiti se na bezbednu razdaljinu,</li>
                            <li>sprečiti radoznale prilaze,</li>
                            <li>preneti nove, proverljive informacije nadležnima,</li>
                            <li>sačekati dalja uputstva.</li>
                        </ul>
                        <p>To znači da akreditovano lice ostaje u ulozi prve uočene osobe i svedoka, a ne preuzima ovlašćenja obezbeđenja ili policije.</p>

                        <h4>Bezbedno udaljavanje od sumnjivog predmeta</h4>
                        <ul>
                            <li><strong>Ne prilaziti</strong> — održavajte bezbednu udaljenost</li>
                            <li><strong>Bezbedna udaljenost</strong> — minimum 5 metara</li>
                            <li><strong>Ne prilaziti</strong> — ne pokušavajte da pomjerite predmet</li>
                            <li><strong>Čekati uputstva</strong> — sačekajte dolazak nadležnih službi</li>
                        </ul>

                        <h4>Koraci zaštite restriktivne zone</h4>
                        <ol>
                            <li><strong>Povuci se na bezbednu razdaljinu.</strong> Ne zadržavaj se kod predmeta i ne pokušavaj da proceniš njegov sadržaj iz blizine. Kratko zadržavanje je dovoljno da potvrdiš lokaciju i da ne izgubiš pregled prostora.</li>
                            <li><strong>Obavesti nadležne propisanim kanalom.</strong> Prenesi tačnu lokaciju, šta je viđeno i da li ima ljudi u blizini. Koristi samo činjenice koje možeš pouzdano da potvrdiš, bez nagađanja.</li>
                            <li><strong>Usmeri ljude dalje od mesta događaja.</strong> Smireno zamoli posetioce da se udalje i koristi reči koje ne izazivaju paniku. Cilj je da se prostor rastereti, a ne da se stvara gužva oko predmeta.</li>
                            <li><strong>Sačekaj dalja uputstva i ostani dostupan.</strong> Ne diraj predmet, ne premeštaj ga i ne preduzimaj radnje koje pripadaju obezbeđenju ili policiji. Ako se pojave nove informacije, odmah ih prosledi.</li>
                        </ol>
                        """)
                .sortOrder(3)
                .section(s4)
                .build());

        // ===== 5. KRIZNE I VANREDNE SITUACIJE =====
        Section s5 = sectionRepository.save(Section.builder()
                .title("Krizne i vanredne situacije")
                .description("Kanali prijave, evakuacija, saradnja i integrisana vežba reakcije")
                .sortOrder(5)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Kanali komunikacije i prijava rizika")
                .content("""
                        <h3>Kanali prijave rizika</h3>
                        <p>U restriktivnoj zoni, brzina prijave je važna isto koliko i tačnost informacija. Kada nešto deluje neuobičajeno, cilj nije da sami procenite rizik do kraja, već da ga prenesete kroz pravi kanal i bez odlaganja. Jasna dojava pomaže da operativni centar obezbeđenja, a po potrebi i nadležni organi, odmah preuzmu dalji postupak.</p>

                        <h4>Šta prijava podrazumeva</h4>
                        <ul>
                            <li>da se odmah razume ko prijavljuje</li>
                            <li>da se precizno locira gde je događaj</li>
                            <li>da se proceni šta se dešava sada</li>
                            <li>da se vidi da li postoji neposredna opasnost</li>
                            <li>da se zna šta je već učinjeno</li>
                        </ul>

                        <h4>Redosled u 6 koraka</h4>
                        <ol>
                            <li><strong>Predstavite se odmah.</strong> Recite ime, akreditaciju, jasno navedite ko ste i kako bi prijava mogla da se poveže sa vama.</li>
                            <li><strong>Saopštite šta se dogodilo.</strong> Opišite događaj kratko i činjenično, bez nagađanja. Koristite jednostavne rečenice.</li>
                            <li><strong>Precizirajte lokaciju.</strong> Navedite objekat, ulaz, sektor, sprat, prostor ili drugi orijentir koji će omogućiti brzo usmeravanje ekipe.</li>
                            <li><strong>Vreme uočavanja.</strong> Navedite da li je događaj trenutno u toku, kada ste ga prvi put uočili i da li se nešto menja.</li>
                            <li><strong>Opisati opasnost.</strong> Recite da li postoji povređivanje, panika, požar, sumnja na opasnu sadržinu, blokiran izlaz ili druga hitnost.</li>
                            <li><strong>Navedite šta je već preduzeto.</strong> Recite da li ste obavestili obezbeđenje, udaljili ljude, obezbedili prostor ili samo posmatrali bez prilaženja.</li>
                        </ol>

                        <table class="table">
                            <thead><tr><th>Vrsta događaja</th><th>Prvi kanal prijave</th><th>Napomena</th></tr></thead>
                            <tbody>
                                <tr><td>Uobičajeni bezbednosni rizik u zoni</td><td>Operativni centar obezbeđenja</td><td>Koristite zvanični kanal organizatora i pratite uputstva koja dobijete.</td></tr>
                                <tr><td>Situacija koja zahteva postupanje nadležnog organa</td><td>MUP, kada je propisano ili potrebno</td><td>Prijava ide prema važećoj proceduri i u koordinaciji sa organizatorom.</td></tr>
                                <tr><td>Incident vezan za prolaz, akreditaciju ili internu proceduru</td><td>Zvanični kanal organizatora</td><td>Prijavu usmerite tamo gde se najbrže može proveriti i evidentirati.</td></tr>
                                <tr><td>Hitna i nejasna situacija</td><td>Operativni centar obezbeđenja</td><td>U prijavi odmah naglasite hitnost i da li postoji neposredna opasnost.</td></tr>
                            </tbody>
                        </table>
                        """)
                .sortOrder(1)
                .section(s5)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Evakuacija restriktivnih zona")
                .content("""
                        <h3>Evakuacija restriktivnih zona</h3>
                        <p>U vanrednoj situaciji pretpostavlja se da će se pratiti samo zvanično uputstvo i da se prostor napusti mirno, bez zadržavanja. Kod požara, dojave o bombi ili drugog neposrednog rizika cilj je isti: zaštititi život kroz brz, organizovan izlazak i dolazak na zbornom mestu. Neformalna obaveštavanja, glasine i samoinicijativno vraćanje u zonu mogu da uspore postupanje i povećaju rizik.</p>

                        <h4>Postupak evakuacije</h4>
                        <ul>
                            <li><strong>Zvaničan kanal je uvek merilo:</strong> obezbeđenje, organizator i druga nadležna lica daju uputstva koja se prate odmah.</li>
                            <li><strong>Kretanje mora biti kontrolisano:</strong> koriste se bezbedni izlazi koji su označeni i koji su navedeni u uputstvu.</li>
                            <li><strong>Pomoć drugima je važna, ali samo kada je bezbedno:</strong> ako je neko usporen, zgrčen ili otežano pokretan, pruži se podrška bez pravljenja gužve i bez vraćanja unazad.</li>
                            <li><strong>Povratak nije dozvoljen:</strong> u zonu se ne ulazi ponovo dok nadležni izričito ne potvrde da je bezbedno.</li>
                        </ul>

                        <h4>Koraci evakuacije</h4>
                        <ol>
                            <li><strong>Prekini šta radiš i poslušaj zvanično uputstvo.</strong> Ako se oglasi alarm, čuje se najava ili dobiješ nalog za evakuaciju, odmah prekini aktivnost i usmeri pažnju na najbližu informaciju. Ne oslanjaj se na prepričavanje drugih lica.</li>
                            <li><strong>Kreni prema najbližem bezbednom izlazu.</strong> Prati označene pravce kretanja ili direktno uputstvo ovlašćenog lica. Ne koristi prečice, ne ulazi u zatvorene delove i ne zadržavaj se da proveravaš situaciju.</li>
                            <li><strong>Ostani miran i kreni se uredno.</strong> Zadrži razmak, ne trči i ne pravi gužvu. Ako su ti potrebni kratki usmeravajući signali ili potvrda pravca, traži ih od obezbeđenja ili drugog ovlašćenog lica.</li>
                            <li><strong>Pomozi drugima samo ako to možeš bez rizika.</strong> Ako neko ima poteškoće da se kreće, pruži kratku i jasnu pomoć, ali ne ugrožavaj sebe niti usporavaj tok evakuacije. Prioritet je da svi izađu bez dodatnog zastoja.</li>
                            <li><strong>Stigni na odobreno zborno mesto i ostani tamo.</strong> Nakon izlaska, prijavi prema proceduri i sačekaj dalje uputstvo. Ne vraćaj se po lične stvari i ne ulazi ponovo u zonu dok ne dobiješ zvaničnu dozvolu.</li>
                        </ol>
                        """)
                .sortOrder(2)
                .section(s5)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Saradnja tokom incidenta")
                .content("""
                        <h3>Saradnja tokom incidenta</h3>
                        <p>Kada se u restriktivnoj zoni dogodi incident, najvažnije je da ostanete u svojoj ulozi i postupate po zvaničnim uputstvima. Akreditovano lice ne rešava situaciju samo, već pomaže tako što tačno prenosi ono što je video, čuva informacije i ne ometa službena postupanja.</p>

                        <h4>Osnovna pravila saradnje</h4>
                        <ul>
                            <li><strong>Pridržavajte se naredenja privatnog obezbeđenja, MUP-a i drugih ovlašćenih službi.</strong></li>
                            <li><strong>Ne ulazite u raspravu</strong> i ne pokušavajte da preuzmete vođenje postupka.</li>
                            <li><strong>Prijavite samo činjenice</strong> koje ste neposredno uočili, bez nagađanja.</li>
                            <li><strong>Čuvajte poverljive informacije</strong> i ne delite ih sa drugim licima na licu mesta.</li>
                        </ul>

                        <h4>Akreditovano lice — dužnosti</h4>
                        <table class="table">
                            <thead><tr><th>Akreditovano lice — dužnosti</th><th>Prepušta službama</th></tr></thead>
                            <tbody>
                                <tr><td>Prijavljuje ono što je neposredno uočilo.</td><td>Procenu pretnje i donošenje operativnih mera.</td></tr>
                                <tr><td>Ostaje mirno i prati uputstva.</td><td>Odlučivanje o zoni, pristupu i daljim koracima.</td></tr>
                                <tr><td>Daje tačne činjenice, kratko i jasno.</td><td>Istragu, proveru i službenu komunikaciju.</td></tr>
                                <tr><td>Ne širi poverljive informacije.</td><td>Koordinaciju sa drugim nadležnim organima.</td></tr>
                            </tbody>
                        </table>

                        <h4>Primer koordinacije posle bezbednosne prijave</h4>
                        <p>Akreditovano lice u restriktivnoj zoni primećuje neobično ponašanje posetioca i odmah obaveštava obezbeđenje. Obezbeđenje dolazi, procenjuje situaciju i traži od prisutnih da ostanu na mestu dok se ne proveri rizik. Kasnije se uključuje nadležna služba, a prisutna lica odgovaraju samo na konkretna pitanja i ne dele informacije dalje.</p>
                        """)
                .sortOrder(3)
                .section(s5)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Integrisana vežba reakcije")
                .content("""
                        <h3>Redosled reakcija u kriznim situacijama</h3>
                        <p>Kada se u restriktivnoj zoni pojavi opasnost, najvažnije je da ne reagujete neorganizovano. Pravi redosled je jednostavan; proceni udaljenost, prijavi kroz zvaničan kanal, udalji se iz neposredne blizine i prati uputstva nadležne službe. Cilj je da zaštitiš sebe i druge, bez samostalnog preuzimanja ovlašćenja koja pripadaju obezbeđenju ili policiji.</p>

                        <img src="/uploads/nosenjeAkreditacije.jpg" class="img-fluid rounded mb-3" alt="Integrisana vežba reakcije">

                        <h4>Šta je prioritet</h4>
                        <ul>
                            <li><strong>Život i fizička bezbednost</strong> imaju prednost nad imovinom.</li>
                            <li><strong>Jasna prijava</strong> pomaže službama da brzo procene situaciju.</li>
                            <li><strong>Mirno povlačenje</strong> smanjuje gužvu i dodatni rizik.</li>
                        </ul>

                        <h4>Primer sa terena</h4>
                        <p>Akreditovana osoba u hodniku restriktivne zone primećuje napuštenu torbu blizu prolaza i istovremeno vidi kako nekoliko ljudi pokušava da uđe u prolaz koji nije predviđen za njihov nivo pristupa. U isto vreme, u zoni se stvara kratka zbrka jer deo pristupnih ne zna da li treba da ostane ili da se udalji.</p>
                        <p>Nije ispravno da neko sam proverava sadržaj torbe, zaustavlja prolaznike ili improvizuje evakuaciju. Prvi korak je prijava operativnom centru obezbeđenja kroz zvanični kanal, uz kratak i precizan opis lokacije i onoga što je uočeno. Zatim se osoba udaljava od mesta, ne ometa prolaz i prati dalje uputstvo službi.</p>

                        <h4>Koraci u kriznim situacijama</h4>
                        <ol>
                            <li><strong>Zaustavi se i proceni udaljenost.</strong></li>
                            <li><strong>Prijavi kroz zvaničan kanal.</strong></li>
                            <li><strong>Udalji se iz neposredne zone.</strong></li>
                            <li><strong>Prati naloge obezbeđenja i službi.</strong></li>
                            <li><strong>Pomozi drugima samo ako je bezbedno.</strong></li>
                        </ol>

                        <table class="table">
                            <thead><tr><th>Situacija</th><th>Zašto je važna</th><th>Nadležnost</th></tr></thead>
                            <tbody>
                                <tr><td>Prijava uočenog rizika</td><td>Omogućava brzu procenu i pokretanje službenog postupka.</td><td>Operativni centar obezbeđenja</td></tr>
                                <tr><td>Udaljavanje i oslobađanje prostora</td><td>Smanjuje izloženost i ostavlja prolaz službama.</td><td>Obezbeđenje i organizator</td></tr>
                                <tr><td>Evakuacija po nalogu</td><td>Štiti ljude kada postoji neposredan rizik.</td><td>Zvanični izlazi i službeni pravci</td></tr>
                                <tr><td>Postupanje po službenom zahtevu</td><td>Obezbeđuje uređenu saradnju i ne ometa rad organa.</td><td>Privatno obezbeđenje, MUP i drugi nadležni organi</td></tr>
                            </tbody>
                        </table>
                        """)
                .sortOrder(4)
                .section(s5)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Završni kviz")
                .content("""
                        <div class="alert alert-info">
                            <h4>Testirajte svoje znanje</h4>
                            <p>Nakon što ste prošli sve lekcije, vreme je za završni test. Potrebno je najmanje 9 tačnih odgovora od 10 pitanja (90%) za uspešno polaganje.</p>
                            <p>Ukoliko ne položite test, možete ga ponovo polagati.</p>
                        </div>
                        <img src="/uploads/kacenjeakreditacije.jpg" class="img-fluid rounded mb-3" alt="Završni test - pregled rezultata">
                        """)
                .sortOrder(5)
                .section(s5)
                .build());

        // ===== 6. SAŽETAK =====
        Section s6 = sectionRepository.save(Section.builder()
                .title("Sažetak")
                .description("Ključne lekcije i pregled kursa")
                .sortOrder(6)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Ključne lekcije")
                .content("""
                        <h3>Čestitke na završetku kursa!</h3>
                        <p>Poštovani,</p>
                        <p>Čestitamo vam na uspešnom završetku kursa „Bezbednost u restriktivnim zonama — Expo 2027"! Kao akreditovana lica bez prethodnog bezbednosnog znanja koja pristupaju restriktivnim zonama, svesni smo koliko je važno imati čvrstu osnovu i pripremljen pristup za ovu izazovnu situaciju.</p>

                        <img src="/uploads/zoneKretanjaNaLokaciji.jpg" class="img-fluid rounded mb-3" alt="Pregled ključnih lekcija kursa">

                        <h4>Ciljevi kursa:</h4>
                        <ul>
                            <li><strong>Objasnite pravnu odgovornost</strong> akreditovanog lica prema pravilima privatnog obezbeđenja, zaštite kritične infrastrukture i internim procedurama Expo 2027.</li>
                            <li><strong>Pravilno nosite, čuvate i koristite akreditaciju</strong> da se krećete samo kroz odobrene zone.</li>
                            <li><strong>Prepoznate indikatore sumnjivog ponašanja</strong> i zaštitite osetljive informacije.</li>
                            <li><strong>Primetite i reagujete</strong> primenjujući protokol „Vidi, prepoznaj, prijavi" za sumnjiv ili napušten predmet bez ugrožavanja sebe i drugih.</li>
                            <li><strong>Pravilno komunicirate bezbednosni rizik</strong> i postupate tokom evakuacije, požara, dojave o bombi ili drugog incidenta.</li>
                        </ul>
                        <p>Ova znanja će vas pripremiti da se suočite sa izazovima u restriktivnim zonama i osigurate bezbednost svih uključenih. Hvala vam što ste deo ovog važnog procesa!</p>
                        """)
                .sortOrder(1)
                .section(s6)
                .build());

        // ===== QUIZ (10 questions) =====
        saveQuizQuestions();
    }

    private void saveQuizQuestions() {
        questionRepository.save(QuizQuestion.builder()
                .questionText("Šta treba da uradite ako primetite napuštenu torbu u restriktivnoj zoni?")
                .optionA("Otvorite je da proverite sadržaj")
                .optionB("Pomerite je na bezbedno mesto")
                .optionC("Primenite protokol VIDI-PREPOZNAJ-PRIJAVI i obavestite obezbeđenje")
                .optionD("Ignorišete jer verovatno nije opasno")
                .correctAnswer("C")
                .sortOrder(1)
                .build());

        questionRepository.save(QuizQuestion.builder()
                .questionText("Da li smete da date svoju akreditaciju kolegi da uđe umesto vas?")
                .optionA("Da, ako mu verujete")
                .optionB("Ne, nikada")
                .optionC("Samo uz odobrenje supervizora")
                .optionD("Da, ali samo unutar iste zone")
                .correctAnswer("B")
                .sortOrder(2)
                .build());

        questionRepository.save(QuizQuestion.builder()
                .questionText("Gde smete da se krećete sa svojom akreditacijom?")
                .optionA("Svuda unutar Expo kompleksa")
                .optionB("Samo kroz zone za koje imate ovlašćenje")
                .optionC("Samo u javnim zonama")
                .optionD("Gde god vas posao odvede")
                .correctAnswer("B")
                .sortOrder(3)
                .build());

        questionRepository.save(QuizQuestion.builder()
                .questionText("Koja je prva stvar koju radite kada primetite sumnjiv predmet?")
                .optionA("Pozovete policiju direktno")
                .optionB("VIDI – primetite i procenite")
                .optionC("Pokupite predmet")
                .optionD("Fotografišete i objavite na društvenim mrežama")
                .correctAnswer("B")
                .sortOrder(4)
                .build());

        questionRepository.save(QuizQuestion.builder()
                .questionText("Šta znači 'bezbednosna kultura'?")
                .optionA("Samo posao obezbeđenja")
                .optionB("Odgovornost svih akreditovanih lica za bezbednost")
                .optionC("Pravila za posetioce")
                .optionD("Tehnička zaštita objekata")
                .correctAnswer("B")
                .sortOrder(5)
                .build());

        questionRepository.save(QuizQuestion.builder()
                .questionText("U slučaju dojave o bombi, šta radite?")
                .optionA("Trčite ka izlazu bez obzira na uputstva")
                .optionB("Pratite uputstva službi i ne ometate ih")
                .optionC("Pokušate da pronađete bombu")
                .optionD("Ostanete na mestu i čekate")
                .correctAnswer("B")
                .sortOrder(6)
                .build());

        questionRepository.save(QuizQuestion.builder()
                .questionText("Da li smete da delite informacije o rasporedu službi sa neovlašćenim licima?")
                .optionA("Da, ako su prijatelji")
                .optionB("Ne")
                .optionC("Samo delove informacija")
                .optionD("Da, ali usmeno")
                .correctAnswer("B")
                .sortOrder(7)
                .build());

        questionRepository.save(QuizQuestion.builder()
                .questionText("Šta se dešava ako prekršite pravila restriktivne zone?")
                .optionA("Ništa, samo upozorenje")
                .optionB("Moguće oduzimanje akreditacije i pravne posledice")
                .optionC("Samo novčana kazna")
                .optionD("Privremena suspenzija od 1 dana")
                .correctAnswer("B")
                .sortOrder(8)
                .build());

        questionRepository.save(QuizQuestion.builder()
                .questionText("Kako treba da nosite akreditaciju?")
                .optionA("U džepu")
                .optionB("Vidljivo na sebi")
                .optionC("U torbi")
                .optionD("Samo kada vas pitaju")
                .correctAnswer("B")
                .sortOrder(9)
                .build());

        questionRepository.save(QuizQuestion.builder()
                .questionText("Koji je ispravan redosled protokola za sumnjive predmete?")
                .optionA("PRIJAVI – VIDI – PREPOZNAJ")
                .optionB("VIDI – PREPOZNAJ – PRIJAVI")
                .optionC("PREPOZNAJ – PRIJAVI – VIDI")
                .optionD("VIDI – PRIJAVI – PREPOZNAJ")
                .correctAnswer("B")
                .sortOrder(10)
                .build());

        // ===== QUIZ QUESTIONS (pre-existing) =====
        // See initQuizQuestions() method below
    }

    // ========== EXERCISES INITIALIZATION ==========

    @Transactional
    private void initExercises() {
        List<Lesson> allLessons = lessonRepository.findAll();
        for (Lesson l : allLessons) {
            exerciseRepository.save(Exercise.builder()
                    .lesson(l)
                    .prompt("Opišite kratak scenario za lekciju „" + l.getTitle() + "“ i postavite pitanje koje zahteva brzu i ispravnu reakciju.")
                    .optionA("Opcija A – predefinisan odgovor")
                    .optionB("Opcija B – tačan odgovor")
                    .optionC("Opcija C – predefinisan odgovor")
                    .optionD("Opcija D – predefinisan odgovor")
                    .correctAnswer("B")
                    .feedbackCorrect("Tačno! Odabrali ste ispravnu reakciju koja štiti bezbednost.")
                    .feedbackWrong("Netačno. Pogledajte tačan odgovor i ponovo pokušajte.")
                    .sortOrder(1)
                    .build());
            exerciseRepository.save(Exercise.builder()
                    .lesson(l)
                    .prompt("Drugi scenario za lekciju „" + l.getTitle() + "“. Izaberite najbolju reakciju.")
                    .optionA("Opcija A – tačan odgovor")
                    .optionB("Opcija B – predefinisan odgovor")
                    .optionC("Opcija C – predefinisan odgovor")
                    .optionD("Opcija D – predefinisan odgovor")
                    .correctAnswer("A")
                    .feedbackCorrect("Odlično! Pravilno ste procenili situaciju.")
                    .feedbackWrong("Pogrešno. Ispravno je A – obratite pažnju na proceduru.")
                    .sortOrder(2)
                    .build());
        }
    }
}
