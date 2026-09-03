package com.expo.security.service;

import com.expo.security.model.User;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class EmailService {

    private final JavaMailSender mailSender;

    @Value("${app.course.name}")
    private String courseName;

    @Value("${app.base-url:http://localhost:8080}")
    private String baseUrl;

    @Async
    public void sendCertificate(User user, byte[] pdfBytes, String certificateCode) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom("noreply@expo.rs", "Expo 2027 Security");
            helper.setTo(user.getEmail());
            helper.setSubject("Sertifikat - " + courseName);

            String html = """
                <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
                    <div style="background: #1e3c72; color: white; padding: 20px; text-align: center;">
                        <h1 style="margin: 0;">Expo 2027 Security</h1>
                    </div>
                    <div style="padding: 30px; background: #f9f9f9;">
                        <h2 style="color: #1e3c72;">Cestitamo, %s!</h2>
                        <p>Uspesno ste polozili test iz kursa <strong>%s</strong>.</p>
                        <p>Vas rezultat je sacuvan i sertifikat je prilozen uz ovaj mejl.</p>
                        <div style="background: white; padding: 15px; border-radius: 8px; margin: 20px 0; border: 1px solid #ddd;">
                            <p style="margin: 5px 0;"><strong>Verifikacioni kod:</strong> %s</p>
                            <p style="margin: 5px 0;"><strong>Link za verifikaciju:</strong> 
                                <a href="%s/verify/%s">%s/verify/%s</a>
                            </p>
                        </div>
                        <p style="color: #666; font-size: 12px;">
                            Sertifikat je takodje dostupan za preuzimanje u vasem nalogu na kursu.
                        </p>
                    </div>
                    <div style="background: #1e3c72; color: white; padding: 10px; text-align: center; font-size: 12px;">
                        Expo 2027 - Bezbednost u restriktivnim zonama
                    </div>
                </div>
                """.formatted(user.getFullName(), courseName, certificateCode, baseUrl, certificateCode, baseUrl, certificateCode);

            helper.setText(html, true);
            helper.addAttachment("sertifikat-expo2027.pdf", new ByteArrayResource(pdfBytes));

            mailSender.send(message);
            log.info("Certificate email sent to {}", user.getEmail());
        } catch (MessagingException e) {
            log.error("Failed to send certificate email to {}: {}", user.getEmail(), e.getMessage());
        } catch (Exception e) {
            log.error("Unexpected error sending email to {}: {}", user.getEmail(), e.getMessage());
        }
    }
}
