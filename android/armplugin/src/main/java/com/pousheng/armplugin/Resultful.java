package com.pousheng.armplugin;

import android.util.Log;

import androidx.annotation.Nullable;

import io.flutter.plugin.common.MethodChannel;

public class Resultful implements MethodChannel.Result {
    private  boolean called=false;
    private MethodChannel.Result channelResult;
    public  static Resultful of(MethodChannel.Result result){
        return new Resultful(result);
    }
    private Resultful(MethodChannel.Result result) {
        this.channelResult=result;
    }
    @Override
    public void success(@Nullable Object result) {
        if (called){
            printError();
            return;
        }
        called=true;
        channelResult.success(result);
    }



    @Override
    public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {
        if (called){
            printError();
            return;
        }
        called=true;
        Log.d("记得记得",errorCode+"=="+errorMessage+"=="+errorDetails);
        //channelResult.error(errorCode,errorMessage,errorDetails);
    }

    @Override
    public void notImplemented() {
        if (called){
            printError();
            return;
        }
        called=true;
        channelResult.notImplemented();
    }

    private void printError() {

    }
}
