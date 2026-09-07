package com.expo.security.service;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class BackupService {

    private final JdbcTemplate jdbcTemplate;

    public BackupService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private static final List<String> MAIN_TABLES =
            List.of("sections", "lessons", "exercises", "quiz_questions");

    private static final Map<String, String> COPY_QUERIES = new LinkedHashMap<>();

    static {
        COPY_QUERIES.put("backup_sections",
                "INSERT INTO backup_sections (id, title, description, sort_order) " +
                "SELECT id, title, description, sort_order FROM sections");
        COPY_QUERIES.put("backup_lessons",
                "INSERT INTO backup_lessons (id, section_id, title, content, image_path, sort_order, " +
                "scenario_title, scenario_description, scenario_complete_positive, scenario_complete_negative) " +
                "SELECT id, section_id, title, content, image_path, sort_order, " +
                "scenario_title, scenario_description, scenario_complete_positive, scenario_complete_negative FROM lessons");
        COPY_QUERIES.put("backup_exercises",
                "INSERT INTO backup_exercises (id, lesson_id, prompt, optiona, optionb, optionc, optiond, " +
                "correct_answer, feedback_correct, feedback_wrong, sort_order) " +
                "SELECT id, lesson_id, prompt, optiona, optionb, optionc, optiond, " +
                "correct_answer, feedback_correct, feedback_wrong, sort_order FROM exercises");
        COPY_QUERIES.put("backup_quiz_questions",
                "INSERT INTO backup_quiz_questions (id, question_text, optiona, optionb, optionc, optiond, " +
                "correct_answer, sort_order) " +
                "SELECT id, question_text, optiona, optionb, optionc, optiond, correct_answer, sort_order FROM quiz_questions");
    }

    private static final Map<String, String> RESTORE_QUERIES = new LinkedHashMap<>();

    static {
        RESTORE_QUERIES.put("backup_sections",
                "INSERT INTO sections (id, title, description, sort_order) " +
                "SELECT id, title, description, sort_order FROM backup_sections");
        RESTORE_QUERIES.put("backup_lessons",
                "INSERT INTO lessons (id, section_id, title, content, image_path, sort_order, " +
                "scenario_title, scenario_description, scenario_complete_positive, scenario_complete_negative) " +
                "SELECT id, section_id, title, content, image_path, sort_order, " +
                "scenario_title, scenario_description, scenario_complete_positive, scenario_complete_negative FROM backup_lessons");
        RESTORE_QUERIES.put("backup_exercises",
                "INSERT INTO exercises (id, lesson_id, prompt, optiona, optionb, optionc, optiond, " +
                "correct_answer, feedback_correct, feedback_wrong, sort_order) " +
                "SELECT id, lesson_id, prompt, optiona, optionb, optionc, optiond, " +
                "correct_answer, feedback_correct, feedback_wrong, sort_order FROM backup_exercises");
        RESTORE_QUERIES.put("backup_quiz_questions",
                "INSERT INTO quiz_questions (id, question_text, optiona, optionb, optionc, optiond, " +
                "correct_answer, sort_order) " +
                "SELECT id, question_text, optiona, optionb, optionc, optiond, correct_answer, sort_order FROM backup_quiz_questions");
    }

    public void ensureBackupTables() {
        jdbcTemplate.execute("""
                CREATE TABLE IF NOT EXISTS backup_sections (
                    id BIGINT PRIMARY KEY,
                    title VARCHAR(255) NOT NULL,
                    description VARCHAR(255),
                    sort_order INTEGER NOT NULL
                )""");
        jdbcTemplate.execute("""
                CREATE TABLE IF NOT EXISTS backup_lessons (
                    id BIGINT PRIMARY KEY,
                    section_id BIGINT,
                    title VARCHAR(255) NOT NULL,
                    content TEXT,
                    image_path VARCHAR(255),
                    sort_order INTEGER NOT NULL,
                    scenario_title VARCHAR(255),
                    scenario_description TEXT,
                    scenario_complete_positive TEXT,
                    scenario_complete_negative TEXT
                )""");
        jdbcTemplate.execute("""
                CREATE TABLE IF NOT EXISTS backup_exercises (
                    id BIGINT PRIMARY KEY,
                    lesson_id BIGINT NOT NULL,
                    prompt TEXT NOT NULL,
                    optiona TEXT NOT NULL,
                    optionb TEXT NOT NULL,
                    optionc TEXT NOT NULL,
                    optiond TEXT NOT NULL,
                    correct_answer VARCHAR(1) NOT NULL,
                    feedback_correct TEXT,
                    feedback_wrong TEXT,
                    sort_order INTEGER NOT NULL
                )""");
        jdbcTemplate.execute("""
                CREATE TABLE IF NOT EXISTS backup_quiz_questions (
                    id BIGINT PRIMARY KEY,
                    question_text TEXT NOT NULL,
                    optiona VARCHAR(255) NOT NULL,
                    optionb VARCHAR(255) NOT NULL,
                    optionc VARCHAR(255) NOT NULL,
                    optiond VARCHAR(255),
                    correct_answer VARCHAR(1) NOT NULL,
                    sort_order INTEGER NOT NULL
                )""");
    }

    @Transactional
    public Map<String, Integer> backup() {
        ensureBackupTables();
        Map<String, Integer> counts = new LinkedHashMap<>();
        for (String table : MAIN_TABLES) {
            jdbcTemplate.execute("TRUNCATE TABLE backup_" + table);
        }
        for (String backupTable : COPY_QUERIES.keySet()) {
            int rows = jdbcTemplate.update(COPY_QUERIES.get(backupTable));
            counts.put(backupTable, rows);
        }
        return counts;
    }

    public boolean isBackupEmpty() {
        ensureBackupTables();
        for (String table : MAIN_TABLES) {
            Integer count = jdbcTemplate.queryForObject(
                    "SELECT COUNT(*) FROM backup_" + table, Integer.class);
            if (count != null && count > 0) {
                return false;
            }
        }
        return true;
    }

    @Transactional
    public Map<String, Integer> restoreFromBackup() {
        ensureBackupTables();
        jdbcTemplate.execute(
                "TRUNCATE TABLE sections, exercises, quiz_questions, quiz_attempts, user_progress, quiz_answers CASCADE");

        Map<String, Integer> counts = new LinkedHashMap<>();
        for (String backupTable : RESTORE_QUERIES.keySet()) {
            int rows = jdbcTemplate.update(RESTORE_QUERIES.get(backupTable));
            counts.put(backupTable, rows);
        }
        resetSequences();
        return counts;
    }

    private void resetSequences() {
        for (String table : MAIN_TABLES) {
            String seq = jdbcTemplate.queryForObject(
                    "SELECT pg_get_serial_sequence('" + table + "', 'id')", String.class);
            if (seq != null) {
                jdbcTemplate.execute("SELECT setval('" + seq + "', COALESCE((SELECT MAX(id) FROM "
                        + table + "), 1), true)");
            }
        }
    }
}