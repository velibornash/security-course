package com.expo.security.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

@Component
public class DatabaseInitializer implements CommandLineRunner {

    @Value("${spring.datasource.url}")
    private String datasourceUrl;

    @Value("${spring.datasource.username}")
    private String username;

    @Value("${spring.datasource.password}")
    private String password;

    @Value("${spring.datasource.driverClassName}")
    private String driverClassName;

    @Override
    public void run(String... args) throws Exception {
        // Extract database name from URL: jdbc:postgresql://host:port/dbname
        String dbName = extractDbName(datasourceUrl);
        String baseUrl = datasourceUrl.substring(0, datasourceUrl.lastIndexOf('/') + 1);

        // Connect to default 'postgres' database to create the target DB if needed
        Class.forName(driverClassName);
        try (Connection conn = DriverManager.getConnection(baseUrl + "postgres", username, password);
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate("CREATE DATABASE " + dbName);
            System.out.println("Database '" + dbName + "' created or already exists.");
        } catch (SQLException e) {
            if (e.getMessage().contains("already exists")) {
                System.out.println("Database '" + dbName + "' already exists.");
            } else {
                System.err.println("Warning: Could not create database: " + e.getMessage());
                System.err.println("Make sure PostgreSQL is running and the user has CREATE DATABASE privileges.");
            }
        }
    }

    private String extractDbName(String url) {
        String[] parts = url.split("/");
        return parts[parts.length - 1].split("\\?")[0];
    }
}
