package com.lazythink;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 「懒得想」应用启动类
 *
 * @author lazythink
 * @since 2026-06-25
 */
@SpringBootApplication
@MapperScan("com.lazythink.mapper")
public class LazyThinkApplication {

    public static void main(String[] args) {
        SpringApplication.run(LazyThinkApplication.class, args);
    }
}
