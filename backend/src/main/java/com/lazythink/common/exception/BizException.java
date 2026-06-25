package com.lazythink.common.exception;

import com.lazythink.common.ErrorCode;
import lombok.Getter;

/**
 * 业务异常
 *
 * @author lazythink
 * @since 2026-06-25
 */
@Getter
public class BizException extends RuntimeException {

    private final ErrorCode errorCode;

    public BizException(ErrorCode errorCode) {
        super(errorCode.getMessage());
        this.errorCode = errorCode;
    }

    public BizException(ErrorCode errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
    }
}
