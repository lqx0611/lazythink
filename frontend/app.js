/**
 * 「懒得想」小程序入口
 * 初始化全局数据、登录态检查
 *
 * @since 2026-06-25
 */
App({
  globalData: {
    // 用户信息（登录后填充）
    userInfo: null,
    // JWT Token
    token: null,
    // 是否已登录
    isLogin: false,
    // API 基础地址（生产环境替换为真实域名）
    apiBaseUrl: 'https://api.lazythink.com/api/v1'
  },

  onLaunch() {
    // 检查本地缓存的登录态
    const token = wx.getStorageSync('token');
    if (token) {
      this.globalData.token = token;
      this.globalData.isLogin = true;
    }
  },

  /**
   * 检查登录态，未登录则返回false
   */
  checkLogin() {
    if (!this.globalData.isLogin) {
      wx.showToast({ title: '请先登录', icon: 'none' });
      return false;
    }
    return true;
  }
});
