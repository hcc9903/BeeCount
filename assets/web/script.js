document.getElementById('loginForm').addEventListener('submit', function (e) {
    e.preventDefault();

    const usernameInput = document.getElementById('username');
    const passwordInput = document.getElementById('password');
    const loginBtn = document.getElementById('loginBtn');
    const errorMsg = document.getElementById('errorMsg');

    const username = usernameInput.value;
    const password = passwordInput.value;

    // 禁用按钮显示加载状态
    loginBtn.disabled = true;
    const originalBtnText = loginBtn.querySelector('.btn-text').textContent;
    loginBtn.querySelector('.btn-text').textContent = '验证中...';
    errorMsg.style.display = 'none';

    // 模拟网络延迟
    setTimeout(() => {
        if (username === 'hcc' && password === '555') {
            // 登录成功
            loginBtn.style.background = '#00C853';
            loginBtn.querySelector('.btn-text').textContent = '登录成功！';

            // 成功动画
            document.querySelector('.glass-card').style.transform = 'scale(0.95)';
            document.querySelector('.glass-card').style.opacity = '0';
            document.querySelector('.glass-card').style.transition = 'all 0.5s ease';

            setTimeout(() => {
                alert('欢迎回来, hcc! 正在进入黄成财专业版...');
                // 这里可以跳转到主页
                // window.location.href = 'dashboard.html';
            }, 500);
        } else {
            // 登录失败
            loginBtn.disabled = false;
            loginBtn.querySelector('.btn-text').textContent = originalBtnText;

            errorMsg.textContent = '用户名或密码错误，请重试。';
            errorMsg.style.display = 'block';

            // 输入框震动效果
            passwordInput.value = '';
            passwordInput.focus();
        }
    }, 1200);
});

// 添加输入框聚焦时的发光扩散效果
document.querySelectorAll('input').forEach(input => {
    input.addEventListener('focus', () => {
        input.parentElement.style.transform = 'scale(1.02)';
        input.parentElement.style.transition = 'transform 0.3s ease';
    });
    input.addEventListener('blur', () => {
        input.parentElement.style.transform = 'scale(1)';
    });
});
