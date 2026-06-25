/**
 * 全局常量
 * 等级阈值、经验值、错误码映射等
 *
 * @since 2026-06-25
 */

// ============================================================
// 碰撞引擎
// ============================================================
const MAX_CONCEPT_COUNT = 5;
const MIN_CONCEPT_COUNT = 2;

// ============================================================
// 等级系统
// ============================================================
const LEVEL_CONFIG = [
  { level: 1, expRequired: 0,   conceptCount: 2, title: '灵感新手' },
  { level: 2, expRequired: 100, conceptCount: 3, title: '脑洞学徒' },
  { level: 3, expRequired: 300, conceptCount: 4, title: '创意达人' },
  { level: 4, expRequired: 600, conceptCount: 5, title: '灵感大师' }
];

// ============================================================
// 经验值规则
// ============================================================
const EXP_RULES = {
  collide: { exp: 2, dailyLimit: 20 },
  publish: { exp: 10, dailyLimit: 5 },
  liked:   { exp: 5, dailyLimit: 20 },
  daily:   { exp: 5, dailyLimit: 1 },
  share:   { exp: 3, dailyLimit: 10 }
};

// ============================================================
// 分页
// ============================================================
const DEFAULT_PAGE_SIZE = 20;

// ============================================================
// 创作
// ============================================================
const MAX_CONTENT_LENGTH = 500;
const MAX_IMAGE_COUNT = 3;

// ============================================================
// 错误码
// ============================================================
const ERROR_CODE = {
  SUCCESS: 0,
  PARAM_ERROR: 40001,
  UNAUTHORIZED: 40100,
  TOKEN_EXPIRED: 40101,
  FORBIDDEN: 40300,
  NOT_FOUND: 40400,
  RATE_LIMIT: 42900,
  INTERNAL_ERROR: 50000,
  WX_API_ERROR: 50001,
  CONTENT_SECURITY_FAIL: 50002
};

module.exports = {
  MAX_CONCEPT_COUNT,
  MIN_CONCEPT_COUNT,
  LEVEL_CONFIG,
  EXP_RULES,
  DEFAULT_PAGE_SIZE,
  MAX_CONTENT_LENGTH,
  MAX_IMAGE_COUNT,
  ERROR_CODE
};
