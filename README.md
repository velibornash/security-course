# Expo 2027 Security Course – Custom E-learning App

Java Spring Boot aplikacija za jedan konkretan kurs:  
**Bezbednost u restriktivnim zonama — Expo 2027**

## Funkcionalnosti

- Registracija / Login korisnika
- Pregled kursa sa sekcijama i lekcijama
- Navigacija Previous / Next kroz lekcije
- Progress tracking
- Admin panel – dodavanje, izmena i brisanje lekcija (tekst + slike)
- Završni test (10 pitanja, prolaz 9/10 = 90%)
- Generisanje PDF sertifikata sa:
  - Podacima korisnika
  - Rezultatom i pregledom tačnih/netačnih odgovora
  - QR kodom za verifikaciju
- Stranica za verifikaciju sertifikata preko QR koda

## Tech stack

- Java 21
- Spring Boot 3.3
- Spring Security + Thymeleaf
- Spring Data JPA + H2 (file-based, lako prebaciti na PostgreSQL)
- OpenPDF + ZXing (PDF + QR)

## Pokretanje

```bash
# U folderu projekta
./mvnw spring-boot:run
# ili
mvn spring-boot:run
```

Aplikacija radi na: **http://localhost:8080**

### Demo nalozi

| Email            | Lozinka  | Uloga  |
|------------------|----------|--------|
| admin@expo.rs    | admin123 | ADMIN  |
| user@expo.rs     | user123  | USER   |

## Struktura

```
src/main/java/com/expo/security/
├── config/          # Security, Web, DataInitializer
├── controller/      # Auth, Course, Admin
├── model/           # Entity klase
├── repository/      # JPA repositoriji
├── security/        # UserDetailsService
└── service/         # Business logika + PDF generisanje
```

## Produkcija

U `application.properties` zameni H2 sa PostgreSQL:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/expo_course
spring.datasource.username=...
spring.datasource.password=...
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
```

## Napomene

- Slike se čuvaju u folderu `./uploads`
- Sertifikat se generiše on-the-fly i može se preuzeti
- QR kod vodi na `/verify/{code}`
- Admin može da dodaje nove lekcije i menja postojeće (tekst + slika)

---
Napravljeno po zahtevu za Expo 2027 obuku.
