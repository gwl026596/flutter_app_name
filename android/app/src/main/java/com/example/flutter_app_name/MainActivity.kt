package com.example.flutter_app_name

import com.pousheng.armplugin.AsrPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry

class MainActivity: FlutterActivity() {


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        //flutter sdk >= v1.17.0 时使用下面方法注册自定义plugin
        AsrPlugin.rigesterWith(this, flutterEngine.getDartExecutor().getBinaryMessenger());
    }
}
