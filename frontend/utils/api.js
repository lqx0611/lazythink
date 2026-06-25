/**
 * API 请求封装
 * 统一处理 Token、Loading、异常
 *
 * @since 2026-06-25
 */
const BASE_URL = 'https://api.lazythink.com/api/v1';

/**
 * 发起请求
 * @param {string} method - GET | POST | DELETE
 * @param {string} path - 接口路径（以 / 开头）
 * @param {object} data - 请求体（GET时自动转query）
 * @param {boolean} showLoading - 是否显示loading，默认true
 * @returns {Promise<any>} 响应data字段
 */
function request(method, path, data, showLoading = true) {
  const token = wx.getStorageSync('token');
  const header = {
    'Content-Type': 'application/json'
  };
  if (token) {
    header['Authorization'] = `Bearer ${token}`;
  }

  if (showLoading) {
    wx.showLoading({ title: '加载中', mask: true });
  }

  return new Promise((resolve, reject) => {
    wx.request({
      url: BASE_URL + path,
      method,
      data,
      header,
      success(res) {
        if (res.statusCode === 200 && res.data.code === 0) {
          resolve(res.data.data);
        } else if (res.statusCode === 401 || res.data.code === 40100 || res.data.code === 40101) {
          // Token失效，清除本地缓存
          wx.removeStorageSync('token');
          wx.showToast({ title: '登录已过期，请重新登录', icon: 'none' });
          reject(res.data);
        } else {
          wx.showToast({ title: res.data.message || '请求失败', icon: 'none' });
          reject(res.data);
        }
      },
      fail(err) {
        wx.showToast({ title: '网络异常，请重试', icon: 'none' });
        reject(err);
      },
      complete() {
        if (showLoading) {
          wx.hideLoading();
        }
      }
    });
  });
}

/**
 * GET 请求
 */
function get(path, data) {
  return request('GET', path, data);
}

/**
 * POST 请求
 */
function post(path, data) {
  return request('POST', path, data);
}

/**
 * DELETE 请求
 */
function del(path, data) {
  return request('DELETE', path, data);
}

module.exports = { get, post, del, BASE_URL };
