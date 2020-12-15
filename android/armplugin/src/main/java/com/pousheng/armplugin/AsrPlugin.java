package com.pousheng.armplugin;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.util.ArrayList;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class AsrPlugin implements MethodChannel.MethodCallHandler {
    private Activity activity;
    private ArmManager armManager;
    private Resultful resultful;

    public static void rigesterWith(Activity activity, BinaryMessenger messenger) {
        MethodChannel channel = new MethodChannel(messenger, "arm_plugin");
        AsrPlugin asrPlugin = new AsrPlugin(activity);
        channel.setMethodCallHandler(asrPlugin);
    }

    public AsrPlugin(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        initPermission();
        switch (call.method) {
            case "start":
                resultful = Resultful.of(result);
                start(call.arguments, resultful);
                break;
            case "stop":
                stop();
                break;
            case "cancle":
                cancle();
                break;
            case "release":
                release();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void start(Object arguments, Resultful resultful) {
        getArmManager().start(arguments instanceof Map ? ((Map) (arguments)) : null);
    }

    private void stop() {
        getArmManager().stop();
    }

    private void cancle() {
        getArmManager().cancel();
    }
    private void release() {
        getArmManager().release();
    }

    private ArmManager getArmManager() {
        if (armManager == null) {
            if (activity != null && !activity.isFinishing()) {
                armManager = new ArmManager(activity, listener);
            }
        }
        return armManager;
    }
    /**
     * android 6.0 以上需要动态申请权限
     */
    private void initPermission() {
        String permissions[] = {Manifest.permission.RECORD_AUDIO,
                Manifest.permission.ACCESS_NETWORK_STATE,
                Manifest.permission.INTERNET,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
        };

        ArrayList<String> toApplyList = new ArrayList<String>();

        for (String perm :permissions){
            if (PackageManager.PERMISSION_GRANTED != ContextCompat.checkSelfPermission(activity, perm)) {
                toApplyList.add(perm);
                //进入到这里代表没有权限.

            }
        }
        String tmpList[] = new String[toApplyList.size()];
        if (!toApplyList.isEmpty()){
            ActivityCompat.requestPermissions(activity, toApplyList.toArray(tmpList), 123);
        }

    }
    private OnArmListener listener = new OnArmListener() {

        @Override
        public void onAsrReady() {

        }

        @Override
        public void onAsrBegin() {

        }

        @Override
        public void onAsrEnd() {

        }

        @Override
        public void onAsrPartialResult(String[] results, RecogResult recogResult) {

        }

        @Override
        public void onAsrOnlineNluResult(String nluResult) {

        }

        @Override
        public void onAsrFinalResult(String[] results, RecogResult recogResult) {
            resultful.success(results[0]);
        }

        @Override
        public void onAsrFinish(RecogResult recogResult) {

        }

        @Override
        public void onAsrFinishError(int errorCode, int subErrorCode, String descMessage, RecogResult recogResult) {
            resultful.error(String.valueOf(subErrorCode) ,descMessage,recogResult);
        }

        @Override
        public void onAsrLongFinish() {

        }

        @Override
        public void onAsrVolume(int volumePercent, int volume) {

        }

        @Override
        public void onAsrAudio(byte[] data, int offset, int length) {

        }

        @Override
        public void onAsrExit() {

        }

        @Override
        public void onOfflineLoaded() {

        }

        @Override
        public void onOfflineUnLoaded() {

        }
    };

}
