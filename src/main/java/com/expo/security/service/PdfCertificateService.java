package com.expo.security.service;

import com.expo.security.model.QuizAnswer;
import com.expo.security.model.QuizAttempt;
import com.expo.security.model.User;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfWriter;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;

@Service
@RequiredArgsConstructor
public class PdfCertificateService {

    @Value("${app.course.name}")
    private String courseName;

    @Value("${app.base-url:http://localhost:8080}")
    private String baseUrl;

    public byte[] generateCertificate(QuizAttempt attempt) throws Exception {
        User user = attempt.getUser();

        Document document = new Document(PageSize.A4, 50, 50, 50, 50);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, baos);
        document.open();

        // Title
        Font titleFont = new Font(Font.HELVETICA, 22, Font.BOLD, new Color(30, 60, 114));
        Paragraph title = new Paragraph("SERTIFIKAT O POLOŽENOM KURSU", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20);
        document.add(title);

        // Course name
        Font courseFont = new Font(Font.HELVETICA, 14, Font.BOLD);
        Paragraph course = new Paragraph(courseName, courseFont);
        course.setAlignment(Element.ALIGN_CENTER);
        course.setSpacingAfter(30);
        document.add(course);

        // User info
        Font normal = new Font(Font.HELVETICA, 12);
        Font bold = new Font(Font.HELVETICA, 12, Font.BOLD);

        document.add(new Paragraph("Polaznik: " + user.getFullName(), bold));
        document.add(new Paragraph("Email: " + user.getEmail(), normal));
        document.add(new Paragraph("Datum polaganja: " +
                attempt.getAttemptedAt().format(DateTimeFormatter.ofPattern("dd.MM.yyyy. HH:mm")), normal));
        document.add(new Paragraph("Rezultat: " + attempt.getScore() + " / " + attempt.getTotalQuestions() +
                " (" + String.format("%.0f", attempt.getPercentage()) + "%)", bold));
        document.add(new Paragraph("Status: POLOŽENO", new Font(Font.HELVETICA, 12, Font.BOLD, new Color(0, 128, 0))));
        document.add(Chunk.NEWLINE);

        // Answers summary
        document.add(new Paragraph("Pregled odgovora:", bold));
        document.add(Chunk.NEWLINE);

        int i = 1;
        for (QuizAnswer answer : attempt.getAnswers()) {
            String status = answer.isCorrect() ? "✓ TAČNO" : "✗ NETAČNO";
            Color color = answer.isCorrect() ? new Color(0, 128, 0) : new Color(180, 0, 0);
            Font statusFont = new Font(Font.HELVETICA, 10, Font.NORMAL, color);

            Paragraph q = new Paragraph(i + ". " + answer.getQuestion().getQuestionText(), normal);
            document.add(q);
            document.add(new Paragraph("   Odgovor: " + answer.getSelectedAnswer() + "  →  " + status, statusFont));
            document.add(Chunk.NEWLINE);
            i++;
        }

        // QR Code
        document.add(Chunk.NEWLINE);
        document.add(new Paragraph("Verifikacioni kod: " + attempt.getCertificateCode(), normal));
        document.add(Chunk.NEWLINE);

        String verifyUrl = baseUrl + "/verify/" + attempt.getCertificateCode();
        Image qrImage = Image.getInstance(generateQrCode(verifyUrl, 150, 150));
        qrImage.setAlignment(Element.ALIGN_CENTER);
        document.add(qrImage);

        Paragraph qrNote = new Paragraph("Skenirajte QR kod za verifikaciju sertifikata", new Font(Font.HELVETICA, 9, Font.ITALIC));
        qrNote.setAlignment(Element.ALIGN_CENTER);
        document.add(qrNote);

        document.close();
        return baos.toByteArray();
    }

    private byte[] generateQrCode(String text, int width, int height) throws Exception {
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);
        ByteArrayOutputStream pngOutputStream = new ByteArrayOutputStream();
        MatrixToImageWriter.writeToStream(bitMatrix, "PNG", pngOutputStream);
        return pngOutputStream.toByteArray();
    }
}
