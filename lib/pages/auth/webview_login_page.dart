import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

/// WebView 登录页面
/// 加载本地 assets/web/index.html 作为登录界面
class WebViewLoginPage extends StatefulWidget {
  const WebViewLoginPage({super.key});

  @override
  State<WebViewLoginPage> createState() => _WebViewLoginPageState();
}

class _WebViewLoginPageState extends State<WebViewLoginPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'FlutterBridge',
        onMessageReceived: (JavaScriptMessage message) {
          _handleMessage(message.message);
        },
      );

    _loadLocalHtml();
  }

  Future<void> _loadLocalHtml() async {
    try {
      // 读取本地 HTML 文件
      final htmlContent = await rootBundle.loadString('assets/web/index.html');
      
      // 构建完整的 HTML，包含内联的 CSS 和 JS
      final cssContent = await rootBundle.loadString('assets/web/style.css');
      final jsContent = await rootBundle.loadString('assets/web/script.js');
      
      final fullHtml = '''
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>蜜蜂记账 - 登录</title>
    <style>$cssContent</style>
</head>
<body>
    ${htmlContent.replaceAll(RegExp(r'<head>.*?</head>', dotAll: true), '')}
    <script>
      // 修改原JS，登录成功后通过 FlutterBridge 通知 Flutter
      $jsContent
      
      // 拦截登录成功
      const originalAlert = window.alert;
      window.alert = function(message) {
        if (message.includes('欢迎回来')) {
          // 登录成功，通知 Flutter
          if (window.FlutterBridge) {
            FlutterBridge.postMessage(JSON.stringify({
              'type': 'login_success',
              'username': 'hcc'
            }));
          }
        }
        originalAlert(message);
      };
    </script>
</body>
</html>
''';

      await _controller.loadHtmlString(fullHtml, baseUrl: 'about:blank');
    } catch (e) {
      debugPrint('Failed to load HTML: $e');
    }
  }

  void _handleMessage(String message) {
    try {
      final data = jsonDecode(message);
      if (data['type'] == 'login_success') {
        // 登录成功，导航到主页
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
    } catch (e) {
      debugPrint('Failed to parse message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
