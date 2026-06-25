-- ============================================================
-- 「懒得想」LazyThink — 数据库初始化脚本
-- ============================================================
-- 版本: V1.0.0
-- 包含: 建库 + 6张表 + 全部索引
-- 字符集: utf8mb4 / utf8mb4_unicode_ci
-- 引擎: InnoDB
-- 本脚本可重复执行（CREATE IF NOT EXISTS）
-- ============================================================

CREATE DATABASE IF NOT EXISTS lazychink
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE lazychink;

-- ============================================================
-- 1. 用户表
-- ============================================================
CREATE TABLE IF NOT EXISTS t_user (
    id            BIGINT        NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    open_id       VARCHAR(64)   NOT NULL COMMENT '微信openid',
    union_id      VARCHAR(64)   DEFAULT NULL COMMENT '微信unionid',
    nick_name     VARCHAR(64)   NOT NULL DEFAULT '' COMMENT '昵称',
    avatar_url    VARCHAR(512)  NOT NULL DEFAULT '' COMMENT '头像URL',
    user_level    INT           NOT NULL DEFAULT 1 COMMENT '等级(1-4)',
    exp           INT           NOT NULL DEFAULT 0 COMMENT '当前等级经验值',
    total_exp     INT           NOT NULL DEFAULT 0 COMMENT '累计总经验',
    created_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_t_user_open_id (open_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- ============================================================
-- 2. 概念池
-- ============================================================
CREATE TABLE IF NOT EXISTS t_concept_pool (
    id            BIGINT        NOT NULL AUTO_INCREMENT COMMENT '概念ID',
    name          VARCHAR(64)   NOT NULL COMMENT '概念名称',
    category      VARCHAR(32)   NOT NULL COMMENT '分类(风格/场景/角色/情绪/时代/动作)',
    sort_order    INT           NOT NULL DEFAULT 0 COMMENT '同分类排序',
    created_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id),
    KEY idx_concept_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='概念池';

-- ============================================================
-- 3. 灵感记录（每次碰撞生成一条）
-- ============================================================
CREATE TABLE IF NOT EXISTS t_inspiration (
    id            BIGINT        NOT NULL AUTO_INCREMENT COMMENT '灵感ID',
    user_id       BIGINT        NOT NULL COMMENT '碰撞用户ID',
    concepts_json VARCHAR(1024) NOT NULL COMMENT '碰撞结果JSON [{name, category}]',
    is_favorited  TINYINT       NOT NULL DEFAULT 0 COMMENT '是否收藏 0=否 1=是',
    created_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '碰撞时间',
    PRIMARY KEY (id),
    KEY idx_insp_user_id (user_id),
    KEY idx_insp_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='灵感记录';

-- ============================================================
-- 4. 创作表
-- ============================================================
CREATE TABLE IF NOT EXISTS t_creation (
    id              BIGINT        NOT NULL AUTO_INCREMENT COMMENT '创作ID',
    user_id         BIGINT        NOT NULL COMMENT '作者ID',
    inspiration_id  BIGINT        DEFAULT NULL COMMENT '关联灵感ID(可为空)',
    content         TEXT          NOT NULL COMMENT '创作文字内容',
    images_json     VARCHAR(2048) NOT NULL DEFAULT '' COMMENT '图片URL列表JSON',
    like_count      INT           NOT NULL DEFAULT 0 COMMENT '点赞数(冗余)',
    is_deleted      TINYINT       NOT NULL DEFAULT 0 COMMENT '软删除 0=否 1=是',
    created_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
    PRIMARY KEY (id),
    KEY idx_creation_user_id (user_id),
    KEY idx_creation_created_at (created_at),
    KEY idx_creation_deleted_time (is_deleted, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='创作表';

-- ============================================================
-- 5. 点赞表
-- ============================================================
CREATE TABLE IF NOT EXISTS t_user_like (
    id            BIGINT        NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
    user_id       BIGINT        NOT NULL COMMENT '点赞者ID',
    creation_id   BIGINT        NOT NULL COMMENT '被点赞创作ID',
    created_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_like_user_creation (user_id, creation_id),
    KEY idx_like_creation_id (creation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='点赞表';

-- ============================================================
-- 6. 经验流水
-- ============================================================
CREATE TABLE IF NOT EXISTS t_exp_log (
    id            BIGINT        NOT NULL AUTO_INCREMENT COMMENT '流水ID',
    user_id       BIGINT        NOT NULL COMMENT '用户ID',
    exp           INT           NOT NULL COMMENT '本次获得经验值',
    reason        VARCHAR(32)   NOT NULL COMMENT '来源(collide/publish/liked/daily/share)',
    created_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录时间',
    PRIMARY KEY (id),
    KEY idx_exp_log_user_id (user_id),
    KEY idx_exp_log_user_date (user_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='经验流水';
