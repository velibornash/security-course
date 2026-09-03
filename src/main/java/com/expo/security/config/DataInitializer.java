package com.expo.security.config;

import com.expo.security.model.*;
import com.expo.security.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final SectionRepository sectionRepository;
    private final LessonRepository lessonRepository;
    private final QuizQuestionRepository questionRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        if (userRepository.count() > 0) return; // already initialized

        // Admin user
        userRepository.save(User.builder()
                .firstName("Ana")
                .lastName("Ašković")
                .email("admin@expo.rs")
                .password(passwordEncoder.encode("admin123"))
                .role(Role.ADMIN)
                .enabled(true)
                .build());

        // Demo user
        userRepository.save(User.builder()
                .firstName("Marko")
                .lastName("Marković")
                .email("user@expo.rs")
                .password(passwordEncoder.encode("user123"))
                .role(Role.USER)
                .enabled(true)
                .build());

        // ===== SECTIONS & LESSONS (based on the real course) =====
        Section s1 = sectionRepository.save(Section.builder()
                .title("Dobrodošli i uvod")
                .description("Uvod u obuku")
                .sortOrder(1)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Dobrodošli")
                .content("""
                        <p>Dobro došli na obuku <strong>Bezbednost u restriktivnim zonama — Expo 2027</strong>.</p>
                        <p>Ova profesionalna uvodna obuka namenjena je akreditovanim licima koja ulaze u restriktivne prostore Expo 2027.</p>
                        <p>Kroz jasna i praktična pravila naučićete šta znači vaša pravna odgovornost, kako se pravilno nosi i čuva akreditacija, 
                        po kom principu se krećete samo kroz odobrene zone, kako da prepoznate indikatore bezbednosnog rizika i zaštitite osetljive informacije, 
                        kao i kako da primenite protokol <strong>VIDI – PREPOZNAJ – PRIJAVI</strong>.</p>
                        """)
                .sortOrder(1)
                .section(s1)
                .build());

        Section s2 = sectionRepository.save(Section.builder()
                .title("Pravna odgovornost")
                .description("Šta se od vas očekuje")
                .sortOrder(2)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Pravna odgovornost akreditovanog lica")
                .content("""
                        <p>Kao akreditovano lice u restriktivnoj zoni, vi snosite odgovornost prema:</p>
                        <ul>
                            <li>Pravilima privatnog obezbeđenja</li>
                            <li>Zakonima o zaštiti kritične infrastrukture</li>
                            <li>Internim procedurama Expo 2027</li>
                        </ul>
                        <p>Nepridržavanje pravila može dovesti do oduzimanja akreditacije i pravnih posledica.</p>
                        """)
                .sortOrder(2)
                .section(s2)
                .build());

        Section s3 = sectionRepository.save(Section.builder()
                .title("Akreditacija i zone")
                .description("Kako se krećete")
                .sortOrder(3)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Nošenje i čuvanje akreditacije")
                .content("""
                        <p>Akreditaciju uvek nosite vidljivo. Ne dajte je drugom licu. U slučaju gubitka odmah prijavite.</p>
                        <p>Krećite se <strong>isključivo</strong> kroz zone za koje imate ovlašćenje. Ulazak u zabranjenu zonu = kršenje pravila.</p>
                        """)
                .sortOrder(3)
                .section(s3)
                .build());

        Section s4 = sectionRepository.save(Section.builder()
                .title("Bezbednosna kultura")
                .description("Odgovorno ponašanje")
                .sortOrder(4)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Bezbednosna kultura i sumnjivo ponašanje")
                .content("""
                        <p>Bezbednost je odgovornost svih. Ako primetite nešto sumnjivo – prijavite.</p>
                        <p>Ne delite osetljive informacije (raspored, pristupne tačke, procedure) sa neovlašćenim licima.</p>
                        """)
                .sortOrder(4)
                .section(s4)
                .build());

        Section s5 = sectionRepository.save(Section.builder()
                .title("Sumnjivi predmeti")
                .description("Protokol VIDI-PREPOZNAJ-PRIJAVI")
                .sortOrder(5)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Protokol VIDI – PREPOZNAJ – PRIJAVI")
                .content("""
                        <p><strong>VIDI</strong> – Primetite predmet ili situaciju</p>
                        <p><strong>PREPOZNAJ</strong> – Procenite da li je sumnjivo (napuštena torba, paket bez vlasnika...)</p>
                        <p><strong>PRIJAVI</strong> – Odmah obavestite obezbeđenje. <strong>Ne dirajte predmet!</strong></p>
                        <p>Održavajte bezbedno rastojanje i upozorite druge da se udalje.</p>
                        """)
                .sortOrder(5)
                .section(s5)
                .build());

        Section s6 = sectionRepository.save(Section.builder()
                .title("Reakcija u krizi")
                .description("Evakuacija i incidenti")
                .sortOrder(6)
                .build());

        lessonRepository.save(Lesson.builder()
                .title("Postupanje u kriznim situacijama")
                .content("""
                        <p>U slučaju požara, dojave o bombi ili evakuacije:</p>
                        <ul>
                            <li>Pratite uputstva službi obezbeđenja</li>
                            <li>Ne ometajte službe</li>
                            <li>Ne preuzimajte tuđe ovlašćenje</li>
                            <li>Jasno i mirno prijavite rizik</li>
                        </ul>
                        """)
                .sortOrder(6)
                .section(s6)
                .build());

        // ===== QUIZ (10 questions, 9 needed to pass) =====
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
    }
}
