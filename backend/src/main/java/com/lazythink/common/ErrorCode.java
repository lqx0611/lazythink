package com.lazythink.common;

import lombok.Getter;

/**
 * 统一错误码枚举
 *
 * @author lazythink
 * @since 2026-06-25
 */
@Getter
public enum ErrorCode {

    SUCCESS(0, "ok"),
    PARAM_ERROR(40001, "参数校验失败"),
    UNAUTHORIZED(40100, "未登录"),
    TOKEN_EXPIRED(40101, "登录已过期，请重新登录"),
    FORBIDDEN(40300, "无权操作"),
    NOT_FOUND(40400, "资源不存在"),
    RATE_LIMIT(42900, "操作过于频繁，请稍后再试"),
    INTERNAL_ERROR(50000, "服务器繁忙，请稍后重试"),
    WX_API_ERROR(50001, "微信服务异常"),
    CONTENT_SECURITY_FAIL(50002, "内容不合规，请修改后重试");

    private final int code;
    private final String message;

    ErrorCode(int code, String message) {
        this.code = code;
        this.message = message;
    }
}
